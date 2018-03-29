From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Thu, 29 Mar 2018 16:27:49 +0100
Message-ID: <20180329152749.GC16141@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LGDg/QOAAJpsDz9revNXwfQoBOf1buk3Pn/Qsaw7at0=; b=kyNHtjXZHbMcW6
	/01BFBSLKKXFn4DpjznZPnI0fKMDJwk83WlVRhZRN4+QbkMbeWFMNkbWGDWHit9DHmpS+x+1UM1Hy
	IDGzx/hKLegTMEaUVqyaMvdi2M86MRywL8O8bcoJwr94GFV1uERVkbTP96QOjA3OIfqklY+8lw55d
	aoRhROKlc9UXyNzrbDigzMqMBY3CZ25+1fXYYN9ZdWoStslr1/cxteHIqQBglBI/nmlGUl2v/I8T3
	ItFIQJkgZUmq/v85kIwAcXOn8vUIGwRF+DiS2ZJO96grmPQ1lEFlEd6hagZUEOL3HTJshllGQQnBi
	V4d0x8/7qY6/cjOdjdOQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; 
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=tszDhZ36qEhT+cbTS7MjWHFiFTBM6apHylUvgVhpCDU=; 
 b=ePCJ3cfQtbtO22sc7en39ZLcmdH6emq7dEEGhg8fX1MiI/9AhxLwBaq+AYg6OMAKCFubi1fxiKN2DQnIkFutq/xQEwTsmyb/8OGs3gV/QxEUBhhthVlav3Q4rZ7ZJnSA+UawAPxOjnrdYrWzXt2cauVD3gcKrBe2An01ICmGxzI=;
Content-Disposition: inline
In-Reply-To: <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Oliver <oohall@gmail.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfou>

On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> >>
> >>
> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> >> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> >> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
> >> >>> Now only those architectures that have custom initrd free requirements
> >> >>> need to define free_initrd_mem.
> >> >> ...
> >> >>> --- a/arch/arc/mm/init.c
> >> >>> +++ b/arch/arc/mm/init.c
> >> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >> >>>  {
> >> >>>   free_initmem_default(-1);
> >> >>>  }
> >> >>> -
> >> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> >> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >> >>> -{
> >> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >> >>> -}
> >> >>> -#endif
> >> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> >>> index 3f972e83909b..19d1c5594e2d 100644
> >> >>> --- a/arch/arm/Kconfig
> >> >>> +++ b/arch/arm/Kconfig
> >> >>> @@ -47,6 +47,7 @@ config ARM
> >> >>>   select HARDIRQS_SW_RESEND
> >> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >> >>> + select HAVE_ARCH_FREE_INITRD_MEM
> >> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
> >> >>
> >> >> Isn't this why weak symbols were invented?
> >> >
> >> > Weak symbols means that we end up with both the weakly-referenced code
> >> > and the arch code in the kernel image.  That's fine if the weak code
> >> > is small.
> >>
> >> The kernel's been able to build with link time garbage collection since 2016:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> >>
> >> Wouldn't that remove the unused one?
> >
> > Probably, if anyone bothered to use that, which they don't.
> >
> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > what I can see, nothing selects it.  Therefore, the symbol is always
> > disabled, and so the feature never gets used in mainline kernels.
> >
> > Brings up the obvious question - why is it there if it's completely
> > unused?  (Maybe to cause confusion, and allowing a justification
> > for __weak ?)
> 
> IIRC Nick had some patches to do the arch enablement for powerpc, but
> I'm not sure what happened to them though. I suspect it just fell down
> Nick's ever growing TODO list.

I've given it a go on ARM, marking every linker-built table with KEEP()
and comparing the System.map files.  The resulting kernel is around
150k smaller, which seems good.

However, it doesn't boot - and I don't know why.  Booting the kernel
under kvmtool in a VM using virtio-console, I can find no way to get
any kernel messages out of it.  Using lkvm debug, I can see that the
PC is stuck inside die(), and that's the only information I have.
It dies before bringing up the other CPUs, so it's a very early death.

I don't think other console types are available under ARM64.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
