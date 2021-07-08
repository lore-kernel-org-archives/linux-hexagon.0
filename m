From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: how can we test the hexagon port in mainline
Date: Thu, 8 Jul 2021 13:35:49 -0500
Message-ID: <0a6801d77428$13c88060$3b598120$@codeaurora.org>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de> <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com> <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de> <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org> <20210708052751.GA18789@lst.de> <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625769384; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=CaCFZHGTqeI0frAdNEP44m6CAB9Mlr4tcLRQxgjQMC0=; b=l+8YjTFcf9DgzkAXum9bidj9n13zgxAgS0W9muAqDxSNTWW2c8DtVbFRt1DhWhPG+kpBwYPE
 lgXzQ79cJK2YEjf3pcxvMgXXGTmXANBJHCrDS5DWBgoE2IlEpYJ0DNsWbCbMAbXhtOlECy9n
 fIUCZ4J/yMlvjpObz4ShQCL35Ao=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Nick Desaulniers' <ndesaulniers@google.com>, 'Christoph Hellwig' <hch@lst.de>
Cc: "'Manning, Sid'" <sidneym@quicinc.com>, 'Nathan Chancellor' <nathan@kernel.org>, 'Sid Manning' <sidneym@codeaurora.org>, 'Arnd Bergmann' <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Thursday, July 8, 2021 12:54 PM
> To: Christoph Hellwig <hch@lst.de>
> Cc: Nathan Chancellor <nathan@kernel.org>; Brian Cain
> <bcain@codeaurora.org>; Sid Manning <sidneym@codeaurora.org>; Arnd
> Bergmann <arnd@arndb.de>; linux-hexagon@vger.kernel.org; linux-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: Re: how can we test the hexagon port in mainline
>=20
> On Wed, Jul 7, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jul 07, 2021 at 10:42:27AM -0700, Nathan Chancellor wrote:
> > >> hch@brick:~/work/linux$ make -j4 ARCH=3Dhexagon
> > >> CROSS_COMPILE=3Dhexagon-unknown-linux-musl LLVM=3D1 LLVM_IAS=3D1
> defconfig all
> > >> HOSTCC  scripts/basic/fixdep
> > >> clang: error while loading shared libraries: libtinfo.so.5: =
cannot open
> shared object file: No such file or directory
> > >
> > > Hmmm, is that with libtinfo5 installed (or whatever the =
ncurses-compat
> > > equivalent is on your distribution installed)? I had that problem =
on Debian
> > > until I insta
> >
> > I did install libtinfo5, which just gets me to the next error:
> >
> > hch@brick:~/work/linux$ export PATH=3D/opt/clang+llvm-12.0.0-cross-
> hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/:$PATH
> > hch@brick:~/work/linux$ make -j4 ARCH=3Dhexagon
> CROSS_COMPILE=3Dhexagon-unknown-linux-musl LLVM=3D1 LLVM_IAS=3D1 =
defconfig
> all
> >   HOSTCC  scripts/basic/fixdep
> > clang: error while loading shared libraries: libc++.so.1: cannot =
open shared
> object file: No such file or directory
>=20
> ^ Nathan did mention earlier in the thread that he "had to install
> libtinfo5 and libc++1-7 on Debian Buster." Emphasis on the _and
> libc++_ part.
>=20
> I'm not sure if that binary distribution came with a libc++.so.1; if
> so, that path needs to be specified via LD_LIBRARY_PATH so that the
> runtime loader can find it.  Perhaps rpath wasn't set when the clang
> binary was built.

The only libc++ builds in this distribution are the target hexagon ones. =
 I did not include a host x86_64 libc++.so library, but it does seem =
like it would be more convenient if we did.

Nathan suggested disabling the terminfo dependency, I will include that =
change for the next release that we produce.  Also, the upcoming =
clang-13 release from releases.llvm.org should contain all the necessary =
fixes (discussed recently) to build kernel code for hexagon.

> We're looking into statically linked images of clang to prevent these
> kinds of games.

Statically linking against libc++/libc++abi at least seems like a good =
idea.  Let me know if we can help.

-Brian

