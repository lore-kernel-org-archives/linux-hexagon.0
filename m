From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH 2/3] hexagon: Use common DISCARDS macro
Date: Thu, 3 Jun 2021 11:59:57 -0500
Message-ID: <09a801d75899$e24c97f0$a6e5c7d0$@codeaurora.org>
References: <20210521011239.1332345-1-nathan@kernel.org> <20210521011239.1332345-3-nathan@kernel.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622739624; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=/pHlYIqIuh+eZ1QKQJtdnJ5xmRU/hum2lRn0qX6Gm0U=; b=Fs6poXv8SgIcQ1pJPR9TrLuZ6DXQlChJ3yuULQEBgNrD17DCUlFDFzKlO6IWcNga+G2cnZQ5
 n6gxhbX9rk7jq86Xtsr86CCeQEKDAz31RCLDoyVgjvBi1bR2NajJV/GU92hLESRCYMz96AJ+
 H0pacsQJ9+jNqRv5dxggEz1SLYk=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210521011239.1332345-3-nathan@kernel.org>
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
> Subject: [PATCH 2/3] hexagon: Use common DISCARDS macro
> 
> ld.lld warns that the '.modinfo' section is not currently handled:
> 
> ld.lld: warning: kernel/built-in.a(workqueue.o):(.modinfo) is being placed
in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(printk/printk.o):(.modinfo) is being
placed in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(irq/spurious.o):(.modinfo) is being
placed in
> '.modinfo'
> ld.lld: warning: kernel/built-in.a(rcu/update.o):(.modinfo) is being
placed in
> '.modinfo'
> 
> The '.modinfo' section was added in commit 898490c010b5 ("moduleparam:
> Save information about built-in modules in separate file") to the
> DISCARDS macro but Hexagon has never used that macro. The unification of
> DISCARDS happened in commit 023bf6f1b8bf ("linker script: unify usage of
> discard definition") in 2009, prior to Hexagon being added in 2011.
> 
> Switch Hexagon over to the DISCARDS macro so that anything that is
> expected to be discarded gets discarded.
> 
> Fixes: e95bf452a9e2 ("Hexagon: Add configuration and makefiles for the
> Hexagon architecture.")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/hexagon/kernel/vmlinux.lds.S | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S
> b/arch/hexagon/kernel/vmlinux.lds.S
> index 20f19539c5fc..57465bff1fe4 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -61,14 +61,9 @@ SECTIONS
> 
>  	_end = .;
> 
> -	/DISCARD/ : {
> -		EXIT_TEXT
> -		EXIT_DATA
> -		EXIT_CALL
> -	}
> -
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  	ELF_DETAILS
> 
> +	DISCARDS
>  }
> --
> 2.32.0.rc0

Acked-by: Brian Cain <bcain@codeaurora.org>

