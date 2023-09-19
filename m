From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: Arches that don't support PREEMPT
Date: Tue, 19 Sep 2023 17:41:21 +0100
Message-ID: <de98424d-41f9-90f9-742d-623e2b55c564@cambridgegreys.com>
References: <87zg1u1h5t.fsf@oracle.com> <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <bd664a61-4506-bab0-19c3-0011f57005b5@cambridgegreys.com>
 <87y1h2ur98.ffs@tglx>
 <9a5c0856-d542-9912-7494-53d7fe4538a3@cambridgegreys.com>
 <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-alpha-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <551475267.58816.1695140566849.JavaMail.zimbra@nod.at>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: Richard Weinberger <richard@nod.at>
Cc: tglx <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Matthew Wilcox <willy@infradead.org>, torvalds <torvalds@linux-foundation.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, bp <bp@alien8.de>, dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, mingo <mingo@redhat.com>, juri lelli <juri.lelli@redhat.com>, vincent guittot <vincent.guittot@linaro.org>, mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>, jon grimm <jon.grimm@amd.com>, bharata@amd.com, raghavendra kt <raghavendra.kt@amd.com>, boris ostrovsky <bori>



On 19/09/2023 17:22, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
>> It's been a while. I remember that I dropped it at the time, but do not =
remember
>> the full details.
>>
>> There was some stuff related to FP state and a few other issues I ran in=
to while
>> rewriting the interrupt controller. Some of it may be resolved by now as=
 we are
>> using host cpu flags, etc.
>=20
> I remember also having a hacky but working version almost 10 years ago.
> It was horrible slow because of the extra scheduler rounds.
> But yes, if PREEMPT will be a must-have feature we'll have to try again.

We will need proper fpu primitives for starters that's for sure. fpu_star/e=
nd in UML are presently NOOP.

Some of the default spinlocks and other stuff which we pick up from generic=
 may need to change as well.

This is off the top of my head and something which we can fix straight away=
. I will send some patches to the mailing list tomorrow or on Thu.

A.

>=20
> Thanks,
> //richard
>=20
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

--=20
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
