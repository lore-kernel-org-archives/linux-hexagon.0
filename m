From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean()
 helper
Date: Mon, 27 Mar 2023 16:01:43 +0100
Message-ID: <ZCGv18wnEtoFvtfM@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GEE0ldPCAv+f5hC1f+jvTvP/uCZufNK448SDtGAe4Zk=; b=v1TiVcw6SlE1jYl57XDWmMLk7R
        EWSel/m8qaxtTIpi1wpcv4wbnE7RPavO3PfN2/IvOoiwi/gCP7xcE5F2askSa5L3uzpsODKQD61x8
        StfEk4v08foXfrG7VasjwmrT+4yuDajfp3NNHvjaYyh4aLuCmqN87WdluK/CgHa4tXqQusBd9TUSf
        rgoEiiSrmdHN6nfAY4zrzY2ufcDHt1crFZ4RO0F/V9Ze42PDJKXYA8Ce8yBzBCsjOpJfgasawcEnA
        +RKV1eekKL4QKumS3WLMLcQq87DVakybcmXPiUHI+Lzv6UbDhiuLRCeqCognGPTq1tbBLbTgEZBez
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-21-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 02:13:16PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
> PG_dcache_clean after a DMA, but no other architecture does this here.

... because this is an arm32 specific feature. Generically, it's
PG_arch_1, which is a page flag free for architecture use. On arm32
we decided to use this to mark whether we can skip dcache writebacks
when establishing a PTE - and thus it was decided to call it
PG_dcache_clean to reflect how arm32 decided to use that bit.

This isn't just a DMA thing, there are other places that we update
the bit, such as flush_dcache_page() and copy_user_highpage().

So thinking that the arm32 PG_dcache_clean is something for DMA is
actually wrong.

Other architectures are free to do their own other optimisations
using that bit, and their implementations may be DMA-centric.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
