From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
Date: Wed, 16 Sep 2020 11:34:50 -0700
Message-ID: <CAHk-=whvULv3M2dQzPra1W-uGiX=_6Z_YeGnRDodbtXgJpihWA@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de> <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <87y2la4xu6.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxuwlCpSO8TsaLIcauC4aS5tgqsK9SeD3UYfP7DN7g0=;
        b=ZKGyeh6DjOj0P0poUJri2yvAXd4omTbSKkycPwhZ3i+69eOgCicq7HjntIxGCUS9d/
         zNZFDIECDK4GwkaKDrKuGgCWjAAnhqqHdcPPPF/38HaA25t0OpynH7kdnV1WYZaxFMxz
         W50ov+r+RFsylVih7TsRScGj6r7RgJSz63qJs=
In-Reply-To: <87y2la4xu6.fsf@nanos.tec.linutronix.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Valentin Schneider <valentin.schneider@arm.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um <linux-um@lists.infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Ingo Molnar <mingo@kernel.org>

On Tue, Sep 15, 2020 at 12:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> You wish. I just found a 7 year old bug in a 10G network driver which
> surely would have been found if people would enable debug configs and
> not just run the crap on their PREEMPT_NONE, all debug off kernel. And
> that driver is not subject to bitrot, it gets regular bug fixes from
> people who seem to care (distro folks).

That driver clearly cannot be very well maintained. All the distro
kernels have the basic debug checks in place, afaik.

Is it some wonderful "enterprise hardware" garbage again that only
gets used in special data centers?

Becasue the "enterprise" people really are special. Very much in the
"short bus" special kind of way. The fact that they have fooled so
much of the industry into thinking that they are the competent and
serious people is a disgrace.

              Linus
