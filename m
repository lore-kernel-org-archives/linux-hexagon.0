From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: [PATCH v4 7/8] bitmap: don't assume compiler evaluates small mem*() builtins calls
Date: Tue, 21 Jun 2022 21:15:52 +0200
Message-ID: <20220621191553.69455-8-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655839002; x=1687375002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwGnL3cKrVpIYdUCZi0g8IIvLiuF1HHfK1nv3YKvvvI=;
  b=Pk1U1pWwT3Rce9cmXQWWOfWqeyXRMMm5Dg75YZL7KRTOIeLiVHLZBfYM
   cU6TEG3Y565fyXAvgai8ybgBddzkccOEvW16Pz+zaT+wD1GX0S5F738AV
   u5lq0y6HmxfN0Kn2lz+ltcHZPoJR9I9qz/XCS7Se83CTHjDEmi4l05wxl
   GYMcZysMo9+VCvgATJQ5G9B5XVUG/o5IyoDTp+Trm2e5iZCtjtqJrIjkY
   3wkH+7BHn+U4G7Ug+52jsrNuBZHCWUlnk+u3X/OLKb1P5iJCeU0lU/U9C
   XVGGqH2QwuILK+8Ildo5cBzmzQnLaGFhjCMSxIbx43j3k7cx+uKyf5Na+
   w==;
In-Reply-To: <20220621191553.69455-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64

Intel kernel bot triggered the build bug on ARC architecture that
in fact is as follows:

	DECLARE_BITMAP(bitmap, BITS_PER_LONG);

	bitmap_clear(bitmap, 0, BITS_PER_LONG);
	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

which can be expanded to:

	unsigned long bitmap[1];

	memset(bitmap, 0, sizeof(*bitmap));
	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

In most cases, a compiler is able to expand small/simple mem*()
calls to simple assignments or bitops, in this case that would mean:

	unsigned long bitmap[1] = { 0 };

	BUILD_BUG_ON(!__builtin_constant_p(*bitmap));

and on most architectures this works, but not on ARC, despite having
-O3 for every build.
So, to make this work, in case when the last bit to modify is still
within the first long (small_const_nbits()), just use plain
assignments for the rest of bitmap_*() functions which still use
mem*(), but didn't receive such compile-time optimizations yet.
This doesn't have the same coverage as compilers provide, but at
least something to start:

text: add/remove: 3/7 grow/shrink: 43/78 up/down: 1848/-3370 (-1546)
data: add/remove: 1/11 grow/shrink: 0/8 up/down: 4/-356 (-352)

notably cpumask_*() family when NR_CPUS <= BITS_PER_LONG:

netif_get_num_default_rss_queues              38       4     -34
cpumask_copy                                  90       -     -90
cpumask_clear                                146       -    -146

and the abovementioned assertion started passing.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/linux/bitmap.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 2e6cd5681040..a0f4f3af8d30 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -238,20 +238,32 @@ extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0, len);
+
+	if (small_const_nbits(nbits))
+		*dst = 0;
+	else
+		memset(dst, 0, len);
 }
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memset(dst, 0xff, len);
+
+	if (small_const_nbits(nbits))
+		*dst = ~0UL;
+	else
+		memset(dst, 0xff, len);
 }
 
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
 	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-	memcpy(dst, src, len);
+
+	if (small_const_nbits(nbits))
+		*dst = *src;
+	else
+		memcpy(dst, src, len);
 }
 
 /*
@@ -431,6 +443,8 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__set_bit(start, map);
+	else if (small_const_nbits(start + nbits))
+		*map |= GENMASK(start + nbits - 1, start);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
@@ -445,6 +459,8 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 {
 	if (__builtin_constant_p(nbits) && nbits == 1)
 		__clear_bit(start, map);
+	else if (small_const_nbits(start + nbits))
+		*map &= ~GENMASK(start + nbits - 1, start);
 	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
-- 
2.36.1

