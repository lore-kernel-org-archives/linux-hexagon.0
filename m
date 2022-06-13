From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the non-atomics
Date: Mon, 13 Jun 2022 16:30:34 +0200
Message-ID: <20220613143034.1176680-1-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-5-alexandr.lobakin@intel.com> <YqNNjKRja7KelljA@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655130745; x=1686666745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ujiwlsqt2KBvF1qvv4tJ1iHQFhwag7L0iIc7Ytjnd0s=;
  b=lsUuFmEZ1hsnq4DkDDWYnAH+0vL3lI1K0PJ+FEMnm7NEjCvk/HkEeGJa
   X9UWYbHa0Rxm5JHw9PA47BoHbCyxLOU5ZWlC9ivwPSEAt7zJnTSH/LLEe
   ajIwmWbkbg2RA6DEyMFhal+zn7ehfpubB++WUWpvuCYtANGQgNDmDEZpw
   OCHHoQrv5w3a2CaLCjwYSLKrwrn6HrcCnElNyyeNxveKwgJDLStApYXHX
   rP9sxl9Cz3s0vxstU3NajnA3+eLtSYVkvkectRZRV9VRv5dIaFPbWX3Vy
   DeI6eVNqHQJsrbk+lQeEc0KgZvAwkOOa97MiHNqMJ8B504IGrkVOn2WcG
   A==;
In-Reply-To: <YqNNjKRja7KelljA@smile.fi.intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, sp

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 10 Jun 2022 16:56:28 +0300

> On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> > Define const_*() variants of the non-atomic bitops to be used when
> > the input arguments are compile-time constants, so that the compiler
> > will be always to resolve those to compile-time constants as well.
> > Those are mostly direct aliases for generic_*() with one exception
> > for const_test_bit(): the original one is declared atomic-safe and
> > thus doesn't discard the `volatile` qualifier, so in order to let
> > optimize the code, define it separately disregarding the qualifier.
> > Add them to the compile-time type checks as well just in case.
> 
> ...
> 
> >  /* Check that the bitops prototypes are sane */
> >  #define __check_bitop_pr(name)						\
> > -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> > +	static_assert(__same_type(const_##name, generic_##name) &&	\
> > +		      __same_type(arch_##name, generic_##name) &&	\
> >  		      __same_type(name, generic_##name))
> 
> Can't it be a one line change and actually keeping ordering at the same time?

Sure. Wanted to sort them "semantically", but it doesn't really make
any sense in here.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Olek
