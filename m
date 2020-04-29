From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 11/20] parisc: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:17 +0300
Message-ID: <20200429121126.17989-12-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fcMAC+DuOTbL04/VaTEMMfV2zWomMGM4BDerIeyacqI=; b=HNBa+zsHQiciBO
	huSBfb3Bc9XQt4DbpkCK4++9AkKDYHU6UlZGelq8XkNLbyb9G8F3xU58f5enIdRg9cA3ZdqbkXoHx
	P1wk+9wHBdkPSehlwxOk3elC4w+J2HFYNMRuEPG4qyAEn63BFcQDdKM5WsMbxwoBEdzYD0QuC+Cwg
	N1q4MD8UrsNu6itL290tyheimpPHyIeubULw01EUlVLMF2AalneaDxQNrKhXR+OkiHhwGedsbUmsu
	fnHDYgoT55S6RO2WXNsGHDl2IxnMSVjHRk8/ZWHhJ0TGJ9LtdGhg6WOs/4wLqOZ1x+UX7I0SIfmug
	AmvG7whv7xeFDpOpWCew==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588162479;
 bh=qgI7K92iBwIDZAkAJTDuYND4mLS1M8WKNioq+QvWTss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o/CQ8cvTdcUHi88smrvHJeF3wNwRqis+twFo/lxOi6JLDwvnV1MEivPLtYemrGA+I
 b7p0HPTuKGtMpp6lyp2Pv1yjiFSicakH4VDa5ZKj37DEty/Hv/u+97BFUBwB0P8+es
 BNLNjRKzuXHmcQKBsqrZ5ONTBmPAB7I6i6e/Z8GY=
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
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
 arch/parisc/mm/init.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 5224fb38d766..02d2fdb85dcc 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -675,27 +675,11 @@ static void __init gateway_init(void)
 
 static void __init parisc_bootmem_free(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
-	unsigned long holes_size[MAX_NR_ZONES] = { 0, };
-	unsigned long mem_start_pfn = ~0UL, mem_end_pfn = 0, mem_size_pfn = 0;
-	int i;
-
-	for (i = 0; i < npmem_ranges; i++) {
-		unsigned long start = pmem_ranges[i].start_pfn;
-		unsigned long size = pmem_ranges[i].pages;
-		unsigned long end = start + size;
-
-		if (mem_start_pfn > start)
-			mem_start_pfn = start;
-		if (mem_end_pfn < end)
-			mem_end_pfn = end;
-		mem_size_pfn += size;
-	}
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
 
-	zones_size[0] = mem_end_pfn - mem_start_pfn;
-	holes_size[0] = zones_size[0] - mem_size_pfn;
+	max_zone_pfn[0] = memblock_end_of_DRAM();
 
-	free_area_init_node(0, zones_size, mem_start_pfn, holes_size);
+	free_area_init(max_zone_pfn);
 }
 
 void __init paging_init(void)
-- 
2.26.1
