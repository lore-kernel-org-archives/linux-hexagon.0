From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 21:06:41 -0700
Message-ID: <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain>
References: <20210623141854.GA32155@lst.de>
 <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
 <20210623151746.GA4247@lst.de>
 <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624507604;
        bh=AVYk9Kjb9YIUzHPE+Uh15GvFa4yhwq2OwBOq0u9InVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsBrCdUL+zOx7kt1L45LH0oVSMjebFmX8uELfzFhQ6ZrqEU0nqRjdlo2N7BAmE8ZC
         qo+FOqRJueMBU5neX87YnnK327OutYHXWascl2eWFZiE3QZuMdFr/txlOBj8KQUjGW
         jB3dj5IjH0J8WoTDw09sVl18ahtrbc5nqed12D2Smi40duK6/wNkF0WO47r6OhT8l+
         w/cyTX1TBRZqLVOi1rnBw/SbLuNpEMZONt/JJ2C/vZGIVE3sKFiYeEDZRY+WUJmLqR
         +TNNauHerq7PuFEpCpM0AMywg1XfR3MXEj7gbVeIku3ZgpUybKiwKTWQ9fQy7EW2SC
         T0AjD+VN7aodw==
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Brian Cain <bcain@codeaurora.org>, Sid Manning <sidneym@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com

On Wed, Jun 23, 2021 at 05:35:38PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 23, 2021 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > It seem like it still isn't complete enought for a kernel build, though:
> >
> > $ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl-
> > $ make ARCH=hexagon LLVM=1 oldconfig
> > ...
> > scripts/Kconfig.include:40: linker 'ld.lld' not found
> 
> I tried this using the prebuilt binaries from apt.llvm.org:
> 
> $ make ARCH=hexagon LLVM=1 O=obj-hexagon CROSS_COMPILE=hexagon-linux-
> LLVM_IAS=1 CC=llvm-12 defconfig modules vmlinux
> <stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
> #warning syscall clone3 not implemented
>  ^
> 1 warning generated.
> 
> Doing the same thing with allmodconfig results in an internal error
> with clang-12
> while compiling kernel/locking/lockdep.c. Same thing with clang-13.
> After turning
> off lock debugging, it seems fine.

I've reported this upstream with you on CC:

https://bugs.llvm.org/show_bug.cgi?id=50838

Christoph, that toolchain should work (I had to install libtinfo5 and
libc++1-7 on Debian Buster):

$ export PATH=$HOME/tmp/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin:$PATH

$ make -skj"$(nproc)" ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all

CROSS_COMPILE is really only used to set the '--target=' flag when
LLVM=1 LLVM_IAS=1 are used, it can even be just 'hexagon-linux'.

As Arnd points out, https://apt.llvm.org is also an option, that is what
we use in our continuous integration:

https://github.com/ClangBuiltLinux/continuous-integration2

Cheers,
Nathan
