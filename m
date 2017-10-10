From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 3/3] hexagon/kbuild: replace CFLAGS_MODULE with
 KBUILD_CFLAGS_MODULE
Date: Mon, 9 Oct 2017 20:26:08 -0500
Message-ID: <20171010012608.GA23555@codeaurora.org>
References: <1507533107-2069-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <1507533107-2069-3-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507598771;
        bh=/9OfxTwIftXwdXPWcu+FNf7UB8wyCOEaaTHKwW1ZyTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjZu87CPNkpfhitFicHRSW4TyPB2yH020WPI2f5iOicDhNw6qLXkAlbE4Ho1BB5Bc
         RpJvj5QToJilSt8He/LELrHqECPYSFHj7YPTkUxudipJKNJgjXVVeUSy1lrwodf7aN
         QiyRRhbOxTHvp86fOkJ3gLPsdVQTrnJZcmMGilAE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1507598770;
        bh=/9OfxTwIftXwdXPWcu+FNf7UB8wyCOEaaTHKwW1ZyTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxVpXpdw/4ZnpgxA9pF4zyL+FPIO4lnEcJpe8AmTkLPnPc5u7pOZZOzT0GQzOgYc/
         D0W3rerPMa5ga3iFehwYU7XpoRp9RDBnfYb1hrLRvPkXXZ6p11ZUoiVh1Ra4LEnsaC
         t2FzEFY3YYHpNCPpCqkA+B9xBGeXJ1ZTkbi80/Oo=
Content-Disposition: inline
In-Reply-To: <1507533107-2069-3-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Mon, Oct 09, 2017 at 03:11:47PM +0800, Cao jin wrote:
> As kbuild document & commit 6588169d51 says: KBUILD_CFLAGS_MODULE is
> used to add arch-specific options for $(CC). From commandline,
> CFLAGS_MODULE shall be used.
> Doesn't have any functional change, but just follow kbuild rules.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> CC: Richard Kuo <rkuo@codeaurora.org>
> CC: linux-hexagon@vger.kernel.org
> ---
>  arch/hexagon/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
> index 207711a0..4f5c84c 100644
> --- a/arch/hexagon/Makefile
> +++ b/arch/hexagon/Makefile
> @@ -11,9 +11,9 @@ KBUILD_CFLAGS += -fno-short-enums
>  
>  # Modules must use either long-calls, or use pic/plt.
>  # Use long-calls for now, it's easier.  And faster.
> -# CFLAGS_MODULE += -fPIC
> -# LDFLAGS_MODULE += -shared
> -CFLAGS_MODULE += -mlong-calls
> +# KBUILD_CFLAGS_MODULE += -fPIC
> +# KBUILD_LDFLAGS_MODULE += -shared
> +KBUILD_CFLAGS_MODULE += -mlong-calls
>  
>  cflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
>  aflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
> -- 
> 2.1.0
> 
> 
> 

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
