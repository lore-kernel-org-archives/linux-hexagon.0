From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
Date: Mon, 02 Aug 2021 12:56:13 +1000
Message-ID: <87lf5klfle.fsf@mpe.ellerman.id.au>
References: <20210731052233.4703-1-masahiroy@kernel.org>
 <20210731052233.4703-2-masahiroy@kernel.org>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1627872995;
        bh=lgFF44D+VvUgGNOcyjoWgD9ieIKlVa+1W38G93yYucc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mk/OrQNAgyUtJh9QVu/sq6e2cVKMZEuh5t1elkMY1Gr3oABbY0LNl7+izatEJSZYL
         zGYgU92C+VtRG3i2VpinkrgquF7osc3y3sT0rg1Dkyhhq3uC9pQ9Vyxzu9DIdALkJc
         uVe/31b8NqskHAYnC6qUpRqajmu4XqURQ3LIDSg6AKfjRRV0hOE1uY7cgZepVTdX9e
         8HP4jyVzz75vtA5OgyyRq7pJjgDvTYCj/aQ+sFQ1koQ2SqpBgqVF2xnWntozO8y/pw
         uq0H9be0uwkFpXGGeabu1UoeiTG0mQrIQSbO5Gdvb2ehvStkNDQgftwpI5d9vMxe/C
         vq3iTIN0uJtjQ==
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Linus Walleij <linus.walleij@linaro.org>, Ley Foon Tan <ley.foon.tan@intel.com>, x86@kernel.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Nick Hu <nickhu@andestech.com>, Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, YiFei Zhu <yifeifz2@illinois.edu>, Greentime Hu <green.hu@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@g>

Masahiro Yamada <masahiroy@kernel.org> writes:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/Kconfig                  | 3 +++
>  arch/arc/Kconfig              | 4 +---
>  arch/arm/Kconfig              | 5 +----
>  arch/arm64/Kconfig            | 4 +---
>  arch/csky/Kconfig             | 4 +---
>  arch/hexagon/Kconfig          | 4 +---
>  arch/microblaze/Kconfig       | 1 +
>  arch/microblaze/Kconfig.debug | 5 -----
>  arch/mips/Kconfig             | 1 +
>  arch/mips/Kconfig.debug       | 4 ----
>  arch/nds32/Kconfig            | 4 +---
>  arch/nios2/Kconfig            | 3 ---
>  arch/openrisc/Kconfig         | 4 +---
>  arch/parisc/Kconfig           | 1 +
>  arch/parisc/Kconfig.debug     | 3 ---
>  arch/powerpc/Kconfig          | 5 +----
>  arch/riscv/Kconfig            | 4 +---
>  arch/s390/Kconfig             | 1 +
>  arch/s390/Kconfig.debug       | 3 ---
>  arch/sh/Kconfig               | 1 +
>  arch/sh/Kconfig.debug         | 3 ---
>  arch/sparc/Kconfig            | 1 +
>  arch/sparc/Kconfig.debug      | 4 ----
>  arch/um/Kconfig               | 5 +----
>  arch/x86/Kconfig              | 1 +
>  arch/x86/Kconfig.debug        | 3 ---
>  arch/xtensa/Kconfig           | 4 +---
>  27 files changed, 21 insertions(+), 64 deletions(-)

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d01e3401581d..76a28452c042 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -94,10 +94,6 @@ config STACKTRACE_SUPPORT
>  	bool
>  	default y
>  
> -config TRACE_IRQFLAGS_SUPPORT
> -	bool
> -	default y
> -
>  config LOCKDEP_SUPPORT
>  	bool
>  	default y
> @@ -271,6 +267,7 @@ config PPC
>  	select STRICT_KERNEL_RWX if STRICT_MODULE_RWX
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select TRACE_IRQFLAGS_SUPPORT
>  	select VIRT_TO_BUS			if !PPC64
>  	#
>  	# Please keep this list sorted alphabetically.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
