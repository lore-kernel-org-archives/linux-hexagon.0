From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 13:35:43 -0500
Message-ID: <025b01d7386f$78deed80$6a9cc880$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619202956; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=RhAT7aH0Aqqk6QCKlg4vyZ7VqDWoW4t/2SQv52LFvD8=; b=QohCoIOxEFW0EyqN1Du7hcWRFdTQgKo/aJkhU95zH3u4JltnLhl4f5+lM3/nquXBKVGPz4aZ
 GCTUkfnhSmoZcx4C8exkCrN4eNOafjIFcYDGfIXrHTJB/ZX6Ensm7P7T7CJCTxzv7DFw+79T
 JF5VmLAREe5pD9uYxZNjBCLrxFc=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Arnd Bergmann' <arnd@kernel.org>, 'Nick Desaulniers' <ndesaulniers@google.com>
Cc: "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Friday, April 23, 2021 4:37 AM
> To: Nick Desaulniers <ndesaulniers@google.com>
> Cc: open list:QUALCOMM HEXAGON... <linux-hexagon@vger.kernel.org>;
> clang-built-linux <clang-built-linux@googlegroups.com>; Brian Cain
> <bcain@codeaurora.org>; linux-arch <linux-arch@vger.kernel.org>; =
Guenter
> Roeck <linux@roeck-us.net>
> Subject: Re: ARCH=3Dhexagon unsupported?
>=20
> On Fri, Apr 23, 2021 at 12:12 AM 'Nick Desaulniers' via Clang Built =
Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Arnd,
> > No one can build ARCH=3Dhexagon and
> > https://github.com/ClangBuiltLinux/linux/issues/759 has been open =
for
> > 2 years.
> >
> > Trying to build
> > $ ARCH=3Dhexagon CROSS_COMPILE=3Dhexagon-linux-gnu make LLVM=3D1
> LLVM_IAS=3D1
> > -j71
> >
> > shows numerous issues, the latest of which commit 8320514c91bea
> > ("hexagon: switch to ->regset_get()") has a very obvious typo which
> > misspells the `struct` keyword and has been in the tree for almost 1
> > year.
>=20
> Thank you for looking into it.
>=20
> > Why is arch/hexagon/ in the tree if no one can build it?
>=20
> Removing it sounds reasonable to me, it's been broken for too long, =
and we
> did the same thing for unicore32 that was in the same situation where =
the
> gcc port was too old to build the kernel and the clang port never =
quite work
> in mainline.
>=20
> Guenter also brought up the issue a year ago, and nothing happened.
> I see Brian still occasionally sends an Ack to a patch that gets =
merged through
> another tree, but he has not send any patches or pull requests himself =
after
> taking over maintainership from Richard Kuo in 2019, and the four =
hexagon
> pull requests after 2014 only contained build fixes from developers =
that don't
> have access to the hardware (Randy Dunlap, Viresh Kumar, Mike =
Frysinger
> and me).

Nick, Arnd,

I can appreciate your frustration, I can see that I have let the =
community down here.  I would like to keep hexagon in-tree and I am =
committed to making the changes necessary to do so.  I have a patch =
under internal review to address the cited build issues and =
libgcc/compiler-rt content.  In addition, my team has been focusing on =
developing QEMU system mode support that would mitigate some of the need =
for having hardware access.  We have landed support for userspace =
hexagon-linux in upstream QEMU.  My team and I want to make hexagon's =
open source footprint larger, not smaller.  I realize that not being a =
good steward of the hexagon kernel has not helped, and we will do what =
we can to fix it.

-Brian

