From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4] mm: Avoid unnecessary page fault retires on shared
 memory types
Date: Mon, 30 May 2022 12:00:52 -0400
Message-ID: <YpTqNKMTt8PoA41n@xz-m1.local>
References: <20220527193936.30678-1-peterx@redhat.com>
 <YpPYkzbrQmy4FjrI@osiris>
 <33fd4731-9765-d78b-bdc3-f8243c98e81f@linux.ibm.com>
 <YpToVpjXmdFqGOpY@xz-m1.local>
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
	List-Owner; bh=6fQFZKIn0aAHsEt/geMh3vNufZ47+6R+BsKfdpfiy3g=; b=dnbF/2e2g91Eqr
	mgNZYghPrUYP+R9PAvuq+AV2PH8A1wCQKk0UMKLGHxa0S7y8R2TNZoPai8E+LzxbnLSbFc92GR7jH
	E+kioaxFU2kKoD575eei11bnmIP8oaRGtmN6VOYpstSfOPx/02Rgo93VbpfiDFoRTQHPoELMye9Z6
	yqO6c3QzWWIuVU4Az71f3McpWNDApigETclemzMbUYUA2nPr5SZwRJ5A8rJheEXJoxgTLWdQzMc6E
	H/UJA7JqcazeVw9/1ngewLcQLAwl04EjgsLaK4P5MJNLf4zMN3I4mrbFCFdMFHhOuRCqJZwNAUjPA
	0i/iz1LdIfeGDrFrLxRQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1653926460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZWphZRcK3afyDhn+H8+iYAM34Y/wtF11YrAt0KXpqo=;
	b=OAlzTeE5V8IDemnaydPys11/ZrVI/qBW1DOX6CPplb5qXISrVW1Skgh7NUzAUpdX2Yqw/p
	pHKMJG+8Mdx/ufIWFXE5y5I8riDML3OEKL/xpQCxyErsRfUKjW22PRJZPOar4KJ4zfDQ61
	nAJEfPCcXlXGS1LH0+N1yZAXk2j7fts=
In-Reply-To: <YpToVpjXmdFqGOpY@xz-m1.local>
Content-Disposition: inline
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
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Will Deacon <will@kernel.org>, Matt Turner <mattst88@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@quicinc.com>, Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org, Alistair Popple <apopple@nvidia.com>, Jonas Bonn <jonas@southpole.se>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Rich Felker <dalias@libc.org>, sparclinux@vger.kernel.org, Russell King <linux@armlinux.org.uk>, David Hildenbrand <david@redhat.com>, Benjamin

On Mon, May 30, 2022 at 11:52:54AM -0400, Peter Xu wrote:
> On Mon, May 30, 2022 at 11:35:10AM +0200, Christian Borntraeger wrote:
> > 
> > 
> > Am 29.05.22 um 22:33 schrieb Heiko Carstens:
> > [...]
> > > 
> > > Guess the patch below on top of your patch is what we want.
> > > Just for clarification: if gmap is not NULL then the process is a kvm
> > > process. So, depending on the workload, this optimization makes sense.
> > > 
> > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > index 4608cc962ecf..e1d40ca341b7 100644
> > > --- a/arch/s390/mm/fault.c
> > > +++ b/arch/s390/mm/fault.c
> > > @@ -436,12 +436,11 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> > >   	/* The fault is fully completed (including releasing mmap lock) */
> > >   	if (fault & VM_FAULT_COMPLETED) {
> > > -		/*
> > > -		 * Gmap will need the mmap lock again, so retake it.  TODO:
> > > -		 * only conditionally take the lock when CONFIG_PGSTE set.
> > > -		 */
> > > -		mmap_read_lock(mm);
> > > -		goto out_gmap;
> > > +		if (gmap) {
> > > +			mmap_read_lock(mm);
> > > +			goto out_gmap;
> > > +		}
> > > +		goto out;

Hmm, right after I replied I found "goto out" could be problematic, since
all s390 callers of do_exception() will assume it an error condition (side
note: "goto out_gmap" contains one step to clear "fault" to 0).  I'll
replace this with "return 0" instead if it looks good to both of you.

I'll wait for a confirmation before reposting.  Thanks,

-- 
Peter Xu
