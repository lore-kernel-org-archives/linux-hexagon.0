From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
Date: Sat, 7 Apr 2018 20:32:10 -0500
Message-ID: <20180408013210.GD3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
 <20180406142832.2243021-3-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151132;
        bh=lzyZLQWjH+gFDPdKQAcEfmi+DdVBiC3G3bhiNUA5Ruc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AG4JSDYwEOGG/JL8TamuNKRa6QNj2IVYKLFV/+fZMtOgaDkusjHYBIeBUvbvhvWAq
         UxEqiWVpFbw5qht8indSH33Jz03KNpsf7m5gQgQb+iJmiP7r32K4X/kHjDoZkbIgjH
         wvK1lx+3NeSl0zpTu7WxHOwfKqFwS+NOj+XVVCMs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151132;
        bh=lzyZLQWjH+gFDPdKQAcEfmi+DdVBiC3G3bhiNUA5Ruc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AG4JSDYwEOGG/JL8TamuNKRa6QNj2IVYKLFV/+fZMtOgaDkusjHYBIeBUvbvhvWAq
         UxEqiWVpFbw5qht8indSH33Jz03KNpsf7m5gQgQb+iJmiP7r32K4X/kHjDoZkbIgjH
         wvK1lx+3NeSl0zpTu7WxHOwfKqFwS+NOj+XVVCMs=
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:23PM +0200, Arnd Bergmann wrote:
> This is needed to link ipv6 as a loadable module, which in turn happens
> in allmodconfig.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/lib/checksum.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
> index 617506d1a559..7cd0a2259269 100644
> --- a/arch/hexagon/lib/checksum.c
> +++ b/arch/hexagon/lib/checksum.c
> @@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
>  	memcpy(dst, src, len);
>  	return csum_partial(dst, len, sum);
>  }
> +EXPORT_SYMBOL(csum_partial_copy_nocheck);

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
