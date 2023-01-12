From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 16/51] cpuidle: Annotate poll_idle()
Date: Thu, 12 Jan 2023 20:43:30 +0100
Message-ID: <20230112195540.312601331@infradead.org>
References: <20230112194314.845371875@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15A8841057
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84E11414E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B9C781FA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2931E81EE3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=1NaK9G2/I/OTlb13IaE2Tqn3F/yijw+kp1Wy55f7+Ak=; b=Pt5HmjIEh3Wv8VJ6MDtP5xehnn
 IUfFZt912P+mmTmm7PW8VooKzJadT4+m/Te6yoMuw5Yy2FYh+WuBDhTAjEZBv6lCfcQ4jNYq7Ai4g
 EnHDd3+eV/WH4+0T1ctfvYCLMGKoqFuvKw70y6ZBgq00zHq9qXB+xE+jnUKnuWCB6TMHwA6eDaJ9O
 B6yaNOuZG/t1GScNt6B8MVnlCOfuU0zfKdd1cFhUdymM+Rx/TK1Lfk7xvMGNo7h3kdAreRhcd23BT
 1nheNmLfFQKk13PNA1eo4x2FfWUiu971uZDdeN7MCp66kwgTaoAbYogJNt0HuDQBJP4HmnafgDhY4
 tf3PZIng==;
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
Cc: juri.lelli@redhat.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, catalin.marinas@arm.com, linus.walleij@linaro.org, nsekhar@ti.com, bsegall@google.com, guoren@kernel.org, pavel@ucw.cz, agordeev@linux.ibm.com, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, vincent.guittot@linaro.org, mpe@ellerman.id.au, chenhuacai@kernel.org, christophe.leroy@csgroup.eu, linux-acpi@vger.kernel.org, agross@kernel.org, geert@linux-m68k.org, linux-imx@nxp.com, vgupta@kernel.org, mattst88@gmail.com, mturquette@baylibre.com, sammy@sammy.net, pmladek@suse.com, linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-um@lists.infradead.org, npiggin@gmail.com, tglx@linutronix.de, linux-omap@vger.kernel.org, dietmar.eggemann@arm.com, andreyknvl@gmail.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.

The __cpuidle functions will become a noinstr class, as such they need
explicit annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/poll_state.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -13,7 +13,10 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start = local_clock();
+	u64 time_start;
+
+	instrumentation_begin();
+	time_start = local_clock();
 
 	dev->poll_time_limit = false;
 
@@ -39,6 +42,7 @@ static int __cpuidle poll_idle(struct cp
 	raw_local_irq_disable();
 
 	current_clr_polling();
+	instrumentation_end();
 
 	return index;
 }
