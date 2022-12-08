From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable RFC 17/26] powerpc/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
Date: Thu, 8 Dec 2022 09:55:49 +0100
Message-ID: <c904aa67-1add-119c-162f-e35d8243a11a@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
 <20221206144730.163732-18-david@redhat.com>
 <8be167b6-3836-25c3-9f69-b8b3916ee5b4@csgroup.eu>
 <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670489755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
	b=QPFkG++A/8JL5La+pALQpMxgOwAt4ktwVCkc0B7GKmSOmsQdJwO6bUe02qtZHfivaxVdc3
	G9Wjgdcy6CTAaGzTr8Cckc2sdx+1EbdNMrC++y5ZAPBbYS5RMOrBZy9yOPYliW8bDkf1S/
	1Ay3qqX5PGov4onlFtRbv5LxaYRg05Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670489755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZzQND0XXn/ac1VVVRiwKzVF2wPIGejtH8QPoB1hHfA=;
	b=QPFkG++A/8JL5La+pALQpMxgOwAt4ktwVCkc0B7GKmSOmsQdJwO6bUe02qtZHfivaxVdc3
	G9Wjgdcy6CTAaGzTr8Cckc2sdx+1EbdNMrC++y5ZAPBbYS5RMOrBZy9yOPYliW8bDkf1S/
	1Ay3qqX5PGov4onlFtRbv5LxaYRg05Q=
In-Reply-To: <0b5b1303-8bcb-c19d-5f63-0e4a3517fea5@redhat.com>
Content-Language: en-US
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Nadav Amit <namit@vmware.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Andrea Arcangeli <aarcange@redhat.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Hugh Dickins <hughd@google.com>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>, "linux-snps-arc@lists.i
 nfradead.org" <linux-snps-arc@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <>

On 08.12.22 09:52, David Hildenbrand wrote:
> On 07.12.22 14:55, Christophe Leroy wrote:
>>
>>
>> Le 06/12/2022 à 15:47, David Hildenbrand a écrit :
>>> We already implemented support for 64bit book3s in commit bff9beaa2e80
>>> ("powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s")
>>>
>>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also in 32bit by reusing yet
>>> unused LSB 2 / MSB 29. There seems to be no real reason why that bit cannot
>>> be used, and reusing it avoids having to steal one bit from the swap
>>> offset.
>>>
>>> While at it, mask the type in __swp_entry().
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     arch/powerpc/include/asm/book3s/32/pgtable.h | 38 +++++++++++++++++---
>>>     1 file changed, 33 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> index 75823f39e042..8107835b38c1 100644
>>> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
>>> @@ -42,6 +42,9 @@
>>>     #define _PMD_PRESENT_MASK (PAGE_MASK)
>>>     #define _PMD_BAD	(~PAGE_MASK)
>>>     
>>> +/* We borrow the _PAGE_USER bit to store the exclusive marker in swap PTEs. */
>>> +#define _PAGE_SWP_EXCLUSIVE	_PAGE_USER
>>> +
>>>     /* And here we include common definitions */
>>>     
>>>     #define _PAGE_KERNEL_RO		0
>>> @@ -363,17 +366,42 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
>>>     #define pmd_page(pmd)		pfn_to_page(pmd_pfn(pmd))
>>>     
>>>     /*
>>> - * Encode and decode a swap entry.
>>> - * Note that the bits we use in a PTE for representing a swap entry
>>> - * must not include the _PAGE_PRESENT bit or the _PAGE_HASHPTE bit (if used).
>>> - *   -- paulus
>>> + * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
>>> + * are !pte_none() && !pte_present().
>>> + *
>>> + * Format of swap PTEs (32bit PTEs):
>>> + *
>>> + *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>>> + *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>>> + *   E H P <- type --> <----------------- offset ------------------>
>>
>> That's in reversed order. _PAGE_HASHPTE is bit 30 and should be on the
>> right hand side. Etc ...
> 
> Ugh, messed it up while converting back and forth between LSB 0 and MSB 0.
> 
> /*
>    * Format of swap PTEs (32bit PTEs):
>    *
>    *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
>    *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
>    *   <----------------- offset ------------------> <- type --> E H P
> 
> 

Still wrong, the type is only 5 bits:

+ * Format of swap PTEs (32bit PTEs):
+ *
+ *                         1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3
+ *   0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+ *   <----------------- offset --------------------> < type -> E H P
+ *


-- 
Thanks,

David / dhildenb

