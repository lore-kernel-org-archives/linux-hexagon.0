From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] Hexagon: Export raw I/O routines for modules
Date: Tue, 27 Jul 2021 17:18:45 -0700
Message-ID: <YQCiZSj1gfnF5x/d@Ryzen-9-3900X.localdomain>
References: <20210708233849.3140194-1-nathan@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627431528;
        bh=u9teLUiNfbExZwY0su7A/WppbGW4OwOm30JjrzJwpT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiLLOwBj4S6iTjmD6cWVEkPVs1ROFYXiX4ey6t1HSTViAqEkrOHQyzFepfkVCpmmW
         1WBfLqH7TwtJzd4Bk4QLQ4i5Z2DQYw62cTkPg6TW/rqCByaLqVUS027YxlbO7WQ7FZ
         /he1w2ODl8Gp09NgEL1SHFqv6JhRjh13dpwFElcJCHcd4bJ8/dirT0BUZKmMxAx72+
         2uNTjdttSI0N08sbRiDttRdHJaXwe/6c6eHNWBoTIjJFETOyUi1d2VddxL49XOMbE4
         7gvj8S4PQ78vzjbV0vKzkpzg+ZZ/WYI6B8WUf3XnYMkXU8uKwBfTNwdNYwAdjJm6gT
         eXBH6ZFlHettQ==
Content-Disposition: inline
In-Reply-To: <20210708233849.3140194-1-nathan@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

On Thu, Jul 08, 2021 at 04:38:50PM -0700, Nathan Chancellor wrote:
> When building ARCH=hexagon allmodconfig, the following errors occur:
> 
> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/svc-i3c-master.ko] undefined!
> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/dw-i3c-master.ko] undefined!
> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/dw-i3c-master.ko] undefined!
> ERROR: modpost: "__raw_writesl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> ERROR: modpost: "__raw_readsl" [drivers/i3c/master/i3c-master-cdns.ko] undefined!
> 
> Export these symbols so that modules can use them without any errors.
> 
> Fixes: 013bf24c3829 ("Hexagon: Provide basic implementation and/or stubs for I/O routines.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> It would be nice if this could get into 5.14 at some point so that we
> can build ARCH=hexagon allmodconfig in our CI.
> 
>  arch/hexagon/lib/io.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/hexagon/lib/io.c b/arch/hexagon/lib/io.c
> index d35d69d6588c..55f75392857b 100644
> --- a/arch/hexagon/lib/io.c
> +++ b/arch/hexagon/lib/io.c
> @@ -27,6 +27,7 @@ void __raw_readsw(const void __iomem *addr, void *data, int len)
>  		*dst++ = *src;
>  
>  }
> +EXPORT_SYMBOL(__raw_readsw);
>  
>  /*
>   * __raw_writesw - read words a short at a time
> @@ -47,6 +48,7 @@ void __raw_writesw(void __iomem *addr, const void *data, int len)
>  
>  
>  }
> +EXPORT_SYMBOL(__raw_writesw);
>  
>  /*  Pretty sure len is pre-adjusted for the length of the access already */
>  void __raw_readsl(const void __iomem *addr, void *data, int len)
> @@ -62,6 +64,7 @@ void __raw_readsl(const void __iomem *addr, void *data, int len)
>  
>  
>  }
> +EXPORT_SYMBOL(__raw_readsl);
>  
>  void __raw_writesl(void __iomem *addr, const void *data, int len)
>  {
> @@ -76,3 +79,4 @@ void __raw_writesl(void __iomem *addr, const void *data, int len)
>  
>  
>  }
> +EXPORT_SYMBOL(__raw_writesl);
> 
> base-commit: f55966571d5eb2876a11e48e798b4592fa1ffbb7
> -- 
> 2.32.0.93.g670b81a890

Ping? Brian, if you do not want to carry this, can you give an ack so
that Andrew can?

Cheers,
Nathan
