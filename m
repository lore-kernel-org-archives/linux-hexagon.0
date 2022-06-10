From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/6] bitops: define const_*() versions of the
 non-atomics
Date: Fri, 10 Jun 2022 16:56:28 +0300
Message-ID: <YqNNjKRja7KelljA@smile.fi.intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-5-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654869398; x=1686405398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rgp4lTJLX0ot2IhjAJHLXWfwVn1Hf1envZh9HGJ8MuU=;
  b=LL9TDN8rw3ofnJ0/yz8QuWpf4lPwstD6t+nWUuEoX0+cGassHsh0A1qw
   5x5FBh65NaEm9+peLkqTbvr4HE56LRqfrqeND5JtKXJ2VQl8kuKZYi48y
   49LbDsI+VvVbqmKxWXzpk7Di6fnQqxUml/piRmWOqbnNejQfjdHGeqNle
   h1MNEK7YwpuXhkVKh1ixtlHt+10YSeU4yVRD3T7a6zqdMIv8mWya9RYWg
   HWBRMS3emvcMWhASbaxIqgsJ8Lyp9V5zVyQ9Rz3t3kX/TkhQcY+ZUuV4E
   7mWdg1B5c3qpFuWeAJNKNkUp/w3PcKsKNrszHVM30xXg91/6FBmvRUR2r
   w==;
Content-Disposition: inline
In-Reply-To: <20220610113427.908751-5-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-ke

On Fri, Jun 10, 2022 at 01:34:25PM +0200, Alexander Lobakin wrote:
> Define const_*() variants of the non-atomic bitops to be used when
> the input arguments are compile-time constants, so that the compiler
> will be always to resolve those to compile-time constants as well.
> Those are mostly direct aliases for generic_*() with one exception
> for const_test_bit(): the original one is declared atomic-safe and
> thus doesn't discard the `volatile` qualifier, so in order to let
> optimize the code, define it separately disregarding the qualifier.
> Add them to the compile-time type checks as well just in case.

...

>  /* Check that the bitops prototypes are sane */
>  #define __check_bitop_pr(name)						\
> -	static_assert(__same_type(arch_##name, generic_##name) &&	\
> +	static_assert(__same_type(const_##name, generic_##name) &&	\
> +		      __same_type(arch_##name, generic_##name) &&	\
>  		      __same_type(name, generic_##name))

Can't it be a one line change and actually keeping ordering at the same time?

-- 
With Best Regards,
Andy Shevchenko


