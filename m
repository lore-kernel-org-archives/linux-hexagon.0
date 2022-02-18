From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 14/18] lib/test_lockup: fix kernel pointer check for
 separate address spaces
Date: Fri, 18 Feb 2022 08:15:42 +0100
Message-ID: <CAK8P3a31_zG7npZbPHGixOYL0p28dGzs3f9ku_RB4p1tiEY0Tw@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-15-arnd@kernel.org>
 <20220218063549.GJ22576@lst.de>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645168560;
        bh=vgWt8lxnjYZUPlvwCFWcIBvafVy+fWmkyAOoKRaWgHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dip1NFffCT7YD3qzSAr1Fin/GwmOB5NYBJTOzrs7U7/Bvm4XqaiPYE0m5TfZQusca
         MRbcrmTm5/SvvBBwJ6d+gM/F4x3xTDVRaN3NXTeg29thtPCJZj5ucrkgu2KYOhOcca
         YYG79UlIdYrQmh318MnQPoMOhj/pzpg3ySf0sXzNhV4tmppW8ULCqS+V4JeMQrhHjy
         P04kRQs0VFG/iaOGrdUQTVs7nOgPxJrBYQnBTVPJQ7UmXqpZWxnZi6pNAeXqxk5wFh
         MnH6liRJL8MC6e3VLCid/+t09EHzhk77W8JdtjJAyk2DbefTP4jt0D08fEK2pcAo0U
         1wdZA3S0EkbnQ==
In-Reply-To: <20220218063549.GJ22576@lst.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.i>

On Fri, Feb 18, 2022 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 16, 2022 at 02:13:28PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > test_kernel_ptr() uses access_ok() to figure out if a given address
> > points to user space instead of kernel space. However on architectures
> > that set CONFIG_ALTERNATE_USER_ADDRESS_SPACE, a pointer can be valid
> > for both, and the check always fails because access_ok() returns true.
> >
> > Make the check for user space pointers conditional on the type of
> > address space layout.
>
> What is this code even trying to do?  It looks extremly broken.

As I understand it, this is only meant for debugging, and the module contains
intentionally broken lock usage to test whether the watchdog and lockup
detection in the kernel is able to find them.

I did not try that hard to understand how it works though.

      Arnd
