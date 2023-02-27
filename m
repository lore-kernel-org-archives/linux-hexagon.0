From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Mon, 27 Feb 2023 14:31:37 +0100
Message-ID: <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ADPVGeGClPAVjaK1NUKFiUQgXC09wruwct6yTF3m3c=; b=oBZI0rz4HyYKdW
	GBMU/jKVyT1Nf9RLSHYDZryqM5+Ua7SZ4q888mPQ2PwyPPTG1qstC0TACAIP3f6NV5kNZcyw1eklt
	Ua7aeNf8wPjKLnCJmAxOPnCexHuB+5Wu7LrUGadQkKh+zH9rh6AUJ8UodWE7tzvY9D+dTThPwEBOB
	l4OKfVS6MrGUbikoLynklDdsvo0yGwb5hpCXEX+K8oXo4G1XjG2TCVS2/2MXZVT0iyK8ybd6DU/jw
	gnnE5glq4EYOK0VTzOwfJVtNnECzjDiwXVLASQYlKf87/Izojsbqj1j9XYaxO1k+IgyORkoRH1mff
	+kQCHOsL3nHF3gZu/KNw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677504702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V+6qFC7OXniFoFqHVWKESI1xjQfVcOUspp9yumvENXI=;
	b=ex46fXXrhKmDPYEWGcB+af8vCe1J2IzZwA/e2KmgnAYszjSYEeJRhD0SpcUuO1qPy3fF9X
	XAUmcoTTxXm+25+CGrHsNBZUTmHTyITfycVgVEzyB9To6mrfHrZuTHv/h//7qCbivgE7jW
	G/8xMJixjPXbKePOGt18zoDHMoIkxVA=
In-Reply-To: <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Content-Language: en-US
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 

On 26.02.23 21:13, Geert Uytterhoeven wrote:
> Hi David,

Hi Geert,

> 
> On Fri, Jan 13, 2023 at 6:16 PM David Hildenbrand <david@redhat.com> wrote:
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
>> from the type. Generic MM currently only uses 5 bits for the type
>> (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.
>>
>> The shift by 2 when converting between PTE and arch-specific swap entry
>> makes the swap PTE layout a little bit harder to decipher.
>>
>> While at it, drop the comment from paulus---copy-and-paste leftover
>> from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
>> __swp_entry_to_pte() as well.
>>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Thanks for your patch, which is now commit b5c88f21531c3457
> ("microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") in
> 

Right, it went upstream, so we can only fixup.

>>   arch/m68k/include/asm/mcf_pgtable.h   |  4 +--
> 
> What is this m68k change doing here?
> Sorry for not noticing this earlier.

Thanks for the late review, still valuable :)

That hunk should have gone into the previous patch, looks like I messed 
that up when reworking.

> 
> Furthermore, several things below look strange to me...
> 
>>   arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
>>   2 files changed, 37 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
>> index 3f8f4d0e66dd..e573d7b649f7 100644
>> --- a/arch/m68k/include/asm/mcf_pgtable.h
>> +++ b/arch/m68k/include/asm/mcf_pgtable.h
>> @@ -46,8 +46,8 @@
>>   #define _CACHEMASK040          (~0x060)
>>   #define _PAGE_GLOBAL040                0x400   /* 68040 global bit, used for kva descs */
>>
>> -/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
>> -#define _PAGE_SWP_EXCLUSIVE    0x080
>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
>> +#define _PAGE_SWP_EXCLUSIVE    CF_PAGE_NOCACHE
> 
> CF_PAGE_NOCACHE is 0x80, so this is still bit 7, thus the new comment
> is wrong?

You're right, it's still bit 7 (and we use LSB-0 bit numbering in that 
file). I'll send a fixup.

> 
>>
>>   /*
>>    * Externally used page protection values.
>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
>> index 42f5988e998b..7e3de54bf426 100644
>> --- a/arch/microblaze/include/asm/pgtable.h
>> +++ b/arch/microblaze/include/asm/pgtable.h
>> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
>>    * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
>>    * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
>>    * zone.
>> - * - PRESENT *must* be in the bottom two bits because swap cache
>> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
>> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
>> - * is cleared in the TLB miss handler before the TLB entry is loaded.
>> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
>> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
>> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
>> + * before the TLB entry is loaded.
> 
> So the PowerPC 4xx comment is still here?

I only dropped the comment above __swp_type(). I guess you mean that we 
could also drop the "Because 4xx doesn't support SMP anyway, M is 
irrelevant so we borrow it for PAGE_PRESENT." sentence, correct? Not 
sure about the "Bit 30 is cleared in the TLB miss handler" comment, if 
that can similarly be dropped.

> 
>>    * - All other bits of the PTE are loaded into TLBLO without
>>    *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>>    * software PTE bits.  We actually use bits 21, 24, 25, and
>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>>   #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>>   #define _PMD_PRESENT   PAGE_MASK
>>
>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
> 
> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
> wrong?

In the example, I use MSB-0 bit numbering (which I determined to be 
correct in microblaze context eventually, but I got confused a couple a 
times because it's very inconsistent). That should be MSB-0 bit 24.

Thanks!

-- 
Thanks,

David / dhildenb
