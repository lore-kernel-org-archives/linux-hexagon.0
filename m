From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Mon, 26 Apr 2021 08:13:43 -0500
Message-ID: <034f01d73a9d$fc4ed420$f4ec7c60$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <025b01d7386f$78deed80$6a9cc880$@codeaurora.org> <CAKwvOdnyowwDnHXPyJc8-KZg9vKy8zFn7hErazVT30+sPO8TyA@mail.gmail.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619442853; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=2aasOBDfVeKKukuy1LhKC7ZOGD0SUDLdz1bz/6bTWp8=; b=bMrrpEj31lTay8/KKgQWQCpuD2Td7UflW+eby1eXoyi6awQiNKLH4P1AUGi3kOlKK42ueNmp
 mQxApI2hV71DhCrVYKw06P98l7yTXFEc2Lz1Rqcit4Z8RMBuaYCfpyqg70ZdSYOiyWJIrsxQ
 TU0NPeVGJ42kS2RKD2RIXu+rEf8=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <CAKwvOdnyowwDnHXPyJc8-KZg9vKy8zFn7hErazVT30+sPO8TyA@mail.gmail.com>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nick Desaulniers' <ndesaulniers@google.com>
Cc: 'Arnd Bergmann' <arnd@kernel.org>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>, 'Randy Dunlap' <rdunlap@infradead.org>, 'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>

> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Friday, April 23, 2021 4:40 PM
> To: Brian Cain <bcain@codeaurora.org>
> Cc: Arnd Bergmann <arnd@kernel.org>; open list:QUALCOMM HEXAGON...
> <linux-hexagon@vger.kernel.org>; clang-built-linux <clang-built-
> linux@googlegroups.com>; linux-arch <linux-arch@vger.kernel.org>; =
Guenter
> Roeck <linux@roeck-us.net>; Randy Dunlap <rdunlap@infradead.org>; =
Miguel
> Ojeda <miguel.ojeda.sandonis@gmail.com>
> Subject: Re: ARCH=3Dhexagon unsupported?
>=20
> On Fri, Apr 23, 2021 at 11:35 AM Brian Cain <bcain@codeaurora.org> =
wrote:
> >
> > > -----Original Message-----
> > > From: Arnd Bergmann <arnd@kernel.org>
> > > Sent: Friday, April 23, 2021 4:37 AM
> > > To: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: open list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>;
> > > clang-built-linux <clang-built-linux@googlegroups.com>; Brian Cain
> > > <bcain@codeaurora.org>; linux-arch <linux-arch@vger.kernel.org>;
> > > Guenter Roeck <linux@roeck-us.net>
> > > Subject: Re: ARCH=3Dhexagon unsupported?
> > >
> > > On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang =
Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > Arnd,
> > > > No one can build ARCH=3Dhexagon and
> > > > https://github.com/ClangBuiltLinux/linux/issues/759 has been =
open
> > > > for
> > > > 2 years.
> > > >
> > > > Trying to build
> > > > $ ARCH=3Dhexagon CROSS_COMPILE=3Dhexagon-linux-gnu make LLVM=3D1
> > > LLVM_IAS=3D1
> > > > -j71
> > > >
> > > > shows numerous issues, the latest of which commit 8320514c91bea
> > > > ("hexagon: switch to ->regset_get()") has a very obvious typo
> > > > which misspells the `struct` keyword and has been in the tree =
for
> > > > almost 1 year.
> > >
> > > Thank you for looking into it.
> > >
> > > > Why is arch/hexagon/ in the tree if no one can build it?
> > >
> > > Removing it sounds reasonable to me, it's been broken for too =
long,
> > > and we did the same thing for unicore32 that was in the same
> > > situation where the gcc port was too old to build the kernel and =
the
> > > clang port never quite work in mainline.
> > >
> > > Guenter also brought up the issue a year ago, and nothing =
happened.
> > > I see Brian still occasionally sends an Ack to a patch that gets
> > > merged through another tree, but he has not send any patches or =
pull
> > > requests himself after taking over maintainership from Richard Kuo
> > > in 2019, and the four hexagon pull requests after 2014 only
> > > contained build fixes from developers that don't have access to =
the
> > > hardware (Randy Dunlap, Viresh Kumar, Mike Frysinger and me).
> >
> > Nick, Arnd,
> >
> > I can appreciate your frustration, I can see that I have let the =
community
> down here.  I would like to keep hexagon in-tree and I am committed to
> making the changes necessary to do so.
>=20
> I'm very happy to hear that.
>=20
> > I have a patch under internal review to address the cited build =
issues and
> libgcc/compiler-rt content.
>=20
> We'd be first in line to help build test such a patch. Please consider =
cc'ing
> myself and clang-built-linux@googlegroups.com when such a patch is
> available externally.  Further, we have the CI ready and waiting to =
add new
> architectures, even if it's just build testing. That would have caught
> regressions like 8320514c91bea; we were down to 1 build failure with
> https://github.com/ClangBuiltLinux/linux/issues/759 last I looked =
which was
> preventing us from adding Hexagon to any CI, but we must now dig =
ourselves
> out of a slightly deeper hole now.
>=20
> Is this patch something you suspect will take quite some time to work =
through
> internal review?

I don't think it should take long, no.  I should have a better idea =
today of about how long it will take.  We will share it ASAP.

> > In addition, my team has been focusing on developing QEMU system =
mode
> support that would mitigate some of the need for having hardware =
access.
> We have landed support for userspace hexagon-linux in upstream QEMU.
>=20
> That's also great to hear. QEMU is a critical part of our CI for boot =
testing; if
> there's more info on timelines or what's involved with booting a =
hexagon
> kernel in QEMU, we'd be very happy to know how or when that's =
available.
>=20
> > My team and I want to make hexagon's open source footprint larger, =
not
> smaller.  I realize that not being a good steward of the hexagon =
kernel has not
> helped, and we will do what we can to fix it.
>=20
> A worthwhile and appreciated sentiment. I believe you.
>=20
> Hexagon could be an interesting case for LLVM support in general for =
the
> Linux kernel; a case where each target or driver need not necessarily =
have a
> GCC backend to be acceptable.  But barring anyone from being able to =
actually
> build it (let alone run it), it's not that; it's less than that. It's =
dead code that bit
> rots further and burdens maintainers who are maintaining something =
that's
> already broken. I'm not sure who derives any benefit.
>=20
> I think it's in everyone's best interest to see Linux support more =
targets than
> fewer, and 2020 has been a hard year, but I'm curious how long =
something
> has to be broken before folks say "enough." Please let's support this =
properly
> or recognize the situation for what it is.

I don't think the special circumstances of 2020 are to blame, it's just =
my failure to give this work the priority it deserves.  Agreed: we will =
support the target properly.

-Brian

