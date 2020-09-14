From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/13] uaccess: Clenaup PREEMPT_COUNT leftovers
Date: Mon, 14 Sep 2020 22:42:16 +0200
Message-ID: <20200914204441.686695987@linutronix.de>
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
	 bh=o1E89rV0arbbKZn+PusE1cP8rKvjj7Aml9GzR9cdGI0=; b=fq6ZIQAfFNYMmZRbhL9OfDarI
	F9Vl6KZOvUt3gEbMbIIfGKzO96jBxifwVaZKUL4DkUv1cyCMiRqN7Al4BauiMuheGZSE6Scj+YKV0
	KXBq+LW3LWsHtE21CQk1wZR2/OVAbGq+SmcSP8E76Lby5uw3d1Ul+5/X93ge8kyLyCkNZ6+sBesFF
	cIcFET4XBFgakcoqpKp6Q3jtPcjdnXrGzpRRfi4rIaKufLXQfXvDaSJIYSgWcZKfCjaW92+p/ZO2K
	5aO9+4fJkRkz+GikviCatBqMNGzjQjHM5lcaK7q1tXKLvPlphzY0Lae0oVlEgmk64UC8uTqcE/fUk
	f1jM3S1iw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1600116312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=RfxMqlPiepbkielPdHvAzLuC/W7nRAVZVsmDVELAHII=;
 b=pjt4ipoHz2SR+76u/tosh7gyPxQsg2oL/bqNd6MRCV4oI1z48eqv1u70tHD6lv8me21lrp
 r0nf9q7gfeNk/g6/mQbWoxxc6sgattZculBG7/CAEhhAosn3HO+ELh/5ZMKS01PZDGGPiV
 5UPGaI9uTL9WPM9r49P7uaq5wk95tawOQtkcIzkOz6iSKD5SsqVW8RpHISt5xAmsNGRf/s
 PwQDlz+dCOVfrDUrCEkzB0vPklJs8f3/2QV6ZG5w6yyAxtpbaqFGEafdnTlhe/mPuQGW/2
 aaWaJRqL/bLlqEm3DE9P4rm0Ldlt8ELtOtjbcIXqqOCzZO06YL/N5kw2xvNEHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1600116312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=RfxMqlPiepbkielPdHvAzLuC/W7nRAVZVsmDVELAHII=;
 b=KKlXvjmRL6XVp/lLKfPN8jJGOYdGr+dBLEzJxa2pQ6HTfXoVmCn9f/zEn0x26bRx145urU
 PFTkWVcFpRpLnPDg==
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
---
 include/linux/uaccess.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -230,9 +230,9 @@ static inline bool pagefault_disabled(vo
  *
  * This function should only be used by the fault handlers. Other users should
  * stick to pagefault_disabled().
- * Please NEVER use preempt_disable() to disable the fault handler. With
- * !CONFIG_PREEMPT_COUNT, this is like a NOP. So the handler won't be disabled.
- * in_atomic() will report different values based on !CONFIG_PREEMPT_COUNT.
+ *
+ * Please NEVER use preempt_disable() or local_irq_disable() to disable the
+ * fault handler.
  */
 #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
