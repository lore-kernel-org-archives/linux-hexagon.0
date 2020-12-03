From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix arch_cpu_idle() vs
 tracing
Date: Thu, 3 Dec 2020 18:10:15 +0100
Message-ID: <20201203171015.GN2414@hirez.programming.kicks-ass.net>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
 <20201203145442.GC9994@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bqUimWkuWsbPDqKNCEUum7KttnGShCm7fafFU6+xUHA=; b=1BN8JwobHXPhH0DCEQrNqSLNz
	os+gfuboBuyIrCjYj0h258qCPCu4HFLDpCHvet8ta2AblXlCzxkWkkc6cBZAvijK64UmRUHe8ATE5
	LVrlwgWPyKVHSQ7pOVUO2MSCQxvehnTtrH4BXbJpg6eZfv2soCyQgdL4xYiANol1emQn85erROm+r
	0bimu2k2Ud4L4cwnAR6K9EI3mP+oCJCHor7j3Wu5xgdS0lLLaAegJk0Cie+GFK07S9DnRzdWgjpxs
	pJU18tEH5EVzTvXuxzRnVRkWqGy9lnc5ZiBXVsmz5w4ccYX8mEgOdb79UvzyM6eyqhHzK5Ir1Apfa
	nAbyq9H1g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0lhCxHLgf8TSOAvypxgyZdt6AOtyZg3i7+GSOy69WwU=; b=jeeAqf558AfAqY1ZPTR4HfNgwX
 YopjYarSwRSdQuGeGyjCSNFpvTWHEYq7+8CHvDrMVdGazF9BvP9no40RR9phvvpP85cND+YTv5ln8
 KPsTGbcRveY23zSbT4NayaXcOaWGv8eD84pD4++pebfb9TdeUpWsXFyBzsbMD+4DIqsHk8ZIrsRiW
 I7PtW3gWf5TUhQ5JidDUj/TGspfxPwztfLhtU0q/hd+wkoe4vNNFcR8XRjZIn82vi+bkd0ZTVcg/Z
 fo0RR2g2KJYGfC5KQ9XiTR/EvLYuZJdjOjJWpHZAgMtF0E4z09yRlsVs8vjqzUSCTdzo9+Ps9L8Qg
 SgThpYbg==;
Content-Disposition: inline
In-Reply-To: <20201203145442.GC9994@osiris>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, linux-alpha@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 03, 2020 at 03:54:42PM +0100, Heiko Carstens wrote:
> On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
> > 
> > We call arch_cpu_idle() with RCU disabled, but then use
> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > 
> > Switch all arch_cpu_idle() implementations to use
> > raw_local_irq_{en,dis}able() and carefully manage the
> > lockdep,rcu,tracing state like we do in entry.
> > 
> > (XXX: we really should change arch_cpu_idle() to not return with
> > interrupts enabled)
> > 
> > Reported-by: Sven Schnelle <svens@linux.ibm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> This patch broke s390 irq state tracing. A patch to fix this is
> scheduled to be merged upstream today (hopefully).
> Therefore I think this patch should not yet go into 5.9 stable.

Agreed.
