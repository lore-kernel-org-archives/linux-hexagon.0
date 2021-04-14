From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] init: consolidate trap_init()
Date: Wed, 14 Apr 2021 11:10:42 +0200
Message-ID: <44bdf1f1-117d-0f10-fc59-9edd32d1ad61@csgroup.eu>
References: <20210414165808.458a3d11@xhacker.debian>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20210414165808.458a3d11@xhacker.debian>
Content-Language: fr
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@da>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-parisc@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org



Le 14/04/2021 à 10:58, Jisheng Zhang a écrit :
> Many architectures implement the trap_init() as NOP, since there is
> no such default for trap_init(), this empty stub is duplicated among
> these architectures. Provide a generic but weak NOP implementation
> to drop the empty stubs of trap_init() in these architectures.

You define the weak function in the __init section.

Most but not all architectures had it in __init section.

And the remaining ones may not be defined in __init section. For instance look at the one in alpha 
architecture.

Have you checked that it is not a problem ? It would be good to say something about it in the commit 
description.


> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   arch/arc/kernel/traps.c      |  5 -----
>   arch/arm/kernel/traps.c      |  5 -----
>   arch/h8300/kernel/traps.c    | 13 -------------
>   arch/hexagon/kernel/traps.c  |  4 ----
>   arch/nds32/kernel/traps.c    |  5 -----
>   arch/nios2/kernel/traps.c    |  5 -----
>   arch/openrisc/kernel/traps.c |  5 -----
>   arch/parisc/kernel/traps.c   |  4 ----
>   arch/powerpc/kernel/traps.c  |  5 -----
>   arch/riscv/kernel/traps.c    |  5 -----
>   arch/um/kernel/trap.c        |  4 ----
>   init/main.c                  |  2 ++
>   12 files changed, 2 insertions(+), 60 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 53b278845b88..4bdbe2928530 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -790,6 +790,8 @@ static inline void initcall_debug_enable(void)
>   }
>   #endif
>   
> +void __init __weak trap_init(void) { }
> +

I think in a C file we don't try to save space as much as in a header file.

I would prefer something like:


void __init __weak trap_init(void)
{
}


>   /* Report memory auto-initialization states for this boot. */
>   static void __init report_meminit(void)
>   {
> 
