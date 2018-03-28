From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 17:48:14 +0100
Message-ID: <20180328164813.GA3888@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
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
	List-Owner; bh=EnNoqydAdvMP6pR700fSXlr66rfHwTwavSVRXI1y1ns=; b=VtTBw3ivWquJSe
	prLCL9mpZAZ2HX/n6XWepyb1wOYBe5/85DLrapQY7Vw1UCNPG6P2edhbq8r9evISghqp4x7XkrzMC
	6cqFEPkXLFkY/j66CpQ/YGvOjLnEHYweugByalAeeArBz9asrtATfbVYh4HbgDNQb+cBb4tsYj9Ee
	7KX7fMnF7a4CKm/zItEu9Hb7jmCkwIBLBg+UNDttwnGRHhaK4e20vHkm6XBV4ILW0HtICOj06LabK
	MxqUlAYJ238Fn/f2a+rMGMPiaUj0mzRJIi0x4yj/eXxSdbg2arALn9Rqg0C3I/m7xg2v1F/i16lyX
	khiDXdqY0bWNFJuZ8A3g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; 
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=iIi57hmdUHu/G2PcLLQKVvJN4dL/nzk3JYon59E2zQw=; 
 b=oPiSPwhddBJyyLAmQs82TiFjpBPcivwJE1urXf3p86d0WxbL8DoulegTAuymldkTeBcDVs27e/6SY7qPC0e4j8mHC3RtDJmRUdQ9imnetv5boESAorrcRiN0yIFjQmX2iQM/2GKmudUkkEVULeq+6PWKqra7v5hkz6dXbaH5m8w=;
Content-Disposition: inline
In-Reply-To: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
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
To: Rob Landley <rob@landley.net>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Christoph Hellwig <hch@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, uclinux-h8-devel@lists.sourceforge.jp, Vladimir Murzin <vladimir.murzin@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, adi-buildroot-devel@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, linux-cris-kernel@axis.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kerne

On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> On 03/28/2018 10:26 AM, Shea Levy wrote:
> > Now only those architectures that have custom initrd free requirements
> > need to define free_initrd_mem.
> ...
> > --- a/arch/arc/mm/init.c
> > +++ b/arch/arc/mm/init.c
> > @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >  {
> >  	free_initmem_default(-1);
> >  }
> > -
> > -#ifdef CONFIG_BLK_DEV_INITRD
> > -void __init free_initrd_mem(unsigned long start, unsigned long end)
> > -{
> > -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> > -}
> > -#endif
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 3f972e83909b..19d1c5594e2d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -47,6 +47,7 @@ config ARM
> >  	select HARDIRQS_SW_RESEND
> >  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> > +	select HAVE_ARCH_FREE_INITRD_MEM
> >  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> 
> Isn't this why weak symbols were invented?

Weak symbols means that we end up with both the weakly-referenced code
and the arch code in the kernel image.  That's fine if the weak code
is small.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
