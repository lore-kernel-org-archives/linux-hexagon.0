From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Mon, 10 Feb 2020 11:05:37 +0530
Message-ID: <955229f7-f161-f720-0e75-a3163f63817d@arm.com>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
 <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jvymwFRZ/o+HWnM4U3Kt8dDQGzT1t/TMw+7HkQOMiAM=; b=HRtVmraxeQQC4J
	4THo/EPMydlWNCUoKleDsuWz+UvHAiI25dWe8XfI6FubmhD/jiVtDYv/VUMI8J5/YuQ6GDlG8iYk9
	O4Xt0/YK/8+fgVtXS1UEocV+a6uzsO7hnt0O8Z3QeLHZai/HMqYTC8K3Med+jP14MpH9RbGAkjeRs
	4NRLWnVlbLStncEjWD1EceJ+uU1eTJK9TeuoEdT5Lg1LJBFyQlDrvFg0pBleWB7MVsnaqT8zYsUgb
	wj/OYh24h7synSEyNL0FhUWfYGuJy1gw1E2qP5CrH5J4a5k0x2Yv2DIs7bCMzzhvUciZNa7JXeCiw
	RhUN/kFhJad5aAueY3zQ==;
In-Reply-To: <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven



On 02/10/2020 10:22 AM, Andrew Morton wrote:
> On Thu, 6 Feb 2020 13:49:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>
>> On 02/06/2020 04:40 AM, kbuild test robot wrote:
>>> Hi Anshuman,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on powerpc/next]
>>> [also build test ERROR on s390/features linus/master arc/for-next v5.5]
>>> [cannot apply to mmotm/master tip/x86/core arm64/for-next/core next-20200205]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-215507
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>>> config: ia64-allmodconfig (attached as .config)
>>> compiler: ia64-linux-gcc (GCC) 7.5.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>
>>> All error/warnings (new ones prefixed by >>):
>>>
>>>    In file included from include/asm-generic/pgtable-nopud.h:8:0,
>>>                     from arch/ia64/include/asm/pgtable.h:586,
>>>                     from include/linux/mm.h:99,
>>>                     from include/linux/highmem.h:8,
>>>                     from mm/debug_vm_pgtable.c:14:
>>>    mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
>>>>> include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implicit declaration of function '__pgd'; did you mean '__p4d'? [-Werror=implicit-function-declaration]
>>>     #define __pud(x)    ((pud_t) { __pgd(x) })
>>>                                    ^
>>>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>>>      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>>>            ^~~~~
>>>>> include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: missing braces around initializer [-Wmissing-braces]
>>>     #define __pud(x)    ((pud_t) { __pgd(x) })
>>>                          ^
>>>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>>>      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>>>            ^~~~~
>>>    cc1: some warnings being treated as errors
>>
>> This build failure is expected now given that we have allowed DEBUG_VM_PGTABLE
>> with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. This problem
>> i.e build failure caused without a platform __pgd(), is known to exist both on
>> ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/2019/9/24/314
>> for details where this was discussed earlier.
>>
> 
> I'd prefer not to merge a patch which is known to cause build
> regressions.  Is there some temporary thing we can do to prevent these
> errors until arch maintainers(?) get around to implementing the
> long-term fixes?

We could explicitly disable CONFIG_DEBUG_VM_PGTABLE on ia64 and arm platforms
which will ensure that others can still use the EXPERT path.

config DEBUG_VM_PGTABLE
	bool "Debug arch page table for semantics compliance"
	depends on MMU
	depends on !(IA64 || ARM)
	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
	default n if !ARCH_HAS_DEBUG_VM_PGTABLE
	default y if DEBUG_VM

