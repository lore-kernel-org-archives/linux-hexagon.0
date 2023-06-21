From: kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Wed, 21 Jun 2023 10:15:39 +0800
Message-ID: <202306211030.DioMEPhl-lkp@intel.com>
References: <20230620131356.25440-3-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687313755; x=1718849755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6m8oZcodhtix0QwhxR/xmxGRXoNB5c0KxxyIl1Y1I6M=;
  b=HIZVnunCgibxfr0aDSLwDwILMB3r7PBEJnTZlNUSSZYzAU8qdOj/aFiU
   lrCplSfC07N/LAiYZ4LgYeeyZez7tZWpmvfeR6egCowGqgRbe4sIENNh6
   U/lVx7QaurWWGuW/+EqMZmGrWqrKu6Q30N11tdcSvCdPumWu1vrA5v6Bu
   JN75E2JGxejYEespY5e/pnlsuWsOPZv+fqGIEx+7M5yiJ7P6mHQ53zp4D
   14VNa1c6gyIQZOy/SVgvLN/7k3iCMqQmsB1Mf6S5wHFvJJsxhV+1HmyTS
   fmW3v17TIsJewrOWHh71BjQjiq2fJZTZpG3QXfDsG2N2pEdLvPd74aohk
   g==;
Content-Disposition: inline
In-Reply-To: <20230620131356.25440-3-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de, Baoquan He <bhe@redhat.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230620131356.25440-3-bhe%40redhat.com
patch subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211030.DioMEPhl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
