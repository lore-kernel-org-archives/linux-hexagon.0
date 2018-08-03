From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/7] nios2: use generic early_init_dt_add_memory_arch
Date: Fri,  3 Aug 2018 22:58:46 +0300
Message-ID: <1533326330-31677-4-git-send-email-rppt@linux.vnet.ibm.com>
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

All we have to do is to enable memblock, the generic FDT code will take
care of the rest.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Ley Foon Tan <ley.foon.tan@intel.com>
---
 arch/nios2/Kconfig        |  1 +
 arch/nios2/kernel/prom.c  | 10 ----------
 arch/nios2/kernel/setup.c |  2 ++
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88..5db8fa1 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,6 +19,7 @@ config NIOS2
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
+	select HAVE_MEMBLOCK
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 8d7446a..ba96a49 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -32,16 +32,6 @@
 
 #include <asm/sections.h>
 
-void __init early_init_dt_add_memory_arch(u64 base, u64 size)
-{
-	u64 kernel_start = (u64)virt_to_phys(_text);
-
-	if (!memory_size &&
-	    (kernel_start >= base) && (kernel_start < (base + size)))
-		memory_size = size;
-
-}
-
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
 					     bool nomap)
 {
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 926a02b..0946840 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/console.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <linux/initrd.h>
 #include <linux/of_fdt.h>
 #include <linux/screen_info.h>
@@ -147,6 +148,7 @@ void __init setup_arch(char **cmdline_p)
 
 	console_verbose();
 
+	memory_size = memblock_phys_mem_size();
 	memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
 	memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE + memory_size;
 
-- 
2.7.4

