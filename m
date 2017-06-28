From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH -next] hexagon: Fix compile error
Date: Tue, 27 Jun 2017 17:43:14 -0700
Message-ID: <1498610594-5993-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vieutpfzs4YomEeoH3zCqxeIMyKiFDnbVcvxGsgOMXs=; b=bP8D61yI51dYPBtMW+sgh2+dbJ
        jWOtFS+cbmJitj/36+Mbn/2hlxCw7ncJMOx+QEyjPNC+CbtPctAAQJAevwg0GMuH/9RlgW7DVmRzm
        QkrIB0BJz3jF35gS7z0DtLtUm4MSziUWyjW3+bCRRvNEiPSJQvBba2N0hbjTrSt9f4AB0/Wt5FZZE
        9bIstFw3yQmk8haJ7ym9jZiNlJ0bcBmxREYj4OxNf9c4Y8q9GYqswuRn/0Blh+WWo6iKlnmMvf4Ef
        ysN6H+qFkjSeEYAdim6eGjafhqgobEuQdu8PxJgxKZ/6pStwuPf2fW4/SbPLarEqPO3WRgw33itC+
        GDxCww 
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>

Fix:

arch/hexagon/kernel/dma.c: At top level:
arch/hexagon/kernel/dma.c:209:40: error: expected '}' before ';' token

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 8715a7227c30b ("hexagon: switch to use ->mapping_error for ...")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Maybe fold into the offending patch if possible ?

 arch/hexagon/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 9ff1b2041f85..546792d176a4 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -206,7 +206,7 @@ const struct dma_map_ops hexagon_dma_ops = {
 	.map_page	= hexagon_map_page,
 	.sync_single_for_cpu = hexagon_sync_single_for_cpu,
 	.sync_single_for_device = hexagon_sync_single_for_device,
-	.mapping_error	= hexagon_mapping_error;
+	.mapping_error	= hexagon_mapping_error,
 	.is_phys	= 1,
 };
 
-- 
2.7.4
