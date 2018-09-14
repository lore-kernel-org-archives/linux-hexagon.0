From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 13/30] memblock: replace __alloc_bootmem_nopanic with
 memblock_alloc_from_nopanic
Date: Fri, 14 Sep 2018 15:10:28 +0300
Message-ID: <1536927045-23536-14-git-send-email-rppt@linux.vnet.ibm.com>
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
	bh=eqvRyy5mAnic+7rcIOAV6u5jyli2qgr2Qbr4agkG/hs=; b=KnLHYmBmeboVaQ33Xf45IL0SYn
	wJ/IwRg79EIE9YtjgySLxDaliU0Yozz5fXqu0sOfCNbC0nf/VSb+ShaBRC0W8i3GFTKJo059D9ABC
	vfIH2X/8dpDpo4EKVYu45TS6hIpSPvZSjhbxOn31c4xBYHNMo7VS9zRccnJ7mMevJAmdWRfBzdqKd
	p8SdnkAkSnMNhaZ9Owyq9xqS9i+S580s5FBWwgxF5zKMDzJ+kuR/3rKkNkajiBQ5MESRmM/vDFjD1
	G293aZP2rClNCfBV90NP4uFFyHxcqDMEwxPm6B26h2uQrLcNM+zMyrV9/8/UskvI+Uc7BYvEfJc/Y
	EwBu798g==;
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

When __alloc_bootmem_nopanic() is used with explicit lower limit for the
allocation it attempts to allocate memory at or above that limit and falls
back to allocation with no limit set.

The memblock_alloc_from_nopanic() does exactly the same thing and can be
used as a replacement for __alloc_bootmem_nopanic() is such cases.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/arc/kernel/unwind.c       | 4 ++--
 arch/x86/kernel/setup_percpu.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 183391d..2a01dd1 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -181,8 +181,8 @@ static void init_unwind_hdr(struct unwind_table *table,
  */
 static void *__init unw_hdr_alloc_early(unsigned long sz)
 {
-	return __alloc_bootmem_nopanic(sz, sizeof(unsigned int),
-				       MAX_DMA_ADDRESS);
+	return memblock_alloc_from_nopanic(sz, sizeof(unsigned int),
+					   MAX_DMA_ADDRESS);
 }
 
 static void *unw_hdr_alloc(unsigned long sz)
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 67d48e26..041663a 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,7 +106,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 	void *ptr;
 
 	if (!node_online(node) || !NODE_DATA(node)) {
-		ptr = __alloc_bootmem_nopanic(size, align, goal);
+		ptr = memblock_alloc_from_nopanic(size, align, goal);
 		pr_info("cpu %d has no node %d or node-local memory\n",
 			cpu, node);
 		pr_debug("per cpu data for cpu%d %lu bytes at %016lx\n",
@@ -121,7 +121,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, unsigned long size,
 	}
 	return ptr;
 #else
-	return __alloc_bootmem_nopanic(size, align, goal);
+	return memblock_alloc_from_nopanic(size, align, goal);
 #endif
 }
 
-- 
2.7.4
