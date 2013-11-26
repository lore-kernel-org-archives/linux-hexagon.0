From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: include: asm: Kbuild: add generic "serial.h"
 in Kbuild
Date: Tue, 26 Nov 2013 12:09:43 +0800
Message-ID: <52941F07.6010302@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <52941E8C.7010909@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fXttLQ0HzeFdoVLrhcoFnVsDHgd9U+/bADt/OZIqpFw=;
        b=J5XrJBCt4dbSo4tQK2sUY9AnWpeJBYiZkIq1I493NR5292eJwUib4xgVngdHlJfitA
         Xgq0rfe7ynMCPjGAwiOoEMktHpA4xOC3We3I12iT0EEcCLFi2ToD68NmkKLGj/5Vyc+P
         VDvp5p+YH0bgqtACHFtfsFBhNlt3oxiXCkQDbJjWImCxagNxGrFUEKUMNG1hsyfYd1as
         FmBcOG1+MWNOYfjZFfAZuQL+72W1qFchRpn0UayPyXHM6DYnskpP8yP8elMElzB9IZL2
         f2FFlzvF8sQLkts3bsfBr3wRWjnTajwNB+3EwOCnsQ3+U2bgUE4Tv8t7rV58wPrHoUKo
         Ye1A==
In-Reply-To: <52941E8C.7010909@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

Add "serial.h" in Kbuild, or can not pass compiling with allmodconfig,
the related error:

    CC [M]  drivers/staging/speakup/speakup_acntpc.o
  In file included from drivers/staging/speakup/speakup_acntpc.c:33:0:
  drivers/staging/speakup/serialio.h:7:24: fatal error: asm/serial.h: No such file or directory


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 424e28e..0852230 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -38,6 +38,7 @@ generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += sembuf.h
+generic-y += serial.h
 generic-y += shmbuf.h
 generic-y += shmparam.h
 generic-y += siginfo.h
-- 
1.7.7.6
