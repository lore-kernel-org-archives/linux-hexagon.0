From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 14:31:11 -0500
Message-ID: <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619206275; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=+/oWbT+YhpS+wVDK/yW7x/UFoHGSzJ0/A7AJlxQ6qZw=; b=xICGoYUqwYJg9caJy4kMRE0eqF5CmyLCoE2AsZvU/1yh6Uh8eNtgtZBWEohyF94tCdnZj0p6
 6Zg5xRenDTLEp3Oa9/p8GqCGK1Etx+EtXw+ndIJNDV6yFZrn0UX+VSp0Jwxfi5VXTntK2Qsp
 ZZPscJ2zxPKcahWB83AlvZha11M=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Arnd Bergmann' <arnd@kernel.org>, 'Randy Dunlap' <rdunlap@infradead.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
...
> > There is no current gcc C compiler in the 3 locations that I know of =
to look.
> > The one I tried is v4.6 and it is too old to work with current =
makefiles.
>=20
> Correct, as I understand it , work on gcc was stopped after the 4.6 =
release
> and any testing internally to Qualcomm was done using a patched clang. =
A
> few years ago this was said to be (almost?) entirely upstream, but as =
Nick
> points out it has never been possible to build an upstream hexagon =
kernel
> with an upstream clang.

The critical missing component for a conventional build are =
implementations for compiler-emitted calls to builtins like =
__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes, __hexagon_modsi3 =
-- these are available in the toolchain libraries =
(LIBGCC=3Dlibclang_rt.builtins-hexagon.a) but not in the kernel.  This =
is easy to mitigate and yet disappointing that I did not do so before.  =
I will do it.

There is a hexagon cross toolchain used for testing QEMU (userspace) =
guest code test cases.  This same toolchain can be used to build the =
kernel.  I will share a reference to that toolchain, standby.

-Brian

