From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
Date: Tue, 1 Jun 2021 12:20:43 -0700
Message-ID: <CAKwvOdn49Nm27rCyyTeGvz4qtL0uNp7ZW_AB_Asc1PdGW=xW7w@mail.gmail.com>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-4-nathan@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l0Qbrea+PxVgdT68iuGwF0mAxIyy2sZ0fOtF/mCAdE=;
        b=NxqHANsd9noU1dytE+vzA0ZU0iV7rpsgI3kFKMXoCmoKp83F1a8PSCZsNNLDEcDqG4
         PyNUoeLYmBc5P+tSCSu2G++2hjnudsCV9oCrwfVLfjHHQ+VAjrGWkCwMx+TliUIckf67
         cWggurPyXcZVZ8BQyoXEr4W9ZI9qVgpWrUWffTQriUsL+nczRV65DjrRRJoutcXEUtyK
         LnDnb8+G3TmmiStxQl5M0HuL7ApFRFu9W0/LEZNpgh+UkchIdZalfGnkL/hzzsM3K8Ux
         hicUScIEpTQ2rb33iDerOraMbzDqakKQpBpFtiuVnPfzLABLnTiY3BsIv15R26Ybk8Tx
         8GFg==
In-Reply-To: <20210521011239.1332345-4-nathan@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <nathan@kernel.org>
Cc: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>

On Thu, May 20, 2021 at 6:13 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Now that we handle all of the sections in a Hexagon defconfig, select
> ARCH_WANT_LD_ORPHAN_WARN so that unhandled sections are warned about by
> default.

Great to see another arch using this build-safety feature!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
>         select MODULES_USE_ELF_RELA
>         select GENERIC_CPU_DEVICES
>         select SET_FS
> +       select ARCH_WANT_LD_ORPHAN_WARN
>         help
>           Qualcomm Hexagon is a processor architecture designed for high
>           performance and low power across a wide variety of applications.
> --
> 2.32.0.rc0
>


-- 
Thanks,
~Nick Desaulniers
