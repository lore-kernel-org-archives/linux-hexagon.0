From: Christoph Hellwig <hch@lst.de>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 7 Jul 2021 16:10:54 +0200
Message-ID: <20210707141054.GA24828@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de> <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com> <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Brian Cain <bcain@codeaurora.org>, Sid Manning <sidneym@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com

On Wed, Jun 23, 2021 at 09:06:41PM -0700, Nathan Chancellor wrote:
> On Wed, Jun 23, 2021 at 05:35:38PM +0200, Arnd Bergmann wrote:
> > On Wed, Jun 23, 2021 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > It seem like it still isn't complete enought for a kernel build, though:
> > >
> > > $ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl-
> > > $ make ARCH=hexagon LLVM=1 oldconfig
> > > ...
> > > scripts/Kconfig.include:40: linker 'ld.lld' not found
> > 
> > I tried this using the prebuilt binaries from apt.llvm.org:
> > 
> > $ make ARCH=hexagon LLVM=1 O=obj-hexagon CROSS_COMPILE=hexagon-linux-
> > LLVM_IAS=1 CC=llvm-12 defconfig modules vmlinux
> > <stdin>:1515:2: warning: syscall clone3 not implemented [-W#warnings]
> > #warning syscall clone3 not implemented
> >  ^
> > 1 warning generated.
> > 
> > Doing the same thing with allmodconfig results in an internal error
> > with clang-12
> > while compiling kernel/locking/lockdep.c. Same thing with clang-13.
> > After turning
> > off lock debugging, it seems fine.
> 
> I've reported this upstream with you on CC:
> 
> https://bugs.llvm.org/show_bug.cgi?id=50838

I've not actually got any mail from that Cc..

> Christoph, that toolchain should work (I had to install libtinfo5 and
> libc++1-7 on Debian Buster):
> 
> $ export PATH=$HOME/tmp/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin:$PATH
> 
> $ make -skj"$(nproc)" ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all

hch@brick:~/work/linux$ make -j4 ARCH=hexagon
CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
HOSTCC  scripts/basic/fixdep
clang: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory
