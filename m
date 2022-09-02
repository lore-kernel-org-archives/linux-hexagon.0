From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [masahiroy-kbuild:kbuild 18/19] ld.lld: error:
 vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4): relocation
 R_HEX_B22_PCREL out of range: 2313184 is not in [-2097152, 2097151];
 references __vmnewmap
Date: Fri, 2 Sep 2022 08:08:03 -0700
Message-ID: <YxIcU9LW3OLHjAnm@dev-arch.thelio-3990X>
References: <202209020450.jH1ovepP-lkp@intel.com>
 <YxEoo8M++9tyaLOO@thelio-3990X>
 <CAK7LNAS9BtiQ8oSX+oOZ8Wewaed+p7Kj8kaObpVddBuR308Nww@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662131285;
        bh=xO8wxI5N3x/3nL9IXG1D9c8+CTbJsEtvXnnMKHgpngI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSHfQDZ4IVdwsFFGcyaN6sp7emXn9AYu/ulI/2q++SAvlmWN/WhNqA2XikoBsFIxL
         z02PVQL1E3F0NqiiwGkdVDidzgGcYeEpKA4oBVp7p47RN+qLv1GdcXbnIzqGtfJZcD
         wxO4sL4J2hLqW/UwVqHiJJoiP/YaAlWVscM06YfpqIXhQ8h6MKF9XWlRObYJX9MdOf
         6ccB5YMWZkG/IETFR26iPkE3/MztuFWl/csrHaCxGEVV7mnEVMRC8qiiRWjrMukDNp
         yR1sai+zQjYClu4ct2bhbm55A4f/XsOIF8a1F159V+l3oKFKz91FljzrP4bF+WGQDU
         h+nP+2rNPtGow==
Content-Disposition: inline
In-Reply-To: <CAK7LNAS9BtiQ8oSX+oOZ8Wewaed+p7Kj8kaObpVddBuR308Nww@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>, Brian Cain <bcain@quicinc.com>
Cc: kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org, clang-built-linux <llvm@lists.linux.dev>, linux-hexagon@vger.kernel.org

On Fri, Sep 02, 2022 at 09:36:33AM +0900, Masahiro Yamada wrote:
> On Fri, Sep 2, 2022 at 6:48 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > + Masahiro
> >
> > On Fri, Sep 02, 2022 at 04:41:09AM +0800, kernel test robot wrote:
> > > CC: linux-kbuild@vger.kernel.org
> > > TO: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Hi Masahiro,
> > >
> > > First bad commit (maybe != root cause):
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
> > > head:   67c0e0cf21cd5065fba45a6a00dd252ae4b9417a
> > > commit: 0b1de512cba77e11bdf0305264c56ab61b23b3e1 [18/19] kbuild: use obj-y instead extra-y for objects placed at the head
> > > config: hexagon-randconfig-r041-20220831 (https://download.01.org/0day-ci/archive/20220902/202209020450.jH1ovepP-lkp@intel.com/config)
> > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=0b1de512cba77e11bdf0305264c56ab61b23b3e1
> > >         git remote add masahiroy-kbuild https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> > >         git fetch --no-tags masahiroy-kbuild kbuild
> > >         git checkout 0b1de512cba77e11bdf0305264c56ab61b23b3e1
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4): relocation R_HEX_B22_PCREL out of range: 2313184 is not in [-2097152, 2097151]; references __vmnewmap
> > >    >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> > > --
> > > >> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x12c): relocation R_HEX_B22_PCREL out of range: 2313056 is not in [-2097152, 2097151]; references __vmsetvec
> > >    >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> > > --
> > > >> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160): relocation R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152, 2097151]; references memset
> > >    >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
> > >
> 
> 
> Thanks for the forwarding.
> 
> This is not a regression.
> 
> The hexagon was already broken.
> 
> It is just that it was deemed to be a new breakage
> due to slightly different error messages.

Thanks a lot for checking! Something for the Hexagon folks to look at
then.

The original report is at

https://lore.kernel.org/202209020450.jH1ovepP-lkp@intel.com/

with the original config file.

Cheers,
Nathan

> Compare the before/after.
> 
> 
> 
> 
> [Before]
> 
> 
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0xd4):
> relocation R_HEX_B22_PCREL out of range: 2313200 is not in [-2097152,
> 2097151]; references __vmnewmap
> >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x120):
> relocation R_HEX_B22_PCREL out of range: 2313124 is not in [-2097152,
> 2097151]; references __vmnewmap
> >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x12c):
> relocation R_HEX_B22_PCREL out of range: 2313072 is not in [-2097152,
> 2097151]; references __vmsetvec
> >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x160):
> relocation R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152,
> 2097151]; references memset
> >>> defined in ./built-in.a(arch/hexagon/lib/memset.o)
> make: *** [Makefile:1170: vmlinux] Error 1
> make: Target '__all' not remade because of errors.
> 
> 
> 
> 
> [After]
> 
>   LD      .tmp_vmlinux.kallsyms1
> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4):
> relocation R_HEX_B22_PCREL out of range: 2313200 is not in [-2097152,
> 2097151]; references __vmnewmap
> >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x120):
> relocation R_HEX_B22_PCREL out of range: 2313124 is not in [-2097152,
> 2097151]; references __vmnewmap
> >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x12c):
> relocation R_HEX_B22_PCREL out of range: 2313072 is not in [-2097152,
> 2097151]; references __vmsetvec
> >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> 
> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160):
> relocation R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152,
> 2097151]; references memset
> >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> make: *** [Makefile:1180: vmlinux] Error 1
> make: Target '__all' not remade because of errors.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
