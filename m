From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 17/30] memblock: replace alloc_bootmem_node with
 memblock_alloc_node
Date: Fri, 14 Sep 2018 15:10:32 +0300
Message-ID: <1536927045-23536-18-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:
	References:In-Reply-To:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=RRLI2MBkAMKI3pfbAN94s0BLqU4NMwcCadfTJJemkPg=; b=FMs8rCnXBnDRxCphHiaIV6qezG
	cH4HgB6bB/6v71cQCnXVjPcDvuy6JlwtNo899eWHSMZ0v6jbgYmmXL9WHIgooAz1qumTo/7AQY/nK
	hquYnRpibkK2thBsRohq/ZjCcFKMi4KMVXb9iQyBJp1/73Dy8Fcw+Rsm9BQbh65TpZNOucbfyRxo7
	bcUQuGxJDDwYfmS5G08/XyMGdKCu/Gfy0A76Kpqh1xCR2jNPqaoyobJsOvi4kdeT8Vt0/xkOCEhlV
	VmUQPXN/9Ml8qe4sJQxebI8Np61XMFHkSeV/Fg6/i1LXiTUUXrWCi7tI6xawWhf6oryd71Ia6Zy3j
	t/xiPFHw==;
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vge

Both functions attempt to allocate memory with specified alignment from a
particular node. If the allocation from that node fails, they both fall
back to allocating from any node in the system.

Usage of native memblock API eliminates the nobootmem translation layer.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/alpha/kernel/pci_iommu.c   | 4 ++--
 arch/ia64/sn/kernel/io_common.c | 7 ++-----
 arch/ia64/sn/kernel/setup.c     | 4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index 6923b0d..b52d76f 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -74,7 +74,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 
 #ifdef CONFIG_DISCONTIGMEM
 
-	arena = alloc_bootmem_node(NODE_DATA(nid), sizeof(*arena));
+	arena = memblock_alloc_node(sizeof(*arena), align, nid);
 	if (!NODE_DATA(nid) || !arena) {
 		printk("%s: couldn't allocate arena from node %d\n"
 		       "    falling back to system-wide allocation\n",
@@ -82,7 +82,7 @@ iommu_arena_new_node(int nid, struct pci_controller *hose, dma_addr_t base,
 		arena = alloc_bootmem(sizeof(*arena));
 	}
 
-	arena->ptes = __alloc_bootmem_node(NODE_DATA(nid), mem_size, align, 0);
+	arena->ptes = memblock_alloc_node(sizeof(*arena), align, nid);
 	if (!NODE_DATA(nid) || !arena->ptes) {
 		printk("%s: couldn't allocate arena ptes from node %d\n"
 		       "    falling back to system-wide allocation\n",
diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 102aaba..8b05d55 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -385,16 +385,13 @@ void __init hubdev_init_node(nodepda_t * npda, cnodeid_t node)
 {
 	struct hubdev_info *hubdev_info;
 	int size;
-	pg_data_t *pg;
 
 	size = sizeof(struct hubdev_info);
 
 	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
-		pg = NODE_DATA(0);
-	else
-		pg = NODE_DATA(node);
+		node = 0;
 
-	hubdev_info = (struct hubdev_info *)alloc_bootmem_node(pg, size);
+	hubdev_info = (struct hubdev_info *)memblock_alloc_node(size, 0, node);
 
 	npda->pdinfo = (void *)hubdev_info;
 }
diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 5f6b6b4..ab2564f 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -511,7 +511,7 @@ static void __init sn_init_pdas(char **cmdline_p)
 	 */
 	for_each_online_node(cnode) {
 		nodepdaindr[cnode] =
-		    alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
+		    memblock_alloc_node(sizeof(nodepda_t), 0, cnode);
 		memset(nodepdaindr[cnode]->phys_cpuid, -1,
 		    sizeof(nodepdaindr[cnode]->phys_cpuid));
 		spin_lock_init(&nodepdaindr[cnode]->ptc_lock);
@@ -522,7 +522,7 @@ static void __init sn_init_pdas(char **cmdline_p)
 	 */
 	for (cnode = num_online_nodes(); cnode < num_cnodes; cnode++)
 		nodepdaindr[cnode] =
-		    alloc_bootmem_node(NODE_DATA(0), sizeof(nodepda_t));
+		    memblock_alloc_node(sizeof(nodepda_t), 0, 0);
 
 	/*
 	 * Now copy the array of nodepda pointers to each nodepda.
-- 
2.7.4
