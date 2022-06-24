From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 02/26] mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
Date: Fri, 24 Jun 2022 11:41:30 +0530
Message-ID: <378e124f-914a-36b1-ff2f-9f4ea3b946a5@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-3-anshuman.khandual@arm.com>
 <d3676fce-2dc7-6331-66f5-7009ac45f605@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Language: en-US
In-Reply-To: <d3676fce-2dc7-6331-66f5-7009ac45f605@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "hch@infradead.org" <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vg>



On 6/24/22 10:58, Christophe Leroy wrote:
> 
> Le 24/06/2022 à 06:43, Anshuman Khandual a écrit :
>> This just converts the generic vm_get_page_prot() implementation into a new
>> macro i.e DECLARE_VM_GET_PAGE_PROT which later can be used across platforms
>> when enabling them with ARCH_HAS_VM_GET_PAGE_PROT. This does not create any
>> functional change.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   include/linux/mm.h | 8 ++++++++
>>   mm/mmap.c          | 6 +-----
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 47bfe038d46e..237828c2bae2 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -428,6 +428,14 @@ extern unsigned int kobjsize(const void *objp);
>>   extern pgprot_t protection_map[16];
>>   #endif
>>   
> I think the comment above protection_map[16] in mm/mmap.c should be 
> moved here.

Sure, makes sense. Will move.
