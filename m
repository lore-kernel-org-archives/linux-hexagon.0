From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Hexagon-setup: Combine four seq_printf() calls into one call
 in show_cpuinfo()
Date: Fri, 21 Oct 2016 08:33:45 +0200
Message-ID: <c19c69d5-600c-f08b-f448-0420e677db63@users.sourceforge.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 21 Oct 2016 08:18:38 +0200

Some data were printed into a sequence by four separate function calls.
Print the same data by a single function call instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/hexagon/kernel/setup.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 6981949..ff37044 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -132,13 +132,14 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	if (!cpu_online(cpu))
 		return 0;
 #endif
-
-	seq_printf(m, "processor\t: %d\n", cpu);
-	seq_printf(m, "model name\t: Hexagon Virtual Machine\n");
-	seq_printf(m, "BogoMips\t: %lu.%02lu\n",
-		(loops_per_jiffy * HZ) / 500000,
-		((loops_per_jiffy * HZ) / 5000) % 100);
-	seq_printf(m, "\n");
+	seq_printf(m,
+		   "processor\t: %d\n"
+		   "model name\t: Hexagon Virtual Machine\n"
+		   "BogoMips\t: %lu.%02lu\n"
+		   "\n",
+		   cpu,
+		   (loops_per_jiffy * HZ) / 500000,
+		   ((loops_per_jiffy * HZ) / 5000) % 100);
 	return 0;
 }
 
-- 
2.10.1

