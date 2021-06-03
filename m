From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
Date: Thu, 3 Jun 2021 11:59:55 -0500
Message-ID: <09a701d75899$e116d710$a3448530$@codeaurora.org>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-4-nathan@kernel.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739614; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=GpFa0F1nBiz7gXdJe/yKy7CwUy3wkvYy2FupJZqvlCY=; b=DoxK3kSQDZ4vNOYVBfkGc0CQ6dxxTjCyIAFcwUY7XInDGkR9/o3ewV9t6QM6ulfCWbqfnRJI
 A7H7OpuEHGDHanGKR37/wgTpBm7yazGriLn4ZeKkS4SuXhSw0X4HMzgkxvS+FRWg/wyt9dWX
 zJ13LhmWJ9wDt3LHEOXMvP2Sg+k=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210521011239.1332345-4-nathan@kernel.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nathan Chancellor' <nathan@kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Thursday, May 20, 2021 8:13 PM
> To: Brian Cain <bcain@codeaurora.org>; Andrew Morton <akpm@linux-
> foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>; linux-
> hexagon@vger.kernel.org; linux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Nathan Chancellor <nathan@kernel.org>
> Subject: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
> 
> Now that we handle all of the sections in a Hexagon defconfig, select
> ARCH_WANT_LD_ORPHAN_WARN so that unhandled sections are warned
> about by
> default.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 44a409967af1..e5a852080730 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -30,6 +30,7 @@ config HEXAGON
>  	select MODULES_USE_ELF_RELA
>  	select GENERIC_CPU_DEVICES
>  	select SET_FS
> +	select ARCH_WANT_LD_ORPHAN_WARN
>  	help
>  	  Qualcomm Hexagon is a processor architecture designed for high
>  	  performance and low power across a wide variety of applications.
> --
> 2.32.0.rc0

Acked-by: Brian Cain <bcain@codeaurora.org>

