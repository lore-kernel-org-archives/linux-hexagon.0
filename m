From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 7/7] lib: test_bitmap: add compile-time
 optimization/evaluations assertions
Date: Mon, 20 Jun 2022 13:07:56 +0300
Message-ID: <YrBG/OQG9UTs303n@smile.fi.intel.com>
References: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
 <20220617144031.2549432-8-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655719687; x=1687255687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/YTviqZJx+Zv4LLi02NSY2v7l5dWHUHoA+rNi5k9dvE=;
  b=HK3EYzyPOR29n8iZv03YGXi2LpDNy+iKYpAOfg12VH/Glnq2QeXJ+Y3M
   02+8LaO/ZGpwkUHVhRVUA4N8jR0Xa/qahzwPrkpYRbmb2ITquS7jnTpA+
   JGnat/ok3hVA7/t9ycZjdxwoDC+L0MS/u/4IXdceTuAOD1HEyRPlMo9df
   nP6Ve73yvM+hF1JIjCQv7YmMawPRy6B2iWiL6wdepWbaDJTbjxJHrrbFT
   BrDXxvGhuZ+g9Bqfvjk5usEhZudNQByNt5AQuovSqjLJmZCc0QysSpKMw
   3zX44LUBydwAf+DYR8tcle9jkYb1SNs39o4Aoy4YdRkgc3h2tSsQRh26K
   g==;
Content-Disposition: inline
In-Reply-To: <20220617144031.2549432-8-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m6

On Fri, Jun 17, 2022 at 04:40:31PM +0200, Alexander Lobakin wrote:
> Add a function to the bitmap test suite, which will ensure that
> compilers are able to evaluate operations performed by the
> bitops/bitmap helpers to compile-time constants when all of the
> arguments are compile-time constants as well, or trigger a build
> bug otherwise. This should work on all architectures and all the
> optimization levels supported by Kbuild.
> The function doesn't perform any runtime tests and gets optimized
> out to nothing after passing the build assertions.

Always in favour of new test cases!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
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
> 

-- 
With Best Regards,
Andy Shevchenko


