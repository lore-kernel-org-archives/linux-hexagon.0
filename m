From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] hexagon: fix warning comparing pointer to 0
Date: Wed, 10 Mar 2021 14:53:39 +0800
Message-ID: <1615359219-1528-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Fix the following coccicheck warning:

./arch/hexagon/kernel/traps.c:142:6-7: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 904134b..58083df 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -139,7 +139,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		}
 
 		/* Attempt to continue past exception. */
-		if (0 == newfp) {
+		if (!newfp) {
 			struct pt_regs *regs = (struct pt_regs *) (((void *)fp)
 						+ 8);
 
-- 
1.8.3.1

