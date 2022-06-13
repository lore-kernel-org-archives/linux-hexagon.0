From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 21/36] x86/tdx: Remove TDX_HCALL_ISSUE_STI
Date: Mon, 13 Jun 2022 10:41:27 +0200
Message-ID: <Yqb4N3iwh1X7378o@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.251109029@infradead.org>
 <CAJhGHyCnu_BsKf5STMMJKMWm0NVZ8qXT8Qh=BhhCjSSgwchL3Q@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TBu1hM1Fbte1hrb329bc3ivTNLPSxYZoE9gYu5eRiHg=; b=KxzripGEv6RXnFm15+8ZNtwXqY
        Y0JQlZmUiuwVauVjo8mNReXrjzu7dWBx//TAFwSPTKyr6Zo77tWh01rzDl7XPFXl1EJF1ttjF28Oa
        Y26cGarHrml+WTzUDghfHXbs5buhMtFUXZKnD8izBxoX/odIuIn/MS3zL+yigJd7n7oUAZgV4ByN7
        p6X3IE5tp4AkqXkq6o5D71vN0FpfLBNWJd/uWUgeZWDMiUNKEwdAFHXa2Yb8/dwobM0HWB5ZW2n2y
        erfG8/B2Ujcs2fyWLmikq2G1n9ndEAxh8tSaS3kLIgdEhCz5PunbXVo7FDX4cQ6brXM4ITD5NqgrB
        fH7JUAsQ==;
Content-Disposition: inline
In-Reply-To: <CAJhGHyCnu_BsKf5STMMJKMWm0NVZ8qXT8Qh=BhhCjSSgwchL3Q@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, Will Deacon <will@kernel.org>, guoren@kernel.org, bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@hansenpartnership.com, deller@gmx.de, Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org, 

On Mon, Jun 13, 2022 at 04:26:01PM +0800, Lai Jiangshan wrote:
> On Wed, Jun 8, 2022 at 10:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Now that arch_cpu_idle() is expected to return with IRQs disabled,
> > avoid the useless STI/CLI dance.
> >
> > Per the specs this is supposed to work, but nobody has yet relied up
> > this behaviour so broken implementations are possible.
> 
> I'm totally newbie here.
> 
> The point of safe_halt() is that STI must be used and be used
> directly before HLT to enable IRQ during the halting and stop
> the halting if there is any IRQ.

Correct; on real hardware. But this is virt...

> In TDX case, STI must be used directly before the hypercall.
> Otherwise, no IRQ can come and the vcpu would be stalled forever.
> 
> Although the hypercall has an "irq_disabled" argument.
> But the hypervisor doesn't (and can't) touch the IRQ flags no matter
> what the "irq_disabled" argument is.  The IRQ is not enabled during
> the halting if the IRQ is disabled before the hypercall even if
> irq_disabled=false.

All we need the VMM to do is wake the vCPU, and it can do that,
irrespective of the guest's IF.

So the VMM can (and does) know if there's an interrupt pending, and
that's all that's needed to wake from this hypercall. Once the vCPU is
back up and running again, we'll eventually set IF again and the pending
interrupt will get delivered and all's well.

Think of this like MWAIT with ECX[0] set if you will.
