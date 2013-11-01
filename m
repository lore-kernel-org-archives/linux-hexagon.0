From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] hexagon: kernel: remove useless variables 'dn', 'r' and 'err'
 in time_init_deferred() in "time.c"
Date: Fri, 01 Nov 2013 19:07:48 +0800
Message-ID: <52738B84.9080704@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Remove them, since they are useless. The related warnings (with
allmodconfig for v4):

    CC      arch/hexagon/kernel/time.o
  arch/hexagon/kernel/time.c: In function 'time_init_deferred':
  arch/hexagon/kernel/time.c:196: warning: unused variable 'err'
  arch/hexagon/kernel/time.c:195: warning: unused variable 'r'
  arch/hexagon/kernel/time.c:194: warning: unused variable 'dn'


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/hexagon/kernel/time.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index 9903fad..d0c4f5a 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -191,9 +191,6 @@ void __init time_init_deferred(void)
 {
 	struct resource *resource = NULL;
 	struct clock_event_device *ce_dev = &hexagon_clockevent_dev;
-	struct device_node *dn;
-	struct resource r;
-	int err;
 
 	ce_dev->cpumask = cpu_all_mask;
 
-- 
1.7.7.6
