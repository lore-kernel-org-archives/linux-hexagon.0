From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 18:58:15 -0600
Message-ID: <1361926695.18483.1@driftwood>
References: <5251361904861@web14e.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <5251361904861@web14e.yandex.ru> (from cotulla@yandex.ua on Tue
	Feb 26 12:54:21 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; delsp="Yes	Format=Flowed"
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 02/26/2013 12:54:21 PM, cotulla@yandex.ua wrote:
>=20
> > =A0You're comparing arm performance with QDSP6 by writing pessimal =
=20
> QDSP6
> > =A0code that does single-byte moves and keeps half the execution un=
its
> > =A0idle. You're going to get some extremely useful numbers out of =20
> that,
> > =A0aren't you? (Even their uClibc port had an assembly optimized
> > =A0memmove().)
> Well, is it simular to usual C/C++ code task and results of =20
> compilation?

Not for strcpy(), strcat(), memcpy(), memmove(), structure assignment..=
=2E

> Until you will do a manual assembler optimization.

No, until your libc does the manual assembler optimization of common =20
operations _for_ you (which is half the reason there's target-specific =
=20
code), and you use the right functions.

> > =A0Is your arm code also doing single byte moves, with the requisit=
e
> > =A0bit-shifting and masking that doing that on arm entails (since =20
> last I
> > =A0checked arm hasn't actually _got_ instructions that handle bytes=
,
> > =A0although maybe it went into thumb2 or v7 or v8 when I wasn't
> > =A0looking...)?
> ARM has LDRB and STRB instructions long time ago (ever in ARMv4)
>=20
> Okay, seems this is really bad test.

That was my point, yes.

I honestly dunno how good the hexagon optimizer in gcc is. (The =20
qualcomm guys did extensive hand-hacked assembly, platform hasn't been =
=20
all that widely used outside of there.) We've gone a touch beyond =20
"duff's device" these days...

> > =A0Specifically, the v2 hardware (in the snapdragon chipset in the =
=20
> Nexus
> > =A0One) has 6 register profiles (for the 6 pipeline stages, acting =
as
> > =A06-way SMP) but performance peaked at "make -j 3" which ran very
> > =A0slightly faster than "make -j 4", and then -j 5 and -j 6 were ea=
ch
> > =A0noticeably slower (due to TLB thrashing).
> Intersting to know that.
> I want to get SSH access to got console and interaction with system.

I miss having that myself. I built Aboriginal Linux on target and built=
 =20
Linux From Scratch and chunks of Beyond Linux From Scratch under it and=
 =20
the result was a fairly decent machine. I would love to support it in =20
my upstream vanilla projects, but Qualcomm never gave me (or anyone =20
else) the tools to do that outside of employee context.

> > =A0I believe that v3 had already taped out by then (late 2010, but =
it =20
> had
> > =A0fewer pipeline stages and thus register profiles anyway), and th=
en =20
> v4
> > =A0was going to increase the TLB entries. What actually shipped was=
 =20
> after
> > =A0my time, dunno the details.
> v3 should be rather close to v2, but v4 seems to have few new =20
> features.
> At the current moment all v2 source code works on v3.

They're backwards but not forwards compatible. v2 works on v3 and v4, =20
but v4 may not work on v2. (Most architectures work that way.)

Over in the arm world, moving from armv4l to armv5l gives you about a =20
25% performance boost (which means 25% more battery life if it races it=
 =20
idle faster), and Arm EABI standard requires thumb instructions =20
(armv4tl). But otherwise, you can run the old code just fine.

Rob--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
