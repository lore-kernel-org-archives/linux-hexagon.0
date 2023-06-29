From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 06/12] arch: Declare screen_info in <asm/screen_info.h>
Date: Thu, 29 Jun 2023 15:03:20 +0200
Message-ID: <b31f42c1-4283-4793-b448-f7b9326be5d4@app.fastmail.com>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-7-tzimmermann@suse.de>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688043823; x=1688130223; bh=UU
        HaYOR2mXOloOMHF3WLMCOR1A2U5vkl9suJPqtiWo0=; b=MrZKZHz8n89eIUCcId
        WXghgyhn+F5Y91JfHNG7h6bRVjajE8fTPAAhjd5yTneIb4wXSmpq1LbKXeSmewdI
        sjdK3BzECiJ9VsNHc2PNHRoZhm3xRYAm+niXcO3LaQQU4MhSkHRgNL7KekTbhGST
        XCtAL/9vFB8aEMmwPzbk/lKYaOw3o3ta7pbwYVJoUl4935nDF9T6MZnBnxl2NyE7
        45XG/pQFMaOjg4FsJiuQ0OJjKw2rT3OTyLreg4EK69iWblkKDeRqN9hM0nHAreco
        4RI2C7HjAM7m3bAIxsusNPU7K1/tqKHlRAu78xIkM/MvkFfL8/VzpTp9irh6eiv1
        BUyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688043823; x=1688130223; bh=UUHaYOR2mXOlo
        OMHF3WLMCOR1A2U5vkl9suJPqtiWo0=; b=cw+4bxWp1SCuh1Fepi9QaF0if2xkJ
        4cVNwE6L2Y8B0BZ4j9mhs/w9CTABQ9uk/lLli7KdPcxXX5GNTfzwwEySah2SpLb8
        3Aufg0geWX/HnfgPaOANO2QzCTk7sUuxlOKDej+fIqwnaRnTlWOjf1PvCQRQ1mQ0
        CXujhLdJDB5jYKlNYIPiNMNvbVyuShIxf7Z2hPXbTAnwB8HTZUAxnS+3doFVCZfS
        gmb4I1VMLKW5DeH4sul6m4UUqvsEZj5uqrhNhN+sCrKAZmp5/84QBsLfhkM2pVjK
        QvJS+nuvgBir+CxBeaUMXNbGK4UqHWvJ/CRH9X+edp1kdt3CdxMbNaTXQ==
In-Reply-To: <20230629121952.10559-7-tzimmermann@suse.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.mari>

On Thu, Jun 29, 2023, at 13:45, Thomas Zimmermann wrote:

> diff --git a/include/asm-generic/screen_info.h 
> b/include/asm-generic/screen_info.h
> new file mode 100644
> index 0000000000000..6fd0e50fabfcd
> --- /dev/null
> +++ b/include/asm-generic/screen_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_GENERIC_SCREEN_INFO_H
> +#define _ASM_GENERIC_SCREEN_INFO_H
> +
> +#include <uapi/linux/screen_info.h>
> +
> +#if defined(CONFIG_ARCH_HAS_SCREEN_INFO)
> +extern struct screen_info screen_info;
> +#endif
> +
> +#endif /* _ASM_GENERIC_SCREEN_INFO_H */
> diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
> index eab7081392d50..c764b9a51c24b 100644
> --- a/include/linux/screen_info.h
> +++ b/include/linux/screen_info.h
> @@ -4,6 +4,6 @@
> 
>  #include <uapi/linux/screen_info.h>
> 
> -extern struct screen_info screen_info;
> +#include <asm/screen_info.h>
> 

What is the purpose of adding a file in asm-generic? If all
architectures use the same generic file, I'd just leave the
declaration in include/linux/. I wouldn't bother adding the
#ifdef either, but I can see how that helps turn a link
error into an earlier compile error.

      Arnd
