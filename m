From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
Date: Fri, 19 Jun 2015 14:19:43 +1000
Message-ID: <1434687583.23771.5.camel@ellerman.id.au>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
	 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434386579-6045-2-git-send-email-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Long <dave.long@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>, Behan Webster <behanw@converseincode.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Paris <eparis@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>, Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>, Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kerne

On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
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
>  arch/powerpc/kernel/ptrace.c | 5 -----

Built and booted on powerpc, but is there an easy way to actually test the code
paths in question?

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

