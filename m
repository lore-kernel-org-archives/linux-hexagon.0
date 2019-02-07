From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH-tip 04/22] locking/rwsem: Remove arch specific rwsem files
Date: Thu, 7 Feb 2019 20:36:56 +0100
Message-ID: <20190207193656.GF32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-5-git-send-email-longman@redhat.com>
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
	List-Owner; bh=nNBFc1NYsFryYu/zO3q/ulJcPC86oPxJYUndQskAhR0=; b=IXJbYmifdItiML
	H4Cmn1ntLpzKkkGlRWlhdwzPe9FQ2J5wdge4Earc73JIWy9G14JMwIqHozNfobIJ/cr6V10OAR6Ka
	PTCGtkUEDXlq3sfu2HdHEK1c3Wn/3I6N3y71JkMoYWqnfjEjKPjJ5AWvSpmPcCbQBYUMT8GgYX15y
	wpBwLJPf6Om+LCoq4qVc5GODfTMIaVcVRX8MCXf0mAR0d9TWBVme4ro/nVA5GrMu3FxNSzv8EhyrG
	91BvPmJ4auwGVxZLgGmf+DUVTWDcUrzeIyH9OI/2DeNd0EE7fCz9gIbb0MY1v4L/k+GHjr5TwUKld
	h0pBoy6mVsVg3NHwpzWw==;
Content-Disposition: inline
In-Reply-To: <1549566446-27967-5-git-send-email-longman@redhat.com>
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
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

On Thu, Feb 07, 2019 at 02:07:08PM -0500, Waiman Long wrote:

> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +			return 1;
> +		}
> +	}

Nah, you're supposed to write that like:

	for (;;) {
		val = atomic_long_cond_read_relaxed(&sem->count, VAL < 0);
		if (atomic_long_try_cmpxchg_acquire(&sem->count, &val,
						    val + RWSEM_ACTIVE_READ_BIAS))
			break;
	}

> +	return 0;
> +}


Anyway, yuck, you're keeping all that BIAS nonsense :/ I was so hoping
for a rwsem implementation without that impenetrable crap.
