From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 21/34] arm64: Convert various functions to use ptdescs
Date: Tue, 2 May 2023 09:48:46 +0800
Message-ID: <202305020914.OGRWcEG1-lkp@intel.com>
References: <20230501192829.17086-22-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682992170; x=1714528170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=atYvzhPCCZ/tytx2DE7s23i4jWidElWSRjsH6cc5aEY=;
  b=d23w+BzaWJAmUGLwsyxoKCGUVqfn2Pt0qCUmr3/0G6xkWQmWcU+pTkGI
   OFx4Sb/h5BLVPSvaiAeTMQBCj+D8iW4mRwTVYzONnxqdCsIagCOdjslyl
   +ETnfYsENbRk+pN80p7yZScGF9gkMFlKFM890osI4k03DnGywa11NZHcZ
   yFd3Uwl/Uk6BuXqZ/dc0rMUQfMVEn0F8SES92Lt+0EwpNasHQOiklwqnK
   Cu9Lr2iSQgpJScKCL6/vUHIv7/kucw/OvxSoT4cW5w31eWyXcF0B72vkm
   wxx2PrKsLL5bMnY/N+55z8TIbgyBDqILJQT9UYatpp+xH/ufnq2Tg6j26
   w==;
Content-Disposition: inline
In-Reply-To: <20230501192829.17086-22-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>

Hi Vishal,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20230428]
[cannot apply to s390/features powerpc/next powerpc/fixes geert-m68k/for-next geert-m68k/for-linus v6.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230502-033042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230501192829.17086-22-vishal.moola%40gmail.com
patch subject: [PATCH v2 21/34] arm64: Convert various functions to use ptdescs
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230502/202305020914.OGRWcEG1-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8e9481b63b5773d7c914836dcd7fbec2449902bc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/mm-Add-PAGE_TYPE_OP-folio-functions/20230502-033042
        git checkout 8e9481b63b5773d7c914836dcd7fbec2449902bc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305020914.OGRWcEG1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:21,
                    from include/linux/bitops.h:6,
                    from arch/arm64/include/asm/cache.h:39,
                    from include/linux/cache.h:6,
                    from arch/arm64/mm/mmu.c:9:
   arch/arm64/mm/mmu.c: In function 'pgd_pgtable_alloc':
>> arch/arm64/mm/mmu.c:440:24: error: invalid use of void expression
     440 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                        ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/arm64/mm/mmu.c:440:17: note: in expansion of macro 'BUG_ON'
     440 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                 ^~~~~~
   arch/arm64/mm/mmu.c:442:24: error: invalid use of void expression
     442 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                        ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   arch/arm64/mm/mmu.c:442:17: note: in expansion of macro 'BUG_ON'
     442 |                 BUG_ON(!ptdesc_pte_dtor(ptdesc));
         |                 ^~~~~~


vim +440 arch/arm64/mm/mmu.c

   425	
   426	static phys_addr_t pgd_pgtable_alloc(int shift)
   427	{
   428		phys_addr_t pa = __pgd_pgtable_alloc(shift);
   429		struct ptdesc *ptdesc = page_ptdesc(phys_to_page(pa));
   430	
   431		/*
   432		 * Call proper page table ctor in case later we need to
   433		 * call core mm functions like apply_to_page_range() on
   434		 * this pre-allocated page table.
   435		 *
   436		 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
   437		 * folded, and if so ptdesc_pte_dtor() becomes nop.
   438		 */
   439		if (shift == PAGE_SHIFT)
 > 440			BUG_ON(!ptdesc_pte_dtor(ptdesc));
   441		else if (shift == PMD_SHIFT)
   442			BUG_ON(!ptdesc_pte_dtor(ptdesc));
   443	
   444		return pa;
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
