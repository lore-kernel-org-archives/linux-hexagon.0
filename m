From: Will Deacon <will@kernel.org>
Subject: Re: [patch 04/13] lockdep: Clenaup PREEMPT_COUNT leftovers
Date: Tue, 15 Sep 2020 17:11:05 +0100
Message-ID: <20200915161104.GB26745@willie-the-truck>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.375753691@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3Jd7O+XfzsDqTVWYpygNzFVs9DFP1rZHPA2BFHwIvb8=; b=SBWe+v2VD0Qoqd+qTE52nKOJU
	6ivL3t5mGaacpdQCyefztPIzdZlVxoOXAJDDRTEX0a1Da/UVFHRCpPtVqXmdrzDWg2FXnoRbFODZc
	mzrLIfgnnVcWy1/PEu/oAI2HdVXM8Z/omHMj3a5z0gR7j2O36QOsOzBNd+eu9gYbXPG/bFSENDMXZ
	LG0FyMuRnOrUzyt0Y4DWQQfDCbr8PdJNThtRBava1aYTVFirin6FddHjOfeZY9DSzbryDwumO8H7+
	1FXfc9fCBd8aB7hk0tLEf898NuzcvliOnSQKymffnb+mFWYKEPzLfTVa6R1xK1YssNZbBjIBCRt9b
	cTpsNfHWA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600186275;
 bh=UC1yh2hp7xYE271XAEDPNKg+J+sQcRAFlbeySxxF1fY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aLJBoJyZ2MbAregGNpzO/CAOq3qYqCUVYtw7hO4M7FduU8HInY48wZG+1gWntYelQ
 oLWO9tTjUONmPdC0nJ9es906NbinxDOlYlq9MiTPOxDMzJntQj9N/nuOqfyS1ru3ka
 TrV8du2f8kHA6eUDyUlEROxdTu8m4Jc0gLv8xEr4=
Content-Disposition: inline
In-Reply-To: <20200914204441.375753691@linutronix.de>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Matt Turner <mattst88@gmail.com>, Valentin

On Mon, Sep 14, 2020 at 10:42:13PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  include/linux/lockdep.h |    6 ++----
>  lib/Kconfig.debug       |    1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -585,16 +585,14 @@ do {									\
>  
>  #define lockdep_assert_preemption_enabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() != 0		||		\
>  		      !raw_cpu_read(hardirqs_enabled)));		\
>  } while (0)
>  
>  #define lockdep_assert_preemption_disabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() == 0		&&		\
>  		      raw_cpu_read(hardirqs_enabled)));			\
>  } while (0)
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1161,7 +1161,6 @@ config PROVE_LOCKING
>  	select DEBUG_RWSEMS
>  	select DEBUG_WW_MUTEX_SLOWPATH
>  	select DEBUG_LOCK_ALLOC
> -	select PREEMPT_COUNT
>  	select TRACE_IRQFLAGS
>  	default n
>  	help

Acked-by: Will Deacon <will@kernel.org>

Will
