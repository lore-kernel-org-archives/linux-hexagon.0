From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH 2/2] arch: hexagon: include: asm: use 'affinity' instead of
 'locdis' for __vmintop_affinity() in "hexagon_vm.h"
Date: Mon, 25 Nov 2013 10:41:21 +0800
Message-ID: <5292B8D1.5050407@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <5292B845.3010404@gmail.com> <5292B8A0.7020409@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VPfgw1mVGXt9BuuJvDJhohE3rwzKHeCtyE069cCfsx0=;
        b=b0KKrPgoqz1PXLUSpv3Ko+RHGkbqc5znYj3nFPyoV/uJpPI5CXsePKMA2TJ6NiNRgR
         Qz5fH/LTn6/83cb2NxcpexAFR6tDyiHTnY1M5k2sBMotSAOU4Dm+Cyk4ubiGpErSUqCU
         y4p2SmpZimkHeKXk4Nj2OSYpco2iwBb03XuMzrrDyPrJlyc2qgGD5VPQeLkMB1zbjeaz
         X1zr4S2sYgFyAqV945Ab8ECpARNX8p0Tp2RGSMlBmjYpUaWaWEX9fFOtaKzAUxtVuWs7
         axmNlRdhKb94hoqR/Vq/jn69SRaR0xaSS20i1oBwB/JvAUpy5GeDVEpHOHjvUuGwWnt6
         xkRA==
In-Reply-To: <5292B8A0.7020409@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

All __vmintop_*() use  __vmintop(*, ...), so __vmintop_affinity() need
use __vmintop(vm_affinity, ...).


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index e1e0470..3ea99c1 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -161,7 +161,7 @@ static inline long __vmintop_locdis(long i)
 
 static inline long __vmintop_affinity(long i, long cpu)
 {
-	return __vmintop(locdis, i, cpu, 0, 0);
+	return __vmintop(vm_affinity, i, cpu, 0, 0);
 }
 
 static inline long __vmintop_get(void)
-- 
1.7.7.6
