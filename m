From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 07/21] powerpc: dma-mapping: always clean cache in _for_device() op
Date: Mon, 27 Mar 2023 14:13:03 +0200
Message-ID: <20230327121317.4081816-8-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x+d70OvVkRiaXQNQ3aYHtKws5S6WQGsKfXnAXpXcHdc=; b=acMJNW6cSqgMwB
	0UWIqkOuX9dFwhkrl1hzWsFHGIfayEcS13tfkGEMakRRgQPi4JySa2NZFEKFlUAH/SACouV8BSxHy
	viqEwlsYSx6Nd+idfXvDO6csiHMED5TaRqFYra9WetJdXgSWRpKOTKHehoOeiPzLdSdb1sGQqRXNr
	Rst7Omu7EtSbgb7PDIU6xueecwBXztwWi1OVttKHtXIrgDZDVo55+1TQSRMzwtoPxB3Q03rYy38UP
	lK5sapQVlLAU12hcwVDhgu1cvapzWKWPT/6cjCx0JH2ynyBi0DNE4yKHLR7g2gAgUx1kvqSONmI6A
	bSAq0lVEqn8CRaMe13mg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919298;
	bh=Y+wx0FiQgLjkqhPKxtczgrowoCTrPuzhrrVdIO/KSAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPGniWUcV5VUAZiOWzIY5/EsUqYQgyEzxjQ8UMeF3Al20/Hh61j9pc8T9PS2mzH4N
	 RSYd/J7YHPH5Nmfk7XsUSK79nWPo+dGlRYvhxWqnqg+N+CIjbuT/Wb2iRTjyp1l0YE
	 q3AT+X8nNFF6xSpGl06sKKOZy0e/LCKNsDpUgC07vuwopI9ykgcvXa2bBFGYOjVaGl
	 X5PV9Eydwk0GTrNzStCQUtT6ovd3xxwDRfs6NRHuZY4OjKijI2Z6KdM95ztBnGcDwK
	 5HPw8DEJ4VDkMTWgdZ8nt+6QlnfKBn6oiVjPRF9H4yYTieJdfpVbSHx8IkThq5gzbA
	 lsa0aYW1Hchqw==
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.>

From: Arnd Bergmann <arnd@arndb.de>

The powerpc implementation of arch_sync_dma_for_device() is unique in that
it sometimes performs a full flush for the arch_sync_dma_for_device(paddr,
size, DMA_FROM_DEVICE) operation when the address is unaligned, but
otherwise invalidates the caches.

Since the _for_cpu() counterpart has to invalidate the cache already
in order to avoid stale data from prefetching, this operation only really
needs to ensure that there are no dirty cache lines, which can be done
using either invalidation or cleaning the cache, but not necessarily
both.

Most architectures traditionally go for invalidation here, but as
Will Deacon points out, this can leak old data to user space if
a DMA is started but the device ends up not actually filling the
entire buffer, see the link below.

The same argument applies to DMA_BIDIRECTIONAL transfers. Using
a cache-clean operation is the safe choice here, followed by
invalidating the cache after the DMA to get rid of stale data
that was prefetched before the completion of the DMA.

Link: https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/mm/dma-noncoherent.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e108cacf877f..00e59a4faa2b 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -104,26 +104,7 @@ static void __dma_phys_op(phys_addr_t paddr, size_t size, enum dma_cache_op op)
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
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
-		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		__dma_phys_op(start, end, DMA_CACHE_FLUSH);
-		break;
-	}
+	__dma_phys_op(start, end, DMA_CACHE_CLEAN);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
-- 
2.39.2
