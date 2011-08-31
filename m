From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 24/35] Hexagon: Provide basic implementation and/or stubs for I/O routines.
Date: Wed, 31 Aug 2011 16:47:41 +0200
Message-ID: <201108311647.42017.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.995980546@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110830190801.995980546@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Tuesday 30 August 2011, Richard Kuo wrote:
> Changed read/write to use inline assembly.
> 
> Rearranged the file and put all the ioport stuff at the bottom.  For now
> I'd like to just leave the stubs in there in case they need to be
> filled out later; plus things don't compile.
> 
> We still seem to need IO_SPACE_LIMIT to be defined, particularly to something
> large, as we have drivers that request resources with IORESOURCE_IO that
> are memory mapped IO.  The ioread/iowrites work as they select the correct
> routine to use.

Which drivers? If the drivers are buggy, better fix them than working around
in the architecture.

I have experimental patches in the tmp/randconfig3 branch of the arm-soc.git
tree to remove the need for PIO functions in ARM. Please have a look there
if you are interested.

> +/*
> + * We don't have PCI yet.
> + */
> +#define IO_SPACE_LIMIT 0xffffffff
> +#define _IO_BASE 0x0

If you absolutely insist on defining these, at least make them meaningful,
e.g. defining _IO_BASE to an unused location in the virtual address space,
and IO_SPACE_LIMIT small enough to be harmless, at most 0xffff.

If you ever gain PCI support, you can then map the PCI I/O space into that
area.

> +static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
> +	int count)
> +{
> +	memcpy(dst, (void *) src, count);
> +}
> +
> +static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
> +	int count)
> +{
> +	memcpy((void *) dst, src, count);
> +}

This will need __force in order to build with sparse.

> +#define PCI_IO_ADDR	volatile void __iomem *

Better make _IO_BASE have the right type to start with, like

#define _IO_BASE ((void __iomem *)0xefff0000)
static inline u8 inb(unsigned long port)
{
	return readb(_IO_BASE + (port & IO_SPACE_LIMIT));
}

static inline void outb(u8 data, unsigned long port)
{
	writeb(data, _IO_BASE + (port & IO_SPACE_LIMIT));
}

> +/*  _p means "pause until the I/O completes"  */
> +#define outb_p outb
> +#define outw_p outw
> +#define outl_p outl
> +
> +#define inb_p inb
> +#define inw_p inw
> +#define inl_p inl

It doesn't actually mean that. It means 'pause for a bit longer'. The inb/outb
family of functions is already required to wait for the I/O to complete,
unlike readb/writeb, which only needs to wait for inbound data, while
outbound writes are posted to the bus without waiting for the data to arrive.

> +static inline void insb(unsigned long addr, void *buffer, int count)
> +{
> +	printk(KERN_INFO "insb not implemented\n");
> +}
> +
> +static inline void insw(unsigned long addr, void *buffer, int count)
> +{
> +	printk(KERN_INFO "insw not implemented\n");
> +}
> +
> +static inline void insl(unsigned long addr, void *buffer, int count)
> +{
> +	printk(KERN_INFO "insl not implemented\n");
> +}
> +
> +static inline void outsb(unsigned long addr, const void *buffer, int count)
> +{
> +	printk(KERN_INFO "outsb not implemented\n");
> +}
> +
> +static inline void outsw(unsigned long addr, const void *buffer, int count)
> +{
> +	printk(KERN_INFO "outsw not implemented\n");
> +}
> +
> +static inline void outsl(unsigned long addr, const void *buffer, int count)
> +{
> +	printk(KERN_INFO "outsl not implemented\n");
> +}

Either just add the obvious implementations adding _IO_BASE as above
or stub these out to create a link time error in drivers using them.
If a driver relies on these functions, it won't work anyway, so it's
better to not even build it.

> +/*  generic versions defined in lib/iomap.c  */
> +extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
> +extern void ioport_unmap(void __iomem *addr);


You can also just set CONFIG_NO_IOPORT (CONFIG_NO_IOPORT_MAP once my
patches went in) to remove support for ioport_map.

	Arnd
