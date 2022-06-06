From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: [PATCH 3/6] bitops: define gen_test_bit() the same way as the rest of functions
Date: Mon,  6 Jun 2022 13:49:04 +0200
Message-ID: <20220606114908.962562-4-alexandr.lobakin@intel.com>
References: <20220606114908.962562-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654516225; x=1686052225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UfNxvkyTgN3+Cr6Fria9sdwavpE+KYijn4w/ioe52M=;
  b=LMdAzzAnYg9rbvevBxctjV6grB9+O2OF8x9+ZItRFySIwIjljrRS8KjC
   1FnubVQim8Gyax6LD+zckium+4qZs32c5GEXJtCDayl8IANljKO2Oj2tZ
   ysHiYgsfFS34cI3SHuvXDM3jgHrBp/x0/333y5Yc+ol1XaifhcaX9/1zs
   kS3kb5U0wq2bBS30TV/oJvpirQglTorCDjiTxa8DYmfBQoX1o8cJHOaup
   xnxjEIcRoq47S+pByQv7bqtRwGA9q9CZ6k09bismqNSg72U8QxEh8R7WR
   3ANr6Da/J/XGN+LTyKJNFbeUod2azVCcRf4XYzNGo3P1gDriwrKY6I3ID
   g==;
In-Reply-To: <20220606114908.962562-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

Currently, the generic test_bit() function is defined as a one-liner
and in case with constant bitmaps the compiler is unable to optimize
it to a constant. At the same time, gen_test_and_*_bit() are being
optimized pretty good.
Define gen_test_bit() the same way as they are defined.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/asm-generic/bitops/generic-non-atomic.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bitops/generic-non-atomic.h b/include/asm-generic/bitops/generic-non-atomic.h
index 7a60adfa6e7d..202d8a3b40e1 100644
--- a/include/asm-generic/bitops/generic-non-atomic.h
+++ b/include/asm-generic/bitops/generic-non-atomic.h
@@ -118,7 +118,11 @@ gen___test_and_change_bit(unsigned int nr, volatile unsigned long *addr)
 static __always_inline int
 gen_test_bit(unsigned int nr, const volatile unsigned long *addr)
 {
-	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
+	const unsigned long *p = (const unsigned long *)addr + BIT_WORD(nr);
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long val = *p;
+
+	return !!(val & mask);
 }
 
 #endif /* __ASM_GENERIC_BITOPS_GENERIC_NON_ATOMIC_H */
-- 
2.36.1

