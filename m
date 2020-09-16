From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [patch 00/13] preempt: Make preempt count
 unconditional
Date: Wed, 16 Sep 2020 20:23:52 +0100
Message-ID: <20200916192352.GO5449@casper.infradead.org>
References: <20200914204209.256266093@linutronix.de>
 <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Lu9AW4PaP4+ghxOf92Z5TIuOtrZJHfVdt4GP1kALmko=; b=qie+Isc1xWiVTOH0FpnUHhEdVO
 U/jpqcMvDRllAqn5p1U7GdefAxVM84Yy20b0cEM1bgiBf5hCnk01e9MB0TfKNwOXtWN1U1K+TKZoh
 Bf7eW6kpPKuWJAr92A4pFo4s9J4/zlCT/ZybRGMdVlaWMx2Lk0KLJY3uqYA5myPxU7z9T0QBID7Dv
 QCPTePB01BBKw0BUKhTbux2is2J6jnziOkr8sFb2qrhMyKZ9JnMFHBYx4uJoB16mYi9Z0C/a5HCRA
 DVWm6Js19jJdrChlv68PKTMdyYhgXX++ENCqsExKeuZiA9F/oE7zG8P2cfvR8n7McmH85zDTJUYAn
 sSR0hzAg==;
Content-Disposition: inline
In-Reply-To: <871rj4owfn.fsf@nanos.tec.linutronix.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Segall <bsegall@google.com>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch <linux-arch@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx <intel-gfx@lists.freedesktop.org>, Matt Turner <mattst88@gmail.com>, Valentin Schneider <valen>

On Mon, Sep 14, 2020 at 11:55:24PM +0200, Thomas Gleixner wrote:
> But just look at any check which uses preemptible(), especially those
> which check !preemptible():

hmm.

+++ b/include/linux/preempt.h
@@ -180,7 +180,9 @@ do { \
 
 #define preempt_enable_no_resched() sched_preempt_enable_no_resched()
 
+#ifndef MODULE
 #define preemptible()  (preempt_count() == 0 && !irqs_disabled())
+#endif
 
 #ifdef CONFIG_PREEMPTION
 #define preempt_enable() \


$ git grep -w preemptible drivers
(slightly trimmed by hand to remove, eg, comments)
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON_ONCE(preemptible());
drivers/firmware/arm_sdei.c:    WARN_ON(preemptible());
drivers/firmware/efi/efi-pstore.c:                            preemptible(), record->size, record->psi->buf);
drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
drivers/irqchip/irq-gic-v4.c:   WARN_ON(preemptible());
drivers/scsi/hisi_sas/hisi_sas_main.c:          if (!preemptible())
drivers/xen/time.c:     BUG_ON(preemptible());

That only looks like two drivers that need more than WARNectomies.

Although maybe rcu_read_load_sched_held() or rcu_read_lock_any_held()
might get called from a module ...
