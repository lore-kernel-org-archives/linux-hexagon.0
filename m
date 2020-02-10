From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Mon, 10 Feb 2020 11:46:23 +0100
Message-ID: <7cb3a5bb-eaea-a01c-4047-e3c000b7ad1d@c-s.fr>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
 <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
 <955229f7-f161-f720-0e75-a3163f63817d@arm.com>
 <aef1048f-68c4-d14f-e669-8f288ba9ac7a@c-s.fr>
 <20200210100200.GB25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3VdT8leEAlfSLQpPQKoxenZVPWjYs1yN+U09thgTRJA=; b=Q4Nz7P5o1dkqXf
	CnqA7NtxI1vbGS477frKK8n56twajPJ1xuHZYYE5nDauUSUPBdoxJ40v4S20x3Fwf/3PPrKlXKQl6
	QoyAKLZYfUpy8vVSiD/uwXRYpkYz6pJa0+sfoZLFscj5W4H539DEG2Kg8mZ301tmIfZ8qh5dXmCzO
	4pcWIfXAzfLEnTQmRWHkRf/nXYwHohsS/jQZ5pv6gvSZeK7UefGkHKYAhHsRp3NjE0P29C0Hf+TqB
	PFAqOVWCkqBkfcdafBHb2rcRBlaCM3AQF9ppQVnwLnla4SzCw2w8Mhy26u8lPn/iihix9LrthyMjq
	u17RxGuyQ32UT8RBJtnQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1581331585; bh=3VdT8leEAlfSLQpPQKoxenZVPWjYs1yN+U09thgTRJA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RdSNVpl3eRdV3gPJ7XDvUegm6wZGug8ejVpKq74HLxDjFS3pwYqC+BZGFoUQ1Oq78
 SVulkxR8i/NmQfPxXj9q1ZP6MDJ4/eVa8ThwXr9rdv9XZ0ODywoTCAXN5cQTc5KVGa
 aEm6pzX4mgbIsgNXEcKTlXONuuV1vYFncq9hDwgQ=
In-Reply-To: <20200210100200.GB25745@shell.armlinux.org.uk>
Content-Language: fr
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Geert Uytterhoeven <geert@linux-m6>



Le 10/02/2020 à 11:02, Russell King - ARM Linux admin a écrit :
> On Mon, Feb 10, 2020 at 07:38:38AM +0100, Christophe Leroy wrote:
>>
>>
>> Le 10/02/2020 à 06:35, Anshuman Khandual a écrit :
>>>
>>>
>>> On 02/10/2020 10:22 AM, Andrew Morton wrote:
>>>> On Thu, 6 Feb 2020 13:49:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>>>
>>>>> On 02/06/2020 04:40 AM, kbuild test robot wrote:
>>>>>> Hi Anshuman,
>>>>>>
>>>>>> Thank you for the patch! Yet something to improve:
>>>>>>
>>>>>> [auto build test ERROR on powerpc/next]
>>>>>> [also build test ERROR on s390/features linus/master arc/for-next v5.5]
>>>>>> [cannot apply to mmotm/master tip/x86/core arm64/for-next/core next-20200205]
>>>>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>>>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>>>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>>>>
>>>>>> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-215507
>>>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>>>>>> config: ia64-allmodconfig (attached as .config)
>>>>>> compiler: ia64-linux-gcc (GCC) 7.5.0
>>>>>> reproduce:
>>>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>           chmod +x ~/bin/make.cross
>>>>>>           # save the attached .config to linux build tree
>>>>>>           GCC_VERSION=7.5.0 make.cross ARCH=ia64
>>>>>>
>>>>>> If you fix the issue, kindly add following tag
>>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>>
>>>>>> All error/warnings (new ones prefixed by >>):
>>>>>>
>>>>>>      In file included from include/asm-generic/pgtable-nopud.h:8:0,
>>>>>>                       from arch/ia64/include/asm/pgtable.h:586,
>>>>>>                       from include/linux/mm.h:99,
>>>>>>                       from include/linux/highmem.h:8,
>>>>>>                       from mm/debug_vm_pgtable.c:14:
>>>>>>      mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
>>>>>>>> include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implicit declaration of function '__pgd'; did you mean '__p4d'? [-Werror=implicit-function-declaration]
>>>>>>       #define __pud(x)    ((pud_t) { __pgd(x) })
>>>>>>                                      ^
>>>>>>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>>>>>>        pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>>>>>>              ^~~~~
>>>>>>>> include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: missing braces around initializer [-Wmissing-braces]
>>>>>>       #define __pud(x)    ((pud_t) { __pgd(x) })
>>>>>>                            ^
>>>>>>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>>>>>>        pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>>>>>>              ^~~~~
>>>>>>      cc1: some warnings being treated as errors
>>>>>
>>>>> This build failure is expected now given that we have allowed DEBUG_VM_PGTABLE
>>>>> with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. This problem
>>>>> i.e build failure caused without a platform __pgd(), is known to exist both on
>>>>> ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/2019/9/24/314
>>>>> for details where this was discussed earlier.
>>>>>
>>>>
>>>> I'd prefer not to merge a patch which is known to cause build
>>>> regressions.  Is there some temporary thing we can do to prevent these
>>>> errors until arch maintainers(?) get around to implementing the
>>>> long-term fixes?
>>>
>>> We could explicitly disable CONFIG_DEBUG_VM_PGTABLE on ia64 and arm platforms
>>> which will ensure that others can still use the EXPERT path.
>>>
>>> config DEBUG_VM_PGTABLE
>>> 	bool "Debug arch page table for semantics compliance"
>>> 	depends on MMU
>>> 	depends on !(IA64 || ARM)
>>> 	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>> 	default n if !ARCH_HAS_DEBUG_VM_PGTABLE
>>> 	default y if DEBUG_VM
>>>
>>
>> On both ia32 and arm, the fix is trivial.
>>
>> Can we include the fix within this patch, just the same way as the
>> mm_p4d_folded() fix for x86 ?
> 
> Why should arm include a macro for something that nothing (apart from
> this checker) requires?  If the checker requires it but the rest of
> the kernel does not, it suggests that the checker isn't actually
> correct, and the results can't be relied upon.
> 

As far as I can see, the problem is that arm opencodes part of the API 
instead of including asm-generic/pgtable-nopmd.h

Here, the ARM has 2 levels, ie only PGD and PTE. But instead of defining 
__pgd and __pte and getting everything else from asm-generic, it defines 
a __pmd then redefines the folded levels like the pud, etc ...

That's exactly what the checker aims at detecting: architectures than do 
not properly use the standard linux page table structures.

Christophe

