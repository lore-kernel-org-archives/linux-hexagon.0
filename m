From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0147/1529] Fix typo
Date: Sat, 21 May 2016 13:55:37 +0200
Message-ID: <20160521115537.7155-1-andrea.gelmini@gelma.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EJ/sAy7zaTJgIgLODmPwXXjSBB9ukGexzsdYBxla3oY=;
        b=s61J94wub50rpwWqQY/2p+0gpVrdf5+3vXtTW4JN3Lh3sRMGMJvCOB82a+SBGTMYW4
         eUTNu7uVWSZ1E3Bn/A8UD+UZFFDw9eqqF+hT5EsQv7Ot0ZPZiaGXgEdAhJsLAV8icHJ5
         f5XWPoEP/IMBTVjLA9CtH0nPP8Hz6u7bnX7K9e4DKtXu2DrAEX6fkRnQURDRj88mr+c0
         t6Jz/ZU0rPkpbRKgD+wOSOgJRXxxdkWylY3J+DpDFkURytp60zBEkTYVZvMBj43hOWCD
         zKJGJf7izaMF3RekQvY8MQh5rfoBN5/SjAELyqOxvkMy7JUyevNBaECKry2pBIPDS6RQ
         Bn7Q==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 110dab1..b12a080 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -415,7 +415,7 @@ void do_trap0(struct pt_regs *regs)
 			info.si_signo = SIGTRAP;
 			info.si_errno = 0;
 			/*
-			 * Some architecures add some per-thread state
+			 * Some architectures add some per-thread state
 			 * to distinguish between breakpoint traps and
 			 * trace traps.  We may want to do that, and
 			 * set the si_code value appropriately, or we
-- 
2.8.2.534.g1f66975
