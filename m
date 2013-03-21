From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] Hexagon: remove two Kconfig entries
Date: Thu, 21 Mar 2013 11:13:17 +0100
Message-ID: <1363860797.1390.108.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

The Kconfig entries for HEXAGON_VM and HEXAGON_ANGEL_TRAPS were added,
together with the configuration and makefiles for the Hexagon
architecture, in v3.2. They have never been used. They can safely be
removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/hexagon/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index e4decc6..48130eb 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -109,9 +109,6 @@ config HEXAGON_COMET
 
 endchoice
 
-config HEXAGON_VM
-	def_bool y
-
 config CMDLINE
 	string "Default kernel command string"
 	default ""
@@ -122,12 +119,6 @@ config CMDLINE
 	  minimum, you should specify the memory size and the root device
 	  (e.g., mem=64M root=/dev/nfs).
 
-config HEXAGON_ANGEL_TRAPS
-	bool "Use Angel Traps"
-	default n
-	---help---
-	  Enable angel debug traps (for printk's).
-
 config SMP
 	bool "Multi-Processing support"
 	---help---
-- 
1.7.11.7
