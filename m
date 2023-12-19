Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA33A1B5;
	Tue, 19 Dec 2023 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSeQljuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F5C433C9;
	Tue, 19 Dec 2023 21:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703019897;
	bh=WBbwVhDlfgpRlCFCY4cFurEjxND6ilp2x/EXW99qkKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSeQljucbytZT3ID34ARglZRdLjfTFkvlmv+GpIWvM+MDWVpDgFjpDk4Mf+cP2VlD
	 cl39hwC72DSuIOW+gEmc0SSJrp05GrSOH5YXyssVR0ARes0bdsGsg/0aSlClUbHGCv
	 R45qTLQOUfNkeMNRgbkbIMNODQuMv+35Zf/SdiBR9YcEVd+G8SUOYCNTMZbWo4CD4M
	 ofVSDB21zLePNCpAR3SHqwMbVv8FNGq3NAXnP3ryN0J4naG1TPMnk7wCBZIoFz6M3W
	 DKsmAHviOBq2zkDBV2x8aCXvPGVvFtGMYXmrTvhxvF0ZWbAGx5ilu3Vps1BKd7Z7PG
	 nbViAwOoTAU9A==
Date: Tue, 19 Dec 2023 14:04:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <20231219210454.GA540439@dev-arch.thelio-3990X>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>

On Tue, Dec 19, 2023 at 12:58:28PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 19, 2023 at 12:54 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Dec 19, 2023 at 09:40:09PM +0800, kernel test robot wrote:
> > > tree:   https://evilpiepirate.org/git/bcachefs.git header_cleanup
> > > head:   89188fceb7a49e3c4b0578d86f6f6e647f202821
> > > commit: 1db61740aeb7d6b1c7bfb2a98708a65a6679d068 [21/51] locking/seqlock: Split out seqlock_types.h
> > > config: hexagon-randconfig-r005-20220913 (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/config)
> > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.wMIKiZWw-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    die__process_unit: DW_TAG_member (0xd) @ <0xc689> not handled!
> > >    die__process_unit: tag not supported 0xd (member)!
> > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc697> not handled!
> > >    die__process_function: tag not supported 0x11 (compile_unit)!
> > >    die__process_function: DW_TAG_member (0xd) @ <0xc6db> not handled!
> > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc6e5> not handled!
> > >    die__process_class: DW_TAG_compile_unit (0x11) @ <0xc778> not handled!
> > >    namespace__recode_dwarf_types: couldn't find 0xc689 type for 0xc66b (member)!
> > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc674 (member)!
> > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc67e (member)!
> > > >> /bin/bash: line 1: 19420 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
> >
> > Not sure how likely a header cleanup is to cause a segfault in
> > llvm-objcopy and I don't have the toolchain to repro this - could
> > hexagon people take a look?

For what it's worth in case you were not aware, I provide copies of LLVM
on kernel.org that can be installed in some prefix and invoked with
LLVM=<prefix>/bin/, which can make reproducing reports such as these
relatively easy.

https://mirrors.edge.kernel.org/pub/tools/llvm/

> Is it a segfault in llvm-objcopy, or pahole?

Should be pahole. I have not been able to reproduce these crashes in
pahole v1.25 in the past when they come up every so often. 0day folks,
what version of pahole are you testing with?

Cheers,
Nathan
