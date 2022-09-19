From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 03/44] cpuidle/poll: Ensure IRQ state is invariant
Date: Mon, 19 Sep 2022 11:59:42 +0200
Message-ID: <20220919101520.534233547@infradead.org>
References: <20220919095939.761690562@infradead.org>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=74awPgmRWnz6TtiKDYLgK7Deo1BdG7DroGRjfVtm8U0=; b=SFQYA3jAmhFq40VYZM68Tl2w5i
        ZXRBNgbLC3acA/1Dm/ZTH0pKngpyZarrHO2urIBRGd1SFXtlBVsxBG5w3GvcNlPbnMiIzGgnA+Y8t
        dXazbL2lngg+xVaLeVvXkenThdUDjpquoAohkyV4ZdsIELsDdK/l8RS1n5Tz50U++NJCb4r09fRIs
        kieZ0CsOt3gPv2NZizNIQhY8xJqq2RCg52cWnS+fYBZiVJ6uU3u4gx57qQdc9RSVuVE+VOTiNE5qY
        bUCPNJ6Ogw6hQFEH7tWJhnIsvwMUvNInJslCtzYuuDdwYWXhLCJ6oMb7pHkM31N8il9TbGM5YnHUV
        95FWEVpQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbel

cpuidle_state::enter() methods should be IRQ invariant

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/poll_state.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -17,7 +17,7 @@ static int __cpuidle poll_idle(struct cp
 
 	dev->poll_time_limit = false;
 
-	local_irq_enable();
+	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
 		unsigned int loop_count = 0;
 		u64 limit;
@@ -36,6 +36,8 @@ static int __cpuidle poll_idle(struct cp
 			}
 		}
 	}
+	raw_local_irq_disable();
+
 	current_clr_polling();
 
 	return index;


