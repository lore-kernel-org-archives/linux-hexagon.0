From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 34/44] cpuidle,omap3: Use WFI for omap3_pm_idle()
Date: Mon, 19 Sep 2022 12:00:13 +0200
Message-ID: <20220919101522.640861846@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6BBE416FC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B38E41700
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5F9C83FC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F163084068
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=Jv9RVwj6ep0TNO3s8uQfW2HtHTmBFm30lOC4tMkhMhE=; b=I0EhwdPmpjSZk5ja964YpGAeCk
 C45fO8EM2mFiC3DqJ/DLybVkyafkKHKl3HVER9ZEbihKzLYNqVeFyddpeJHRtyR3Hqt6oLKSGVGjW
 vqS2M9zIsxV8gsOfD7+XCbU9PTw5axIq4H/pb8qDwFBvMyaPepi+uWsHsWNlsWS7xrTM/BPK4YgD3
 Dc5KuCRzAzK3XGO0qZfcsXuFfFJ9wq6bMfse+Cfxnca5S5lUCl4E/cwiPRmLCQSUW7X2HmRLeBpql
 t7ZytyFf5zRqKJC9wJ/YYZXZRdxRenNHmV2zQCP0YUncXkY5SvjZeThv7pYpsP5HwzDFYicMtgcd9
 GoTez4OA==;
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

arch_cpu_idle() is a very simple idle interface and exposes only a
single idle state and is expected to not require RCU and not do any
tracing/instrumentation.

As such, omap_sram_idle() is not a valid implementation. Replace it
with the simple (shallow) omap3_do_wfi() call. Leaving the more
complicated idle states for the cpuidle driver.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -294,7 +294,7 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		return;
 
-	omap_sram_idle();
+	omap3_do_wfi();
 }
 
 #ifdef CONFIG_SUSPEND
