From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Thu, 6 Feb 2020 13:49:35 +0530
Message-ID: <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vDZowM4nZqt58aEoBuLifwJ1YLS8pfkiXZ6ghEz4T1Q=; b=Q0QbVlCFUY+yo+
	zFG8z7sBepoJa0+5pGPx0rzRtZBoZTc+Kvq/3m5dqPGBysQklc19hXKNdRo/jQF6nyr8vvEFcT6Gw
	dSxNaBwJBtwpDeptdqq3k1VuDr9LKSAh6bs1Xprirto9giMy1tu9ny/M6y+I4Y9+hXjodsLcdfOU0
	lyeUlFlDlFWe5F7IHG8C+v7V3w4oSjo7eMB73uV2JXs/3ZvPJI3YaKTiUeDwcUPayQbb55P6Cu1gl
	BrgmcZuT8oTURSMNXNU3vWjBNof1wnIdxBfo3SV0PgAete7w9Jr8sMMYtOicmP3WCA0BXry24KtRw
	08wv9kePtEbmgh5Vr6ng==;
In-Reply-To: <202002060619.wEOdAZU1%lkp@intel.com>
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
To: kbuild test robot <lkp@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven Price <Steven.Price@arm.com>, Jason


On 02/06/2020 04:40 AM, kbuild test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on s390/features linus/master arc/for-next v5.5]
> [cannot apply to mmotm/master tip/x86/core arm64/for-next/core next-20200205]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-215507
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/pgtable-nopud.h:8:0,
>                     from arch/ia64/include/asm/pgtable.h:586,
>                     from include/linux/mm.h:99,
>                     from include/linux/highmem.h:8,
>                     from mm/debug_vm_pgtable.c:14:
>    mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
>>> include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implicit declaration of function '__pgd'; did you mean '__p4d'? [-Werror=implicit-function-declaration]
>     #define __pud(x)    ((pud_t) { __pgd(x) })
>                                    ^
>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>            ^~~~~
>>> include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: missing braces around initializer [-Wmissing-braces]
>     #define __pud(x)    ((pud_t) { __pgd(x) })
>                          ^
>>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
>      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
>            ^~~~~
>    cc1: some warnings being treated as errors

This build failure is expected now given that we have allowed DEBUG_VM_PGTABLE
with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. This problem
i.e build failure caused without a platform __pgd(), is known to exist both on
ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/2019/9/24/314
for details where this was discussed earlier.

- Anshuman

