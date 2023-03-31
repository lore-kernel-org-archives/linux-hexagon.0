From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 15/21] ARM: dma-mapping: always invalidate WT caches
 before DMA
Date: Fri, 31 Mar 2023 10:07:28 +0100
Message-ID: <ZCai0FmZiOqsMkzc@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-16-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BFqC7haDTybAEGUq1e2Uhe+LahY2lMZuCKo7e1OI8xQ=; b=ln4+Y+gWAHQSIKd2IosmEm1kwL
        9rQrpQ4E43SCxGnY7oCiHOfu1wEhrtmLCIph2RoTF0Zr9Jl+lwXk0EloYYwZp1vP4G9309e+oavO1
        W4gscCHtGYQQ/lE4PaexTfIzVhVn8ZkbG/CF1gjy/6j2N0CDUb+u8PLNi0SvNP4j7UurXdo8YXnzj
        FgTE97HTmPYCpw04O/SaUQ6wP2EslXB8dKZxMKdUsN6rI1OT+fm2ale4gtGaRCzwcx2OlTpIpkN9b
        CgHQYxdDR/G/k11QZy1D2M1/SQxlzh6J/tvaEB5xTC8HOr4tRJNRZhsIJXbX/XtjKGw1Lgk2JQN4g
Content-Disposition: inline
In-Reply-To: <20230327121317.4081816-16-arnd@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 02:13:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most ARM CPUs can have write-back caches and that require
> cache management to be done in the dma_sync_*_for_device()
> operation. This is typically done in both writeback and
> writethrough mode.
> 
> The cache-v4.S (arm720/740/7tdmi/9tdmi) and cache-v4wt.S
> (arm920t, arm940t) implementations are the exception here,
> and only do the cache management after the DMA is complete,
> in the dma_sync_*_for_cpu() operation.
> 
> Change this for consistency with the other platforms. This
> should have no user visible effect.

NAK...

The reason we do cache management _after_ is to ensure that there
is no stale data. The kernel _has_ (at the very least in the past)
performed DMA to data structures that are embedded within other
data structures, resulting in cache lines being shared. If one of
those cache lines is touched while DMA is progressing, then we
must to cache management _after_ the DMA operation has completed.
Doing it before is no good.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
