From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0145/1529] Fix typo
Date: Sat, 21 May 2016 13:55:21 +0200
Message-ID: <20160521115521.7050-1-andrea.gelmini@gelma.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=bkl2+F2JjMLt/7x64pE8cEljC2EDfrLRAXQJVBZA29o=;
        b=UX9l0V6l9nPk+L/PzQXG8+l08ajLBhYReYMHs5/Q/IGfhLD1aP+K4Lh1QJTUBIBjN1
         me5tlWwGNvdULbktmIgKiCKT1QjJPcjzZMrE2WvuZd/biuZxsW4an+f6eWYvkODFjkzl
         7cr2ZAN2lZWjo4+HJoUjlDNleMXFFyaXd4n98Vy2jPWuk2IlGOAeTdTNqEORXpzeRs9V
         VmUOnD2xwhsexGHA1bA+pTSbrlVPVN6bHqT0TFCjp8N75/QqCR9c7mYn9ZdCmM0xSDan
         v8TAnpKrSSYLySP6A8NiDB1oNa7gNc4vVDQs9nWahX/kcKmaxTsbhk9KXSSUMOqNyqgD
         OcAg==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/hexagon/include/asm/cacheflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index b86f9f3..34bc468 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -76,7 +76,7 @@ extern void flush_cache_all_hexagon(void);
 
 /*
  * This may or may not ever have to be non-null, depending on the
- * virtual machine MMU.  For a native kernel, it's definitiely  a no-op
+ * virtual machine MMU.  For a native kernel, it's definitely a no-op
  *
  * This is also the place where deferred cache coherency stuff seems
  * to happen, classically...  but instead we do it like ia64 and
-- 
2.8.2.534.g1f66975
