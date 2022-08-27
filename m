From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
Date: Sat, 27 Aug 2022 09:50:44 -0700
Message-ID: <CAHk-=whyBQzofeFc1a1d2=HKcrTCLDi_FY+K2NG0R4e-9epqPw@mail.gmail.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com>
 <CAHk-=wh91FqN2sNSRFZPxfGnqAbJ1o66ew8TXh+neM9hW0xZiA@mail.gmail.com>
 <alpine.LRH.2.02.2208261620210.9648@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whO2sd233T8AXNMhYztPiF9hae+1ePOX1fEMEu6Ow1CQQ@mail.gmail.com> <alpine.LRH.2.02.2208270720500.18630@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WAEr4zCif0zp++lZAUWZkj4GJhtO7eOsEWQzvmzftQQ=;
        b=Usv9scAAadihgjNYDL+pCD+vdqOGF1X0cWC9MSgKis7DY1nR47sOn/fUFAwpVGARg2
         R28Rkid0Z4bmdsM2qMAaJdSP1ygPFSKxdXwNRtDIYxO/YduZhQYknWZKo4dOrEu2FVgH
         hZLhNoIfLH15LdDClrvelFDdmfGzL5gJ5DcEs=
In-Reply-To: <alpine.LRH.2.02.2208270720500.18630@file01.intranet.prod.int.rdu2.redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Sat, Aug 27, 2022 at 4:38 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> I compile-tested this patch on alpha, s390x, m68k, sh, sparc32, sparc64.
> So, you can commit it to close these uncompilable-kernel reports.

Thanks, done.

                Linus
