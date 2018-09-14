From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 05/30] mm: nobootmem: remove dead code
Date: Fri, 14 Sep 2018 15:10:20 +0300
Message-ID: <1536927045-23536-6-git-send-email-rppt@linux.vnet.ibm.com>
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Russell King <linux@armlinux.org.uk>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jonathan Corbet <corbet@lwn.net>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-alpha@vger.kernel.org, linux-um@lists.infradead.o

Several bootmem functions and macros are not used. Remove them.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/bootmem.h | 26 --------------------------
 mm/nobootmem.c          | 35 -----------------------------------
 2 files changed, 61 deletions(-)

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index fce6278..b74bafd1 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -36,17 +36,6 @@ extern void free_bootmem_node(pg_data_t *pgdat,
 extern void free_bootmem(unsigned long physaddr, unsigned long size);
 extern void free_bootmem_late(unsigned long physaddr, unsigned long size);
 
-/*
- * Flags for reserve_bootmem (also if CONFIG_HAVE_ARCH_BOOTMEM_NODE,
- * the architecture-specific code should honor this).
- *
- * If flags is BOOTMEM_DEFAULT, then the return value is always 0 (success).
- * If flags contains BOOTMEM_EXCLUSIVE, then -EBUSY is returned if the memory
- * already was reserved.
- */
-#define BOOTMEM_DEFAULT		0
-#define BOOTMEM_EXCLUSIVE	(1<<0)
-
 extern void *__alloc_bootmem(unsigned long size,
 			     unsigned long align,
 			     unsigned long goal);
@@ -73,13 +62,6 @@ void *___alloc_bootmem_node_nopanic(pg_data_t *pgdat,
 extern void *__alloc_bootmem_low(unsigned long size,
 				 unsigned long align,
 				 unsigned long goal) __malloc;
-void *__alloc_bootmem_low_nopanic(unsigned long size,
-				 unsigned long align,
-				 unsigned long goal) __malloc;
-extern void *__alloc_bootmem_low_node(pg_data_t *pgdat,
-				      unsigned long size,
-				      unsigned long align,
-				      unsigned long goal) __malloc;
 
 /* We are using top down, so it is safe to use 0 here */
 #define BOOTMEM_LOW_LIMIT 0
@@ -92,8 +74,6 @@ extern void *__alloc_bootmem_low_node(pg_data_t *pgdat,
 	__alloc_bootmem(x, SMP_CACHE_BYTES, BOOTMEM_LOW_LIMIT)
 #define alloc_bootmem_align(x, align) \
 	__alloc_bootmem(x, align, BOOTMEM_LOW_LIMIT)
-#define alloc_bootmem_nopanic(x) \
-	__alloc_bootmem_nopanic(x, SMP_CACHE_BYTES, BOOTMEM_LOW_LIMIT)
 #define alloc_bootmem_pages(x) \
 	__alloc_bootmem(x, PAGE_SIZE, BOOTMEM_LOW_LIMIT)
 #define alloc_bootmem_pages_nopanic(x) \
@@ -104,17 +84,11 @@ extern void *__alloc_bootmem_low_node(pg_data_t *pgdat,
 	__alloc_bootmem_node_nopanic(pgdat, x, SMP_CACHE_BYTES, BOOTMEM_LOW_LIMIT)
 #define alloc_bootmem_pages_node(pgdat, x) \
 	__alloc_bootmem_node(pgdat, x, PAGE_SIZE, BOOTMEM_LOW_LIMIT)
-#define alloc_bootmem_pages_node_nopanic(pgdat, x) \
-	__alloc_bootmem_node_nopanic(pgdat, x, PAGE_SIZE, BOOTMEM_LOW_LIMIT)
 
 #define alloc_bootmem_low(x) \
 	__alloc_bootmem_low(x, SMP_CACHE_BYTES, 0)
-#define alloc_bootmem_low_pages_nopanic(x) \
-	__alloc_bootmem_low_nopanic(x, PAGE_SIZE, 0)
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem_low(x, PAGE_SIZE, 0)
-#define alloc_bootmem_low_pages_node(pgdat, x) \
-	__alloc_bootmem_low_node(pgdat, x, PAGE_SIZE, 0)
 
 /* FIXME: use MEMBLOCK_ALLOC_* variants here */
 #define BOOTMEM_ALLOC_ACCESSIBLE	0
diff --git a/mm/nobootmem.c b/mm/nobootmem.c
index d4d0cd4..44ce7de 100644
--- a/mm/nobootmem.c
+++ b/mm/nobootmem.c
@@ -404,38 +404,3 @@ void * __init __alloc_bootmem_low(unsigned long size, unsigned long align,
 {
 	return ___alloc_bootmem(size, align, goal, ARCH_LOW_ADDRESS_LIMIT);
 }
-
-void * __init __alloc_bootmem_low_nopanic(unsigned long size,
-					  unsigned long align,
-					  unsigned long goal)
-{
-	return ___alloc_bootmem_nopanic(size, align, goal,
-					ARCH_LOW_ADDRESS_LIMIT);
-}
-
-/**
- * __alloc_bootmem_low_node - allocate low boot memory from a specific node
- * @pgdat: node to allocate from
- * @size: size of the request in bytes
- * @align: alignment of the region
- * @goal: preferred starting address of the region
- *
- * The goal is dropped if it can not be satisfied and the allocation will
- * fall back to memory below @goal.
- *
- * Allocation may fall back to any node in the system if the specified node
- * can not hold the requested memory.
- *
- * The function panics if the request can not be satisfied.
- *
- * Return: address of the allocated region.
- */
-void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
-				       unsigned long align, unsigned long goal)
-{
-	if (WARN_ON_ONCE(slab_is_available()))
-		return kzalloc_node(size, GFP_NOWAIT, pgdat->node_id);
-
-	return ___alloc_bootmem_node(pgdat, size, align, goal,
-				     ARCH_LOW_ADDRESS_LIMIT);
-}
-- 
2.7.4

