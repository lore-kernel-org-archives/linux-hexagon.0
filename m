From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] hexagon/time: make rtos_timer_device __initdata
Date: Tue, 19 Sep 2017 12:37:21 +0530
Message-ID: <1505804841-20278-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=njLzkGwxYoPVGc1km8m0aCqPPx7Kj6i8D6yuH8YN+lM=;
        b=B99hxMi5gfA5E2T2BqQ0wfvCmjqlBCRsS6/aXFBXpgKlZkK0Gxk3TV400zsitWv5bQ
         TZw1agEch3otx4nxstNi0gVTiyAqMGnLdAqzYh1NGtr3iJkvZmuwVafzp7xTKhXXoP7n
         SuZPv0zFVdNqulSr7PQpBeKVTy5g0Fbl0+r4j8XmkSTP+op8wPOmakm8sO8nhnKyMMa6
         +WgBbJ14ymM9cEVz8b4nM8pBhryCaACNfU7dnkRONftAoGYqQ+WTJvPsHl4xJJi0i91b
         jRT7s2vueMOUtSECtYntiyxXNaQ9n9zQLzemSE1XjfVUenxyJTFFhCD0de9kCzdjJb7t
         xFOQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make this __initdata as it is only modified during the init phase and
after that the structure and its fields are not referenced anywhere.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
Hexagon architecture was not found while cross-compiling, so the
file is not compile-tested. 

 arch/hexagon/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index 29b1f57..5b5a366 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -54,7 +54,7 @@
 	},
 };
 
-static struct platform_device rtos_timer_device = {
+static struct platform_device rtos_timer_device __initdata = {
 	.name		= "rtos_timer",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(rtos_timer_resources),
-- 
1.9.1

