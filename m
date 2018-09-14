From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 16/30] memblock: replace __alloc_bootmem_node with appropriate
 memblock_ API
Date: Fri, 14 Sep 2018 15:10:31 +0300
Message-ID: <1536927045-23536-17-git-send-email-rppt@linux.vnet.ibm.com>
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
	bh=iIjC91m+DVql/RY/U/XGwVehEVELwJrfuXLqdaemaDc=; b=P1nl+xJAXkRrs+HgEWeVi6hCfP
	sRiQUCH3xuGjyhQNsCUdpYSuxD+DX7FO7KUGed/G8Vmfd4n58MmGFHGphIIsHIZX6H2YW8YcTOdW6
	sg2KEqE9f7XTVHuUv6vcvSJ58r7PKUNa4WwDyRDaZTaWLDq6M0fFYb6pPTq8K2p+YyWsUohFl+ED8
	+RPzk5bCfav25xYojAkhNC5aWLywMzvGUN26AkqIqSwxUNqLMFytVy2EcaX0Sm6mo4innT+2B9SQg
	KxGSf+qokcbgpKAM+Wz5c6oREYPQr/iyeIFVOW2H7e3m7umxT2xH67rfTRPVDiZbgutixZfgieKDR
	FF0crnUQ==;
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

Use memblock_alloc_try_nid whenever goal (i.e. minimal address is
specified) and memblock_alloc_node otherwise.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/ia64/mm/discontig.c       |  6 ++++--
 arch/powerpc/kernel/setup_64.c |  6 ++++--
 arch/sparc/kernel/setup_64.c   | 10 ++++------
 arch/sparc/kernel/smp_64.c     |  4 ++--
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 1928d57..918dda9 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -451,8 +451,10 @@ static void __init *memory_less_node_alloc(int nid, unsigned long pernodesize)
 	if (bestnode == -1)
 		bestnode = anynode;
 
-	ptr = __alloc_bootmem_node(pgdat_list[bestnode], pernodesize,
-		PERCPU_PAGE_SIZE, __pa(MAX_DMA_ADDRESS));
+	ptr = memblock_alloc_try_nid(pernodesize, PERCPU_PAGE_SIZE,
+				     __pa(MAX_DMA_ADDRESS),
+				     BOOTMEM_ALLOC_ACCESSIBLE,
+				     bestnode);
 
 	return ptr;
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6a501b2..6add560 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -757,8 +757,10 @@ void __init emergency_stack_init(void)
 
 static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 {
-	return __alloc_bootmem_node(NODE_DATA(early_cpu_to_node(cpu)), size, align,
-				    __pa(MAX_DMA_ADDRESS));
+	return memblock_alloc_try_nid(size, align, __pa(MAX_DMA_ADDRESS),
+				      BOOTMEM_ALLOC_ACCESSIBLE,
+				      early_cpu_to_node(cpu));
+
 }
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 206bf81..5fb11ea 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -622,12 +622,10 @@ void __init alloc_irqstack_bootmem(void)
 	for_each_possible_cpu(i) {
 		node = cpu_to_node(i);
 
-		softirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
-							THREAD_SIZE,
-							THREAD_SIZE, 0);
-		hardirq_stack[i] = __alloc_bootmem_node(NODE_DATA(node),
-							THREAD_SIZE,
-							THREAD_SIZE, 0);
+		softirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
+						       THREAD_SIZE, node);
+		hardirq_stack[i] = memblock_alloc_node(THREAD_SIZE,
+						       THREAD_SIZE, node);
 	}
 }
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index d3ea1f3..83ff88d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1594,8 +1594,8 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
 			 cpu, size, __pa(ptr));
 	} else {
-		ptr = __alloc_bootmem_node(NODE_DATA(node),
-					   size, align, goal);
+		ptr = memblock_alloc_try_nid(size, align, goal,
+					     BOOTMEM_ALLOC_ACCESSIBLE, node);
 		pr_debug("per cpu data for cpu%d %lu bytes on node%d at "
 			 "%016lx\n", cpu, size, node, __pa(ptr));
 	}
-- 
2.7.4
