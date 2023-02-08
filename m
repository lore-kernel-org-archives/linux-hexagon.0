From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] hexagon: Fix warning comparing pointer to 0
Date: Wed,  8 Feb 2023 09:11:05 +0800
Message-ID: <20230208011105.80219-1-yang.lee@linux.alibaba.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@quicinc.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>

./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0

Avoid pointer type value compared with 0 to make code clear.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3978
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..fdbbf78b4ce0 100644
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
2.20.1.7.g153144c

