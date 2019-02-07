From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH-tip 15/22] locking/rwsem: Merge owner into count on x86-64
Date: Thu, 7 Feb 2019 20:45:42 +0100
Message-ID: <20190207194542.GG32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-16-git-send-email-longman@redhat.com>
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
	List-Owner; bh=qJ4R4vKR5Gh3TUQ3aR+hUsBRzfAA3J2RckeljmJSAzU=; b=kz++8QFGUz+34b
	LQLDKTGHCj1zjdmo5ad3IsZ1VnNeLXoiol0j4xUrEHL1zPS0a0WlBEmpX7QNLebFlM4zyntiwJQRJ
	fsmNTjJGkfLracSEyFf5wMWh7EaKv4vKgRKU5HXGEWIQJefQwkq9vpVj1V5hBi/D+Nhr/HfSmHSBo
	hclevqIlWDC72LTt3ac/nWXrWJWf/mgkh4kDptvK++SwHXC7q7FVAGiU8YIVMWaYAZApekr2I5iv4
	pGysHU+EdUCZw6F3a/AOibRnRruX02uSAOK9At65OurqOaKw+d8ezC80oPOEBJUCpSE1Ip8pwXv53
	zMsSyR9KwSRtNvBUThjA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d2Auinqj+iinWuACUh1zWQLvdx+uvY34M1d8kVvscRo=; b=GD6MNJTH7ahxODIJwjMRtXdnR
 RGD+hw9J+ZDL8sz/xbv/d7Zqgil1ESzAyfO7J6vTAR0eOBQbKA+2n1dr0BkrZrWBaHsHiinLNErB3
 g+h3oZHOrxMVq84OJ9xWE4MvvJNsJ7gMZziSCkHMHlorLYek/Ay+0h+X4Ff02okQAYSM9Q9kbsEYG
 sP6vzRH/Aw3OMOnEjV905Mx2248RvsaFgDw5pfYmQN1OH4MoKxYYnGwKbb1rQt3d/GT/GYTWx5Omh
 KzbHIoABiKb148eXjHvwxsrvCmrg26erty1ERFcwZ5kSKWjGzDj0O5Sh8u0FqWgxN6v7ekPCAzKqa
 wmJhspFPg==;
Content-Disposition: inline
In-Reply-To: <1549566446-27967-16-git-send-email-longman@redhat.com>
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

On Thu, Feb 07, 2019 at 02:07:19PM -0500, Waiman Long wrote:
> On 32-bit architectures, there aren't enough bits to hold both.
> 64-bit architectures, however, can have enough bits to do that. For
> x86-64, the physical address can use up to 52 bits. That is 4PB of
> memory. That leaves 12 bits available for other use. The task structure
> pointer is also aligned to the L1 cache size. That means another 6 bits
> (64 bytes cacheline) will be available. Reserving 2 bits for status
> flags, we will have 16 bits for the reader count.  That can supports
> up to (64k-1) readers.

*groan*...

So take qrwlock's idea for a queue, then make the count value (similar
to the new mutex); that is have a bit0 be a r/w bit, when w bits 6-N are
owner, when r they are reader-count. bit1 can be a pending bit, bit2 a
handoff bit etc..

That should fit and work on 32bit and 64bit without issue.

I have a half-arsed rwsem-atomic.c somewhere that does just that. I just
never got around to doing all the optimistic spin and steal crap that
makes our current rwsem fly.

And that nicely gets rid of that mind bending BIAS crud.
