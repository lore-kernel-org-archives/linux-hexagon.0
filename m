From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 10:40:44 +0100
Message-ID: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
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
	List-Owner; bh=Y0EgoPEkjEUEJ9OzeKbzTA31KG4D7bRIVqEx6N5A6/U=; b=c1QGJQXJX3mbiZ
	rwxGKurmsh/cu8Hvlr2Qc05IOQzM1chMUHaxhf/b/OXDY6YjdkQYTz0XtS7gbLAn9jGDWKCbu4/kI
	mTvw2xLgYrwLGOObNd8V0lw5bNhLF8u69wnc/mXqkZbaXqUTjK0HQu+oPwk8NZSvXPvZKQfTSiEum
	syH46qgKtx9it87bbuH5k0StU0JERhu+2gerBNKBdqmfTshnxEzEgakaTs44WFOj08/T7ZkHAgGyr
	TvDmNJz6jSud7w7WOdyBDrncUmH5NzZ9oJy814yTH6a+BXrPEKe99CM0qRprWWOPoj71mMRtmH3ON
	ZEn6f7NFoQUzOsSMtMbg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ghs6LH9pD2+Qt1fMHsHWX7VIkwjblgvPz91UThcXfc=; b=nNRXSHARKVBmPUa0LVuH1O7kS
 D/oHBcrwrbjjDaMI/I4qewdIuT/u+ArfVn2Q44kMxGKdqoZU4BrB2JiF0LZk1bGZZs9L580RjqEhj
 L/USBXhXhYD/MgwY5GbFdlv5b6PiOyMPil73fSwdB7H5xlLFS5BPFM67km0fFGywwBOAawYMifq1G
 HSHzGXev8QvIMVygJwKAVAp68/g6FyGSdabNsVYCSP3ClQnb39d/wPIfqLOWNXziE3BHkxIZYnbfz
 /l7StgJN3Z3/SLfPW5ugji1Mm5WmfSdNY0eEzYTydiDQebUNZUpbq0AD6mr1QzMtp4JGqmU6Lyx2E
 +SFo6yR3Q==;
Content-Disposition: inline
In-Reply-To: <20190211093601.GT32511@hirez.programming.kicks-ass.net>
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

On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > +{
> > +	long tmp;
> > +
> > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > +			return 1;
> 
> That really wants to be:
> 
> 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> 
> > +		}
> > +	}
> > +	return 0;
> > +}

Also, the is the one case where LL/SC can actually do 'better'. Do you
have benchmarks for say PowerPC or ARM64 ?
