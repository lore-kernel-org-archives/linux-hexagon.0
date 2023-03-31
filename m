From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/21] dma-mapping: unify support for cache flushes
Date: Fri, 31 Mar 2023 22:27:29 +0200
Message-ID: <578fda41-4a69-44f5-8a58-1eacd49e1347@app.fastmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <ZCcQGX/i8xBPiG7T@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gcc1NNw2IwuGHgoZOYK0h32kX75tDFBHYN/38q/+luE=; b=oYBcs6US3EJghL
	/EtU2j6EoaRXaYhvr8tI9QxG0fvwWGr9lbCv8+lOQgxp/SACBVj6XxBcHlt34lCPsacg9lHt5c9cA
	ioUtQKnwcZ+MI1zPS4mbHW1LnJYTr5rFIfftF3aNf92DEJKnTgEUNLaCYB4pA/ex3A5kXbXFTaV4p
	PDD42ITH/NI7E0cT7aHJpQXI5zo80HBBiVCELH1j7lOgFo6Md3CS1KTeQTMXYGAcQxdDPkHRI2sas
	At9WL6U9VRXuHL171Lr/fKEuvaCVAGrv1/PIpcmbQT/s2ElvIXX0tZ0osKxfpv2Qa/yuwpRlsni/u
	wRaM0CxlVJDlHrnLX7gg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1680294472; x=1680301672; bh=/s
	Pv/U5zGrhU1zcR9PvlFx9Mj6SaMuREGSBaNy/AOF4=; b=ga32HoREWznYqBsSqM
	hn2DgPhI0+UmwSJFnXp6cXUsAyk1RZOXfq4b1WpgTwt3IraMWAxdDHHwFHQwBWRE
	TlsHkLIB3Nc4l8Bq6wSMeqIIyToWRVX/9f0t7rNKj/mDhGRzzkvtwaJ1p5UpYAuF
	Z8rGx9r19iaVplZvj6iIVKmJ3wxEDol/ZCX+kvVRcieGj5+X8Yk4mNrXKl02EzG1
	O78oDXTRdwjh2SHkZPsjwwsywB0J05PUo7W3k2TfteNL/nInrhKIiqrlfLqOpaH2
	gfSyNuJsTvaCC7NaTMNKQDKVNF1f8g489075mkua2DPfSTRqEHVWobPvSnhWQi8c
	vjHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1680294472; x=1680301672; bh=/sPv/U5zGrhU1
	zcR9PvlFx9Mj6SaMuREGSBaNy/AOF4=; b=dW2djYMpYmfXAs+yd/mPO4TOJPOfU
	DV9D3TLO5Cwx60AN2ozaZ1sIoj1IN10iqG7fO5heya/Cg3MohERkBeh3ap3w9dhj
	sJFkvHI4fXsy8Q+qeBBqlnPkR+t4SXMIO4JB3c9b1mmQmo31q8RxeeafqW4SIcqP
	fnxTPr7MCW1EmoykWd6eoPr6eF59XoPpd22azkOEW5Mr9WH4A0XXyV8IeEsZIe0k
	85q8QcqlxSt6yntoYMxaNEARIaZqm5Hr0r3F7jiqQoP8/MeIKFBIoHwkM3jUUU9o
	ffdqAx7D0BFQxh01VCVU3tMUBATkOZmczDXHy4vypo6Qq38qKVE2G/xQw==
In-Reply-To: <ZCcQGX/i8xBPiG7T@arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Chris

On Fri, Mar 31, 2023, at 18:53, Catalin Marinas wrote:
> On Mon, Mar 27, 2023 at 02:12:56PM +0200, Arnd Bergmann wrote:
>> Another difference that I do not address here is what cache invalidation
>> does for partical cache lines. On arm32, arm64 and powerpc, a partial
>> cache line always gets written back before invalidation in order to
>> ensure that data before or after the buffer is not discarded. On all
>> other architectures, the assumption is cache lines are never shared
>> between DMA buffer and data that is accessed by the CPU.
>
> I don't think sharing the DMA buffer with other data is safe even with
> this clean+invalidate on the unaligned cache. Mapping the DMA buffer as
> FROM_DEVICE or BIDIRECTIONAL can cause the shared cache line to be
> evicted and override the device written data. This sharing only works if
> the CPU guarantees not to dirty the corresponding cache line.
>
> I'm fine with removing this partial cache line hack from arm64 as it's
> not safe anyway. We'll see if any driver stops working. If there's some
> benign sharing (I wouldn't trust it), the cache cleaning prior to
> mapping and invalidate on unmap would not lose any data.

Ok, I'll add a patch to remove that bit from dcache_inval_poc
then. Do you know if any of the the other callers of this function
rely on on the writeback behavior, or is it safe to remove it for
all of them?

Note that before c50f11c6196f ("arm64: mm: Don't invalidate
FROM_DEVICE buffers at start of DMA transfer"), it made some
sense to write back partial cache lines before a DMA_FROM_DEVICE,
in order to allow sharing read-only data in them the same way as
on arm32 and powerpc. Doing the writeback in the sync_for_cpu
bit is of course always pointless.

       Arnd
