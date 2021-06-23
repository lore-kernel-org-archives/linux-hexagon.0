From: 'Christoph Hellwig' <hch@lst.de>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 17:17:46 +0200
Message-ID: <20210623151746.GA4247@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org> <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com> <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08e101d76842$94f78a60$bee69f20$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: 'Arnd Bergmann' <arnd@arndb.de>, 'Christoph Hellwig' <hch@lst.de>, 'Sid Manning' <sidneym@codeaurora.org>, "'open list:QUALCOMM HEXAGON...'" <linux-hexagon@vger.kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>

It seem like it still isn't complete enought for a kernel build, though:

$ export CROSS_COMPILE=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/hexagon-unknown-linux-musl- 
$ make ARCH=hexagon LLVM=1 oldconfig
...
scripts/Kconfig.include:40: linker 'ld.lld' not found
make[1]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
make: *** [Makefile:614: oldconfig] Error 2

