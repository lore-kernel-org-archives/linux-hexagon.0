From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 14/21] parisc: dma-mapping: use regular flush/invalidate ops
Date: Mon, 27 Mar 2023 14:13:10 +0200
Message-ID: <20230327121317.4081816-15-arnd@kernel.org>
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
	List-Owner; bh=iGFtyqoXJqYBuHou6yCsEqcPDXl7iZ1Bz1f4GK7WJPI=; b=4QtPnEQKeZzWor
	SLmkfwmyO1jgVrRkIUFXjtKLvVWMqjsfcGZyi5dqxZmpI/qKWQykwyV7W/JA5kXqLgI3LylIZ8M74
	6mLUpz2HaBXisfrBjnMXuzmUzTBLkhyaefx2KsL/01dM9scH4RlCSkcYr3TvbMnElRb4xp/MKNXWf
	Ua9Jr79Zr/4N/9wxs7AQQVlsjgRqI2za5BW5cpT5U0pr0Kastj28mCFGkJgK2G9PsmMXkaQ3lwxee
	sshPa8NWOapCO8YyXAt5ZcCfb1COqOT+BCS8NHKk4qUTCb3ADTyiLE9B8NGEb9ziYtUWSoX7MF/YF
	Ahsk1dd76lB5Q8hIZmdQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919359;
	bh=dXkVBSHFZo75+7tpVyAnh5gU/93Of01AyIY3GkfM5Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxcGBomvsroLU/soGwnnpht+OmpwZ+CQiYPJxIKYSMNj00PvVbGR5doPLu7Ta51zU
	 A4AjXgBFUoaToan99cxpW2tpzSfzmbx7CfucJpx/cZmN4J82wZvf5lGWjPr1irkWI4
	 eZp949vYHz5uXoUdFNeW62DfrFW7AYO5kKpo+/0YEhvvJIUHP4VPFskv3Eqs77XyrF
	 Xs9EDnGZ3aZvKZmOae+ULTgqTWW5PJS6Wpz4iR9tqX40bYNm1DPxfkANwAHMeIL88M
	 53CkbdMXPh+FND6MhgUZQGkY9ycD9t2Azpib43BAHfEe1LeuLFcS8ozxudjpxtNHkD
	 yYFa2ciLpv92A==
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

non-coherent devices on parisc traditionally use a full flush+invalidate
before and after each DMA, which is more expensive that what we do on
other architectures.

Before transfers to a device, the cache only has to be written back,
but apparently there is no operation for this on parisc. There is no
need to flush it again after the transfer though.

After transfers from a device, the second writeback can be skipped because
the CPU was not allowed to write to the buffer anyway, instead a purge
(invalidate without flush) can be used.

The DMA_FROM_DEVICE is handled differently across architectures,
most use only an invalidate (purge) operation, but some have moved
to flush in order to preserve dirty data when the device does not
write to the buffer, see the link below. As parisc already did the
full flush here, keep that behavior.

Link: https://lore.kernel.org/all/20220606152150.GA31568@willie-the-truck/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not really sure I understand the semantics of the 'flush'
and 'purge' operations on parisc correctly, please double-check that
this makes sense in the context of this architecture.
---
 arch/parisc/include/asm/cacheflush.h |  6 +++++-
 arch/parisc/kernel/pci-dma.c         | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index 0bdee6724132..a4c5042f1821 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -33,8 +33,12 @@ void flush_cache_mm(struct mm_struct *mm);
 
 void flush_kernel_dcache_page_addr(const void *addr);
 
+#define clean_kernel_dcache_range(start,size) \
+	flush_kernel_dcache_range((start), (size))
 #define flush_kernel_dcache_range(start,size) \
-	flush_kernel_dcache_range_asm((start), (start)+(size));
+	flush_kernel_dcache_range_asm((start), (start)+(size))
+#define purge_kernel_dcache_range(start,size) \
+	purge_kernel_dcache_range_asm((start), (start)+(size))
 
 #define ARCH_IMPLEMENTS_FLUSH_KERNEL_VMAP_RANGE 1
 void flush_kernel_vmap_range(void *vaddr, int size);
diff --git a/arch/parisc/kernel/pci-dma.c b/arch/parisc/kernel/pci-dma.c
index ba87f791323b..6d3d3cffb316 100644
--- a/arch/parisc/kernel/pci-dma.c
+++ b/arch/parisc/kernel/pci-dma.c
@@ -446,11 +446,32 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long virt = (unsigned long)phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		clean_kernel_dcache_range(virt, size);
+		break;
+	case DMA_FROM_DEVICE:
+		clean_kernel_dcache_range(virt, size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		flush_kernel_dcache_range(virt, size);
+		break;
+	}
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	flush_kernel_dcache_range((unsigned long)phys_to_virt(paddr), size);
+	unsigned long virt = (unsigned long)phys_to_virt(paddr);
+
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		purge_kernel_dcache_range(virt, size);
+		break;
+	}
 }
-- 
2.39.2
