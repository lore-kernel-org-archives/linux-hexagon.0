From: Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
Date: Mon, 21 Feb 2022 16:21:30 +0100
Message-ID: <20220221152130.GA17373@alpha.franken.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
 <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guo Ren <guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, Nick Hu <nickhu-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dinh Nguyen <dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stafford Horne <shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Pe

On Mon, Feb 21, 2022 at 03:31:23PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 21, 2022 at 2:24 PM Thomas Bogendoerfer
> <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org> wrote:
> > On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> > >
> > > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > > index db9a8e002b62..d7c89dc3426c 100644
> >
> > this doesn't work. For every access above maximum implemented virtual address
> > space of the CPU an address error will be issued, but not a TLB miss.
> > And address error isn't able to handle this situation.
> 
> Ah, so the __ex_table entry only catches TLB misses?

no, but there is no __ex_table handling in address error hanlder (yet).

> Does this mean it also traps for kernel memory accesses, or do those
> work again?

it will trap for every access.


> If the addresses on mips64 are separate like on
> sparc64 or s390, the entire access_ok() step could be replaced
> by a fixup code in the exception handler. I suppose this depends on
> CONFIG_EVA and you still need a limit check at least when EVA is
> disabled.

only EVA has seperate address spaces for kernel/user.

> > Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> > for the 32bit case ?
> >
> 
> For 32-bit, the __UA_LIMIT is a compile-time constant, so the check
> ends up being trivial. On all other architectures, the same thing can
> be done after the set_fs removal, so I was hoping it would work here
> as well.

ic

> I suspect doing the generic (size <= limit) && (addr <= (limit - size))
> check on mips64 with the runtime limit ends up slightly slower
> than the current code that checks a bit mask instead. If you like,
> I'll update it this way, otherwise I'd need help in form of a patch
> that changes the exception handling so __get_user/__put_user
> also return -EFAULT for an address error.

that's what the patch does. For aligned accesses the patch should
do the right thing, but it breaks unaligned get_user/put_user.
Checking if the trapping vaddr is between end of CPU VM space and
TASK_MAX_SIZE before exception handling should do the trick. I'll
send a patch, if this works.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
