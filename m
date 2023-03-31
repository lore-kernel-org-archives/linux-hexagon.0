From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches
 before DMA
Date: Fri, 31 Mar 2023 11:01:54 +0000
Message-ID: <a5f226ee509b4968a4c85784aedbedf4@AcuMS.aculab.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-16-arnd@kernel.org>
 <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
 <ZCapXlrqMOpRxkSu@shell.armlinux.org.uk>
 <a8a90181-a003-47a1-8257-fcbf55752249@app.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QrBIDbe8KK4B6fCw/HJZA0DOTYv+Szj9ORNl6fuIy1U=; b=ZDlu3SSkiNfKE3
	HvHGAcqAjvkN0lDr0YBZsQERCpDb487U0psOSc5zkMZv3xFV/9hXyM9HQM0exd8HNQe88dWlseXmB
	vUdROwa2wIGdXCSXKs4Q1NeadcKWC1BTWD//SRL+FLh7o5eSvnPRWl79XFFl+sVA7pGGgZf0ocRIA
	Jp+/mMgZM7VowaJk1nzExoyxJUMAGl/rhwHe+DRkoo1ndBP478mRVKO9J8fJUk16vl1xD5/P8u7eQ
	ncDmOMOJYqfOjeY1zXVoEsOkBOEVzD9jWXMVtelq4Nq7igKW139vK5tGOdjK/Lt8FQP7hUeoiwQ6W
	UTUZrvvs5VfVZte0JezQ==;
In-Reply-To: <a8a90181-a003-47a1-8257-fcbf55752249@app.fastmail.com>
Content-Language: en-US
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
To: 'Arnd Bergmann' <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@kernel.org>
Cc: Rich Felker <dalias@libc.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus
 Walleij <linus.walleij@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, "Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Will
 Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Vineet Gupta <vgupta@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-x>

From: Arnd Bergmann
> Sent: 31 March 2023 11:39
...
> Most architectures that have write-through caches (m68k,
> microblaze) or write-back caches but no speculation (all other
> armv4/armv5, hexagon, openrisc, sh, most mips, later xtensa)
> only invalidate before DMA but not after.
> 
> OTOH, most machines that are actually in use today (armv6+,
> powerpc, later mips, microblaze, riscv, nios2) also have to
> deal with speculative accesses, so they end up having to
> invalidate or flush both before and after a DMA_FROM_DEVICE
> and DMA_BIDIRECTIONAL.

nios2 is a simple in-order cpu with a short pipeline
(it is a soft-cpu made from normal fpga logic elements).
Definitely doesn't do speculative accesses.
OTOH any one trying to run Linux on it needs their head examined.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
