From: Pranith Kumar <bobby.prani@gmail.com>
Subject: [PATCH 4/6] update reference, kerneltrap.org no longer works
Date: Mon,  9 Jun 2014 11:51:26 -0400
Message-ID: <1402329088-4802-4-git-send-email-bobby.prani@gmail.com>
References: <1402329088-4802-1-git-send-email-bobby.prani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Zde7GaRhKc+qo8pBe/6lwaGMEplysi1LtWuXs+nTDBI=;
        b=i+ZKfshr7IUyloHmXPzNu+Xl8Zg/hU+7/cN9f6xgWl8TsGw+49uhp6hyuZdMXhmyVQ
         qAw0xthJ37/TCgAEnj+Oukkk+AfDOEfqobiOaNti9qYmzRgyQizcpO4DhwSvw5PZoMvu
         9KAAHGk1YtXO2rsYfFn+6p05RnbE078i9DyBxe4lKjF/A9zFbIOF/43aT5QlM4sGWZii
         /b7an28hRcu9eOzFIwpmxl+4YLwWuRokQJYPcNE/CDaObgLQcfHhCbwpiafpQqYxsnNB
         O+bfdg4GjY5CUQIvsZ4NqDaQd1xsrW7CdcAYwaqcULhSCKgV/JtlFRic3Rhk428DXchg
         3SYg==
In-Reply-To: <1402329088-4802-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@rustcorp.com.au, Richard Kuo <rkuo@codeaurora.org>, "GitAuthor: Pranith Kumar" <bobby.prani@gmail.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

kerneltrap.org no longer works, update to a working reference

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/hexagon/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cache.h b/arch/hexagon/include/asm/cache.h
index f4ca594..2635117 100644
--- a/arch/hexagon/include/asm/cache.h
+++ b/arch/hexagon/include/asm/cache.h
@@ -28,7 +28,7 @@
 #define __cacheline_aligned	__aligned(L1_CACHE_BYTES)
 #define ____cacheline_aligned	__aligned(L1_CACHE_BYTES)
 
-/* See http://kerneltrap.org/node/15100  */
+/* See http://lwn.net/Articles/262554/ */
 #define __read_mostly
 
 #endif
-- 
1.9.1
