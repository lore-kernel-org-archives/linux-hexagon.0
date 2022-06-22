From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v4 8/8] lib: test_bitmap: add compile-time optimization/evaluations assertions
Date: Wed, 22 Jun 2022 18:04:15 +0200
Message-ID: <20220622160415.589430-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com> <20220621191553.69455-9-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655913868; x=1687449868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eG4q6c4UvYGtzxug36fSTUwHXCGqtjeRSHre942YGGg=;
  b=f4HALTIJHzTUe+vyEev6ujB3KqMor2a2QouSLx6V0SrZDrSF6+nKA1AT
   ZrY9Z3DdILKDKIde4qsL0X2JdDnQ+V8Oa9fJxasgyupPbT+FFQYBygkWu
   fFRiUgSe/fsPNFHGyxx5KktBk86hdpvghWCsLcqmPsDU/AoZ4/hvcA9mc
   vLJX5ldoyX55w+HeKDQVwDPvPkMi+ZtDq6Y7tLgFw5uEoduwaR6VZNl7f
   0wZItBxrZG2aa6+Aa/Km4i1N2cBtqz4brpDv2MJr9yO0NLDm5nf2Wtn6O
   oJNCtpdyrs3hf+179oTqZIBp2TM5T+bG/oc82bCAW0YqIp7swgcnEkqDP
   w==;
In-Reply-To: <20220621191553.69455-9-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulni>

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 21 Jun 2022 21:15:53 +0200

> Add a function to the bitmap test suite, which will ensure that
> compilers are able to evaluate operations performed by the
> bitops/bitmap helpers to compile-time constants when all of the
> arguments are compile-time constants as well, or trigger a build
> bug otherwise. This should work on all architectures and all the
> optimization levels supported by Kbuild.
> The function doesn't perform any runtime tests and gets optimized
> out to nothing after passing the build assertions.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/test_bitmap.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index d5923a640457..3a7b09b82794 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -869,6 +869,50 @@ static void __init test_bitmap_print_buf(void)
>  	}
>  }
>  
> +static void __init test_bitmap_const_eval(void)
> +{
> +	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> +	unsigned long initvar = BIT(2);
> +	unsigned long bitopvar = 0;
> +	unsigned long var = 0;
> +	int res;
> +
> +	/*
> +	 * Compilers must be able to optimize all of those to compile-time
> +	 * constants on any supported optimization level (-O2, -Os) and any
> +	 * architecture. Otherwise, trigger a build bug.
> +	 * The whole function gets optimized out then, there's nothing to do
> +	 * in runtime.
> +	 */
> +
> +	/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
> +	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> +	if (!test_bit(7, bitmap))
> +		bitmap_set(bitmap, 5, 1);

So for now, when building for s390, Clang (up to the latest Git
snapshot) generates some incorrect code here.
It does expand both test_bit() and bitmap_set() to const_test_bit()
and const___set_bit(), but at the same time thinks that starting
from this point, @bitmap and @bitopvar (???) are *not* constants
and fails the assertions below, which is not true and weird.
Any other architecture + compiler couples work fine, including
s390 on GCC.
So would it be acceptable for now to do:

	/* Equals to `unsigned long bitmap[1] = { BIT(5), }` */
	bitmap_clear(bitmap, 0, BITS_PER_LONG);
	/*
	 * Some comment saying that this is currently broken
	 * on s390 + Clang
	 */
#if !(defined(__s390__) && defined(__clang__))
	if (!test_bit(7, bitmap))
		bitmap_set(bitmap, 5, 1);
#endif

	/* Equals to `unsigned long bitopvar = BIT(20)` */
	__change_bit(31, &bitopvar);
	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);

[...]

or there could be any better solutions?

(+Cc LLVM folks)

> +
> +	/* Equals to `unsigned long bitopvar = BIT(20)` */
> +	__change_bit(31, &bitopvar);
> +	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
> +
> +	/* Equals to `unsigned long var = BIT(25)` */
> +	var |= BIT(25);
> +	if (var & BIT(0))
> +		var ^= GENMASK(9, 6);
> +
> +	/* __const_hweight<32|64>(BIT(5)) == 1 */
> +	res = bitmap_weight(bitmap, 20);
> +	BUILD_BUG_ON(!__builtin_constant_p(res));
> +
> +	/* !(BIT(31) & BIT(18)) == 1 */
> +	res = !test_bit(18, &bitopvar);
> +	BUILD_BUG_ON(!__builtin_constant_p(res));
> +
> +	/* BIT(2) & GENMASK(14, 8) == 0 */
> +	BUILD_BUG_ON(!__builtin_constant_p(initvar & GENMASK(14, 8)));
> +	/* ~BIT(25) */
> +	BUILD_BUG_ON(!__builtin_constant_p(~var));
> +}
> +
>  static void __init selftest(void)
>  {
>  	test_zero_clear();
> @@ -884,6 +928,7 @@ static void __init selftest(void)
>  	test_for_each_set_clump8();
>  	test_bitmap_cut();
>  	test_bitmap_print_buf();
> +	test_bitmap_const_eval();
>  }
>  
>  KSTM_MODULE_LOADERS(test_bitmap);
> -- 
> 2.36.1

Thanks,
Olek
