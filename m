From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
Date: Wed, 26 Sep 2018 21:31:53 +0300
Message-ID: <20180926183152.GA4597@rapoport-lnx>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com, Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn, Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org, jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>, lftan@altera.com, msalter@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, mattst88@gmail.com, mpe@ellerman.id.au, Michal Hocko <mhocko@suse.com>, monstr@monstr.eu, palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org, richard@nod.at, dalias@libc.org, Russell King - ARM Linux <linux@armlinux.org.uk>, fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>

On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> >
> > All architecures use memblock for early memory management. There is no need
> > for the CONFIG_HAVE_MEMBLOCK configuration option.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> <snip>
> 
> > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > index 5169205..4ae91fc 100644
> > --- a/include/linux/memblock.h
> > +++ b/include/linux/memblock.h
> > @@ -2,7 +2,6 @@
> >  #define _LINUX_MEMBLOCK_H
> >  #ifdef __KERNEL__
> >
> > -#ifdef CONFIG_HAVE_MEMBLOCK
> >  /*
> >   * Logical memory blocks.
> >   *
> > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> >  {
> >         return 0;
> >  }
> > -#endif /* CONFIG_HAVE_MEMBLOCK */
> >
> >  #endif /* __KERNEL__ */
> 
> There was an #else above this section and I believe it and the code
> after it needs to be stripped as well.

Right, I've already sent the fix [1] and it's in mmots.

[1] https://lkml.org/lkml/2018/9/19/416

-- 
Sincerely yours,
Mike.

