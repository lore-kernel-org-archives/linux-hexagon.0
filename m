From: Thomas Meyer <thomas@m3y3r.de>
Subject: [PATCH] Hexagon: Use resource_size function
Date: Tue, 08 Nov 2011 19:49:30 +0100
Message-ID: <1320778170.8062.134.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

From: Thomas Meyer <thomas@m3y3r.de>

 Use resource_size function on resource object
 instead of explicit computation.

 The semantic patch that makes this change is available
 in scripts/coccinelle/api/resource_size.cocci.

 More information about semantic patching is available at
 http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
--- a/arch/hexagon/kernel/time.c 2011-11-07 19:37:21.719553477 +0100
+++ b/arch/hexagon/kernel/time.c 2011-11-08 12:21:17.722176538 +0100
@@ -200,12 +200,10 @@ void __init time_init_deferred(void)
 		resource = rtos_timer_device.resource;
 
 	/*  ioremap here means this has to run later, after paging init  */
-	rtos_timer = ioremap(resource->start, resource->end
-		- resource->start + 1);
+	rtos_timer = ioremap(resource->start, resource_size(resource));
 
 	if (!rtos_timer) {
-		release_mem_region(resource->start, resource->end
-			- resource->start + 1);
+		release_mem_region(resource->start, resource_size(resource));
 	}
 	clocksource_register_khz(&hexagon_clocksource, pcycle_freq_mhz * 1000);
 

