From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 17:25:22 -0500
Message-ID: <02a501d7388f$8dfb3b90$a9f1b2b0$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org> <027401d7387e$f5630120$e0290360$@codeaurora.org> <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619216738; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=wMOnQpi7ovLRfONEKjZgRwn/sKBHpGwI4nuW9iNQ37g=; b=lIAJB8NQdadJZNH1XQQgxhfYkc/0l93vakl2UpLd0u27FQPHrR/mEu/DRbJs2pNC/4ZFGwFU
 1t2TT66fEdvx8HMWQAjmm12ljtHj7t+lF/JoeTB3x5+UFQ/S6w2mNeVdFWUMwdAD4ZrfNTq3
 BzUbYQIMRFNH41uxpk0V8hMhtaE=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <24da08a4-e055-d8ac-8214-97d86cdcfd3d@infradead.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Randy Dunlap' <rdunlap@infradead.org>, 'Arnd Bergmann' <arnd@kernel.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
...
> > It's published as a container in the Gitlab Container Registry.  You =
can use
> docker/podman to pull "registry.gitlab.com/qemu-
> project/qemu/qemu/debian-hexagon-cross" in order to use it.
>=20
> Hi Brian,
>=20
> Maybe that will be useful to someone.
>=20
> However, I am looking for something like a tarball that I can download =
and
> deploy locally, like one can find at these locations:
>=20
> https://toolchains.bootlin.com/
> https://download.01.org/0day-ci/cross-package/
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Randy,

	I 100% agree, I would prefer a tarball myself.  I have been working =
with the team to produce the tarball and we haven't been able to deliver =
that yet.  No good excuses here, only bad ones: somewhat tied up in =
process bureaucracy.

I can share the recipe that was used to build the toolchain in the =
container.  No Dockerfile required, just a shell script w/mostly cmake + =
make commands.  All of the sources are public, but musl is a =
downstream-public repo because we haven't landed the hexagon support in =
upstream musl yet.

-Brian

