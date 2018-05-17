From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [RFC] hexagon: Drop the unused variable zero_page_mask
Date: Thu, 17 May 2018 11:41:05 +0530
Message-ID: <20180517061105.30447-1-khandual@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rkuo@codeaurora.org, linux@roeck-us.net, vdavydov.dev@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

Hexagon arch does not seem to have subscribed to _HAVE_COLOR_ZERO_PAGE
framework. Hence zero_page_mask variable is not needed.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
I will have to request some one with hexagon system to compile and
test this patch. Dont have access to hardware.

 arch/hexagon/include/asm/pgtable.h | 1 -
 arch/hexagon/mm/init.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index aef02f7ca8aa..65125d0b02dd 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -30,7 +30,6 @@
 
 /* A handy thing to have if one has the RAM. Declared in head.S */
 extern unsigned long empty_zero_page;
-extern unsigned long zero_page_mask;
 
 /*
  * The PTE model described here is that of the Hexagon Virtual Machine,
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 192584d5ac2f..1495d45e472d 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -39,9 +39,6 @@ unsigned long __phys_offset;	/*  physical kernel offset >> 12  */
 /*  Set as variable to limit PMD copies  */
 int max_kernel_seg = 0x303;
 
-/*  think this should be (page_size-1) the way it's used...*/
-unsigned long zero_page_mask;
-
 /*  indicate pfn's of high memory  */
 unsigned long highstart_pfn, highend_pfn;
 
-- 
2.11.0

