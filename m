From: Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] hexagon: Fix warning comparing pointer to 0
Date: Thu, 24 Mar 2022 10:26:31 +0800
Message-ID: <1648088791-31848-1-git-send-email-baihaowen@meizu.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org, ebiederm@xmission.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Haowen Bai <baihaowen@meizu.com>

Avoid pointer type value compared with 0 to make code clear.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 1240f038..dfdedfe 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -135,7 +135,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		}
 
 		/* Attempt to continue past exception. */
-		if (0 == newfp) {
+		if (!newfp) {
 			struct pt_regs *regs = (struct pt_regs *) (((void *)fp)
 						+ 8);
 
-- 
2.7.4

