From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: ARCH=hexagon unsupported?
Date: Fri, 23 Apr 2021 15:26:34 -0500
Message-ID: <027401d7387e$f5630120$e0290360$@codeaurora.org>
References: <CAKwvOdngSxXGYAykAbC=GLE_uWGap220=k1zOSxe1ntuC=0wjA@mail.gmail.com> <CAK8P3a2DCCjOq+sB+9sRM7XrtnkromCs_+znv3dehqLiYFDQag@mail.gmail.com> <fa0bed95-5ddf-ecad-0613-2f13837578c3@infradead.org> <CAK8P3a0ttLxzP0J-mocxB2TkfEYJYj37TdW=uM65fB4giC_qeg@mail.gmail.com> <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619209614; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=DSbiIptFyG6M9pjdmGFsplYKvwsvZF7o76XdO+3XPjE=; b=TarOUvX+SUyRJaRJl1MpVf3MS0Ryay4ZGyJ6gnR2OEOAM9iI+0aLNXeHuyAjadMt3i4HTdMC
 GLMVFjr9G4fwn/oPOc+6DTSiRuZDhnC81rpA51lVn/T+bnupT0vWbBTy0KRxR6hZaU8Kjuyt
 6HLssbCdF7aTwMlR7Gcnypuo3qg=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <026d01d73877$386a1920$a93e4b60$@codeaurora.org>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@codeaurora.org, 'Arnd Bergmann' <arnd@kernel.org>, 'Randy Dunlap' <rdunlap@infradead.org>
Cc: 'Nick Desaulniers' <ndesaulniers@google.com>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'clang-built-linux' <clang-built-linux@googlegroups.com>, 'linux-arch' <linux-arch@vger.kernel.org>, 'Guenter Roeck' <linux@roeck-us.net>

> -----Original Message-----
> From: bcain=3Dcodeaurora.org@codeaurora.org
...=20
> There is a hexagon cross toolchain used for testing QEMU (userspace) =
guest
> code test cases.  This same toolchain can be used to build the kernel. =
 I will
> share a reference to that toolchain, standby.

It's published as a container in the Gitlab Container Registry.  You can =
use docker/podman to pull =
"registry.gitlab.com/qemu-project/qemu/qemu/debian-hexagon-cross" in =
order to use it.

-Brian

