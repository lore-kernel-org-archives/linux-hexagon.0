From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 17:35:38 +0200
Message-ID: <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20210623151746.GA4247@lst.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Brian Cain <bcain@codeaurora.org>, Sid Manning <sidneym@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jun 23, 2021 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> It seem like it still isn't complete enought for a kernel build, though:
>
> $ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl-
> $ make ARCH=hexagon LLVM=1 oldconfig
> ...
> scripts/Kconfig.include:40: linker 'ld.lld' not found

I tried this using the prebuilt binaries from apt.llvm.org:

$ make ARCH=hexagon LLVM=1 O=obj-hexagon CROSS_COMPILE=hexagon-linux-
LLVM_IAS=1 CC=llvm-12 defconfig modules vmlinux
<stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
#warning syscall clone3 not implemented
 ^
1 warning generated.

Doing the same thing with allmodconfig results in an internal error
with clang-12
while compiling kernel/locking/lockdep.c. Same thing with clang-13.
After turning
off lock debugging, it seems fine.

       Arnd
