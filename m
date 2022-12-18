From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable RFC 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
Date: Sun, 18 Dec 2022 10:59:49 +0100
Message-ID: <b3b90a8e-16e9-a314-8531-e225f8a52817@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
 <CAAhV-H4bU7JnAPyf9Mv1m+WGR5NWmHJLva3d9_CsRd4Q_OHVpg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ppvk/OjA5FMxqKyVP5K1Ms+TigSxJLp6z9BxyLOMwL8=; b=lpVgBDL6u9n+oT
	24aZXEhYx0W3UEpPmbKc7WZW1QuvamtELMZEqRZYQED8/ZfM7pW1WzqC5AoHn8V7IC7Fg23kOwUM6
	QEZuibJXOcGsfkGyNgRJ7czlzpE55yip8LNcbrc5m6yvZHmXeIF9HI9gRc6gAPGSdFUqyjd7lIg9o
	rrrdiKzGrvLBc0jJ3hl6IwQnnijAIic8RjppINVfG18a4OgnBrLYDPPJ4a0lEky9yrXrM6tY4Wk5s
	MS0Vt6BI8Qmo7FlvMxZFKZvjL3RhNz45NZLH4ZmQdXpX9cfmG/RTbn448Ia7oFJN7ZMFYyDV9Elf+
	WSP1VQYHCJt3JPZURo4A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671357597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40GRUdlRAtUxb7WD8Kqf+Ugi5NyUS71hS5wP23U0j54=;
	b=UEwT+YI04qYOQFnWnlpG/AzKvHu0CGS1KpdTvfZjRr93KtehZJYALmVDj04zK0vbUwL1CZ
	b4WVuQy+yTO0ShZ44EiYIoV8YM1BNTx5FpGXoj38mMKC3ycuN0F8IfD960hmzV78oM0xnb
	NMzpcgbg25owVrISFS07RgOlp+rLt9c=
In-Reply-To: <CAAhV-H4bU7JnAPyf9Mv1m+WGR5NWmHJLva3d9_CsRd4Q_OHVpg@mail.gmail.com>
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
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 

On 18.12.22 04:32, Huacai Chen wrote:
> Hi, David,
> 
> What is the opposite of exclusive here? Shared or inclusive? I prefer
> pte_swp_mkshared() or pte_swp_mkinclusive() rather than
> pte_swp_clear_exclusive(). Existing examples: dirty/clean, young/old
> ...

Hi Huacai,

thanks for having a look!

Please note that this series doesn't add these primitives but merely 
implements them on all remaining architectures.

Having that said, the semantics are "exclusive" vs. "maybe shared", not 
"exclusive" vs. "shared" or sth. else. It would have to be 
pte_swp_mkmaybe_shared().


Note that this naming matches just the way we handle it for the other 
pte_swp_ flags we have, namely:

pte_swp_mksoft_dirty()
pte_swp_soft_dirty()
pte_swp_clear_soft_dirty()

and

pte_swp_mkuffd_wp()
pte_swp_uffd_wp()
pte_swp_clear_uffd_wp()


For example, we also (thankfully) didn't call it pte_mksoft_clean().
Grepping for "pte_swp.*soft_dirty" gives you the full picture.

Thanks!

David

> 
> Huacai
> 
> On Tue, Dec 6, 2022 at 10:48 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> This is the follow-up on [1]:
>>          [PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
>>          anonymous pages
>>
>> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
>> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
>> remaining architectures that support swap PTEs.
>>
>> This makes sure that exclusive anonymous pages will stay exclusive, even
>> after they were swapped out -- for example, making GUP R/W FOLL_GET of
>> anonymous pages reliable. Details can be found in [1].
>>
>> This primarily fixes remaining known O_DIRECT memory corruptions that can
>> happen on concurrent swapout, whereby we can lose DMA reads to a page
>> (modifying the user page by writing to it).
>>
>> To verify, there are two test cases (requiring swap space, obviously):
>> (1) The O_DIRECT+swapout test case [2] from Andrea. This test case tries
>>      triggering a race condition.
>> (2) My vmsplice() test case [3] that tries to detect if the exclusive
>>      marker was lost during swapout, not relying on a race condition.
>>
>>
>> For example, on 32bit x86 (with and without PAE), my test case fails
>> without these patches:
>>          $ ./test_swp_exclusive
>>          FAIL: page was replaced during COW
>> But succeeds with these patches:
>>          $ ./test_swp_exclusive
>>          PASS: page was not replaced during COW
>>
>>
>> Why implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all architectures, even
>> the ones where swap support might be in a questionable state? This is the
>> first step towards removing "readable_exclusive" migration entries, and
>> instead using pte_swp_exclusive() also with (readable) migration entries
>> instead (as suggested by Peter). The only missing piece for that is
>> supporting pmd_swp_exclusive() on relevant architectures with THP
>> migration support.
>>
>> As all relevant architectures now implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE,,
>> we can drop __HAVE_ARCH_PTE_SWP_EXCLUSIVE in the last patch.
>>
>>
>> RFC because some of the swap PTE layouts are really tricky and I really
>> need some feedback related to deciphering these layouts and "using yet
>> unused PTE bits in swap PTEs". I tried cross-compiling all relevant setups
>> (phew, I might only miss some power/nohash variants), but only tested on
>> x86 so far.
>>
>> CCing arch maintainers only on this cover letter and on the respective
>> patch(es).
>>
>>
>> [1] https://lkml.kernel.org/r/20220329164329.208407-1-david@redhat.com
>> [2] https://gitlab.com/aarcange/kernel-testcases-for-v5.11/-/blob/main/page_count_do_wp_page-swap.c
>> [3] https://gitlab.com/davidhildenbrand/scratchspace/-/blob/main/test_swp_exclusive.c
>>
>> David Hildenbrand (26):
>>    mm/debug_vm_pgtable: more pte_swp_exclusive() sanity checks
>>    alpha/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    arc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    arm/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    csky/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    hexagon/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    ia64/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    loongarch/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    m68k/mm: remove dummy __swp definitions for nommu
>>    m68k/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    mips/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    nios2/mm: refactor swap PTE layout
>>    nios2/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    openrisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    powerpc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit book3s
>>    powerpc/nohash/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    riscv/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    sh/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 32bit
>>    sparc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE on 64bit
>>    um/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    x86/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE also on 32bit
>>    xtensa/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>    mm: remove __HAVE_ARCH_PTE_SWP_EXCLUSIVE
>>
>>   arch/alpha/include/asm/pgtable.h              | 40 ++++++++-
>>   arch/arc/include/asm/pgtable-bits-arcv2.h     | 26 +++++-
>>   arch/arm/include/asm/pgtable-2level.h         |  3 +
>>   arch/arm/include/asm/pgtable-3level.h         |  3 +
>>   arch/arm/include/asm/pgtable.h                | 34 ++++++--
>>   arch/arm64/include/asm/pgtable.h              |  1 -
>>   arch/csky/abiv1/inc/abi/pgtable-bits.h        | 13 ++-
>>   arch/csky/abiv2/inc/abi/pgtable-bits.h        | 19 ++--
>>   arch/csky/include/asm/pgtable.h               | 17 ++++
>>   arch/hexagon/include/asm/pgtable.h            | 36 ++++++--
>>   arch/ia64/include/asm/pgtable.h               | 31 ++++++-
>>   arch/loongarch/include/asm/pgtable-bits.h     |  4 +
>>   arch/loongarch/include/asm/pgtable.h          | 38 +++++++-
>>   arch/m68k/include/asm/mcf_pgtable.h           | 35 +++++++-
>>   arch/m68k/include/asm/motorola_pgtable.h      | 37 +++++++-
>>   arch/m68k/include/asm/pgtable_no.h            |  6 --
>>   arch/m68k/include/asm/sun3_pgtable.h          | 38 +++++++-
>>   arch/microblaze/include/asm/pgtable.h         | 44 +++++++---
>>   arch/mips/include/asm/pgtable-32.h            | 86 ++++++++++++++++---
>>   arch/mips/include/asm/pgtable-64.h            | 23 ++++-
>>   arch/mips/include/asm/pgtable.h               | 35 ++++++++
>>   arch/nios2/include/asm/pgtable-bits.h         |  3 +
>>   arch/nios2/include/asm/pgtable.h              | 37 ++++++--
>>   arch/openrisc/include/asm/pgtable.h           | 40 +++++++--
>>   arch/parisc/include/asm/pgtable.h             | 40 ++++++++-
>>   arch/powerpc/include/asm/book3s/32/pgtable.h  | 37 ++++++--
>>   arch/powerpc/include/asm/book3s/64/pgtable.h  |  1 -
>>   arch/powerpc/include/asm/nohash/32/pgtable.h  | 22 +++--
>>   arch/powerpc/include/asm/nohash/32/pte-40x.h  |  6 +-
>>   arch/powerpc/include/asm/nohash/32/pte-44x.h  | 18 +---
>>   arch/powerpc/include/asm/nohash/32/pte-85xx.h |  4 +-
>>   arch/powerpc/include/asm/nohash/64/pgtable.h  | 24 +++++-
>>   arch/powerpc/include/asm/nohash/pgtable.h     | 15 ++++
>>   arch/powerpc/include/asm/nohash/pte-e500.h    |  1 -
>>   arch/riscv/include/asm/pgtable-bits.h         |  3 +
>>   arch/riscv/include/asm/pgtable.h              | 28 ++++--
>>   arch/s390/include/asm/pgtable.h               |  1 -
>>   arch/sh/include/asm/pgtable_32.h              | 53 +++++++++---
>>   arch/sparc/include/asm/pgtable_32.h           | 26 +++++-
>>   arch/sparc/include/asm/pgtable_64.h           | 37 +++++++-
>>   arch/sparc/include/asm/pgtsrmmu.h             | 14 +--
>>   arch/um/include/asm/pgtable.h                 | 36 +++++++-
>>   arch/x86/include/asm/pgtable-2level.h         | 26 ++++--
>>   arch/x86/include/asm/pgtable-3level.h         | 26 +++++-
>>   arch/x86/include/asm/pgtable.h                |  3 -
>>   arch/xtensa/include/asm/pgtable.h             | 31 +++++--
>>   include/linux/pgtable.h                       | 29 -------
>>   mm/debug_vm_pgtable.c                         | 25 +++++-
>>   mm/memory.c                                   |  4 -
>>   mm/rmap.c                                     | 11 ---
>>   50 files changed, 943 insertions(+), 227 deletions(-)
>>
>> --
>> 2.38.1
>>
>>
> 

-- 
Thanks,

David / dhildenb
