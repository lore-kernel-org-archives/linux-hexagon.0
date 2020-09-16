From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [patch 03/13] preempt: Clenaup PREEMPT_COUNT leftovers
Date: Wed, 16 Sep 2020 11:56:01 +0100
Message-ID: <jhja6xq56ta.mognet@arm.com>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.268144917@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LFCwEHNC/mtHLc3IVHigcpM5jFcTTG7X3SmatzecfiE=; b=xuuDzakGtSrJR0yFd6YuQw9/C
	L6syd5imcjdLBVFTLUa8l6nuX+qSf169MSD3hwiiexDGLOT7JbJ0C4Wk+4Ftt+SFviq++WIaX2kJQ
	vzEnHMPdBfMQLkbQfTsq5tEqMnfWJV7+SX3jDWDztoKPNVa/yUZHBNwK7HsWBCWCevf3b3ZJI3f1G
	zXWYpazvzJ+DRP9SI6O8AppOCPy3upFuPNS1l7Mb3S9Mn8PvOX6c2SXOeA8xHswUSKGvQ6Qi40GVm
	RFoM1M7kGvJkGqrakM7oBSn9Tw11e8r5kaoZGUvV52V+raLzY99Ak0PQ8YhOyRhbzimtOtDFodM9p
	sZ0it025g==;
In-reply-to: <20200914204441.268144917@linutronix.de>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Matt Turner <mattst88@gmail.com>, intel-gfx@lists.freedesktop.org, linux-xtensa@lin


On 14/09/20 21:42, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
