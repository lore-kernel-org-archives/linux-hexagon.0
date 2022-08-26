From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
Date: Fri, 26 Aug 2022 13:07:24 -0700
Message-ID: <CAHk-=wgCN6moKefrRBECCon6675vh=6+yWGu0N5zu7G5eGh+wg@mail.gmail.com>
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com> <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5uVZvH0WBz/SiP6nDdXQ7fNSiMZNJF3T+BwdwEHBsbs=;
        b=Q/cENHnXRHQfPHNlmHyDlTvWdskTaGpvXdx0YnDNLNS/0RX8WPb1jR5KgVLVBJcIU7
         CSIyrv1NiJyoL5ax12gNIDW8tYBDTItBrtCw3Zl97Jwccpq1Ui0p68Ku4B3uDzrqFg8v
         uNufxLhtMvXsQPswhXy+3+QAszhCgZrLluj6U=
In-Reply-To: <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

[ Crossed emails ]

On Fri, Aug 26, 2022 at 1:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> +static __always_inline bool
> +arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
> +{
> +       unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +       return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
> +}
> +

I'd suggest you just do

  #define arch_test_bit_acquire generic_test_bit_acquire

in each of these files, instead of duplicating that function over and
over again..

Because the generic version always exists, since it comes from
generic-non-atomic.h, which is included directly from
<linux/bitops.h>.

                  Linus
