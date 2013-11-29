From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: kernel: reset.c: use function pointer instead
 of function for pm_power_off and export it
Date: Fri, 29 Nov 2013 12:01:37 +0800
Message-ID: <529811A1.3030708@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=6Tz50lh9Nx/0mATiFyBmMtVLnxFSPHQltF9omvInUm4=;
        b=dXha8MNrKM2gSZz7bsmDwsInKZCDMKry/OiuA+//O4H5VL+u6CYNy2Y8iKp5ro5z4l
         4a1/Zy31XWNT/qKfC6B+LloFWz+rcaJZN1lDwI49CG8QNdQyP+iheZ7yZIsspiG1+qt8
         sRmU1qy0AAG2vQmSc0zVebQeEwefykJTqRu4cINX2t2boltDyQLQ9pOO2UdTh6INhVwV
         aXDJaL0QmIiOnxGf109yuJaG/7J7Vil7BqtzgaEaw8OHwZlbVF28Dg1mxz8MhErDrqvC
         WvwTeeBt6p9GCT4v8uyvIi/9pJqSa4g+VqzkcR+fXDXxCbvKFf6qumrRUzGI89UNEVKS
         uLZg==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

'pm_power_off' is a function pointer, not a function, so need change
its type, and also need export it, or can not pass compiling with
allmodconfig. The related error:

    MODPOST 2879 modules
  ERROR: "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/kernel/reset.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c
index 6aeabc9..76483c1 100644
--- a/arch/hexagon/kernel/reset.c
+++ b/arch/hexagon/kernel/reset.c
@@ -33,6 +33,5 @@ void machine_restart(char *cmd)
 {
 }
 
-void pm_power_off(void)
-{
-}
+void (*pm_power_off)(void) = NULL;
+EXPORT_SYMBOL(pm_power_off);
-- 
1.7.7.6
