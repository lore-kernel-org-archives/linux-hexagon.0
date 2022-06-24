From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: [PATCH v5 1/9] ia64, processor: fix -Wincompatible-pointer-types in ia64_get_irr()
Date: Fri, 24 Jun 2022 14:13:05 +0200
Message-ID: <20220624121313.2382500-2-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656072805; x=1687608805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oB2+/tAQ0YbLfBu8lpkzq06X+Z13qiz2lNUmx1L1VE=;
  b=gRZmWPP1/zu8/BjI8X8QtkR+Tlkky40+eYmnEHfBug4umu11OvYlBi1z
   9wduKqRf2ref4vLYX2TmE50BJiVUfxHNDt1qJ+ego5/HJkfoGJ819m4/+
   M3sMIXr6372d1U6c3XoZ//ZRiWhfHjfnxX0jjP+QDT/zh0xC3SWtDsT08
   /7j9RJhpFrpSJIRB89eM/rXBBU0Wbz98tUT911v+K1cWvpoqG2uYtL+dX
   WZ9EnRbWvJtYwH7eBEQtUYpNlNcbwZh8lOQuRAKe+NL/xryP2Bp3tKo+A
   WuwonrQxN3o0T/9NUaNefEbpBmcVvYO7IzYnnYCQWVJSWeFqf+1EbX0bb
   w==;
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <>

test_bit(), as any other bitmap op, takes `unsigned long *` as a
second argument (pointer to the actual bitmap), as any bitmap
itself is an array of unsigned longs. However, the ia64_get_irr()
code passes a ref to `u64` as a second argument.
This works with the ia64 bitops implementation due to that they
have `void *` as the second argument and then cast it later on.
This works with the bitmap API itself due to that `unsigned long`
has the same size on ia64 as `u64` (`unsigned long long`), but
from the compiler PoV those two are different.
Define @irr as `unsigned long` to fix that. That implies no
functional changes. Has been hidden for 16 years!

Fixes: a58786917ce2 ("[IA64] avoid broken SAL_CACHE_FLUSH implementations")
Cc: stable@vger.kernel.org # 2.6.16+
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 arch/ia64/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 7cbce290f4e5..757c2f6d8d4b 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -538,7 +538,7 @@ ia64_get_irr(unsigned int vector)
 {
 	unsigned int reg = vector / 64;
 	unsigned int bit = vector % 64;
-	u64 irr;
+	unsigned long irr;
 
 	switch (reg) {
 	case 0: irr = ia64_getreg(_IA64_REG_CR_IRR0); break;
-- 
2.36.1

