From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] Hexagon: remove check for CONFIG_COMET_EARLY_UART_DEBUG
Date: Sat, 17 May 2014 13:53:06 +0200
Message-ID: <1400327586.13824.10.camel@x220>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

There's been a check for CONFIG_COMET_EARLY_UART_DEBUG ever since
Hexagon was added in v3.2. But the related Kconfig symbol has never been
added to the tree. Remove this check.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Not tested.

 arch/hexagon/kernel/vm_init_segtable.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/hexagon/kernel/vm_init_segtable.S b/arch/hexagon/kernel/vm_init_segtable.S
index 80967f2192b3..167b48458620 100644
--- a/arch/hexagon/kernel/vm_init_segtable.S
+++ b/arch/hexagon/kernel/vm_init_segtable.S
@@ -85,12 +85,7 @@ swapper_pg_dir:
 	.word X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
 	.word X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X,X
 /*0xa8*/.word X,X,X,X
-#ifdef CONFIG_COMET_EARLY_UART_DEBUG
-UART_PTE_ENTRY:
-/*0xa9*/.word BKPG_IO(0xa9000000),BKPG_IO(0xa9000000),BKPG_IO(0xa9000000),BKPG_IO(0xa9000000)
-#else
 /*0xa9*/.word X,X,X,X
-#endif
 /*0xaa*/.word X,X,X,X
 /*0xab*/.word X,X,X,X
 /*0xac*/.word X,X,X,X
-- 
1.9.0
