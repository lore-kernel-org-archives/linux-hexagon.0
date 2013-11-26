From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: include: asm: add generic macro 'mmiowb' in
 "io.h"
Date: Tue, 26 Nov 2013 12:07:40 +0800
Message-ID: <52941E8C.7010909@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=k+2kS0hsBbcvgt0rd0+fLttxxF1jOQnHM+4kWjqDn9E=;
        b=zAn9QerlEPB5ojLN4xG0twux5QBmd3unGIBMSQisxxKkm3cdAz4nIdAcFl4Afnz/ld
         LYcuOWPvFd2Q3+oaqRe/AgK/OaKvz7r2J/fBATBgFbaI+BplyOtIcKam2dHcMuc96xIS
         TYcf6TIou1HetpSrqLss4IqX+sHrvWbZG78JpXIkBl6VfyKLqdpS+Kdry0o7m1+4isKI
         pCAjaYMpjBiSjtZwu2YwUe21bYFWC8k03GVBHLqHaabVyndxng5APWwoOZ9GvYdAJSKF
         zqN0+NoAfgjVxgHfEL7sWXZz9jH5gueo5e8E+JzXWSU+MTvP+kLuSAzqUySGxZhiPxXQ
         oGyw==
In-Reply-To: <20131125011938.GB18921@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Need dumy mmiowb(), or can not pass compiling, the related error with
allmodconfig:

    CC [M]  drivers/mmc/host/sdhci.o
  drivers/mmc/host/sdhci.c: In function 'sdhci_request':
  drivers/mmc/host/sdhci.c:1409:2: error: implicit declaration of function 'mmiowb' [-Werror=implicit-function-declaration]


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/io.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 1b7698e..7029899 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -189,6 +189,8 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define writew_relaxed __raw_writew
 #define writel_relaxed __raw_writel
 
+#define mmiowb()
+
 /*
  * Need an mtype somewhere in here, for cache type deals?
  * This is probably too long for an inline.
-- 
1.7.7.6
