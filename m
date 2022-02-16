From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
Date: Wed, 16 Feb 2022 14:06:25 +0100
Message-ID: <CAK8P3a0PwjB+KE+j3_sknZuiuY-kUe_J76nYac-mx82dccA3Rw@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-12-arnd@kernel.org>
 <YgqMLYJs0RMecMck@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645016803;
        bh=XpyXyO6XeLPMFwMT57AZNzNQgXnMBZ2Ni2r+dAXZ1s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m86IV6YQZzHRJuDux3taFbaRjn+w9RuI6vh4wtLv8qscNybLMG9S7+2rm1PNzrb20
         Dd5S6VsCYA0xUl1vOFFn3tNcP5kMF/3okjlp1F0h2o1Xvta1epkmZYCJUZnDs3yLoA
         VzYx4F/n1Ow3YwU1D9VL3p/ZapRwreq4wU2F2zdBEZVDPHlhJZ5UCirUITvqXKP03u
         mjPPXaT5ZCAExBhxPZs+6x/NgZOCXftC+3jOhCw6lYUHk202K2WWgJTp7zViNeOTI3
         d6qcX+NrilxdmbmnVfKB2lTecLHUYHmjxyqYH1gVkIK8Gk+2LbSYNZnzPmnsXhuwAQ
         I1fP9Rg2mGbLg==
In-Reply-To: <YgqMLYJs0RMecMck@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s39>

On Mon, Feb 14, 2022 at 6:06 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> >  void prom_world(int enter)
> >  {
> > -     if (!enter)
> > -             set_fs(get_fs());
> > -
> >       __asm__ __volatile__("flushw");
> >  }
>
> The enter argument is now unused.

Right, good point. I'll add a comment, but I think I will leave that
as this seems
too hard to change the callers in assembly code for this. If any
sparc64 developer
wants to clean that up, I'm happy to integrate the cleanup patch in my series.

         Arnd
