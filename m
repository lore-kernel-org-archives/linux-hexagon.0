From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/7] of: ignore sub-page memory regions
Date: Fri,  3 Aug 2018 22:58:45 +0300
Message-ID: <1533326330-31677-3-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-um@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>

Memory region size is rounded down to page boundary and with sub-page
region it becomes 0 and there is no point to add an empty region.
Moreover, when the base is less than PAGE_SIZE we get a bogus size as
(base + size - 1) evaluates to -1.

The commit 8cccffc52694 ("of: check for size < 0 after rounding in
early_init_dt_add_memory_arch") introduced a test for wrap around for the
case when base is not page aligned, the same test can be used to ignore
sub-page region sizes.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6da20b9..e866745 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1134,12 +1134,13 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = MIN_MEMBLOCK_ADDR;
 
+	if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
+		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+			base, base + size);
+		return;
+	}
+
 	if (!PAGE_ALIGNED(base)) {
-		if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
-			pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
-				base, base + size);
-			return;
-		}
 		size -= PAGE_SIZE - (base & ~PAGE_MASK);
 		base = PAGE_ALIGN(base);
 	}
-- 
2.7.4

