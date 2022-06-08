From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 23/36] arm64,smp: Remove trace_.*_rcuidle() usage
Date: Wed, 08 Jun 2022 16:27:46 +0200
Message-ID: <20220608144517.380962958@infradead.org>
References: <20220608142723.103523089@infradead.org>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RgIlqtYjjJdUiI+7wCmxTrS6x1kOK6pzGpl8Q80bmr4=; b=bQitAo3/bhX/7hzGI4T3yibna4
        0mQZeyH26/9uEQoQ3a1aX3sWfKMfQ781vDvBiZrQN/0MSfReYdabg0FWrYVzcM/S2rUEv6t6LGksa
        2BQ/eFu8BDIKfzmcsKUyYvSei/0kIkIiswTsPUZTWuqJ9hrWBbHm9564E7DCbUTazE3QYRIUcrjOI
        aJk5EhnlwCnKYq27DXu1QA/DW1E8sCiSYr9HyBmEjLdFA0HQokSNPY9mowQlBRNW8L1t9Mv4j9GoO
        6NWPHqFFtnihkP9nxLcUiaNc5tX0iEfigOT06QdTK6KDKX5Ebp0k3LNleCw9IlDGN1ZUtCQIxVuOF
        W43+1Cjg==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, paul.walmsley@sifive.com, palmer@dabbelt.com, ao

Ever since commit d3afc7f12987 ("arm64: Allow IPIs to be handled as
normal interrupts") this function is called in regular IRQ context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/kernel/smp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -865,7 +865,7 @@ static void do_handle_IPI(int ipinr)
 	unsigned int cpu = smp_processor_id();
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
+		trace_ipi_entry(ipi_types[ipinr]);
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -914,7 +914,7 @@ static void do_handle_IPI(int ipinr)
 	}
 
 	if ((unsigned)ipinr < NR_IPI)
-		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+		trace_ipi_exit(ipi_types[ipinr]);
 }
 
 static irqreturn_t ipi_handler(int irq, void *data)


