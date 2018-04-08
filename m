From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 2/3] hexagon: add memset_io() helper
Date: Sat, 7 Apr 2018 20:31:30 -0500
Message-ID: <20180408013130.GC3036@codeaurora.org>
References: <20180406142832.2243021-1-arnd@arndb.de>
 <20180406142832.2243021-2-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151094;
        bh=JyKA0vjaH1fz4X3kwAOWOIo63WtJ1DX/vgysBtyP1cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+Fo8NT98Q5r12x5aQoqVDVaPajdW6145W2s7hGL4cj1/v7skliRzv5cwJd0Xpod3
         WRby6XhCsoSFmWBQZ8vsMN3T8Iui0r85GqMkQoQN01GMVkKqoKUxNViEFaDyv76Rie
         MG0MOoPEHnkXlg7AtcfDF22aRpEYnBWgjgd8D+W8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1523151094;
        bh=JyKA0vjaH1fz4X3kwAOWOIo63WtJ1DX/vgysBtyP1cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+Fo8NT98Q5r12x5aQoqVDVaPajdW6145W2s7hGL4cj1/v7skliRzv5cwJd0Xpod3
         WRby6XhCsoSFmWBQZ8vsMN3T8Iui0r85GqMkQoQN01GMVkKqoKUxNViEFaDyv76Rie
         MG0MOoPEHnkXlg7AtcfDF22aRpEYnBWgjgd8D+W8=
Content-Disposition: inline
In-Reply-To: <20180406142832.2243021-2-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 04:28:22PM +0200, Arnd Bergmann wrote:
> We already have memcpy_toio(), but not memset_io(), so let's
> add the obvious version to allow building an allmodconfig kernel
> without errors like
> 
> drivers/gpu/drm/ttm/ttm_bo_util.c: In function 'ttm_bo_move_memcpy':
> drivers/gpu/drm/ttm/ttm_bo_util.c:390:3: error: implicit declaration of function 'memset_io' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/hexagon/include/asm/io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 9e8621d94ee9..e17262ad125e 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -216,6 +216,12 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
>  	memcpy((void *) dst, src, count);
>  }
>  
> +static inline void memset_io(volatile void __iomem *addr, int value,
> +			     size_t size)
> +{
> +	memset((void __force *)addr, value, size);
> +}
> +
>  #define PCI_IO_ADDR	(volatile void __iomem *)
>  
>  /*

Acked-by: Richard Kuo <rkuo@codeaurora.org>



-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
