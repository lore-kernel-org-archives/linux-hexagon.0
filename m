From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean()
 helper
Date: Fri, 31 Mar 2023 16:54:29 +0100
Message-ID: <ZCcCNXyb9TZvA8wD@shell.armlinux.org.uk>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
 <ZCGv18wnEtoFvtfM@shell.armlinux.org.uk>
 <1be05746-9deb-49cb-b106-71b2db8318cd@app.fastmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gUELt2K1QKph0U/mDlh4dwcj3jRy49Fgp81dawItijs=; b=F86J/lODgmEA0uwbHcY3bvQDIg
        TgPZqAN80ItsKKu+iPQcuv/pts9DIvFXJeSEZcyq0SOfARV88djehGMYXJuDHo94xmNoUdc8so8TQ
        lO3DlUKNl0JE1n5lC4OQRNQJ3a+9RGNNtr5VJSUX9rNMXskzfjoEtNIzNUj9gswxqSmuoQ2K/eCd1
        sHbsLGLpmn7B5oFOttF1NlFGM73bvkK8EdPHfxwwzdfF3QwqoSTJnWaOA3vfMNEshnYYvIU/akmQr
        wtBcESnlgj18abmkEesn3hmvJxyBrWubIThmP6qLXHE/lCCqgaePhuHTPqwc712P40mYINjGZoZVl
Content-Disposition: inline
In-Reply-To: <1be05746-9deb-49cb-b106-71b2db8318cd@app.fastmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Fri, Mar 31, 2023 at 04:06:37PM +0200, Arnd Bergmann wrote:
> On Mon, Mar 27, 2023, at 17:01, Russell King (Oracle) wrote:
> > On Mon, Mar 27, 2023 at 02:13:16PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The arm version of the arch_sync_dma_for_cpu() function annotates pages as
> >> PG_dcache_clean after a DMA, but no other architecture does this here.
> >
> > ... because this is an arm32 specific feature. Generically, it's
> > PG_arch_1, which is a page flag free for architecture use. On arm32
> > we decided to use this to mark whether we can skip dcache writebacks
> > when establishing a PTE - and thus it was decided to call it
> > PG_dcache_clean to reflect how arm32 decided to use that bit.
> >
> > This isn't just a DMA thing, there are other places that we update
> > the bit, such as flush_dcache_page() and copy_user_highpage().
> >
> > So thinking that the arm32 PG_dcache_clean is something for DMA is
> > actually wrong.
> >
> > Other architectures are free to do their own other optimisations
> > using that bit, and their implementations may be DMA-centric.
> 
> The flag is used the same way on most architectures, though some
> use the opposite polarity and call it PG_dcache_dirty. The only
> other architecture that uses it for DMA is ia64, with the difference
> being that this also marks the page as clean even for coherent
> DMA, not just when doing a flush as part of noncoherent DMA.
> 
> Based on Robin's reply it sounds that this is not a valid assumption
> on Arm, if a coherent DMA can target a dirty dcache line without
> cleaning it.

The other thing to note here is that PG_dcache_clean doesn't have
much meaning on modern CPUs with PIPT caches. For these,
cache_is_vipt_nonaliasing() will be true, and
cache_ops_need_broadcast() will be false.

Firstly, if we're using coherent DMA, then PG_dcache_clean is
intentionally not touched, because the data cache isn't cleaned
in any way by DMA operations.

flush_dcache_page() turns into a no-op apart from clearing
PG_dcache_clean if it was set.

__sync_icache_dcache() will do nothing for non-executable pages,
but will write-back a page that isn't marked PG_dcache_clean to
ensure that it is visible to the instruction stream. This is only
used to ensure that a the instructions are visible to a newly
established executable mapping when e.g. the page has been DMA'd
in. The default state of PG_dcache_clean is zero on any new
allocation, so this has the effect of causing any executable page
to be flushed such that the instruction stream can see the
instructions, but only for the first establishment of the mapping.
That means that e.g. libc text pages don't keep getting flushed on
the start of every program.

update_mmu_cache() isn't compiled, so it's use of PG_dcache_clean
is irrelevant.

v6_copy_user_highpage_aliasing() won't be called because we're not
using an aliasing cache.

So, for modern ARM systems with DMA-coherent PG_dcache_clean only
serves for the __sync_icache_dcache() optimisation.

ARMs use of this remains valid in this circumstance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
