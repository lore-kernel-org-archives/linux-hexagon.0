From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Wed, 21 Jun 2023 16:50:53 +0800
Message-ID: <ZJK57Uw5ZYQZY3d+@MiWiFi-R3L-srv>
References: <20230620131356.25440-3-bhe@redhat.com>
 <202306211030.DioMEPhl-lkp@intel.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687337470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwyBlKAjWWqC2ADnT8omvFeBUBts/JlKuShTUrNb9VA=;
        b=h20iv9wYPYvSFGu7F7OdU3enTI5FpTcuVfAcSySACC8rgW9IZ4Yd+t3MgKfj7JuvyQWOIN
        246q6J8W/oQ9tAw3icw0Jy48N9tVc8lIhzwEVDQ/UllE5gW83OAJCKMDu+amsLJn4hY8jt
        R4dM9hXizz+MAzhcfw8nk1qP4tWB5xs=
Content-Disposition: inline
In-Reply-To: <202306211030.DioMEPhl-lkp@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, hch@lst.de, christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com, deller@gmx.de, nathan@kernel.org, glaubitz@physik.fu-berlin.de, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

Hi,

On 06/21/23 at 10:15am, kernel test robot wrote:
> Hi Baoquan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/asm-generic-iomap-h-remove-ARCH_HAS_IOREMAP_xx-macros/20230620-212135
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230620131356.25440-3-bhe%40redhat.com
> patch subject: [PATCH v7 02/19] hexagon: mm: Convert to GENERIC_IOREMAP
> config: hexagon-randconfig-r041-20230620 (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211030.DioMEPhl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306211030.DioMEPhl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/hexagon/kernel/hexagon_ksyms.o: error: local symbol ioremap was exported

I followed steps in your reproduce link, didn't reproduce the error as
above line reported. I can still see those PCI_IOMAP warning, however
they will disappear when rebuilding. The clone3 warning can always ben
seen. I didn't see the symbol ioremap error. Could you double check if
anything missed in steps?

[root@dell-pem620-01 linux]# COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
Compiler will be installed in /root/0day
make --keep-going LLVM=1 CROSS_COMPILE=hexagon-linux- LLVM_IAS=1 --jobs=48 W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
make[1]: Entering directory '/root/linux/build_dir'
  GEN     Makefile
ld.lld: /lib64/libtinfo.so.6: no version information available (required by ld.lld)
tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files
  CALL    ../scripts/checksyscalls.sh
clang: /lib64/libtinfo.so.6: no version information available (required by clang)
<stdin>:1519:2: warning: syscall clone3 not implemented [-W#warnings]
 1519 | #warning syscall clone3 not implemented
      |  ^
1 warning generated.
make[1]: Leaving directory '/root/linux/build_dir'
[root@dell-pem620-01 linux]# 


