From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 25/44] printk: Remove trace_.*_rcuidle() usage
Date: Mon, 19 Sep 2022 12:00:04 +0200
Message-ID: <20220919101522.021681292@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5699683365
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64E9783DFD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82154416ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86ABA41568
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=VPG6Pv8mWlQqWm+kW/xAIKtiRyMjOEN9R6RnNMCwxdw=; b=Ca5aS96cYfllCWW4NedYRctlyO
 gIiKYs+tVjR65pA5uFipueivu4K8pqduCvewON4kFVB2LMS+i5eIb/U6nldhQIDn+r9QASPUyZC4c
 GF32lSiMSA+Mhiewzh5F0g4wZwjk2l8xxnNGJnBVrz2MY26bzXbcmRBe2lb1RihVg4t8zc71zZR1Z
 2IfJ3S+ZOlX+uF+fmc+aV4GTYcoglXITJVkDuZAYu2b+tj6JJHtARlfxly/vNboY4Vlaph4FJyVQS
 Es6vtcgbyiH1mH5tISei+3HknX1+gpXNt7RYeujjLEjPx5O3nVTnio6SmEtDdkPxQ6iL6qwNlbTuN
 0w/UxONg==;
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: peterz@infradead.org
Cc: juri.lelli@redhat.com, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, tj@kernel.org, Andrew Morton <a>

The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
tracepoint"), was printk usage from the cpuidle path where RCU was
already disabled.

Per the patches earlier in this series, this is no longer the case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2238,7 +2238,7 @@ static u16 printk_sprint(char *text, u16
 		}
 	}
 
-	trace_console_rcuidle(text, text_len);
+	trace_console(text, text_len);
 
 	return text_len;
 }
