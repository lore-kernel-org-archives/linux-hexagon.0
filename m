From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 05/13] mm/pagemap: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:14 +0200
Message-ID: <20200914204441.486057928@linutronix.de>
References: <20200914204209.256266093@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Subject:To:From:Date:
	Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=q9HjIjXjiNaXFKjWL6n6KTk62DR0gQfGhCdMdmyc7hk=; b=VvFOIWECkxVWBjBWXwV40ytJL
	lW4Hz6w9ZdPuT2UgDy29p32DF1IAYPjn935ZBxubrxRzt5ywasEl1bc6lTdw39eAYC1ZVlMuWVfeB
	BX/+YEwXxeuDl+OYlbjV2AZuw6PaAui2SD7OQaTCxIAAmXbwkMY7IXzb3YSuhVGHc3PvHPAB7D57w
	gjJR3cfKXNyHr9WjKw7KMHwelh//iwAk8tbgSwZtpQ4OtKaG3+CqBsn2C4w/vJTmgUzJrunUm1buL
	XnJJNnoMDCZIAd82X812LzbYEuLZfM5TBP7DRSQzvQSRnun/GB5vkUZ+WO2Vs1C8vkIablPo298u5
	7cLw02nCA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=JgtXFDXxZGfThbRDf0kz64PxO4briiyz9f7Eq57ONcE=;
 b=4P8s5xX/bAi2a+N+CIbhQrzcX7HvFJ7S6CNHYdIstAaonGR/+Dnp1rRjEv7pyPlLgNCFYx
 sFTsKc2IsAVS7kbywI0LEVkCa6iWPXHUhikvoBItTFVO86zjlB5Fn+D/mFFgSAQbIZQS53
 00ZNDy4dfDU32t9qHFMauWVHXQtP0Qojy3xvBYG6atY0csq7zU4WIhUdO5c7N/c6aLPgTC
 Z464/mn2KP5p1MToHKTSzU6V5E1wKd/QmhgJgb7HxMSTZ+HFYru8UIB2rZH4RJycqwOVJD
 uGhpci7usAWJWI1a0nfucwZNnQUjJHBVkOYdQoqQaJQUx9zkmrQU6A8iuIY1nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=JgtXFDXxZGfThbRDf0kz64PxO4briiyz9f7Eq57ONcE=;
 b=iux8epOCVyhcOltC05jMckhTC3+4PPkpXc+cvBTMuwrFHucsc14BLoy7aSSCwXQ7rqsNPn
 xvgdzAI0oBjN5YAA==
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>, Valentin

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/pagemap.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -168,9 +168,7 @@ void release_pages(struct page **pages,
 static inline int __page_cache_add_speculative(struct page *page, int count)
 {
 #ifdef CONFIG_TINY_RCU
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
+	VM_BUG_ON(preemptible())
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
 	 * this for us.
