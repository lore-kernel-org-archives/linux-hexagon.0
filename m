From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Date: Wed, 31 Oct 2018 14:49:26 +0100
Message-ID: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IGq5rW/PZQIoQlw8gnTLK4zcZdfSlP7mi3YFgWOvSb8=; b=E33Im5U89TbCfD
	KcsnSxvuswGZ3zxwdfppUumfCdj0HenKK3IvCcSr4E1paaCHnhuWzg+9HGNkf5+JtdPbceBEGoyPW
	5U9x67bID1SXmeMFX6wDt+lerORNBLhbTXxXYsQDvF0ZHlTA5awhFROl+aOrYPXprsClxN+7PPpoJ
	HqnGS4kZ+9If5rYEEXDG/fLiA+9pvRc1sAayvkfOXGSoKMWXfNpzzuy3viVStKAMn7T1t1EVrWZRf
	7PHyO0dEC9s+9kvJghHSEFyxdTJn4y8zGlNIGWDDxwKyAtcocMaVhF5ZxvIrJu8ZrEYakAlctHJBU
	LoOhR6zmss60c+1ugQOg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B29CGHTcZSRPozCawRO0XQWdzdy7ZVHP04YQm6az4Fg=; b=2b5VPEDS93iezL40hzfFNdB2Q
 Q2oa5emouDWxBDM7YjtCvq3RBkzYU9UIAhg4JYT01GQFj0M0iqYO6+dBiwEGq2gzVWqL4Z17nzAIt
 /B6Mw8Pfum22SIv40RbXUlPzRuOIwFss6fTghn7UuDUfNBHGP4GEMz19SdWzpCc+WDfIaRdUB3sZG
 8GRBWpBKrxDu+ziq0SVvPyqxxbDYcWxfT0Xhih5/K0Vaud120bGBsU6fMFbNhViPxD4EkUUuEv0o8
 CiOgYuuGdLGodb+aXmisTm5i694FBlKVCPEwsGRkq6o6x7rywLw/sbA47HHO8UScG/QrmYyAFJMes
 335WGiv3w==;
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Douglas Anderson <dianders@chromium.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Thompson <daniel.thompson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net, James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org, Jason Wessel <jason.wessel@windriver.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.

You might want to mention that the only reason this isn't a deadlock
itself is because there is a timeout on waiting for the slaves to
check-in.

> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}
> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}
> +
>  /*
>   * Some architectures need cache flushes when we set/clear a
>   * breakpoint:
> @@ -993,6 +1027,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  		return -EBUSY;
>  	}
>  
> +	kgdb_generic_roundup_init();
> +
>  	if (new_dbg_io_ops->init) {
>  		err = new_dbg_io_ops->init();
>  		if (err) {

That's a little bit of overhead for those architectures not using that
generic code; but I suppose we can live with that.
