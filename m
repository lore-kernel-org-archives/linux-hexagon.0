From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
Date: Fri, 18 Feb 2022 08:16:11 +0100
Message-ID: <CAK8P3a2r3zB2G7CjCdXB6cDx1Q7jdOnA8YcCHM+3Q3CybnZ=hQ@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168588;
        bh=q+jKWrJ4jJZ2v7I08P11+5fwNrVng4vZR8KgCaGgNp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E7Qj225LkHl4vakpp/86Clw8A8aYCNcpfLrBP+VCQdOQM5BITuaFC8aajiIPA17sq
         QsQL+tpQFefxmctximGZjJghHIgDs0+5uBmhr8xxAaHPynJ3FAz/VvdJ7A4yiUcYzD
         cvOPc8xsA1RVRdeBpZvu7iuJPB2dq0pqYhhG0eac2ra/YlTXeM+fTnsQjW5NHDOU4h
         cinPsKBHoi0lD++02CV6Px7pd6xZwvcPqjj04/ifU1PciDsuXI0NkC0Bbm1nyirKYP
         OBBXTMFOAcsBgbQTb4NkJ7ZQ5y+D67DT81A8imqE8C6wMfM2VmNDYRx0F0jR7hwP1U
         QI8LFbE7ThFyQ==
In-Reply-To: <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>

On Thu, Feb 17, 2022 at 8:15 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> On Wed, Feb 16, 2022 at 5:19 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > There are many different ways that access_ok() is defined across
> > architectures, but in the end, they all just compare against the
> > user_addr_max() value or they accept anything.
> >
> > Provide one definition that works for most architectures, checking
> > against TASK_SIZE_MAX for user processes or skipping the check inside
> > of uaccess_kernel() sections.
> >
> > For architectures without CONFIG_SET_FS(), this should be the fastest
> > check, as it comes down to a single comparison of a pointer against a
> > compile-time constant, while the architecture specific versions tend to
> > do something more complex for historic reasons or get something wrong.
>
> This isn't actually optimal.  On x86, TASK_SIZE_MAX is a bizarre
> constant that has a very specific value to work around a bug^Wdesign
> error^Wfeature of Intel CPUs.  TASK_SIZE_MAX is the maximum address at
> which userspace is permitted to allocate memory, but there is a huge
> gap between user and kernel addresses, and any value in the gap would
> be adequate for the comparison.  If we wanted to optimize this, simply
> checking the high bit (which x86 can do without any immediate
> constants at all) would be sufficient and, for an access known to fit
> in 32 bits, one could get even fancier and completely ignore the size
> of the access.  (For accesses not known to fit in 32 bits, I suspect
> some creativity could still come up with a construction that's
> substantially faster than the one in your patch.)
>
> So there's plenty of room for optimization here.
>
> (This is not in any respect a NAK -- it's just an observation that
> this could be even better.)

Thank you for taking a look!

As you can see in the patch that changes the algorithm on x86 [1],
it was already using TASK_SIZE_MAX as the limit, only the order
in which the comparison is done, hopefully leading to better code
already. I have looked at trivial examples on x86 that showed an
improvement for constant sizes, but only looked at arm64 in detail
for the overall result.

It may be worth checking if using LONG_MAX as the limit produces
better code, but it's probably best to do the optimization in the
common code in a portable way to keep it from diverging again.

       Arnd

[1] https://lore.kernel.org/lkml/20220216131332.1489939-7-arnd@kernel.org/
