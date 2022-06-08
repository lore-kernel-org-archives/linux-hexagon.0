From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/36] cpuidle/poll: Ensure IRQ state is invariant
Date: Wed, 08 Jun 2022 16:27:26 +0200
Message-ID: <20220608144516.109792837@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5naerUzcbldjXRb10QYbs7+/pM4Ur6B2nPLePdbzHOg=; b=rhgD+2PcLe5JBDMlblYneku2pt
        sdXli9DhMYdDhGWlEZGfdH33pA1vxt2/I6b1j6EXLWZWbJKzwmGTw5dQ1MmGgZUXFXCjmqjyi7Cj0
        RDEeMRhRx462t65vhBmJxF3B2p6UkTTvXKi94yWM8bZ08fR0lDh+Y4pYwx1LnZArZ4GjMKpZDddEp
        x8xSvPeIQZbvtL3deY5Q/Os9xDxH0nwk7Kl+yc43Zl8sk4PIGyqEmr5VJo8LA2u3JPyOV7lFHyHMX
        QOljdOyxCUAilPhGGsAmgB+8n8H2M0DXrQgHdXFz3ZS+VW69bh5LQomhK8O36eqaPNPg9koIFunZF
        REK2rFOw==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

cpuidle_state::enter() methods should be IRQ invariant

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


