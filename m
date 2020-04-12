From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 10/21] m68k: mm: simplify detection of memory zone boundaries
Date: Sun, 12 Apr 2020 22:48:48 +0300
Message-ID: <20200412194859.12663-11-rppt@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UTq/YD/1bMC4KEsH1njZ2neIDhjv8FbdANrVq/k6SKI=; b=TwxR4I5rILz3R9
	oyLNqw5uyQmidU1lwlj32LZg4ZZ7LdrsT57A3gzhoQCLfQjMhPdJaULqbbjR/qrXpljrhhh8L34vg
	yk1MacyBtt/zv9VdfuMPbSzXvx6uEOJX7e79UsXXeRmZNtergH9vQ0e+nCjkg44wPcHQy6jVEZueV
	xRabfpQy5M9AMsT4/kVIWwvzlJCL3GVMT7c9douKYpfH53YshVbOF20V9r5UqTsrgjeIHK9w4k+9B
	eZ7Btw8sa56oOMMk+y4irQ+tjD7vFaRx6+xVdgh8U75Uh4K3nKODSlLbTXs8GObRqoiby02QE40up
	4gtcAwGvJlb/mpXF8EXA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586721108;
 bh=Ok7w8UnbHiLu4xbocwMzpfIo9IGcAlK4aLbtvivoSXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ptZzn70qaRDHuusIJQ2kDW2vKURV7ng1OZjSC8cxSZf5ErovTSNi7d+/WVAi1Pja2
 9Kam6N7RP258+GtMjN+nQBN9jYnUFSrZz0m7UZbW0YwZPo21AuMw5ljsFdZ6JfoMgj
 cJW86dlpE9XFsX7XBXUlQo6J1HaNWpDnYXUk2ugQ=
In-Reply-To: <20200412194859.12663-1-rppt@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>

From: Mike Rapoport <rppt@linux.ibm.com>

The free_area_init() function only requires the definition of maximal PFN
for each of the supported zone rater than calculation of actual zone sizes
and the sizes of the holes between the zones.

After removal of CONFIG_HAVE_MEMBLOCK_NODE_MAP the free_area_init() is
available to all architectures.

Using this function instead of free_area_init_node() simplifies the zone
detection.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/mm/motorola.c | 11 +++++------
 arch/m68k/mm/sun3mmu.c  | 10 +++-------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 84ab5963cabb..904c2a663977 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -365,7 +365,7 @@ static void __init map_node(int node)
  */
 void __init paging_init(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 	unsigned long min_addr, max_addr;
 	unsigned long addr;
 	int i;
@@ -448,11 +448,10 @@ void __init paging_init(void)
 #ifdef DEBUG
 	printk ("before free_area_init\n");
 #endif
-	for (i = 0; i < m68k_num_memory; i++) {
-		zones_size[ZONE_DMA] = m68k_memory[i].size >> PAGE_SHIFT;
-		free_area_init_node(i, zones_size,
-				    m68k_memory[i].addr >> PAGE_SHIFT, NULL);
+	for (i = 0; i < m68k_num_memory; i++)
 		if (node_present_pages(i))
 			node_set_state(i, N_NORMAL_MEMORY);
-	}
+
+	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
+	free_area_init(max_zone_pfn);
 }
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index eca1c46bb90a..5d8d956d9329 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -42,7 +42,7 @@ void __init paging_init(void)
 	unsigned long address;
 	unsigned long next_pgtable;
 	unsigned long bootmem_end;
-	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 	unsigned long size;
 
 	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
@@ -89,14 +89,10 @@ void __init paging_init(void)
 	current->mm = NULL;
 
 	/* memory sizing is a hack stolen from motorola.c..  hope it works for us */
-	zones_size[ZONE_DMA] = ((unsigned long)high_memory - PAGE_OFFSET) >> PAGE_SHIFT;
+	max_zone_pfn[ZONE_DMA] = ((unsigned long)high_memory) >> PAGE_SHIFT;
 
 	/* I really wish I knew why the following change made things better...  -- Sam */
-/*	free_area_init(zones_size); */
-	free_area_init_node(0, zones_size,
-			    (__pa(PAGE_OFFSET) >> PAGE_SHIFT) + 1, NULL);
+	free_area_init(max_zone_pfn);
 
 
 }
-
-
-- 
2.25.1


