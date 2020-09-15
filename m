From: Will Deacon <will@kernel.org>
Subject: Re: [patch 06/13] locking/bitspinlock: Clenaup PREEMPT_COUNT leftovers
Date: Tue, 15 Sep 2020 17:10:48 +0100
Message-ID: <20200915161047.GA26745@willie-the-truck>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.579902354@linutronix.de>
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
	 bh=AReMtYx3l2j0u9mTqORf7nuIty+6nsrHn4acpWzVF4s=; b=pbo3GCG/3twoM6m3AfJIO/hYu
	zuFqd1eCAAhJoiKcTAVLeR1WBYJNo0Zt87kjciTOCt0p5+/UVaKmDcdD0AifoXJiyC5yP4no+RZMo
	yT9+i5CnFi4MuBSh66xxasfC7984nW/z4D2UsABbwMYQHajuclfmPqGkJab/cv3rYo3LW4/qtsLVP
	f2rBB2N02EFETrIt+frO+bJDPxnK6LgDSMLfqSO3ciKG2vZ59GHvvGTh+kizeq0I5r9QiUwvQFPOk
	gEfKVg2B9ALNluALixbM+osiWXXRgo4dLCG4SQbmNr+OzXdGJoPtM4vx2Ue5b0WbD/ATUjMMfzF2f
	3S4obo7uQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600186258;
 bh=h8FrMLmRYTR7EG3ov+53gJbd++NMD57LcgsrZ+W8Sok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sO86BqljD5TTUSf3Do5Tr23UIE8zY6Bz1UDtpNwChPTIbD5+keIeFFrqnf8XsRJr0
 ojiIAWWGP4t8b9bz6D3u0TyrwIrYQfCa/vsL1qeBTtNKTpMduZ7SEC4jTL9i3luICh
 OrDt1j8SFI8DM7C/qo2V0n/aLixXUHY994PZbfUw=
Content-Disposition: inline
In-Reply-To: <20200914204441.579902354@linutronix.de>
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
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>, dri-devel@lists.freedesktop.org, Ben Segall <bsegall@google.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-hexagon@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Brian Cain <bcain@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, David Airlie <airlied@linux.ie>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, intel-gfx@lists.freedesktop.org, Ma

On Mon, Sep 14, 2020 at 10:42:15PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/bit_spinlock.h |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int
>  {
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	return test_bit(bitnum, addr);
> -#elif defined CONFIG_PREEMPT_COUNT
> -	return preempt_count();
>  #else
> -	return 1;
> +	return preempt_count();
>  #endif

Acked-by: Will Deacon <will@kernel.org>

Will
