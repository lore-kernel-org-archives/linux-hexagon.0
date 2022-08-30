From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 2/2 v5] regmap: mmio: Support accelerared noinc operations
Date: Tue, 30 Aug 2022 19:35:19 +0300
Message-ID: <Yw48R+EBmmZYl9x+@smile.fi.intel.com>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
 <20220816204832.265837-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661877611; x=1693413611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+hMJfedZvdsmbwPRh9VykDs64eRMZZWjvzG9b69fVzo=;
  b=bJsI0gf+Z4U6NQsLRyqfiJQWcA6f4c9U9ziBZnHHBCttbGR8t0nDQFMu
   6guSWOhwpxKyJbwVLbpuFSQbQBAz6cs0TYpUvmzhgnZVs6h0V4n1XZZse
   HZg8alqwDCKt4FJKszbe4O1ZzrWCdbb5MFOsfcOAd79Pma8B2lA02X5PQ
   dnKhqVPP0CIDaAeH27vZEP2UERWlyEmaY1a6oIVWkj3wuNq8keXOvFuM7
   AQDDstsYTz6YNZlb/ZL17K1Z9y+BTqXZwJZ6RfiCKXasjfscVZXXXYeCH
   3xvPj3WRDTrXw8zbl8eWoBze9G/+Ua2ZcIOXEJkfTTwGetC9hDdiBpIUt
   g==;
Content-Disposition: inline
In-Reply-To: <20220816204832.265837-2-linus.walleij@linaro.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Tue, Aug 16, 2022 at 10:48:32PM +0200, Linus Walleij wrote:
> Use the newly added callback for accelerated noinc MMIO
> to provide writesb, writesw, writesl, writesq, readsb, readsw,
> readsl and readsq.
> 
> A special quirk is needed to deal with big endian regmaps: there
> are no accelerated operations defined for big endian, so fall
> back to calling the big endian operations itereatively for this
> case.
> 
> The Hexagon architecture turns out to have an incomplete
> <asm/io.h>: writesb() is not implemented. Fix this by doing
> what other architectures do: include <asm-generic/io.h> into
> the <asm/io.h> file.

Wonderful!

So, I have seen a recent blow up by kernel bot due to Alpha issues on these
accessors.

Also see below for the further followups.

...

> +	if (!IS_ERR(ctx->clk)) {
> +		ret = clk_enable(ctx->clk);
> +		if (ret < 0)
> +			return ret;
> +	}

It's a new place of the duplicating check, can we have a helper for that?

...

> +	/*
> +	 * There are no native, assembly-optimized write single register
> +	 * operations for big endian, so fall back to emulation if this
> +	 * is needed. (Single bytes are fine, they are not affected by
> +	 * endianness.)
> +	 */

Wouldn't be faster to memdup() / swap / use corresponding IO accessor?

...

> +	/*
> +	 * There are no native, assembly-optimized write single register
> +	 * operations for big endian, so fall back to emulation if this
> +	 * is needed. (Single bytes are fine, they are not affected by
> +	 * endianness.)
> +	 */
> +	if (ctx->big_endian && (ctx->val_bytes > 1)) {
> +		switch (ctx->val_bytes) {
> +		case 2:
> +		{
> +			u16 *valp = (u16 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab16(valp[i]);
> +			break;
> +		}
> +		case 4:
> +		{
> +			u32 *valp = (u32 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab32(valp[i]);
> +			break;
> +		}
> +#ifdef CONFIG_64BIT
> +		case 8:
> +		{
> +			u64 *valp = (u64 *)val;
> +			for (i = 0; i < val_count; i++)
> +				valp[i] = swab64(valp[i]);
> +			break;
> +		}
> +#endif
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}

So, two questions here:

1) can we use helpers from include/linux/byteorder/generic.h, such as
   cpu_to_be32_array()/be32_to_cpu_array()?

2) have you considered using memcpy_toio() / memcpy_fromio() and why
   it's not okay to use them?

...

> +
> +

Single blank line is enough.

> +out_clk:
> +	if (!IS_ERR(ctx->clk))
> +		clk_disable(ctx->clk);
> +
> +	return ret;
> +
> +	return 0;

Seems like misrebase? I believe this has to be fixed.

-- 
With Best Regards,
Andy Shevchenko


