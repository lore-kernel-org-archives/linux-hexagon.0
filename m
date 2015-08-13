From: Christoph Hellwig <hch@lst.de>
Subject: provide more common DMA API functions
Date: Thu, 13 Aug 2015 17:04:03 +0200
Message-ID: <1439478248-15183-1-git-send-email-hch@lst.de>
Return-path: <linux-ia64-owner@vger.kernel.org>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu, jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn, x86@kernel.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Since 2009 we have a nice asm-generic header implementing lots of DMA API
functions for architectures using struct dma_map_ops, but unfortunately
it's still missing a lot of APIs that all architectures still have to
duplicate.

This series consolidates the remaining functions, although we still
need arch opt outs for two of them as a few architectures have very
non-standard implementations.

