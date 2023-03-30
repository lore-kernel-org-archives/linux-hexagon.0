From: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Date: Thu, 30 Mar 2023 13:51:53 +0200
Message-ID: <CAMj1kXGNjrmTr1R+-09UYtHSgvT6fSgZxvpbEOfeTFxhWtgGcQ@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-19-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6PnRbl98IaeDt5/jXOtMTR3lZ0A3glgMYre0ScgKrWo=; b=n8mhmozqYs7a9H
	k9c+9DyBeZL4CLWgFPUoMRfW46LddThNJFfZj6kgwSERIgx9HEAQ4K4OzgPbamnbyEP9anD7Vidi0
	spogFMryvO50KKs8iPGndNiqsaILD55a59AepnTOKArkWWUapTp+tsuxmhtSwxMVFDZ2gBrJ5ZkGj
	yvJYtmVr5OeeWui8+FdJUum/952AiXGj877pXNVgt6Au7zQPbg6lYtBmCK1w3fJ8mboNupUaHIi9w
	RZ9jLtYCJ04+JlbfPeSAwh5BcGR1f0iI8S4lCEq48GJ//5kQRCg5rDNtd7QTPTRRoZPHSEhW68GFx
	Pn9x5SJjYaohpGhECDoQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680177146;
	bh=Lg8Woq7ScP2NFdPayLKkYeMtRMZwMJRAR9+KtXakJhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZipPa0Ma88cpwApm0Td+Y0hkbkQIILnwFNQiwuNoLfKzZn1t1N2RWebuO5MmOdWR
	 lQtcg7+hOj2+xkyHWlgIoVZbU8l/ColoV4uTbiTmPZpGMjP4+5b5KL+k1PATzLy9Rp
	 ne1YU23rrq+LQ/aY1hx5aVq6JaiwH990blyhsz8dbOuarS9Dyli23+YzGF/f36+HG8
	 eJWfg6HhHG23+Gjz87NUmJCRzsfOcEHVVMSrZcSvvVaSn3bHZUCJGXYVhIzkM552zo
	 58hqYF8ul49kdxkY2muTd2AEDgWpic6fO2hGOkAcvaSEivLLlgKYSKrkNwb4+H7X43
	 TxbpI+NG3HS5w==
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, M

On Mon, 27 Mar 2023 at 14:18, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cache management operations for noncoherent DMA on ARMv6 work
> in two different ways:
>
>  * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>    DMA buffers lead to data corruption when the prefetched data is written
>    back on top of data from the device.
>
>  * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>    is not seen by the other core(s), leading to inconsistent contents
>    accross the system.
>
> As a consequence, neither configuration is actually safe to use in a
> general-purpose kernel that is used on both MPCore systems and ARM1176
> with prefetching enabled.
>
> We could add further workarounds to make the behavior more dynamic based
> on the system, but realistically, there are close to zero remaining
> users on any ARM11MPCore anyway, and nobody seems too interested in it,
> compared to the more popular ARM1176 used in BMC2835 and AST2500.
>
> The Oxnas platform has some minimal support in OpenWRT, but most of the
> drivers and dts files never made it into the mainline kernel, while the
> Arm Versatile/Realview platform mainly serves as a reference system but
> is not necessary to be kept working once all other ARM11MPCore are gone.
>
> Take the easy way out here and drop support for multiprocessing on
> ARMv6, along with the CONFIG_DMA_CACHE_RWFO option and the cache
> management implementation for it. This also helps with other ARMv6
> issues, but for the moment leaves the ability to build a kernel that
> can run on both ARMv7 SMP and single-processor ARMv6, which we probably
> want to stop supporting as well, but not as part of this series.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-oxnas@groups.io
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
