From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] Hexagon: Remove useless select of NO_IOPORT_MAP
Date: Wed, 24 Sep 2014 21:21:51 +0200
Message-ID: <1411586511.19525.38.camel@x220>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Hexagon's primary Kconfig entry has a select for NO_IOPORT_MAP. But
because hexagon never defines a Kconfig symbol NO_IOPORT_MAP this select
is a nop. It can be removed.

Perhaps hexagon should add its own Kconfig entry for NO_IOPORT_MAP and
have it default to 'y'. But since no one apparently had any problems
with HAS_IOPORT_MAP defaulting to 'y' on hexagon, as it currently does,
that is unlikely.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested by playing with arch/hexagon/configs/comet_defconfig. After "make
oldconfig" the .config contains CONFIG_HAS_IOPORT_MAP=y both before and
after this patch, as is expected.

Actually, the only difference I found in the .config file was that after
this patch the .config file contained
    CONFIG_HEXAGON=y

I have no idea why. Did I botch my test?

 arch/hexagon/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 4dc89d1f9c48..f1817eae107a 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -19,7 +19,6 @@ config HEXAGON
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
-	select NO_IOPORT_MAP
 	select GENERIC_IOMAP
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
-- 
1.9.3
