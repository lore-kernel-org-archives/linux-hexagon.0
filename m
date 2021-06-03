From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
Date: Thu, 3 Jun 2021 11:59:51 -0500
Message-ID: <09a501d75899$df036060$9d0a2120$@codeaurora.org>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-2-nathan@kernel.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739606; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=6sGBQMxHgyxCwDyzxIWgWc7VKrWyLjlK6AkJSzo3n/M=; b=l6DHztRDgfxmY003GCfsyiPluspjgQmCCiATlmi7y8ZHW+sMQH3R2618bg05H0kfsnlRkFa3
 TPNwh/v7aujArOLpp78WmjQ7LtByxC0QBhnq1US/2S82YmhYVVt38UEb9tt8lVr+kaMz6ZwH
 zFqDSc5vRtkvS/F999HnTnSavFY=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210521011239.1332345-2-nathan@kernel.org>
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
> Subject: [PATCH 1/3] hexagon: Handle {,SOFT}IRQENTRY_TEXT in linker script
> 
> Patch "mm/slub: use stackdepot to save stack trace in objects" in -mm
> selects CONFIG_STACKDEPOT when CONFIG_STACKTRACE_SUPPORT is
> selected and
> CONFIG_STACKDEPOT requires IRQENTRY_TEXT and SOFTIRQENTRY_TEXT to
> be
> handled after commit 505a0ef15f96 ("kasan: stackdepot: move
> filter_irq_stacks() to stackdepot.c") due to the use of the
> __{,soft}irqentry_text_{start,end} section symbols. If those sections
> are not handled, the build is broken.
> 
> $ make ARCH=hexagon CROSS_COMPILE=hexagon-linux- LLVM=1 LLVM_IAS=1
> defconfig all
> ...
> ld.lld: error: undefined symbol: __irqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __irqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __softirqentry_text_start
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> 
> ld.lld: error: undefined symbol: __softirqentry_text_end
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> >>> referenced by stackdepot.c
> >>>               stackdepot.o:(filter_irq_stacks) in archive
lib/built-in.a
> ...
> 
> Add these sections to the Hexagon linker script so the build continues
> to work. ld.lld's orphan section warning would have caught this prior to
> the -mm commit mentioned above:
> 
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> ld.lld: warning: kernel/built-in.a(softirq.o):(.softirqentry.text) is
being placed in
> '.softirqentry.text'
> 
> Fixes: 505a0ef15f96 ("kasan: stackdepot: move filter_irq_stacks() to
> stackdepot.c")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1381
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S
> b/arch/hexagon/kernel/vmlinux.lds.S
> index 35b18e55eae8..20f19539c5fc 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -38,6 +38,8 @@ SECTIONS
>  	.text : AT(ADDR(.text)) {
>  		_text = .;
>  		TEXT_TEXT
> +		IRQENTRY_TEXT
> +		SOFTIRQENTRY_TEXT
>  		SCHED_TEXT
>  		CPUIDLE_TEXT
>  		LOCK_TEXT
> --
> 2.32.0.rc0

Acked-by: Brian Cain <bcain@codeaurora.org>

