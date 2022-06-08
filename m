From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
Date: Wed, 08 Jun 2022 16:27:47 +0200
Message-ID: <20220608144517.444659212@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-arm-msm-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=1usWiRWR4uttba39otUsN6OqB3IXu4/S2NHARc2LOVI=; b=FwGsX6HqAEWrIDIwqSsLl+2rn+
        jxtc/+7Q73QoS/5n4U2sAOL0VlfaYMGCWkilbboinFeB59SIcUo3UpH4a5CtYGWmPThbsscblAnH4
        PSS71rXa70D7UmJtRK8HWOujM8sLBbHEPGPYqLVKvfZP62p3cW80pTaY4XSX5yfYbfkdrHxiUG5Wz
        T0edzqMYifaS2QyjulPfkPqxRE0jrOsPGKKpMpJYlly7Zipb93HlY74okg/8Mb1f3Kbt7PF9GRF4I
        xfQiX+7/KU3X93vRF1S+bG52Qv3PZIAkNXLJYuCETihI1/nFsTHWt4NnKd/O4/6se7YsYY89QZ1rA
        qO/mDSKA==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

The problem, per commit fc98c3c8c9dc ("printk: use rcuidle console
tracepoint"), was printk usage from the cpuidle path where RCU was
already disabled.

Per the patches earlier in this series, this is no longer the case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


