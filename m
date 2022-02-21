From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
Date: Mon, 21 Feb 2022 15:31:23 +0100
Message-ID: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645453901;
        bh=12Bbx9GqAhHL6qqDyToeCYzPAWe2m8+m6+gTGV+hFTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dWMiI8z7xtZHkIlGi7baHffVMjwIn0mdLtr8w3vUAA5dDZqhK8ZI+KhxrCTrxvery
         mRfleZO0SSscQ7KVHRUh2QGlGW5v/gw6LGH9t2vGIJ9GkNRHieJ694s+DQVSh8xG3o
         1QAKmXJLcJTGwkGYaV1wYGfF51PnInRtSU+fVsx8t4J76oPDgdmMoUbmKLWffZoAAd
         kmIbWlsuSubrQtmT6agHzwSbb3tqK56Q4BV05Zptd15vS9GZroHUtkz4s+wh3Rty9l
         7L/rHU3TLbzMVdK84DCafmUJBj3eUYCSTyyb3m9KPwB8ieX+FNQVnZHH0l+/WrTztv
         U44sZb72pp5dg==
In-Reply-To: <20220221132456.GA7139@alpha.franken.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Pe

On Mon, Feb 21, 2022 at 2:24 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> >
> > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > index db9a8e002b62..d7c89dc3426c 100644
>
> this doesn't work. For every access above maximum implemented virtual address
> space of the CPU an address error will be issued, but not a TLB miss.
> And address error isn't able to handle this situation.

Ah, so the __ex_table entry only catches TLB misses?

Does this mean it also traps for kernel memory accesses, or do those
work again? If the addresses on mips64 are separate like on
sparc64 or s390, the entire access_ok() step could be replaced
by a fixup code in the exception handler. I suppose this depends on
CONFIG_EVA and you still need a limit check at least when EVA is
disabled.

> With this patch
>
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index df4b708c04a9..3911f1481f3d 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -1480,6 +1480,13 @@ asmlinkage void do_ade(struct pt_regs *regs)
>         prev_state = exception_enter();
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
>                         1, regs, regs->cp0_badvaddr);
> +
> +       /* Are we prepared to handle this kernel fault?  */
> +       if (fixup_exception(regs)) {
> +               current->thread.cp0_baduaddr = regs->cp0_badvaddr;
> +               return;
> +       }
> +
>         /*
>          * Did we catch a fault trying to load an instruction?
>          */
>
> I at least get my simple test cases fixed, but I'm not sure this is
> correct.
>
> Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> for the 32bit case ?
>

For 32-bit, the __UA_LIMIT is a compile-time constant, so the check
ends up being trivial. On all other architectures, the same thing can
be done after the set_fs removal, so I was hoping it would work here
as well.

I suspect doing the generic (size <= limit) && (addr <= (limit - size))
check on mips64 with the runtime limit ends up slightly slower
than the current code that checks a bit mask instead. If you like,
I'll update it this way, otherwise I'd need help in form of a patch
that changes the exception handling so __get_user/__put_user
also return -EFAULT for an address error.

       Arnd
