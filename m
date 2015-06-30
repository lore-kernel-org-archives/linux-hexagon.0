From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Tue, 30 Jun 2015 13:29:05 +1000
Message-ID: <1435634945.24866.2.camel@ellerman.id.au>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
	 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
	 <CAL_JsqK3L9Hv9bhAtwAAXVYjLJBTOG9=4ddOo-SFqnD-_KieCQ@mail.gmail.com>
	 <5581BCD0.2040405@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <5581BCD0.2040405@linaro.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Long <dave.long@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>

On Wed, 2015-06-17 at 14:30 -0400, David Long wrote:
> On 06/16/15 09:17, Rob Herring wrote:
> > On Mon, Jun 15, 2015 at 11:42 AM, David Long <dave.long@linaro.org> wrote:
> >>
> >>   #define REG_OFFSET_NAME(r) \
> >>          {.name = #r, .offset = offsetof(struct pt_regs, ARM_##r)}
> >>   #define REG_OFFSET_END {.name = NULL, .offset = 0}
> >
> > Can't you also move these? ARM is complicated with the "ARM_"
> > prefixing, but the others appear to be the same. Maybe you can remove
> > the prefix or redefine the macro for ARM.
> 
> That would mandate that all the architecture-specific pt_regs structures 
> would have to use a top-level named field for each named register.

Why does it mandate that?

See eg. powerpc where we use REG_OFFSET_NAME for the top-level named fields and
then a different macro for the array elements:

  #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
  #define GPR_OFFSET_NAME(num)	\
  	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
  
  static const struct pt_regs_offset regoffset_table[] = {
  	GPR_OFFSET_NAME(0),
  	GPR_OFFSET_NAME(1),
  	GPR_OFFSET_NAME(2),
  	GPR_OFFSET_NAME(3),
  	...
  	REG_OFFSET_NAME(nip),
  	REG_OFFSET_NAME(msr),


So I don't see why REG_OFFSET_NAME couldn't be common.

cheers



