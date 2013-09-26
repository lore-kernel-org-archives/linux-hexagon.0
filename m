From: Rob Herring <robherring2@gmail.com>
Subject: [PATCH 07/21] hexagon: remove unnecessary prom.h includes
Date: Thu, 26 Sep 2013 13:50:42 -0500
Message-ID: <1380221456-11192-8-git-send-email-robherring2@gmail.com>
References: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8L44g9qWIDdZBX8dFmoQBAOHL8mYJdRYrH3XnXtwD/Q=;
        b=cx6QBfFQRuOrpuFNiVx1NDq647KxcEn11r0M8Dy5bcpbsGnL4LukWfdDIhuDb1/u/S
         NnxQ4jmh4J35M/dwNPfKo+0S6USPa/a/mA+evWKKaL/6dRTW4YaPBqcKBHT3yj/CWbdu
         2EwoCsexJqTfxjP4sPJvKPcUOpgV5A8YdGVq1lsyD8+Nj6avsSPM/uHmkEfbuDSA6gUP
         neG1Yrp/NtVb6hv5Y8zje3MNCXl2tPTFFct1k7QWAGWR+2FkIefGV/rKv54DoLFrmsUS
         hQj1SbJVjk+6SOYRkagcEJl4v7hyQwsbHZ1GMMQZRugtDtYRk1c1iftvrl74gKFnDWnr
         kR9w==
In-Reply-To: <1380221456-11192-1-git-send-email-robherring2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

From: Rob Herring <rob.herring@calxeda.com>

Hexagon does not have a prom.h header, so it is probably broken with
CONFIG_OF enabled. In any case, remove unnecessary prom.h include in
preparation to make prom.h optional.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 29d1f1b..0e7c1db 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -32,9 +32,6 @@
 #include <asm/hexagon_vm.h>
 #include <asm/vm_mmu.h>
 #include <asm/time.h>
-#ifdef CONFIG_OF
-#include <asm/prom.h>
-#endif
 
 char cmd_line[COMMAND_LINE_SIZE];
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
-- 
1.8.1.2
