From: Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Mon, 30 May 2022 20:29:30 +0200
Message-ID: <58b163b1-22ec-7634-dcd3-5a0a54adec45@linux.ibm.com>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
 <YpToVpjXmdFqGOpY@xz-m1.local> <YpTqNKMTt8PoA41n@xz-m1.local>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xZlshDnkVXDQAn6/6HTgFf8LD+x0DdjHZGrCQSIxfs8=; b=awNW7U5hQCdMXq
	Xml2yUkaOUKsJRwt5r31tTK021872O9AbT8zXE3WT/wQ5Vc4DfGgEciU7rChvMD3TGZgr7AMmn3qB
	ppU5yWTbYv6yUY8gKQbEEOoRFhm9+qzMGEAoETbiZwSm1VZJlY9c0BIS1W49QcbbGJQTw90/FcRpM
	f8GqD3QL+1Z4dsvwo+OEeX4eEadNTto1jHBPVk+Vp071WaFq5mGFcmeyMIpyOZhSSRlFPuWzTUj4C
	/y+46dhyZQL/rW8GYkxUJAZ9bEM/bMvJgsHhZVJBDx/PAvrDelZ2X2M74fnJXxdeXDg4VtllWUXW+
	7ASJgptW5t0PJ5A1S/Uw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=J3XEFiqlO85yR0rlrt+0Ucb3kcbo/uXfSzDk57v+UvI=;
 b=sK08a5JRQZv/pRZYSijJfgzCNWcnImFCMS1209YIqfs77/e2+DqGCKxKlBXdJgBmlco8
 lBUxmyGoc+OLGeLWYBYYR26O3FsvegFajhqOddNqC68LJDao5jNt43AilvT83QFtIU09
 ymysBZ+7yYvC1vU7jJWa8h114YLyiWf0mvxibmh4UXnXn2YZzAzo8CIdHOnqkmFzsY1r
 B+BMFqTlkhhhT5CMeGiBcg1sFURj8WmM61cUPcqTMXIorBEaBI5LTzeO9gIr7HvJfINf
 FIjGzFOAKcrEWvMA8wWWcaPvQrckVA5zWZJHRK+ah1+o9L5zMidx1M1UKYE9RYi3B87E oA== 
Content-Language: en-US
In-Reply-To: <YpTqNKMTt8PoA41n@xz-m1.local>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Xu <peterx@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, Ru



Am 30.05.22 um 18:00 schrieb Peter Xu:
> On Mon, May 30, 2022 at 11:52:54AM -0400, Peter Xu wrote:
>> On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
>>>
>>>
>>> Am 29.05.22 um 22:33 schrieb Heiko Carstens:
>>> [...]
>>>>
>>>> Guess the patch below on top of your patch is what we want.
>>>> Just for clarification: if gmap is not NULL then the process is a kvm
>>>> process. So, depending on the workload, this optimization makes sense.
>>>>
>>>> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
>>>> index 4608cc962ecf..e1d40ca341b7 100644
>>>> --- a/arch/s390/mm/fault.c
>>>> +++ b/arch/s390/mm/fault.c
>>>> @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>>>>    	/* The fault is fully completed (including releasing mmap lock) */
>>>>    	if (fault & VM_FAULT_COMPLETED) {
>>>> -		/*
>>>> -		 * Gmap will need the mmap lock again, so retake it.  TODO:
>>>> -		 * only conditionally take the lock when CONFIG_PGSTE set.
>>>> -		 */
>>>> -		mmap_read_lock(mm);
>>>> -		goto out_gmap;
>>>> +		if (gmap) {
>>>> +			mmap_read_lock(mm);
>>>> +			goto out_gmap;
>>>> +		}
>>>> +		goto out;
> 
> Hmm, right after I replied I found "goto out" could be problematic, since
> all s390 callers of do_exception() will assume it an error condition (side
> note: "goto out_gmap" contains one step to clear "fault" to 0).  I'll
> replace this with "return 0" instead if it looks good to both of you.
> 
> I'll wait for a confirmation before reposting.  Thanks,

Yes, that sounds good and thank you for double checking.
