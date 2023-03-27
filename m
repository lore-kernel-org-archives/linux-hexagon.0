From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 12/21] mips: dma-mapping: split out cache operation logic
Date: Mon, 27 Mar 2023 14:13:08 +0200
Message-ID: <20230327121317.4081816-13-arnd@kernel.org>
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
	List-Owner; bh=Ba0BkY5Agi62dFi0eS5+2jXxjBDUAu9JYvk90EvyRBo=; b=lf2SGipJkW55Hw
	Z8ELqUCIsZX32XYMzZKAf3w/nYgk4PS+LitTUVnHFxOFfNfagIjouTPCR1/E9aCLvGqdiAEjpfqQy
	RnIMIOuIzwoCPmWWDH76WOjbzTnygRQZSGEVj4iYmQavwbCvc7XisIWV2w4Ki82U7Fpd0dnJK2P0/
	K3zQ/9iKrYzVVt/X6nou0H5Tu7KVj+Gto/Ac4xY6bQRy9KYhMhB9z5wJ3EkLDBqFBv6o9rjfmcR00
	mN/d9989A59FnnmLSToJX5d4m3xxrgCtIG7dlK2BZe8mf+RXWzEkzAfIQy26kQPRt+7jFwY4R+26q
	BhNy4utBumOJu48/fG1w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919341;
	bh=uohG58os+YPGsAoIvHYZEyGIjYTpK/zcJikKrAX9FPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBanRUO40otZWpiIlwJ2ahlYI2/SU8zPpLT3Qw57jJE40woaJrRwcvRFQpLc/CmtF
	 0htU6ckgOgXVZH2DE+dJDcgxfjuUFxw2l8Pn5C7OdFGFsmKKCazqxQQraKNSB0q9Xu
	 8oHDYMJBaw55+tzbreH4Ndmiz3clXO5/H+FcYDQe1iQ34jySEQMALNvOHQCQFHA7Lk
	 5/v6eq8R2opwH5aOlgYkRDsOvBF62H+KLqxeGyv9U6ps8rklWRlmbETlf8xD0OymSe
	 8y75Z9XzlD5evRjJOnI7bZLIIgFEQA8+P2HCk/nt22ZXSqKgj7kPcjr6CG0psnqbOe
	 EFkVwSkNAqLQw==
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

The mips arch_sync_dma_for_device()/arch_sync_dma_for_cpu() functions
behave the same way as on other architectures, but in order to unify
the implementations, the code needs to be rearranged to pick the type
of cache operation in the outermost function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/mm/dma-noncoherent.c | 75 ++++++++++++++--------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index b4350faf4f1e..b9d68bcc5d53 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -54,50 +54,13 @@ void *arch_dma_set_uncached(void *addr, size_t size)
 	return (void *)(__pa(addr) + UNCAC_BASE);
 }
 
-static inline void dma_sync_virt_for_device(void *addr, size_t size,
-		enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_TO_DEVICE:
-		dma_cache_wback((unsigned long)addr, size);
-		break;
-	case DMA_FROM_DEVICE:
-		dma_cache_inv((unsigned long)addr, size);
-		break;
-	case DMA_BIDIRECTIONAL:
-		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
-		    cpu_needs_post_dma_flush())
-			dma_cache_wback((unsigned long)addr, size);
-		else
-			dma_cache_wback_inv((unsigned long)addr, size);
-		break;
-	default:
-		BUG();
-	}
-}
-
-static inline void dma_sync_virt_for_cpu(void *addr, size_t size,
-		enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_TO_DEVICE:
-		break;
-	case DMA_FROM_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		dma_cache_inv((unsigned long)addr, size);
-		break;
-	default:
-		BUG();
-	}
-}
-
 /*
  * A single sg entry may refer to multiple physically contiguous pages.  But
  * we still need to process highmem pages individually.  If highmem is not
  * configured then the bulk of this loop gets optimized out.
  */
 static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir, bool for_device)
+		void(*cache_op)(unsigned long start, unsigned long size))
 {
 	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
 	unsigned long offset = paddr & ~PAGE_MASK;
@@ -113,10 +76,7 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 		}
 
 		addr = kmap_atomic(page);
-		if (for_device)
-			dma_sync_virt_for_device(addr + offset, len, dir);
-		else
-			dma_sync_virt_for_cpu(addr + offset, len, dir);
+		cache_op((unsigned long)addr + offset, len);
 		kunmap_atomic(addr);
 
 		offset = 0;
@@ -128,15 +88,40 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	dma_sync_phys(paddr, size, dir, true);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		dma_sync_phys(paddr, size, _dma_cache_wback);
+		break;
+	case DMA_FROM_DEVICE:
+		dma_sync_phys(paddr, size, _dma_cache_inv);
+		break;
+	case DMA_BIDIRECTIONAL:
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    cpu_needs_post_dma_flush())
+			dma_sync_phys(paddr, size, _dma_cache_wback);
+		else
+			dma_sync_phys(paddr, size, _dma_cache_wback_inv);
+		break;
+	default:
+		break;
+	}
 }
 
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	if (cpu_needs_post_dma_flush())
-		dma_sync_phys(paddr, size, dir, false);
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		if (cpu_needs_post_dma_flush())
+			dma_sync_phys(paddr, size, _dma_cache_inv);
+		break;
+	default:
+		break;
+	}
 }
 #endif
 
-- 
2.39.2
