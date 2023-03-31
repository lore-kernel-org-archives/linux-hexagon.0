From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches
 before DMA
Date: Fri, 31 Mar 2023 10:35:26 +0100
Message-ID: <ZCapXlrqMOpRxkSu@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-16-arnd@kernel.org>
 <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MTxGLQQb7fyev2CdqXrjw/vlc/KwBDC/XLZxAS0kzT0=; b=wBAdtjP0WajIE6
	emez9dGdTys28zjcr1KSNTKvg/K52FSE27EMkoQI0fB9fXbYkmimNSCR8qnOxMGu2ssiVBoQ8UQVP
	w8FIvr6TCUmVhM+8TsavMDPnHhxV9N1ae91ouPekvlao8SRq6CDNoJBYfsfuLmndrmqWiTBGDn9er
	d78JcDjcT1KCRHR+od4wPrmR4Y/33wYrV7tLZAkxqV1H1/6O/T5OrIqud5Q0Fpv1Y4r7LC/7aCilP
	GJExbs5eE7ZtweanWMdad0NaU2/+pwKNmnhYdTpEHUlAmDnmq+qRZOkPTFxlkPVQCM1A7PjyURryU
	1nqC14OqTtucnz8a2VQA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LizQNlR5xeQ9Nx7+wKPFYUJj75jOfRmgpvd1Wr0G7No=; b=UKbXTqzhq2L4s+MyI6LAhZHXPR
	JEXjbEnQAW9YjlzhOJTLAm3faUqrzczga5/5A+k3OzAcg8y2zTvhiGLWpnnuu9Ohj85XsU4grnYcD
	yk5M61TG+xOGvvpr7BdospIoI188Iq0Jt42tRt/xOCB196NQnP2eeZJxFhk6W8d3WLrvzOeDmeDGp
	JdEZ4IItk3nxicikeyfyOXcN5BcpLJAlq5iFuQOYzNedzBy1kDsV1y5AtlHxecOF2ffvGBufXeIlS
	4QoK4UR/YHLQPaOKfszLD1j9qGgpZKpcHV1ssSQAyjuKCuBpMtpEGtTDYtwzgJ2cUFhaZW4SwHxwU
	CCfEAozA==;
Content-Disposition: inline
In-Reply-To: <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christ

On Fri, Mar 31, 2023 at 10:07:28AM +0100, Russell King (Oracle) wrote:
> On Mon, Mar 27, 2023 at 02:13:11PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Most ARM CPUs can have write-back caches and that require
> > cache management to be done in the dma_sync_*_for_device()
> > operation. This is typically done in both writeback and
> > writethrough mode.
> > 
> > The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
> > (arm920t, arm940t) implementations are the exception here,
> > and only do the cache management after the DMA is complete,
> > in the dma_sync_*_for_cpu() operation.
> > 
> > Change this for consistency with the other platforms. This
> > should have no user visible effect.
> 
> NAK...
> 
> The reason we do cache management _after_ is to ensure that there
> is no stale data. The kernel _has_ (at the very least in the past)
> performed DMA to data structures that are embedded within other
> data structures, resulting in cache lines being shared. If one of
> those cache lines is touched while DMA is progressing, then we
> must to cache management _after_ the DMA operation has completed.
> Doing it before is no good.

It looks like the main offender of "touching cache lines shared
with DMA" has now been resolved - that was the SCSI sense buffer,
and was fixed some time ago:

commit de25deb18016f66dcdede165d07654559bb332bc
Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date:   Wed Jan 16 13:32:17 2008 +0900

/if/ that is the one and only case, then we're probably fine, but
having been through an era where this kind of thing was the norm
and requests to fix it did not get great responses from subsystem
maintainers, I just don't trust the kernel not to want to DMA to
overlapping cache lines.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
