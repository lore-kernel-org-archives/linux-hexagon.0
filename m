From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 18/19] linux/include: add non-atomic version of xchg
Date: Thu, 22 Dec 2022 14:47:42 +0200
Message-ID: <Y6RR7hPZUN22ytap@smile.fi.intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
 <20221222114635.1251934-19-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671713272; x=1703249272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UPM8RDFaM30ZmFrIb8CKMZ1JANhWUp662jbH45qLr6M=;
  b=U7Ti5gM7uX2hSBxzWafGGZSDBcDqjumI2csrgPUV3Gmaxw1BNaf3z8Ro
   FF6neieM8V/SA6HrQxhmet6cGsg8V1Pn4Ot+4KX3fglxDxDH1pnW3PVoK
   9YZRCSIZn28az1kCO6XUr5BdCTW0FvwIqD4SViceQ6X0gdg6zF7f5QLxR
   /Bo00h41XDF2crkrb9MNAQZgCN8wXjmgNq51blBh7KNfBIdJYH2/+Rvm3
   /zv4/jpzOePRSdt+y2oFm4ceGTgMmphSDzSce147uOX4vF6brBHpliEaY
   BbIViYm6PVSbzGpAKVyuCm0/IWoVcd4nQbwgISsWEK4Ox8GcXvIGwMOIB
   A==;
Content-Disposition: inline
In-Reply-To: <20221222114635.1251934-19-andrzej.hajda@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Mark

On Thu, Dec 22, 2022 at 12:46:34PM +0100, Andrzej Hajda wrote:
> The pattern of setting variable with new value and returning old
> one is very common in kernel. Usually atomicity of the operation
> is not required, so xchg seems to be suboptimal and confusing in
> such cases.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
>  include/linux/non-atomic/xchg.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/linux/non-atomic/xchg.h
> 
> diff --git a/include/linux/non-atomic/xchg.h b/include/linux/non-atomic/xchg.h
> new file mode 100644
> index 00000000000000..f7fa5dd746f37d
> --- /dev/null
> +++ b/include/linux/non-atomic/xchg.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_NON_ATOMIC_XCHG_H
> +#define _LINUX_NON_ATOMIC_XCHG_H
> +
> +/**
> + * __xchg - set variable pointed by @ptr to @val, return old value
> + * @ptr: pointer to affected variable
> + * @val: value to be written
> + *
> + * This is non-atomic variant of xchg.
> + */
> +#define __xchg(ptr, val) ({		\
> +	__auto_type __ptr = ptr;	\
> +	__auto_type __t = *__ptr;	\
> +	*__ptr = (val);			\
> +	__t;				\
> +})
> +
> +#endif
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


