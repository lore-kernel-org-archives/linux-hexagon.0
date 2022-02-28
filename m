From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date: Mon, 28 Feb 2022 14:49:06 +0100
Message-ID: <CAMuHMdWve8XkqtMJCTB_BH9JRZ8C4f7ynF60D1fvx3hxaK4YzA@mail.gmail.com>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com> <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, alpha <linux-alpha@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtens>

Hi Russell,

On Mon, Feb 28, 2022 at 11:57 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> > This defines and exports a platform specific custom vm_get_page_prot() via
> > subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> > macros can be dropped which are no longer needed.
>
> What I would really like to know is why having to run _code_ to work out
> what the page protections need to be is better than looking it up in a
> table.
>
> Not only is this more expensive in terms of CPU cycles, it also brings
> additional code size with it.
>
> I'm struggling to see what the benefit is.

I was wondering about that as well. But at least for code size on
m68k, this didn't have much impact.  Looking at the generated code,
the increase due to using code for the (few different) cases is offset
by a 16-bit jump table (which is to be credited to the compiler).

In terms of CPU cycles, it's indeed worse than before.

Gr{oetje,eeting}s,

                        Geert
