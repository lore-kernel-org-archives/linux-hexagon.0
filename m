From: Brian Cain <bcain@quicinc.com>
Subject: RE: [masahiroy-kbuild:kbuild 18/19] ld.lld: error:
 vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4): relocation
 R_HEX_B22_PCREL out of range: 2313184 is not in [-2097152, 2097151];
 references __vmnewmap
Date: Mon, 5 Sep 2022 17:04:12 +0000
Message-ID: <SN6PR02MB4205AEC82D37030BE689CE02B87F9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <202209020450.jH1ovepP-lkp@intel.com>
 <YxEoo8M++9tyaLOO@thelio-3990X>
 <CAK7LNAS9BtiQ8oSX+oOZ8Wewaed+p7Kj8kaObpVddBuR308Nww@mail.gmail.com>
 <YxIcU9LW3OLHjAnm@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=jAZ8hEouHUmpEOd9jJyhOEBbcm5aqh1HFxKxfOCiwUo=;
 b=f7ZyJa/ZiRm/fnpIS9USG10XyJH+ryrCl74C6P9S3U4cJsSEF9FrpHEigB6JIg77OMO9
 vToWzFv2uL3IF+fLNJIs2dJkjYQvKY5H0IZG4rxnSVr86WyeKYcv3FaLEY5URcD+Coj4
 WSuWX3rm/4NYbZxCk6ly/7cfqhpmHFnRly1c1o0p6mjfW9dfn5mdk183g2RmrkIRMRpM
 4Dx9ZdTeS60q4E22b8XMsUFJxawDb0CmNg5hyL5x4H+Q6yG6OP2kxpngQcvFifBfmBwp
 pZU0PBpGEZ82dtfSgCIifOCmpjXMV8tEhIe7OOqPT87TAhxVVG7+uo5Jxvi0xPCvwX1V kA== 
In-Reply-To: <YxIcU9LW3OLHjAnm@dev-arch.thelio-3990X>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Sid Manning <sidneym@quicinc.com>
Cc: kernel test robot <lkp@intel.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, clang-built-linux <llvm@lists.linux.dev>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Friday, September 2, 2022 10:08 AM
> To: Masahiro Yamada <masahiroy@kernel.org>; Brian Cain
> <bcain@quicinc.com>
> Cc: kernel test robot <lkp@intel.com>; kbuild-all@lists.01.org; clang-bui=
lt-linux
> <llvm@lists.linux.dev>; linux-hexagon@vger.kernel.org
> Subject: Re: [masahiroy-kbuild:kbuild 18/19] ld.lld: error:
> vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4): relocation
> R_HEX_B22_PCREL out of range: 2313184 is not in [-2097152, 2097151];
> references __vmnewmap
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> On Fri, Sep 02, 2022 at 09:36:33AM +0900, Masahiro Yamada wrote:
> > On Fri, Sep 2, 2022 at 6:48 AM Nathan Chancellor <nathan@kernel.org>
> wrote:
> > >
> > > + Masahiro
> > >
> > > On Fri, Sep 02, 2022 at 04:41:09AM +0800, kernel test robot wrote:
> > > > CC: linux-kbuild@vger.kernel.org
> > > > TO: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > Hi Masahiro,
> > > >
> > > > First bad commit (maybe !=3D root cause):
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/l=
inux-
> kbuild.git kbuild
> > > > head:   67c0e0cf21cd5065fba45a6a00dd252ae4b9417a
> > > > commit: 0b1de512cba77e11bdf0305264c56ab61b23b3e1 [18/19] kbuild:
> use obj-y instead extra-y for objects placed at the head
> > > > config: hexagon-randconfig-r041-20220831
> (https://download.01.org/0day-
> ci/archive/20220902/202209020450.jH1ovepP-lkp@intel.com/config)
> > > > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-projec=
t
> c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> > > > reproduce (this is a W=3D1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy=
/linux-
> kbuild.git/commit/?id=3D0b1de512cba77e11bdf0305264c56ab61b23b3e1
> > > >         git remote add masahiroy-kbuild
> https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.gi=
t
> > > >         git fetch --no-tags masahiroy-kbuild kbuild
> > > >         git checkout 0b1de512cba77e11bdf0305264c56ab61b23b3e1
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang
> make.cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash
> > > >
> > > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > > >> ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text=
+0xd4):
> relocation R_HEX_B22_PCREL out of range: 2313184 is not in [-2097152,
> 2097151]; references __vmnewmap
> > > >    >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> > > > --
> > > > >> ld.lld: error:
> vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x12c): relocation
> R_HEX_B22_PCREL out of range: 2313056 is not in [-2097152, 2097151];
> references __vmsetvec
> > > >    >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> > > > --
> > > > >> ld.lld: error:
> vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160): relocation
> R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152, 2097151];
> references memset
> > > >    >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://01.org/lkp
> > > >
> >
> >
> > Thanks for the forwarding.
> >
> > This is not a regression.
> >
> > The hexagon was already broken.
> >
> > It is just that it was deemed to be a new breakage
> > due to slightly different error messages.
>=20
> Thanks a lot for checking! Something for the Hexagon folks to look at
> then.

Thanks Yamada-san and Nathan.  We are investigating this and will report ba=
ck.

>=20
> The original report is at
>=20
> https://lore.kernel.org/202209020450.jH1ovepP-lkp@intel.com/
>=20
> with the original config file.
>=20
> Cheers,
> Nathan
>=20
> > Compare the before/after.
> >
> >
> >
> >
> > [Before]
> >
> >
> >   LD      .tmp_vmlinux.kallsyms1
> > ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0xd4):
> > relocation R_HEX_B22_PCREL out of range: 2313200 is not in [-2097152,
> > 2097151]; references __vmnewmap
> > >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x120):
> > relocation R_HEX_B22_PCREL out of range: 2313124 is not in [-2097152,
> > 2097151]; references __vmnewmap
> > >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x12c):
> > relocation R_HEX_B22_PCREL out of range: 2313072 is not in [-2097152,
> > 2097151]; references __vmsetvec
> > >>> defined in ./built-in.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: arch/hexagon/kernel/head.o:(.init.text+0x160):
> > relocation R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152,
> > 2097151]; references memset
> > >>> defined in ./built-in.a(arch/hexagon/lib/memset.o)
> > make: *** [Makefile:1170: vmlinux] Error 1
> > make: Target '__all' not remade because of errors.
> >
> >
> >
> >
> > [After]
> >
> >   LD      .tmp_vmlinux.kallsyms1
> > ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0xd4):
> > relocation R_HEX_B22_PCREL out of range: 2313200 is not in [-2097152,
> > 2097151]; references __vmnewmap
> > >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x120)=
:
> > relocation R_HEX_B22_PCREL out of range: 2313124 is not in [-2097152,
> > 2097151]; references __vmnewmap
> > >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x12c)=
:
> > relocation R_HEX_B22_PCREL out of range: 2313072 is not in [-2097152,
> > 2097151]; references __vmsetvec
> > >>> defined in vmlinux.a(arch/hexagon/kernel/vm_ops.o)
> >
> > ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):(.init.text+0x160)=
:
> > relocation R_HEX_B22_PCREL out of range: 2326848 is not in [-2097152,
> > 2097151]; references memset
> > >>> defined in vmlinux.a(arch/hexagon/lib/memset.o)
> > make: *** [Makefile:1180: vmlinux] Error 1
> > make: Target '__all' not remade because of errors.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
