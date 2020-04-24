From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] hexagon: suppress error message for 'make clean'
Date: Fri, 24 Apr 2020 14:06:21 -0500
Message-ID: <009101d61a6b$71f93a70$55ebaf50$@codeaurora.org>
References: <20200424161502.656103-1-masahiroy@kernel.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587755196; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Y0Xh9YwcFuchacYRPmOt5mmHgQmhT+OyA1r+OZ9piB0=; b=QRKaD2CJGHgqPpFlWiiZ5fd2krVfg9T8KE1fMlTclEVmZxykQP0wCRngqtap6ygi7c9e4i+c
 WDk6mRgfFCtGogvHYPp2aOIswrAZoa22Q5hCdBOUQBpSB6UovzCrQl8L1g6X1vBsgv3z4nhj
 +tXA+0kt2pYkZ3t0QjTD1mDxpJ8=
In-Reply-To: <20200424161502.656103-1-masahiroy@kernel.org>
Content-Language: en-us
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Masahiro Yamada' <masahiroy@kernel.org>, linux-hexagon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-hexagon-owner@vger.kernel.org <linux-hexagon-
> owner@vger.kernel.org> On Behalf Of Masahiro Yamada
...
> 'make ARCH=hexagon clean' emits an error message as follows:
> 
>   $ make ARCH=hexagon clean
>   gcc: error: unrecognized command line option '-G0'
> 
> You can suppress it by setting the correct CROSS_COMPILE=, but we should
> not require any compiler for cleaning.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Acked-by: Brian Cain <bcain@codeaurora.org>


> ---
> 
>  arch/hexagon/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile index
> 4c5858b80f0e..c168c6980d05 100644
> --- a/arch/hexagon/Makefile
> +++ b/arch/hexagon/Makefile
> @@ -30,7 +30,7 @@ TIR_NAME := r19
>  KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -
> DTHREADINFO_REG=$(TIR_NAME) -D__linux__  KBUILD_AFLAGS += -
> DTHREADINFO_REG=$(TIR_NAME)
> 
> -LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> +LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name
> +2>/dev/null)
>  libs-y += $(LIBGCC)
> 
>  head-y := arch/hexagon/kernel/head.o
> --
> 2.25.1

