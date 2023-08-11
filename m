From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Date: Fri, 11 Aug 2023 21:09:06 +0100
Message-ID: <ZNaVYh2qi0VQQKWf@antec>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691784547; x=1692389347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiId7A5uZw2EU8qqzqo15ZE/APG2EJpcQ/tYWVbt9lY=;
        b=BaZ+dUQu/1Rh/HmooCs5qesrlznNZmxKQcjlG6xS3H9tMBq45bWpSP/e/I9VW7Q4Xg
         AYC3dIvP3Tshg4rhk7854uV/UhGx97vQN7Rf3ZCaEHHAoEtsxEWEmUpcEhAOLyHKUkRY
         HVVMWwEzTKjzju9rFIbSEBbfEjRns5F4jM4I+IGUunaEP+fCDTpk2oAvMHx4dL7U2RGZ
         4aZGEHqsVqDzd/Dx1nigupYSSEd6i5SYdVQlhZnYf0HmP1+JX1iQyYjTZ7iJO25zwy/W
         meLkO9bC2fWzC7AP4RiEm000UPRoQTx/kvFqN+cmSypY/c7NuSjR+Di9RfLfbQvrmzWa
         O7Lw==
Content-Disposition: inline
In-Reply-To: <20230810141947.1236730-17-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe

On Thu, Aug 10, 2023 at 04:19:34PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
,,, 
> ---
> Below is the full list of warnings I see in defconfig builds for reference, these
> do not need to be part of the changelog.
...
> arch/openrisc/kernel/process.c:100:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
> arch/openrisc/kernel/process.c:240:21: error: no previous prototype for '__switch_to' [-Werror=missing-prototypes]
> arch/openrisc/kernel/ptrace.c:191:17: error: no previous prototype for 'do_syscall_trace_enter' [-Werror=missing-prototypes]
> arch/openrisc/kernel/ptrace.c:210:17: error: no previous prototype for 'do_syscall_trace_leave' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:227:5: error: no previous prototype for 'do_signal' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:293:1: error: no previous prototype for 'do_work_pending' [-Werror=missing-prototypes]
> arch/openrisc/kernel/signal.c:68:17: error: no previous prototype for '_sys_rt_sigreturn' [-Werror=missing-prototypes]
> arch/openrisc/kernel/time.c:111:25: error: no previous prototype for 'timer_interrupt' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:146:6: error: no previous prototype for 'nommu_dump_state' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:221:17: error: no previous prototype for 'die' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:239:17: error: no previous prototype for 'unhandled_exception' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:246:17: error: no previous prototype for 'do_fpe_trap' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:268:17: error: no previous prototype for 'do_trap' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:273:17: error: no previous prototype for 'do_unaligned_access' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:286:17: error: no previous prototype for 'do_bus_fault' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:462:17: error: no previous prototype for 'do_illegal_instruction' [-Werror=missing-prototypes]
> arch/openrisc/kernel/traps.c:67:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]
> arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
> arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]

I'll try to get these fixed for 6.6.  I was looking at them recently but did not
actually make any changes and just put on my TODO.  Your series moves it up in
priority and it should be easy to get the fixes out.

...

> diff --git a/init/Kconfig b/init/Kconfig
> index 639e8a3363c30..80cd67c0d7fa4 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -170,6 +170,16 @@ config WERROR
>  
>  	  If in doubt, say Y.
>  
> +config WNO_MISSING_PROTOTYPES
> +	bool "Hide -Wmissing-prototype warnings in arch code"
> +	default WERROR || !COMPILE_TEST
> +	help
> +	  Some architectures have not yet eliminated all warnings for
> +	  missing prototypes in their core code and will produce a lot
> +	  of output for these. Ideally these should all be addresszed

addressed

> +	  by individual bugfix patches, but in the meantime saying 'y'
> +	  will skip that output.
> +
>  config UAPI_HEADER_TEST
>  	bool "Compile test UAPI headers"
>  	depends on HEADERS_INSTALL && CC_CAN_LINK

-Stafford
