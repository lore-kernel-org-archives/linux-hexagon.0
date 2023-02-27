From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Mon, 27 Feb 2023 18:01:00 +0100
Message-ID: <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
 <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
 <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pULecaxGsved8kVuG+4C3aVdIvBI9HoCjSYpekN5FVc=; b=iTzhqNv4VHSg0z
	JW0MVrQdh3LZoruq50+wSlNlN+wqTeqD0Sy2m1IFyfYsJ9lAhZIfaiy7lOHXkqtD2SAQKe8iUaAVP
	oUxlKV00SqrGkYQIfcaqpVECMmT6b6Z4N+9d+IrIbfReAKCZ3jODYLzufhk4GaRmoKgo6mNF/rHWK
	uHYaX/lmhFn21yuqhSdqsK7RzFhs/eB1UNUKp+2uMi2v7dBD8lD49F3fGPv1ihkKWEE2vV3YoNkHK
	1UGsV49FLNmSLlPKUO446+hW1mMlrc4OU89aurxYjUpq2hL8ScLg8Px/ITIVdsdJhRKbC1ZfdV4Vh
	bb7fwCF6HDIdVTGAUmtA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677517265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+gj+IVlpRNML/WhRdwS5WpJ1kIzGGA+IXuZi3TvglQ=;
	b=hZbv/DyXN+dDQWBq8tkLFX2xUPVqinzFEYtmZbopWmpiFpKpMGGQpD5RtkVhMWBdYaO/sJ
	4RyEeL2oNkcTIj5EZsLcpRg//Wf7p9ZW6a17i6lSoYqta4DdZZMY+1EGZ3EVfAj19mjopB
	KEBG0zd9kNTOvzGczzohPY/iLYINCcI=
In-Reply-To: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
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

>>>>    /*
>>>>     * Externally used page protection values.
>>>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
>>>> index 42f5988e998b..7e3de54bf426 100644
>>>> --- a/arch/microblaze/include/asm/pgtable.h
>>>> +++ b/arch/microblaze/include/asm/pgtable.h
>>>> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
>>>>     * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
>>>>     * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
>>>>     * zone.
>>>> - * - PRESENT *must* be in the bottom two bits because swap cache
>>>> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
>>>> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
>>>> - * is cleared in the TLB miss handler before the TLB entry is loaded.
>>>> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
>>>> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
>>>> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
>>>> + * before the TLB entry is loaded.
>>>
>>> So the PowerPC 4xx comment is still here?
>>
>> I only dropped the comment above __swp_type(). I guess you mean that we
>> could also drop the "Because 4xx doesn't support SMP anyway, M is
>> irrelevant so we borrow it for PAGE_PRESENT." sentence, correct? Not
> 
> Yes, that's what I meant.
> 
>> sure about the "Bit 30 is cleared in the TLB miss handler" comment, if
>> that can similarly be dropped.
> 
> No idea, didn't check. But if it was copied from PPC, chances are
> high it's no longer true....

I'll have a look.

> 
>>>>     * - All other bits of the PTE are loaded into TLBLO without
>>>>     *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>>>>     * software PTE bits.  We actually use bits 21, 24, 25, and
>>>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>>>>    #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>>>>    #define _PMD_PRESENT   PAGE_MASK
>>>>
>>>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
>>>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
>>>
>>> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
>>> wrong?
>>
>> In the example, I use MSB-0 bit numbering (which I determined to be
>> correct in microblaze context eventually, but I got confused a couple a
>> times because it's very inconsistent). That should be MSB-0 bit 24.
> 
> Thanks, TIL microblaze uses IBM bit numbering...

I assume IBM bit numbering corresponds to MSB-0 bit numbering, correct?


I recall that I used the comment above "/* Definitions for MicroBlaze. 
*/" as an orientation.

0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G


So ... either we adjust both or we leave it as is. (again, depends on 
what the right thing to to is -- which I don't know :) )

-- 
Thanks,

David / dhildenb
