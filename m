From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Wed, 19 May 2021 10:28:07 -0500
Message-ID: <06a701d74cc3$92bc59f0$b8350dd0$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org> <027401d7387e$f5630120$e0290360$@codeaurora.org> <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org> <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org> <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621438116; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=FQqOtTWuOS13BN8O02FNaShatp6JGVjdDGcLP0U0neg=; b=D1IPXzOaJha0J/ypXEvWzoVF2sg3wP4S1IlyCSgCD7Jo67+/Z3Ixb8fagfjh87DSa0Vacz0t
 ANRUw+xGoplUuoXx7LWJNb9PdOIg86gOpJN3JBOGUz9dQMcmDKf4H0dFQZU3Jcy5PXzkcbsl
 iNtXgS6bciI0RVrNi47BYJvGdpc=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <42ab3057-3b43-7f98-6387-6e79761d2d3f@infradead.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Randy Dunlap' <rdunlap@infradead.org>, 'Arnd Bergmann' <arnd@kernel.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>, Sid Manning <sidneym@quicinc.com>

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> > Randy,
> >
> > 	I 100% agree, I would prefer a tarball myself.  I have been working =
with
> the team to produce the tarball and we haven't been able to deliver =
that yet.
> No good excuses here, only bad ones: somewhat tied up in process
> bureaucracy.
> >
> > I can share the recipe that was used to build the toolchain in the =
container.
> No Dockerfile required, just a shell script w/mostly cmake + make =
commands.
> All of the sources are public, but musl is a downstream-public repo =
because we
> haven't landed the hexagon support in upstream musl yet.
>=20
> Hi Brian,
> I can wait. :)

Randy, thanks for your patience.  We don't quite have all the kinks =
worked out for a release process but I have worked with the Linaro team =
to produce a clang-based cross toolchain and we can share a link:

https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+=
llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

Contents:
- clang+llvm+lld+libunwind+libcxx+libcxxabi built from `llvmorg-12.0.0` =
release
- `qemu-hexagon` binary (scalar core only!) built from upstream =
github.com/qemu/qemu repo `15106f7dc3290ff3254611f265849a314a93eb0e`
- headers from linux kernel 5.6.18
- C library built from github.com/quic/musl commit =
aff74b395fbf59cd7e93b3691905aa1af6c0778c
- unabridged build details in =
https://github.com/quic/qemu/tree/d26f3843c794d9d9b17b637550dc3b5a2bacd83=
7/quic/container

Once we're able to produce releases on a more regular basis we should be =
able to share a hexagon-linux-user QEMU that can do scalar+vector.  And =
some time after that a sysemu-capable qemu.

Our process for this first run did not include a signature for the build =
tarball, and that is regrettable.  It will be included next time around. =
 I have produced the sha256 signature below (post hoc) of the tarball =
that I tested:

	55c51e8289cc21e6779cfc3b18bb9ad02632fc52d3c3a91bf6fdb4c8f578c84c  =
clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

-Brian

