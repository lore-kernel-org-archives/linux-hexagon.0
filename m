From: Richard Kuo <rkuo@codeaurora.org>
Subject: [PATCH 5/6] Hexagon: break up user fn/arg register setting
Date: Wed,  3 Apr 2013 19:02:55 -0500
Message-ID: <1365033776-21804-6-git-send-email-rkuo@codeaurora.org>
References: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk
Cc: Richard Kuo <rkuo@codeaurora.org>

Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/kernel/process.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 8e90b0c..2009377 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -113,7 +113,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		/* r24 <- fn, r25 <- arg */
-		ss->r2524 = usp | ((u64)arg << 32);
+		ss->r24 = usp;
+		ss->r25 = arg;
 		pt_set_kmode(childregs);
 		return 0;
 	}
-- 
1.7.9.5

--

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
