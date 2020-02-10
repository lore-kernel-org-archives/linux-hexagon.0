From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V13] mm/debug: Add tests validating architecture page
 table helpers
Date: Sun, 9 Feb 2020 20:52:31 -0800
Message-ID: <20200209205231.44d098f8749e88190b8ba10c@linux-foundation.org>
References: <1580897674-16456-1-git-send-email-anshuman.khandual@arm.com>
 <202002060619.wEOdAZU1%lkp@intel.com>
 <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dxNE6KfNdrKrPBUAD0oyw0BqfdHFCx2rmv66T8Rkw5s=; b=qs+MzXNsXwh4IV
	YAwMjH+FSMBT+LZt3yunlfQo6ZXEXIfpEAhpWgZoMfvjlu9MZCwnlTSceHPk7PqxjlPTB+iHuxh+k
	djCL9xviZnAI80hSSJLP9QFxxnFRqZJQ3Ze+b9rQrz/xHuU8sWoNxbBOpKa2LuAqL015owfCMLzCf
	b1q1mW0WZXFOld7mmu7vaph2HCz5EOeHO/blHhZnL9W2PzpIrIJ1l1qUcyP4WmktdpksDafhJJzVR
	cThHT5Bu6XGMPe5VPbausz9FZfv4njsw7yuZDx12Xrc12AMVgcPusLd/vOenLAcdgCdFp0heCD9cL
	oloUepJK6qAeqMcpFp3g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581310354;
 bh=2W/dmgTJj6413Xr7wihmGcYdSzIEeuWsZRG1pj9rho0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fpI8skXkWSRkM2Z7t+IumpNpNlIyF35fF7t+yGEA67BDAAqSWhx6bv4mO/yn0SyDF
 TmUxgUc36bRm998D0NbvswNWlliaFKrJH88Mwv6jTUy1ILklfKpB9gT2jSQppuhH+2
 hH7M1ataalYtvJe9O809m6u56bYNF8WwzVrYPDcM=
In-Reply-To: <78d3ce6b-e100-2561-6b09-124c29731d1a@arm.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, James Hogan <jhogan@kernel.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-s390@vger.kernel.org, kbuild test robot <lkp@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <willy@infradead.org>, Steven

On Thu, 6 Feb 2020 13:49:35 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> 
> On 02/06/2020 04:40 AM, kbuild test robot wrote:
> > Hi Anshuman,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on powerpc/next]
> > [also build test ERROR on s390/features linus/master arc/for-next v5.5]
> > [cannot apply to mmotm/master tip/x86/core arm64/for-next/core next-20200205]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/mm-debug-Add-tests-validating-architecture-page-table-helpers/20200205-215507
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> > config: ia64-allmodconfig (attached as .config)
> > compiler: ia64-linux-gcc (GCC) 7.5.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.5.0 make.cross ARCH=ia64 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from include/asm-generic/pgtable-nopud.h:8:0,
> >                     from arch/ia64/include/asm/pgtable.h:586,
> >                     from include/linux/mm.h:99,
> >                     from include/linux/highmem.h:8,
> >                     from mm/debug_vm_pgtable.c:14:
> >    mm/debug_vm_pgtable.c: In function 'pud_clear_tests':
> >>> include/asm-generic/pgtable-nop4d-hack.h:47:32: error: implicit declaration of function '__pgd'; did you mean '__p4d'? [-Werror=implicit-function-declaration]
> >     #define __pud(x)    ((pud_t) { __pgd(x) })
> >                                    ^
> >>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
> >      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> >            ^~~~~
> >>> include/asm-generic/pgtable-nop4d-hack.h:47:22: warning: missing braces around initializer [-Wmissing-braces]
> >     #define __pud(x)    ((pud_t) { __pgd(x) })
> >                          ^
> >>> mm/debug_vm_pgtable.c:141:8: note: in expansion of macro '__pud'
> >      pud = __pud(pud_val(pud) | RANDOM_ORVALUE);
> >            ^~~~~
> >    cc1: some warnings being treated as errors
> 
> This build failure is expected now given that we have allowed DEBUG_VM_PGTABLE
> with EXPERT without platform requiring ARCH_HAS_DEBUG_VM_PGTABLE. This problem
> i.e build failure caused without a platform __pgd(), is known to exist both on
> ia64 and arm (32bit) platforms. Please refer https://lkml.org/lkml/2019/9/24/314
> for details where this was discussed earlier.
> 

I'd prefer not to merge a patch which is known to cause build
regressions.  Is there some temporary thing we can do to prevent these
errors until arch maintainers(?) get around to implementing the
long-term fixes?
