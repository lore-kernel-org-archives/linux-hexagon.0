From: Christoph Hellwig <hch@lst.de>
Subject: how can we test the hexagon port in mainline
Date: Wed, 23 Jun 2021 16:18:54 +0200
Message-ID: <20210623141854.GA32155@lst.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sid Manning <sidneym@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Hi all,

the oldest supported gcc version in mainline is gcc 4.9.  But the only
hexagon crosscompiler I can find is the one Arnds website points to here:

https://mirrors.edge.kernel.org/pub/tools/crosstool/

which is a non-upstream gcc 4.6.1 port.  How are we supposed to even
build test hexagon code?
