From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 12/20] sparc32: simplify detection of memory zone boundaries
Date: Wed, 29 Apr 2020 15:11:18 +0300
Message-ID: <20200429121126.17989-13-rppt@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vj0ShFbbdgBQxMvpTGxtvjeZnmEzPsrZP+YoYYyxxQY=; b=CRUxsHo0C6yjsS
	Df3rNA2TVbmEcIxDNlzicthmY7BkLNP2yWVSOIIYR7Eri7QoSQSODFo/+M6pn8G/h4fHEFkhJAk47
	VjC38VEd/66ydQR0YxXv5QbyitQkxyd2SekP9GlbwDFnpAMX5R9ljxZbwF/lgIOLAk+yZypFeQS+c
	6F3WKiNOk1S8NQyly6bGl1wKxFk/kZJCl4ukqtkZJgJfEqPq6dJA2fVRtFZ7dFs2Fd52LyHo8D3L1
	q001Gve1LsH8Tno3Ozm9kGYWp5OLfdAOzf68OvVKa+fLdZBu4RQUHRPP9t3N1PLYU5kJMrl0gQpcJ
	4dvBpG8YOCbIAUH/GE5g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588162493;
 bh=PwNAuHT9V5jl2M06GaRQbE+89xoAz3U9lTg8JaLvxZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YUh6MeP5N0j5F003uwP7Tb9XTSPLg1HiJZXgQKYH3aNOV1FgykIkvJX3NbJ/Qjv6x
 h5l1i+Lb2NA/Dz0Sd9NWYHhDPGIF6bIB3xpSE8x8qN/eX6xSrR27VlY2tefXFAHwKj
 RCuvhTEN1u2sy0E32qtQojsNXbmNPrAEDWik6Qwg=
In-Reply-To: <20200429121126.17989-1-rppt@kernel.org>
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
 arch/sparc/mm/srmmu.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index b7c94de70cca..cc071dd7d8da 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -1008,24 +1008,13 @@ void __init srmmu_paging_init(void)
 	kmap_init();
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES];
-		unsigned long zholes_size[MAX_NR_ZONES];
-		unsigned long npages;
-		int znum;
+		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-		for (znum = 0; znum < MAX_NR_ZONES; znum++)
-			zones_size[znum] = zholes_size[znum] = 0;
+		max_zone_pfn[ZONE_DMA] = max_low_pfn;
+		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
+		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
 
-		npages = max_low_pfn - pfn_base;
-
-		zones_size[ZONE_DMA] = npages;
-		zholes_size[ZONE_DMA] = npages - pages_avail;
-
-		npages = highend_pfn - max_low_pfn;
-		zones_size[ZONE_HIGHMEM] = npages;
-		zholes_size[ZONE_HIGHMEM] = npages - calc_highpages();
-
-		free_area_init_node(0, zones_size, pfn_base, zholes_size);
+		free_area_init(max_zone_pfn);
 	}
 }
 
-- 
2.26.1


