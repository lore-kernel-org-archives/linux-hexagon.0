From: Richard Weinberger <richard@nod.at>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 18:22:46 +0200 (CEST)
Message-ID: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org> <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de> <20230919134218.GA39281@noisy.programming.kicks-ass.net> <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com> <87y1h2ur98.ffs@tglx> <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Matthew Wilcox <willy@infradead.org>, torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>, vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>, jon grimm <jon.grimm@amd.com>, bharata@amd.com, raghavendra kt <raghavendra.kt@amd.com>, boris ostrovsky <bori>

----- Urspr=C3=BCngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> It's been a while. I remember that I dropped it at the time, but do not r=
emember
> the full details.
>=20
> There was some stuff related to FP state and a few other issues I ran int=
o while
> rewriting the interrupt controller. Some of it may be resolved by now as =
we are
> using host cpu flags, etc.

I remember also having a hacky but working version almost 10 years ago.
It was horrible slow because of the extra scheduler rounds.
But yes, if PREEMPT will be a must-have feature we'll have to try again.

Thanks,
//richard
