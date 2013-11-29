From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] arch: hexagon: kernel: hexagon_ksyms.c remove useless
 __hexagon_*i3()
Date: Fri, 29 Nov 2013 10:57:20 +0800
Message-ID: <52980290.6090001@gmail.com>
References: <5297FC23.3030507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KkMAba00j28Kl8LyQXr7RV2wY/vcXIkfhje5gSaKJaQ=;
        b=OvSEeYe1A0Sb2qI4eUhr9UcyT2zZL5GY9IEqLKnMGTtnSEsG5TUwUKZUvA08t03wgu
         763/+rVhvc1Po8WMzQgnzJLANEsQ/1zpp6wwnMmHp+Ke9GnLR5yYqL4qFMYnU+ow6kyG
         iRYWV8McFsAMdNabsBAmaqaYikRjbY7aNfo/KyIsIoA8BsmYwLjSSZAHc+W1jxGZJLDv
         TwSnIqJNfIPdaLLQwK3p7W/UIXVU0xZ5zv3VVHwovWd7f/ODDSsnDPTVja0/8Q1S6FKY
         fEVL25tguXp3V6kz8sPKUAVRDeJ1SccjSU2HesV2w3WcAg3jxi9fXNK97jmqCsrd8kyR
         GEew==
In-Reply-To: <5297FC23.3030507@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/29/2013 10:29 AM, Chen Gang wrote:
> Only find "DECLARE_EXPORT(__hexagon_*i3)", no related implementations
> and callers, so remove them, or will cause ld issue with allmodconfig,
> the related error:
> 
>     LD      init/built-in.o
>   arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_umodsi3+0x0): undefined reference to `__hexagon_umodsi3'
>   arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_udivsi3+0x0): undefined reference to `__hexagon_udivsi3'
>   arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_modsi3+0x0): undefined reference to `__hexagon_modsi3'
>   arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_divsi3+0x0): undefined reference to `__hexagon_divsi3'
> 

Oh, sorry, this patch need improved, we can not only remove them simply
(although really no related callers and implementations), I will send
patch v2 later when finish allmodconfig.

Thanks.

> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/hexagon/kernel/hexagon_ksyms.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
> index 32b1379..1257c85 100644
> --- a/arch/hexagon/kernel/hexagon_ksyms.c
> +++ b/arch/hexagon/kernel/hexagon_ksyms.c
> @@ -33,8 +33,3 @@ EXPORT_SYMBOL(memset);
>  
>  /* Symbols found in libgcc that assorted kernel modules need */
>  DECLARE_EXPORT(__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes);
> -
> -DECLARE_EXPORT(__hexagon_divsi3);
> -DECLARE_EXPORT(__hexagon_modsi3);
> -DECLARE_EXPORT(__hexagon_udivsi3);
> -DECLARE_EXPORT(__hexagon_umodsi3);
> 


-- 
Chen Gang
