From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] hexagon: drop selects of bogus Kconfig symbols
Date: Thu, 10 Nov 2011 21:07:47 +0100
Message-ID: <1320955667.27598.72.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

There are no Kconfig symbols named GENERIC_HARDIRQS_NO__DO_IRQ and
GENERIC_HARDIRQS_NO_DEPRECATED. The two select statements for these
symbols are nops. Drop these.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested by running "yes "" | make ARCH=hexagon config" before and after
applying this patch. Identical .config files were generated.
 
 arch/hexagon/Kconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 02513c2..f03740e 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -18,8 +18,6 @@ config HEXAGON
 	select GENERIC_ATOMIC64
 	select HAVE_PERF_EVENTS
 	select HAVE_GENERIC_HARDIRQS
-	select GENERIC_HARDIRQS_NO__DO_IRQ
-	select GENERIC_HARDIRQS_NO_DEPRECATED
 	# GENERIC_ALLOCATOR is used by dma_alloc_coherent()
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_SHOW
-- 
1.7.4.4


