From: Rob Landley <rob@landley.net>
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Fri, 22 Feb 2013 22:24:30 -0600
Message-ID: <1361593470.29465.17@driftwood>
References: <1163031361018389@web26d.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1163031361018389@web26d.yandex.ru> (from cotulla@yandex.ua on
	Sat Feb 16 06:39:49 2013)
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; delsp="Yes	Format=Flowed"
To: cotulla@yandex.ua
Cc: linux-hexagon@vger.kernel.org

On 02/16/2013 06:39:49 AM, cotulla@yandex.ua wrote:
> Hi,
>=20
> > =A0For the qdsp6v3 the effective clock rate was 300MHz per core, so=
 =20
> yes.
> > =A0It might be even slower for v2, not sure. =A0(the chip clock rat=
e is =20
> 1.8
> > =A0GHz, there are 6 interleaved cores, so 1.8/6 =3D 300 =A0The powe=
r =20
> savings
> > =A0are not from the clock rate, but from the tiny transistor count.=
 =20
> The
> > =A0performance efficiency is from keeping all of those transistors
> > =A0constantly wiggling, which is what the interleaved pipeline does=
=2E)
>=20
> Hm, I thought the maximum clock rate is 595.2 Mhz?
> Or 1.8 is another clock?
> But by changing this clock rate I can get different Q6 performance.

The clever thing hexagon did was avoid any pipeline interlocks. Instead=
 =20
they had as many register profiles as pipeline stages, and they =20
round-robined them down the pipeline. So the v2 processor ran at 600 =20
mhz but presented to Linux as a 6-way SMP chip each running at 100 mhz.

This meant there were 6 clock cycles between each memory access, so the=
 =20
DRAM had no trouble keeping up. There was no speculative execution, no =
=20
branch prediction, it never did wasted work and any pipeline stage that=
 =20
had nothing to do powered down completely for that clock cycle. They =20
got performance out of it via massive parallelism: each instruction was=
 =20
a 4-issue VLIW, and the latter two cores were 4-way SIMD vector =20
thingies, so if you could break your task into 6 chunks (4 graphics =20
processes, an audio process, and a control process) it could do some =20
quite heavy lifting.

In the later chips, they were looking to reduce the number of pipeline =
=20
stages, which would let them clock the chip down (increasing the power =
=20
efficiency, power consumption increases exponentially with clock speed)=
 =20
while still allowing each thread to progress at 100 mhz. So a 300 mhz =20
chip is probably a 3 stage pipeline presenting as 3 way SMP.

I only did a 6 month contract there in 2010 beating bugs out of the =20
toolchain. I know they hired Linutronix to help clean up their code so =
=20
it had a chance of being accepted upstream, but tglx and crowd had to =20
sign an NDA so I dunno what they're allowed to say about it, even now =20
that some of the code's gone upstream.

> > =A0Don't know v2. But v3 had a 'real' MMU
> Hm, are you sure in that?
> I had never seen any usage of it. As well as binutils registers =20
> definition
> doesn't include any suitable registers for that.

The version I saw (v2) had a software loaded TLB which a binary blob =20
made act like an MMU. It had too few TLB slots and kept thrashing them =
=20
when running a real OS, so they were going to add more in a future =20
version.

The thing to realize about Qualcom is that the lawyers are in charge. =20
The patent licensing revenue is credited to the legal department but =20
the R&D costs of coming up with that IP in the first place is deducted =
=20
from engineering, so in terms of _net_ revenue it looks like licensing =
=20
is more profitable than engineering even though it's just a fancy =20
story. Political power within the company is based on how much net =20
revenue you're bringing in, and with Legal mooching off engineering =20
like that they get to overrule them most of the time.

So they've got brilliant engineers who do brilliant thigns you never =20
hear about, and would LIKE to get them out into the real world but can =
=20
never get permission. (Hence craziness like the "Code Aurora Forum" =20
which is a partnership between Qualcomm and Qualcomm with some random =20
co-signer (Intel) there to make it SEEM like somebody else is involved,=
 =20
because spinning off a wholly-owned subsidiary "Qualcomm Innovation =20
Center" and having that sock puppet do all your open source stuff isn't=
 =20
considered enough of a firewall between Legal's precious patents and =20
the GPL.

(Now add a bit of political infighting between the people who do their =
=20
"Scorpion" licensed ARM core and the people who would like to see =20
Hexagon used as a real processor instead of a multimedia coprocessor, =20
and what little power engineering has is wasted.)

So it's realy cool technology, fairly widely deployed, and if you want =
=20
to make use of it I'd recommend reverse engineering it. (You can look =20
around the code aurora forum pages and download the toolchains they =20
give to the android guys; those binary blobs get built with modified =20
gcc+binutils and the lawyers scrupulously obey the letter of the law as=
 =20
they understand it; the code is published at an obscure URL somewhere.)

The fun part is that "objdump" can decode the magic instructions, even =
=20
in the binary blob. Because it has to be able to compile them, you see.=
 =20
(They're working on Hexagon support for Open64 and LLVM, but gcc's =20
still a more mature compiler. Google for "hexagon open64" and similar =20
finds interesting stuff, by the way.)

> > =A0Good, because the bootloader was going to be the other issue.
> Yes, in my case it's working :)
> But another guys who also want participate in this project with =20
> MSM8960/APQ8064 they still can't run any unsigned code on Q6.
> In modern phones it's often locked from changes :(

Getting hexagon support into QEMU would make life SO much easier...

> > =A0I'd done the patches for glibc (yes, they're publicly available =
on
> > =A0some website, don't know if they got merged or not), got 98% of =
the
> > =A0many hundreds of glibc unit tests to pass, including most or all=
 of
> > =A0the thread tests including TLS. Someone had bootstrapped hundred=
s =20
> of
> > =A0.debs and both python and perl passed 100% of their tests. =A0I'=
m =20
> sure
> > =A0no one cares, but even guile worked, and I was about to start =20
> fiddling
> > =A0with haskell :-)
> Good to hear that. Good job!
> So userspace support is rather good in common.

I built Linux From Scratch and large chunks of beyond linux from =20
scratch during my contract in 2010 (put together a demo with X11, =20
albeit just clients connecting an X server running on another machine =20
through the net), but that was with their gcc 3.4, binutils 2.14, and =20
uClibc 0.9.30 forks. (All of which were obsolete already when I was =20
there, and have probably been abandoned since.)

That was using... comet boards, I think? (Those hacked up phone =20
motherboards Linas was talking about. The "snapdragon" SoC, QDSP6v2 =20
chips plus a Scorpion plus an armv5 plus a QDSP4, all in a big ball =20
with USB and a serial port and an ethernet device and 256 megs of =20
memory and I forget what else. We had a small number of them because =20
they never made that many. Not a mass produced product, semi-obsolete =20
at the time, but the linux porting effort scrounged what resources it =20
could...)

Rob
