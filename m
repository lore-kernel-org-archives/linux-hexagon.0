From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Date: Wed, 28 Mar 2018 23:14:01 +0100
Message-ID: <20180328221401.GA14084@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
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
	List-Owner; bh=im6eBNoLN8sJoeINblQuxwBG+MYWEvTDfpP356YKkAY=; b=tGsVYspHaAVDjH
	1X7QYBH2N0/yozSsAXExCY5sT6ud5sipnsl44MyaZFv29tkEVg6cxjeTkWxpy7Sp9mRCUvP5tirFw
	i/6LyvO3MHg4B7LTK0sauRoRzV1nqPa/XBB5twPleUUiOEeoqPpuzKvm7lK+ATGUl6PZcWX3mFpVf
	0RhISQS6bzAMQ1l76CJ8oSi/CW6vj5YcuVTmlPmq8vL17RdQ2ZM4EJGBkGYKddje30WyEI8eUvLu1
	Lwm/JclmfxO6bCcCHmE3R2gDHqctmrYcEhoUQ8pe92K7Jd45Ij0Z0xgaHfmV7OylKE7ftQMA7pHIa
	0ECnItYdcLsNP3Y2G6pA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; 
 h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=R6l9I6PvsGbX3NE2xRpmi4yASMm+0pIHUA/D+Vv+P84=; 
 b=gbjR2kk0bv40X9QfjiyNwJUX+5CjStVha/r8BvT9SY4wV5HUGisePY5s6tPYBYEm0VGPJySPFzIPt/PqVBHN/X6+NGAqj7OwAN0i64GlJcfzglZnIuB0Z9JyJv4qZwv6GBbe2N1ntc/rREwqT2LeBvoTBHZ0VqO3lC+PdYPTz7k=;
Content-Disposition: inline
In-Reply-To: <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
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

On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> 
> 
> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
> >>> Now only those architectures that have custom initrd free requirements
> >>> need to define free_initrd_mem.
> >> ...
> >>> --- a/arch/arc/mm/init.c
> >>> +++ b/arch/arc/mm/init.c
> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >>>  {
> >>>  	free_initmem_default(-1);
> >>>  }
> >>> -
> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >>> -{
> >>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >>> -}
> >>> -#endif
> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>> index 3f972e83909b..19d1c5594e2d 100644
> >>> --- a/arch/arm/Kconfig
> >>> +++ b/arch/arm/Kconfig
> >>> @@ -47,6 +47,7 @@ config ARM
> >>>  	select HARDIRQS_SW_RESEND
> >>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >>> +	select HAVE_ARCH_FREE_INITRD_MEM
> >>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> >>
> >> Isn't this why weak symbols were invented?
> > 
> > Weak symbols means that we end up with both the weakly-referenced code
> > and the arch code in the kernel image.  That's fine if the weak code
> > is small.
> 
> The kernel's been able to build with link time garbage collection since 2016:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> 
> Wouldn't that remove the unused one?

Probably, if anyone bothered to use that, which they don't.

LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
what I can see, nothing selects it.  Therefore, the symbol is always
disabled, and so the feature never gets used in mainline kernels.

Brings up the obvious question - why is it there if it's completely
unused?  (Maybe to cause confusion, and allowing a justification
for __weak ?)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
