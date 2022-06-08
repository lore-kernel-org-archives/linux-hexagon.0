From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 10/36] cpuidle,omap3: Push RCU-idle into driver
Date: Wed, 08 Jun 2022 16:27:33 +0200
Message-ID: <20220608144516.552202452@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=F6PB1BepzhzXddHr1ut7n1kgQmvFEr/OgkB1cnk1WPs=; b=M1tCXyGnbstCdvvtQ6/mZ12wfv
        +hr+FYDVrB35l8sZT0TTdCikLVIUmFfj6NCuF5T8qgOzzSP3eAZudz5T6mIBNivroM+BT4eJldpE9
        7+Nnin03YehIhXL00k8dYiLlUce04mN5y6Ve+yhirYQRYF7ZJS7t2XyylndNROV2N8dfM1PpTU/jz
        C1KdUd9/P80+q0ZbUHi4gev9nD3XryZhgPN6/lHDLu9WiEScUhG3xTkiznMw9GW8m2H5YeEzUF4I7
        K4pDvTrIND321JNLvo0AQr3NAc7PiLRPH3zuBWzcqsQzz70MHALRsvHj1fvGnpMkOMw7xp7tYxu8W
        voqbkDkQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Doing RCU-idle outside the driver, only to then teporarily enable it
again before going idle is daft.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -133,7 +133,9 @@ static int omap3_enter_idle(struct cpuid
 	}
 
 	/* Execute ARM wfi */
+	rcu_idle_enter();
 	omap_sram_idle();
+	rcu_idle_exit();
 
 	/*
 	 * Call idle CPU PM enter notifier chain to restore
@@ -265,6 +267,7 @@ static struct cpuidle_driver omap3_idle_
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2 + 2,
 			.target_residency = 5,
@@ -272,6 +275,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10 + 10,
 			.target_residency = 30,
@@ -279,6 +283,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 50 + 50,
 			.target_residency = 300,
@@ -286,6 +291,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 1500 + 1800,
 			.target_residency = 4000,
@@ -293,6 +299,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 2500 + 7500,
 			.target_residency = 12000,
@@ -300,6 +307,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 3000 + 8500,
 			.target_residency = 15000,
@@ -307,6 +315,7 @@ static struct cpuidle_driver omap3_idle_
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 10000 + 30000,
 			.target_residency = 30000,
@@ -328,6 +337,7 @@ static struct cpuidle_driver omap3430_id
 	.owner            = THIS_MODULE,
 	.states = {
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 110 + 162,
 			.target_residency = 5,
@@ -335,6 +345,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 106 + 180,
 			.target_residency = 309,
@@ -342,6 +353,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU ON + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 107 + 410,
 			.target_residency = 46057,
@@ -349,6 +361,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 121 + 3374,
 			.target_residency = 46057,
@@ -356,6 +369,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE ON",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 855 + 1146,
 			.target_residency = 46057,
@@ -363,6 +377,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU RET + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7580 + 4134,
 			.target_residency = 484329,
@@ -370,6 +385,7 @@ static struct cpuidle_driver omap3430_id
 			.desc		  = "MPU OFF + CORE RET",
 		},
 		{
+			.flags		  = CPUIDLE_FLAG_RCU_IDLE,
 			.enter		  = omap3_enter_idle_bm,
 			.exit_latency	  = 7505 + 15274,
 			.target_residency = 484329,


