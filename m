From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 15/30] memblock: replace alloc_bootmem_pages_node with
 memblock_alloc_node
Date: Fri, 14 Sep 2018 15:10:30 +0300
Message-ID: <1536927045-23536-16-git-send-email-rppt@linux.vnet.ibm.com>
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
	bh=UrylhkueRUN5Qy6W93l7yVfFdDga6MfmPahCdUBcIb0=; b=iVSWRVZBDKdWXi2kawLxBM0Hbs
	mwzhRCquK1pphYXXQScB2mOyhV15ZN93UXiHPi9JCFJKzB/UTvRS0HYK0bxUpx6IIY+boGJgNx2MC
	h5R/O/VsdeRdwJUbNOhwB/7AfQvKQV15W896iequ0OHt/sFhcvoUTy3cwKgXXApuUy6DeId11JRC6
	WJ/Zb8uKqegib5XiXbZwSDViFiHl7c564KbFywHWcXLuX+wJk5Tqj1XCt9D+Ic9sdWxhZ4yDaytOX
	/3BHcOR8rvZnz4doTwtTDy8x3Wx1J7X8JyAawBkXO2g17s/t9KDqCJK8XELvLvrw+6YEqkrFK6i3h
	pOzUmXVQ==;
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

The functions are equivalent, just the later does not require nobootmem
translation layer.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 arch/ia64/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 3b85c3e..2169ca5 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -447,19 +447,19 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
 	for (address = start_page; address < end_page; address += PAGE_SIZE) {
 		pgd = pgd_offset_k(address);
 		if (pgd_none(*pgd))
-			pgd_populate(&init_mm, pgd, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
+			pgd_populate(&init_mm, pgd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
 		pud = pud_offset(pgd, address);
 
 		if (pud_none(*pud))
-			pud_populate(&init_mm, pud, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
+			pud_populate(&init_mm, pud, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
 		pmd = pmd_offset(pud, address);
 
 		if (pmd_none(*pmd))
-			pmd_populate_kernel(&init_mm, pmd, alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE));
+			pmd_populate_kernel(&init_mm, pmd, memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node));
 		pte = pte_offset_kernel(pmd, address);
 
 		if (pte_none(*pte))
-			set_pte(pte, pfn_pte(__pa(alloc_bootmem_pages_node(NODE_DATA(node), PAGE_SIZE)) >> PAGE_SHIFT,
+			set_pte(pte, pfn_pte(__pa(memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node)) >> PAGE_SHIFT,
 					     PAGE_KERNEL));
 	}
 	return 0;
-- 
2.7.4
