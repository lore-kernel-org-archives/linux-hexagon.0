From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 16:53:45 +0200
Message-ID: <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Sid Manning <sidneym@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Jun 23, 2021 at 4:39 PM Brian Cain <bcain@codeaurora.org> wrote:
>
> > -----Original Message-----
> > From: Christoph Hellwig <hch@lst.de>
> ...
> >
> > Hi all,
> >
> > the oldest supported gcc version in mainline is gcc 4.9.  But the only
> > hexagon crosscompiler I can find is the one Arnds website points to here:
> >
> > https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >
> > which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
> > build test hexagon code?
>
> We have provided a clang-12-based toolchain here:
>
> https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+llv
> m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

How close is this to the mainline clang builds from https://apt.llvm.org/?

The last time we talked, there were still a couple of bugs that prevented
me from building an unmodified kernel with an unmodified clang toolchain,
but I think you planned to address those. Are any changes left that did
not make it into the 12.0 release?

> Could we update https://mirrors.edge.kernel.org/pub/tools/crosstool/ to
> point here?

I'm happy to edit the index page on
https://mirrors.edge.kernel.org/pub/tools/crosstool,
but could you provide a stable URL that will keep pointing to the latest version
in the future so I don't have to update it for each new build?

        Arnd
