From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 09:39:21 -0500
Message-ID: <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
References: <20210623141854.GA32155@lst.de>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624459187; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=82D/RvnvXIWarUQl34Y8kax/sq7KtyWDivoFVNNrcc0=; b=rjP9aY/21c5AnM0fSC29JcyhRd/mmxRqoFiELFzFFLiXgSC8MsTEFcOS/NsI2M1Id8HNYV87
 PkUpmL79Nm1s4foA8/6zG6czVeAkLNMYitfEJxmNPpbMVE5nqwg+YcJvExFb0EgkqqE1ajbM
 D6KVTMu6kMiVAfLvroSA6q8Ta4M=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <20210623141854.GA32155@lst.de>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Christoph Hellwig' <hch@lst.de>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Sid Manning' <sidneym@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
...
> 
> Hi all,
> 
> the oldest supported gcc version in mainline is gcc 4.9.  But the only
> hexagon crosscompiler I can find is the one Arnds website points to here:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
> build test hexagon code?

We have provided a clang-12-based toolchain here:

https://codelinaro.jfrog.io/artifactory/codelinaro-qemu/2021-05-12/clang+llv
m-12.0.0-cross-hexagon-unknown-linux-musl.tar.xz

Could we update https://mirrors.edge.kernel.org/pub/tools/crosstool/ to
point here?

-Brian

