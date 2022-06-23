From: Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] hexagon: drop unexpected word 'a' in comments
Date: Thu, 23 Jun 2022 14:51:00 +0800
Message-ID: <20220623065100.8268-1-jiangjian@cdjrlc.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@quicinc.com
Cc: ebiederm@xmission.com, nathan@kernel.org, mpe@ellerman.id.au, keescook@chromium.org, wangkefeng.wang@huawei.com, jiangjian@cdjrlc.com, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

there is an unexpected word 'a' in the comments that need to be dropped

file - arch/hexagon/kernel/traps.c
line - 262

* Precise bus errors may be recoverable with a a retry,

changed to:

* Precise bus errors may be recoverable with a retry,

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/hexagon/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..a1f1085887aa 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -259,7 +259,7 @@ static void illegal_instruction(struct pt_regs *regs)
 }
 
 /*
- * Precise bus errors may be recoverable with a a retry,
+ * Precise bus errors may be recoverable with a retry,
  * but for now, treat them as irrecoverable.
  */
 static void precise_bus_error(struct pt_regs *regs)
-- 
2.17.1

