From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 06/21] powerpc: dma-mapping: minimize for_cpu flushing
Date: Mon, 27 Mar 2023 14:13:02 +0200
Message-ID: <20230327121317.4081816-7-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919289;
        bh=deueI+j9QpGrVEyOG4DDYuCvj98ECBO1BAKmt0h8mOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVuAqsjP7YxlTH/jfP4+hsuYEQziw3g24pme7hHONNL+tw53tUh634JeGsQ9qMsJb
         QiINm6FdyBSv5TDyEB7Icm81k8m52mJn/Oxz3tHbi/ytF+O96JNQpZ/Drh8XHi5GkJ
         DmnZaeE1/m3voIm0tXrGCkwwIwVqBzNYdHR+o9A0oJjYUFrIsmjSaMN81JqJ9bMdUz
         ALnkbRdTQARnjKcrPQsU1ISirc/GQsLgUD4/A9nuA1lqc+8ADpy1N7lxpgLiuI99q/
         wavZSpV769B5sIjhDLnf+Uwl5ZpVrfQbbb6B1+ZErklaPLQABWTLh2J99jHRm4BWCH
         eD4ekbguj3pOg==
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

From: Arnd Bergmann <arnd@arndb.de>

The powerpc dma_sync_*_for_cpu() variants do more flushes than on other
architectures. Reduce it to what everyone else does:

 - No flush is needed after data has been sent to a device

 - When data has been received from a device, the cache only needs to
   be invalidated to clear out cache lines that were speculatively
   prefetched.

In particular, the second flushing of partial cache lines of bidirectional
buffers is actively harmful -- if a single cache line is written by both
the CPU and the device, flushing it again does not maintain coherency
but instead overwrite the data that was just received from the device.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/mm/dma-noncoherent.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index f10869d27de5..e108cacf877f 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -132,21 +132,11 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	switch (direction) {
 	case DMA_NONE:
 		BUG();
-	case DMA_FROM_DEVICE:
-		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
-		 */
-		if ((start | end) & (L1_CACHE_BYTES - 1))
-			__dma_phys_op(start, end, DMA_CACHE_FLUSH);
-		else
-			__dma_phys_op(start, end, DMA_CACHE_INVAL);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__dma_phys_op(start, end, DMA_CACHE_CLEAN);
+	case DMA_TO_DEVICE:
 		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		__dma_phys_op(start, end, DMA_CACHE_FLUSH);
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		__dma_phys_op(start, end, DMA_CACHE_INVAL);
 		break;
 	}
 }
-- 
2.39.2

