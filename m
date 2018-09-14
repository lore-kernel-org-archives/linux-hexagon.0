From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 18/30] memblock: replace alloc_bootmem_low_pages with
 memblock_alloc_low
Date: Fri, 14 Sep 2018 15:10:33 +0300
Message-ID: <1536927045-23536-19-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uB8M8qb+Ih2Zeko/ZtzZKm2FcTGTsSfKJyfZPHLtQR4=; b=UtKXfQIp03ZUmGx3FKPk1SOLeF
	BN5u5vug65SZbE9Ihsw+Qb3br5pbuGENNUVtPmXxd4ZXOgY78HyDHYIe8iPGDISa9DEunCvdIJxBS
	K3fX5udmU12ObqjteCTisE4CuwylofDjuLkG6K2WbOby1QKpT4JlA3qB9IXcXGt4QHbtqzXPGn9ug
	sLX88YRB39U3I5uYAZJSRn3kpxm1kv268IlmbE6gZYAnv4PpRbBbLNlBK1LnIaumqTvejbUsjWX9F
	qLrFQ+i1ODzyX/siLv3Xoqmi0guCn8qq6DjKspXkAnZFB0uC9rcjXAiEX+Rtasmj5HTSw/HUyj/6j
	hC6M9Jtg==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

The alloc_bootmem_low_pages() function allocates PAGE_SIZE aligned regions
from low memory. memblock_alloc_low() with alignment set to PAGE_SIZE does
exactly the same thing.

The conversion is done using the following semantic patch:

@@
expression e;
@@
- alloc_bootmem_low_pages(e)
+ memblock_alloc_low(e, PAGE_SIZE)

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/arc/mm/highmem.c                |  2 +-
 arch/m68k/atari/stram.c              |  3 ++-
 arch/m68k/mm/motorola.c              |  5 +++--
 arch/mips/cavium-octeon/dma-octeon.c |  2 +-
 arch/mips/mm/init.c                  |  3 ++-
 arch/um/kernel/mem.c                 | 10 ++++++----
 arch/xtensa/mm/mmu.c                 |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index 77ff64a..f582dc8 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -123,7 +123,7 @@ static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 	pud_k = pud_offset(pgd_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
-	pte_k = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 	pmd_populate_kernel(&init_mm, pmd_k, pte_k);
 	return pte_k;
 }
diff --git a/arch/m68k/atari/stram.c b/arch/m68k/atari/stram.c
index c83d664..1089d67 100644
--- a/arch/m68k/atari/stram.c
+++ b/arch/m68k/atari/stram.c
@@ -95,7 +95,8 @@ void __init atari_stram_reserve_pages(void *start_mem)
 {
 	if (kernel_in_stram) {
 		pr_debug("atari_stram pool: kernel in ST-RAM, using alloc_bootmem!\n");
-		stram_pool.start = (resource_size_t)alloc_bootmem_low_pages(pool_size);
+		stram_pool.start = (resource_size_t)memblock_alloc_low(pool_size,
+								       PAGE_SIZE);
 		stram_pool.end = stram_pool.start + pool_size - 1;
 		request_resource(&iomem_resource, &stram_pool);
 		stram_virt_offset = 0;
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 4e17ecb..8bcf57e 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -55,7 +55,7 @@ static pte_t * __init kernel_page_table(void)
 {
 	pte_t *ptablep;
 
-	ptablep = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+	ptablep = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 
 	clear_page(ptablep);
 	__flush_page_to_ram(ptablep);
@@ -95,7 +95,8 @@ static pmd_t * __init kernel_ptr_table(void)
 
 	last_pgtable += PTRS_PER_PMD;
 	if (((unsigned long)last_pgtable & ~PAGE_MASK) == 0) {
-		last_pgtable = (pmd_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+		last_pgtable = (pmd_t *)memblock_alloc_low(PAGE_SIZE,
+							   PAGE_SIZE);
 
 		clear_page(last_pgtable);
 		__flush_page_to_ram(last_pgtable);
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 236833b..c44c1a6 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -244,7 +244,7 @@ void __init plat_swiotlb_setup(void)
 	swiotlb_nslabs = ALIGN(swiotlb_nslabs, IO_TLB_SEGSIZE);
 	swiotlbsize = swiotlb_nslabs << IO_TLB_SHIFT;
 
-	octeon_swiotlb = alloc_bootmem_low_pages(swiotlbsize);
+	octeon_swiotlb = memblock_alloc_low(swiotlbsize, PAGE_SIZE);
 
 	if (swiotlb_init_with_tbl(octeon_swiotlb, swiotlb_nslabs, 1) == -ENOMEM)
 		panic("Cannot allocate SWIOTLB buffer");
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 400676c..a010fba7 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -244,7 +244,8 @@ void __init fixrange_init(unsigned long start, unsigned long end,
 			pmd = (pmd_t *)pud;
 			for (; (k < PTRS_PER_PMD) && (vaddr < end); pmd++, k++) {
 				if (pmd_none(*pmd)) {
-					pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+					pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
+									   PAGE_SIZE);
 					set_pmd(pmd, __pmd((unsigned long)pte));
 					BUG_ON(pte != pte_offset_kernel(pmd, 0));
 				}
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 3c0e470..185f6bb 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init mem_init(void)
 static void __init one_page_table_init(pmd_t *pmd)
 {
 	if (pmd_none(*pmd)) {
-		pte_t *pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		pte_t *pte = (pte_t *) memblock_alloc_low(PAGE_SIZE,
+							  PAGE_SIZE);
 		set_pmd(pmd, __pmd(_KERNPG_TABLE +
 					   (unsigned long) __pa(pte)));
 		if (pte != pte_offset_kernel(pmd, 0))
@@ -75,7 +76,7 @@ static void __init one_page_table_init(pmd_t *pmd)
 static void __init one_md_table_init(pud_t *pud)
 {
 #ifdef CONFIG_3_LEVEL_PGTABLES
-	pmd_t *pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	pmd_t *pmd_table = (pmd_t *) memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
 	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
 	if (pmd_table != pmd_offset(pud, 0))
 		BUG();
@@ -124,7 +125,7 @@ static void __init fixaddr_user_init( void)
 		return;
 
 	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
-	v = (unsigned long) alloc_bootmem_low_pages(size);
+	v = (unsigned long) memblock_alloc_low(size, PAGE_SIZE);
 	memcpy((void *) v , (void *) FIXADDR_USER_START, size);
 	p = __pa(v);
 	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
@@ -143,7 +144,8 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES], vaddr;
 	int i;
 
-	empty_zero_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
+	empty_zero_page = (unsigned long *) memblock_alloc_low(PAGE_SIZE,
+							       PAGE_SIZE);
 	for (i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
diff --git a/arch/xtensa/mm/mmu.c b/arch/xtensa/mm/mmu.c
index 9d1ecfc..f33a1ff 100644
--- a/arch/xtensa/mm/mmu.c
+++ b/arch/xtensa/mm/mmu.c
@@ -31,7 +31,7 @@ static void * __init init_pmd(unsigned long vaddr, unsigned long n_pages)
 	pr_debug("%s: vaddr: 0x%08lx, n_pages: %ld\n",
 		 __func__, vaddr, n_pages);
 
-	pte = alloc_bootmem_low_pages(n_pages * sizeof(pte_t));
+	pte = memblock_alloc_low(n_pages * sizeof(pte_t), PAGE_SIZE);
 
 	for (i = 0; i < n_pages; ++i)
 		pte_clear(NULL, 0, pte + i);
-- 
2.7.4
