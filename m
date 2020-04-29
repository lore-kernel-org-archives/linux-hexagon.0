From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn in
 descending order
Date: Wed, 29 Apr 2020 15:11:23 +0300
Message-ID: <20200429121126.17989-18-rppt@kernel.org>
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
	List-Owner; bh=5+wFOSrdaHN8q2i+S6o2jX6WZfzbh1K6wbW1AEkxmyY=; b=IB+2xOW2+XyyeQ
	Is1tykQhHz/YN1dmTi+pDPnaA9/BwVmSYADaoLv3jzwuLL/j/QFsxtzA5f7YMwQxnnx1ZPU6p1Jwu
	FZBkc3fzNJNvkdQz4Sm2IcsendDAbe01gcVPL2qCq/J7jgJqIF8uezsaRwepqAUANXnD4uN2i96xz
	/uacBpnM0n8Ars1o3cpEq7eJJc1jQ6oGu2IuId5CvGd1zEQn0mIbZEYImnoA1fwBBn2mXiSm4XL6n
	g73EKEjFuijxhmicDxPiqfeqqc/HTRjj9nlZMaVz9d6G867rBHCvgaAz6sI3C1GQ3QjKz1VNVwTL/
	At0b7/AQtWXPI3/JrKKA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588162563;
 bh=ctUIy/YXeb4o7EetKtzPouPDDIiPmPpivi+QjUKxJWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t6mTPm7tDf6A7Fs1DPVRRbHW9NSUsNbUTBbTB5Mt5W0CY60/S3DgGMfp7O1x4H3dF
 UQWqU+tdAZsr0ftTrK6xUyuXzR3WiWfBGDM0zN31grCnE9SDwBEA4eeBZHjjz7WsYP
 EgqQnBLprJoYDC61AEWwct3Qxl5ChjhVms6vDhQM=
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

Some architectures (e.g. ARC) have the ZONE_HIGHMEM zone below the
ZONE_NORMAL. Allowing free_area_init() parse max_zone_pfn array even it is
sorted in descending order allows using free_area_init() on such
architectures.

Add top -> down traversal of max_zone_pfn array in free_area_init() and use
the latter in ARC node/zone initialization.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/mm/init.c | 36 +++++++-----------------------------
 mm/page_alloc.c    | 24 +++++++++++++++++++-----
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 0920c969c466..41eb9be1653c 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -63,11 +63,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 
 		low_mem_sz = size;
 		in_use = 1;
+		memblock_add_node(base, size, 0);
 	} else {
 #ifdef CONFIG_HIGHMEM
 		high_mem_start = base;
 		high_mem_sz = size;
 		in_use = 1;
+		memblock_add_node(base, size, 1);
 #endif
 	}
 
@@ -83,8 +85,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
  */
 void __init setup_arch_memory(void)
 {
-	unsigned long zones_size[MAX_NR_ZONES];
-	unsigned long zones_holes[MAX_NR_ZONES];
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
 	init_mm.start_code = (unsigned long)_text;
 	init_mm.end_code = (unsigned long)_etext;
@@ -115,7 +116,6 @@ void __init setup_arch_memory(void)
 	 * the crash
 	 */
 
-	memblock_add_node(low_mem_start, low_mem_sz, 0);
 	memblock_reserve(CONFIG_LINUX_LINK_BASE,
 			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
 
@@ -133,22 +133,7 @@ void __init setup_arch_memory(void)
 	memblock_dump_all();
 
 	/*----------------- node/zones setup --------------------------*/
-	memset(zones_size, 0, sizeof(zones_size));
-	memset(zones_holes, 0, sizeof(zones_holes));
-
-	zones_size[ZONE_NORMAL] = max_low_pfn - min_low_pfn;
-	zones_holes[ZONE_NORMAL] = 0;
-
-	/*
-	 * We can't use the helper free_area_init(zones[]) because it uses
-	 * PAGE_OFFSET to compute the @min_low_pfn which would be wrong
-	 * when our kernel doesn't start at PAGE_OFFSET, i.e.
-	 * PAGE_OFFSET != CONFIG_LINUX_RAM_BASE
-	 */
-	free_area_init_node(0,			/* node-id */
-			    zones_size,		/* num pages per zone */
-			    min_low_pfn,	/* first pfn of node */
-			    zones_holes);	/* holes */
+	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
 
 #ifdef CONFIG_HIGHMEM
 	/*
@@ -168,20 +153,13 @@ void __init setup_arch_memory(void)
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
 
-	zones_size[ZONE_NORMAL] = 0;
-	zones_holes[ZONE_NORMAL] = 0;
-
-	zones_size[ZONE_HIGHMEM] = max_high_pfn - min_high_pfn;
-	zones_holes[ZONE_HIGHMEM] = 0;
-
-	free_area_init_node(1,			/* node-id */
-			    zones_size,		/* num pages per zone */
-			    min_high_pfn,	/* first pfn of node */
-			    zones_holes);	/* holes */
+	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 	kmap_init();
 #endif
+
+	free_area_init(max_zone_pfn);
 }
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d35ca0996a09..98a47f90065a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7408,7 +7408,8 @@ static void check_for_memory(pg_data_t *pgdat, int nid)
 void __init free_area_init(unsigned long *max_zone_pfn)
 {
 	unsigned long start_pfn, end_pfn;
-	int i, nid;
+	int i, nid, zone;
+	bool descending = false;
 
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
@@ -7418,13 +7419,26 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
 	start_pfn = find_min_pfn_with_active_regions();
 
+	/*
+	 * Some architecturs, e.g. ARC may have ZONE_HIGHMEM below
+	 * ZONE_NORMAL. For such cases we allow max_zone_pfn sorted in the
+	 * descending order
+	 */
+	if (MAX_NR_ZONES > 1 && max_zone_pfn[0] > max_zone_pfn[1])
+		descending = true;
+
 	for (i = 0; i < MAX_NR_ZONES; i++) {
-		if (i == ZONE_MOVABLE)
+		if (descending)
+			zone = MAX_NR_ZONES - i - 1;
+		else
+			zone = i;
+
+		if (zone == ZONE_MOVABLE)
 			continue;
 
-		end_pfn = max(max_zone_pfn[i], start_pfn);
-		arch_zone_lowest_possible_pfn[i] = start_pfn;
-		arch_zone_highest_possible_pfn[i] = end_pfn;
+		end_pfn = max(max_zone_pfn[zone], start_pfn);
+		arch_zone_lowest_possible_pfn[zone] = start_pfn;
+		arch_zone_highest_possible_pfn[zone] = end_pfn;
 
 		start_pfn = end_pfn;
 	}
-- 
2.26.1
