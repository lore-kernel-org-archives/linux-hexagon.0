From: 'Christoph Hellwig' <hch@lst.de>
Subject: Re: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 17:10:53 +0200
Message-ID: <20210623151053.GB3256@lst.de>
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>
Cc: 'Christoph Hellwig' <hch@lst.de>, 'Arnd Bergmann' <arnd@arndb.de>, 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Sid Manning' <sidneym@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:39:21AM -0500, Brian Cain wrote:
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

Do you have something that is just a small compiler like Arnd's gcc
build?  That tarball is already 264MB with xz compression, which does
not compare very favorablt to the 7MB for gcc.  And I fear I don't
really have space for that on my setups..
