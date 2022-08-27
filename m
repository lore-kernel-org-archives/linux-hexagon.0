From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
Date: Sat, 27 Aug 2022 07:38:45 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.2208270720500.18630@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com> <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com> <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com> <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com> <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661600332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVuxalu5P1+XapIuqjdM8bU9Xz/L+P4hGuQ04daUvb4=;
        b=RV0DbbY7xq2Ly6eSCI/fpU97UYq0d719AMPoHCZ3X3NZaxf6qgkpREIcKS14+ba2l+ZLKE
        FsWjl3spDjjazW1kB1/hwACPKQjJxKiBnMaGgpFHYlqHxWWVoYozX381J5z2jo/yGZXgpH
        Dr5TtkZHPg2763FzBFqsDbh4i4if++Q=
In-Reply-To: <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>



On Fri, 26 Aug 2022, Linus Torvalds wrote:

> On Fri, Aug 26, 2022 at 1:43 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > I'm wondering why do the architectures redefine test_bit, if their
> > definition is equivalent to the generic one? We could just delete
> > arch_test_bit and use "#define arch_test_bit generic_test_bit" as well.
> 
> I think generic_test_bit() came after many of them, and when it
> didn't, people copied earlier architectures where they had already
> done their own.
> 
> > Another untested patch ... tomorrow, I'll try to compile it, at least for
> > architectures where Debian provides cross-compiling gcc.

I compile-tested this patch on alpha, s390x, m68k, sh, sparc32, sparc64. 
So, you can commit it to close these uncompilable-kernel reports.

Mikulas

