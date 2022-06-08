From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/36] cpuidle,armada: Push RCU-idle into driver
Date: Wed, 08 Jun 2022 16:27:34 +0200
Message-ID: <20220608144516.614797628@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=9yd1uW/Ha4lFVJl9g3NG8xPj6tkgCPp8FbdRM3bEBHk=; b=fc+lbbvKwwN4ZJ7iUz0gOd6Kw1
 bWZHe3UXTKQ37VnD0JIa/nKeK2NWAC5dW50BJVMiH1O0g/NAQki27BvHuVbo9/MbJioA+l8bQlAeg
 l4w6/u19HStC/e7hYn9qn64X+GhFM03qFAT/CAxcvj/R6DIolTBBDV6RBWD9rGeBRWsCeD6c+DPTN
 hfdniSGhPewVHFKY3H9c5xdzdll1zcPQGSamYV1TPyhmdCITIhSKQrv2bNMKa90Crt7jnx4M6v4J0
 gzF0aqTx0qtLc4aL7xQtl8DpGTt8VZizoHoOYrXPnJORVcj1rNrY3g+XpMSApiCVfrx62z+2ZhBaT
 W5Yf5pVQ==;
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
Cc: juri.lelli@redhat.com, rafael@kernel.org, benh@kernel.crashing.org, linus.walleij@linaro.org, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, catalin.marinas@arm.com, xen-devel@lists.xenproject.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, acme@kernel.org, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, rth@twiddle.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, senozhatsky@chromium.org, svens@linux.ibm.com, jolsa@kernel.org, paul

Doing RCU-idle outside the driver, only to then temporarily enable it
again before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -36,7 +36,10 @@ static int mvebu_v7_enter_idle(struct cp
 	if (drv->states[index].flags & MVEBU_V7_FLAG_DEEP_IDLE)
 		deepidle = true;
 
+	rcu_idle_enter();
 	ret = mvebu_v7_cpu_suspend(deepidle);
+	rcu_idle_exit();
+
 	cpu_pm_exit();
 
 	if (ret)
@@ -49,6 +52,7 @@ static struct cpuidle_driver armadaxp_id
 	.name			= "armada_xp_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 50,
@@ -57,6 +61,7 @@ static struct cpuidle_driver armadaxp_id
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 1000,
 		.power_usage		= 5,
@@ -72,6 +77,7 @@ static struct cpuidle_driver armada370_i
 	.name			= "armada_370_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 5,
@@ -87,6 +93,7 @@ static struct cpuidle_driver armada38x_i
 	.name			= "armada_38x_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 10,
 		.power_usage		= 5,
