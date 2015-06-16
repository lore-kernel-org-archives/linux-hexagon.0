From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Tue, 16 Jun 2015 08:17:47 -0500
Message-ID: <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org> <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XlRTAokm64fxEMdVurbMp3QY0LOqEuzFR6VZ1KO4Cdw=;
        b=UhtzrWLoyaH0vogTp3kBDx/9Ol+a4YdtAuJtPXE9rjER9miz9QMSgkJTD9XxvwNlr7
         s2z9Esm4LEDv2KSsW8UOa7eiYdR2ko+5sQ5sQZAgbYP+U+u6L1k1Nd7jTNtKfwpruJhs
         IO7C1z3d/ZeriwIgHfoL8Amuf1VARzvhV00AWPHiQ7rQTdeM4rrLUl8TO2f5wm+vtz5K
         twRTpgwPUrNvpgobogcRX+pG7jxXT3z6wWjjjCYidF+S8t31j4qq2FR2fXHG6jo+OJ83
         HtJINj/YxeHa4up9q4bvDxHKdfM9oKeq7HPJ85ngeqO/gJ808IRZMAm6C/4LU3gZoEXs
         nzzw==
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-k>

On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> From: "David A. Long" <dave.long@linaro.org>
>
> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>  feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h.
>
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/kernel/ptrace.c     | 5 -----
>  arch/powerpc/kernel/ptrace.c | 5 -----
>  arch/sh/include/asm/ptrace.h | 5 -----
>  arch/x86/kernel/ptrace.c     | 5 -----
>  include/linux/ptrace.h       | 9 +++++++++
>  5 files changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ef9119f..fb45cf1 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -59,11 +59,6 @@
>  #define BREAKINST_THUMB        0xde01
>  #endif
>
> -struct pt_regs_offset {
> -       const char *name;
> -       int offset;
> -};
> -
>  #define REG_OFFSET_NAME(r) \
>         {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
>  #define REG_OFFSET_END {.name = NULL, .offset = 0}

Can't you also move these? ARM is complicated with the "ARM_"
prefixing, but the others appear to be the same. Maybe you can remove
the prefix or redefine the macro for ARM.

Rob
