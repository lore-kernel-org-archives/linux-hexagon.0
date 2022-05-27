From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Fri, 27 May 2022 12:46:31 +0200
Message-ID: <YpCsBwFArieTpvg2@gmail.com>
References: <20220524234531.1949-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=47i+0uT2HqlxUZF0qinCS+6HQPb+VCxF4jmzUSqdgJM=; b=HmBEiYbuNlU/U1
	fso0v5kOz6Y7beIbTteqqLUEu02mTIIuGuY34eEaSCz5dHAl8PDMf/TbNJmZ5A31ZkQeDwNEIIsKT
	Z/SGTYXgvj2QCuNdBPsmii9qlkLKycgN48u0gOlQrqMHjW3O5w8mblHIERsLadJfzssKUrrFcCWuo
	Wg6pTvnadd6/7bTsYt6BI1Uer+4FfnvzrenyHDX+FotZzi+P7+5OuzAj2UMVsVKfhMAVYtSLTxAW6
	wTxJXresqHxr9lwIlTvFmtYzIho//ggBEz+wuXKDEk2alZy8buF5IKS3N8kue0FG/BK9P+ZnAm3I1
	8dEcRsqLFD7OqyY3VOpA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VEAekRrz/FSY4pk4QnV3m6H5QVjhz8BFDYr0EcpVw1E=;
        b=nXTl96gpCDbYy3bbmZHUFxanwBKanpTD5T3ye91nNt0S5DzRS50X+C3V5calou/Tbd
         W3tp+Pa5ui5nyk/J9IilzxqUhKzX+QyGcukjZk0ELfa/RtKrZMaq9i+yE1j0RcYeHGEH
         V+4RtLXDWPxnAymJMfcVpu0JZEZoxenwNXkmgyYKMQXGnN1Ls7NkOSx9TgW4IEazH0HS
         TOy4lNsQjFRd71dz5D/Ux8BGGU+UgNurAc7P2zcBMC8bJFwbS5pJWekOq461oc+DsRDd
         eh87WbfBiCTIu2NxwA+S3LoC7J0WxrnESI1Jt77XHjKjToAke3bka2tT28oXpFfiDYxk
         GFbg==
Content-Disposition: inline
In-Reply-To: <20220524234531.1949-1-peterx@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Matt Turner <mattst88@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>, Michal Simek <monstr@monstr.eu>, Russell King <linux@armlinux.org.uk>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-riscv@lists.infradead.org, Alexander Gordeev <agordeev@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonas Bonn <jonas@southpole.se>, Will Deacon <will@kernel.org>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "H . Peter Anvin" <hpa@zytor.com>, Andrea Arcangeli <aarcange@redhat.com>, openrisc@lists.librecores.org, linux-s390@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-m68k@lists.linux-m68k.org, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Peter


* Peter Xu <peterx@redhat.com> wrote:

> This patch provides a ~12% perf boost on my aarch64 test VM with a simple
> program sequentially dirtying 400MB shmem file being mmap()ed and these are
> the time it needs:
>
>   Before: 650.980 ms (+-1.94%)
>   After:  569.396 ms (+-1.38%)

Nice!

>  arch/x86/mm/fault.c           |  4 ++++

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Minor comment typo:

> +		/*
> +		 * We should do the same as VM_FAULT_RETRY, but let's not
> +		 * return -EBUSY since that's not reflecting the reality on
> +		 * what has happened - we've just fully completed a page
> +		 * fault, with the mmap lock released.  Use -EAGAIN to show
> +		 * that we want to take the mmap lock _again_.
> +		 */

s/reflecting the reality on what has happened
 /reflecting the reality of what has happened

>  	ret = handle_mm_fault(vma, address, fault_flags, NULL);
> +
> +	if (ret & VM_FAULT_COMPLETED) {
> +		/*
> +		 * NOTE: it's a pity that we need to retake the lock here
> +		 * to pair with the unlock() in the callers. Ideally we
> +		 * could tell the callers so they do not need to unlock.
> +		 */
> +		mmap_read_lock(mm);
> +		*unlocked = true;
> +		return 0;

Indeed that's a pity - I guess more performance could be gained here, 
especially in highly parallel threaded workloads?

Thanks,

	Ingo
