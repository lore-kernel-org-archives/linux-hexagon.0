From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 04/21] microblaze: dma-mapping: skip extra DMA flushes
Date: Mon, 27 Mar 2023 14:13:00 +0200
Message-ID: <20230327121317.4081816-5-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679919272;
        bh=ZhYG8JNUwjljPv9OKiF3eMGP7VJHxmj1d7o6guSf4No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBdwMSfV6WhGkWO4GD6yfcHOXcUpefrDC/+txqBn1K1TXjh6vtxTQLHjgNJ0FEkt0
         8kEYArEe0oN6TTz55A/ouqhYMm5G10akCJmXzW/muCfT8GBSGN5Uni+3VEARUH4Auc
         H3B65ricYeSXsGj53UrQTCcr95NZtYK/45G5qbsvcFbKhYxNglRYB3Jv/RHrFzHtks
         DVdr6HivllSdF2l5dgd1hATA9JZvKqwXHc1koDjA6e60zts4nydXjlN/RqoC6otSSa
         Tq0Qb2MNzDbHG7RwE+Edr/TKARawLeFdDNo+IyVrlawBJzvWe5xP0tuqDo6AiiQKTk
         Trtj2/d6VSosQ==
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

From: Arnd Bergmann <arnd@arndb.de>

The microblaze dma_sync_* implementation uses the same function
for both _for_cpu() and _for_device(), which is inconsistent
with other architectures and slightly more expensive.

Split it up into separate functions and skip the parts that
are not needed:

 - on dma_sync_*_for_cpu(..., DMA_TO_DEVICE), skip the second
   writeback, which does nothing.

 - on dma_sync_*_for_cpu(..., DMA_BIDIRECTIONAL), only invalidate
   the cache to clear out cache lines that got loaded speculatively,
   but skip the extraneous writeback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/kernel/dma.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 04d091ade417..b4c4e45fd45e 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -14,8 +14,8 @@
 #include <linux/bug.h>
 #include <asm/cacheflush.h>
 
-static void __dma_sync(phys_addr_t paddr, size_t size,
-		enum dma_data_direction direction)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	switch (direction) {
 	case DMA_TO_DEVICE:
@@ -30,14 +30,16 @@ static void __dma_sync(phys_addr_t paddr, size_t size,
 	}
 }
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-		enum dma_data_direction dir)
-{
-	__dma_sync(paddr, size, dir);
-}
-
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir)
 {
-	__dma_sync(paddr, size, dir);
-}
+	switch (direction) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_BIDIRECTIONAL:
+	case DMA_FROM_DEVICE:
+		invalidate_dcache_range(paddr, paddr + size);
+		break;
+	default:
+		BUG();
+	}}
-- 
2.39.2

