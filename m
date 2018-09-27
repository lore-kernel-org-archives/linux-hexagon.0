From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
Date: Wed, 26 Sep 2018 17:34:32 -0700
Message-ID: <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com> <20180926183152.GA4597@rapoport-lnx>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCL+Y3Elp9js0tskQ42GEDjYhI0l5SAZZjTRQ2rGzW4=;
        b=gWktOBfbdrBncdviL20J5F04FWoaz6YrOuZLdcCDBv1a1+de7firBMdo56D5siKbuP
         knUUB/mvtfUFAgKRLK6W3vSmF/mpPs+gnm6yp5S+r9Ha9FPHQr2nPuRnqXV2poXWKJJ3
         HIOfbb4fDeKHAeNv1BJcfuUtpb1jGZYjKdkWtTH9UaLxMDvX8nuhR5WKVgZkkOz9BpEd
         CI7OaIPDPdJciw65l552y88iAqeLkftXzSYBxY3FdNga0rrtQBxT8YIewUygbcNpeekX
         N1FJ36m7Pb9UOF1rdrmYpWB/Tlp8yZqialQsEs2ivoPFIrl6lxYgw/zD3yJUoC9cbydD
         y/kA==
In-Reply-To: <20180926183152.GA4597@rapoport-lnx>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rppt@linux.vnet.ibm.com
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com, Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn, Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org, jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>, lftan@altera.com, msalter@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, mattst88@gmail.com, mpe@ellerman.id.au, Michal Hocko <mhocko@suse.com>, monstr@monstr.eu, palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org, richard@nod.at, dalias@libc.org, Russell King - ARM Linux <linux@armlinux.org.uk>, fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>

On Wed, Sep 26, 2018 at 11:32 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> > On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > >
> > > All architecures use memblock for early memory management. There is no need
> > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >
> > <snip>
> >
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index 5169205..4ae91fc 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -2,7 +2,6 @@
> > >  #define _LINUX_MEMBLOCK_H
> > >  #ifdef __KERNEL__
> > >
> > > -#ifdef CONFIG_HAVE_MEMBLOCK
> > >  /*
> > >   * Logical memory blocks.
> > >   *
> > > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> > >  {
> > >         return 0;
> > >  }
> > > -#endif /* CONFIG_HAVE_MEMBLOCK */
> > >
> > >  #endif /* __KERNEL__ */
> >
> > There was an #else above this section and I believe it and the code
> > after it needs to be stripped as well.
>
> Right, I've already sent the fix [1] and it's in mmots.
>
> [1] https://lkml.org/lkml/2018/9/19/416
>

Are you sure? The patch you reference appears to be for
drivers/of/fdt.c, and the bit I pointed out here is in
include/linux/memblock.h.

- Alex
