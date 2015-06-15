From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] Consolidate redundant register/stack access code
Date: Mon, 15 Jun 2015 13:44:42 -0700
Message-ID: <CAGXu5jJ7i6qgUOXuaNJ8vT7+D+6_C_hrOwWHZA+6f9zFJQ+Vbw@mail.gmail.com>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=neaCC0/4A2PmRXGmM9lScaTvK6iPRM9zQWCZ31ehZfI=;
        b=VU2Qq4fsc/N2ltOJSKbTk3aK/M7AY10+qD4o5GMZG6Tqesfyg/wzw5fRDdLe7SWM9w
         Qo1ssH1RJuN4OzLCkH3qyu4nI/MoGYz0qANIxPU1msnOUBDjW0SxbrV8l6ulPQ+ajpg2
         0KQa43P2OPDvPlqoSsHv/OGP2Y4Q3jxLx9/wI7/tSS62CIJAiK3s23HpqNYFQ01k1DqL
         LAhhISl8GEgbKokvb+hyWehVvy0fstfpKF+7lLUHF/3+eowMcCQEU2fAP2KZ1AkWmYWH
         r65C5kvTCgN08mVnjgWr1tjMgrV7bDh8PDunX50fisqDodd+mEWP1B8rQSg9o/WjGwWr
         0gNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=neaCC0/4A2PmRXGmM9lScaTvK6iPRM9zQWCZ31ehZfI=;
        b=dYibaP4ioGAQYaTcnH1/8ZRR0lMO2NewPwjbbTLpbXbYbfe2SSyoAAQJcae+ceC36I
         8D5qZZRZzwkIyoAhLaImyVNrYZJfqqUE5V5O3yMaq5RWwwnrekFvveuOJEEKZ6GtSP0Z
         bqgKJnd0eOozrkbMyk5dbn7A57lJOAt1ats4I=
In-Reply-To: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-h

On Mon, Jun 15, 2015 at 9:42 AM, David Long <dave.long@linaro.org> wrote:
> From: "David A. Long" <dave.long@linaro.org>
>
> Move duplicate and functionally equivalent code for accessing registers
> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> common kernel files.
>
> Note: Help regression testing s390, hexagon, and sh would be appreciated.
>       Powerpc builds but I have not verified the functionality.
>
> David A. Long (2):
>   Move the pt_regs_offset struct definition from arch to common include
>     file
>   Consolidate redundant register/stack access code
>
>  arch/arm/include/asm/ptrace.h          |  6 ---
>  arch/arm/kernel/ptrace.c               | 72 +---------------------------------
>  arch/hexagon/include/uapi/asm/ptrace.h |  3 --
>  arch/powerpc/include/asm/ptrace.h      | 38 ------------------
>  arch/powerpc/kernel/ptrace.c           | 39 +-----------------
>  arch/s390/include/asm/ptrace.h         |  3 --
>  arch/s390/kernel/ptrace.c              | 70 ++++++++++-----------------------
>  arch/sh/include/asm/ptrace.h           | 44 ---------------------
>  arch/sh/kernel/Makefile                |  2 +-
>  arch/sh/kernel/ptrace.c                | 33 ----------------
>  arch/sh/kernel/ptrace_32.c             |  2 +-
>  arch/sh/kernel/ptrace_64.c             |  2 +-
>  arch/x86/include/asm/ptrace.h          | 37 -----------------
>  arch/x86/kernel/ptrace.c               | 39 +-----------------
>  include/linux/ptrace.h                 | 51 ++++++++++++++++++++++++
>  kernel/ptrace.c                        | 38 ++++++++++++++++++
>  16 files changed, 116 insertions(+), 363 deletions(-)
>  delete mode 100644 arch/sh/kernel/ptrace.c

I love the deletions:insertions ratio! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

I wonder why arm64 doesn't define CONFIG_HAVE_REGS_AND_STACK_ACCESS_API?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
