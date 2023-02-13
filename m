From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Date: Mon, 13 Feb 2023 09:54:17 +0200
Message-ID: <Y+nsqV6u/PqNlwDS@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net>
 <Y+mRz6Wfocopv9jw@kernel.org>
 <15a2c023-fdfa-9543-ac36-a846e5f8a000@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676274881;
        bh=6metnuiv9QkmKFu+JTHLVBvZLre3nFtuNi3AR7PlA78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/NLBLn1QBccO0iLmwEVdjTRTOu/1JTVdr0CvbgYz4ThLcAoENpkQwi1mRk7/P19V
         Brn+rbVYSD8LBBQWtetps+o6x9tV427CYirqerxd+gmGggehAz5OXTZeiD3MkT7U29
         s/as2HenQlPGtPPTTf3fp/G4jLA+MmtrrPcey6hAK36CzGgOAg/0LtwnODYIfT0DI9
         MUeph4dw/P2V8jMyhN9SftHlhcEV/JNhGKIKb6cMv7netYSdbt356AlVVkhPoiPUvd
         r4aExWVaj3CL3McIngU/VdH3ENcuJwfiC6rBQVcgRCzZo3MtbE8U1j5N/4s5pn2pxp
         sfCWQJUUPJk8Q==
Content-Disposition: inline
In-Reply-To: <15a2c023-fdfa-9543-ac36-a846e5f8a000@roeck-us.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel>

Andrew, 

On Sun, Feb 12, 2023 at 10:37:15PM -0800, Guenter Roeck wrote:
> On 2/12/23 17:26, Mike Rapoport wrote:
> > On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
> > > On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
> > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > > 
> > > > Every architecture that supports FLATMEM memory model defines its own
> > > > version of pfn_valid() that essentially compares a pfn to max_mapnr.
> > > > 
> > > > Use mips/powerpc version implemented as static inline as a generic
> > > > implementation of pfn_valid() and drop its per-architecture definitions.
> > > > 
> > > 
> > > With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
> > > Reverting this patch fixes the problem.
> > 
> > This should be a better fix than a revert:
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index 506784702430..bf1b54055316 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -301,6 +301,7 @@ void __init paging_init(void)
> >   	 */
> >   	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
> >   	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
> > +	set_max_mapnr(max_low_pfn - min_low_pfn);
> >   	nodes_clear(node_online_map);
> 
> Confirmed, this fixes the problem for me.
 
What is your preference for this and m68k fix? Fixups on top of mm-stable
or v3 of the entire series? 

> Thanks,
> Guenter

-- 
Sincerely yours,
Mike.
