Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBE3B187
	for <linux-hexagon@vger.kernel.org>; Tue, 19 Dec 2023 20:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLm7Rya5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336746a545fso46725f8f.0
        for <linux-hexagon@vger.kernel.org>; Tue, 19 Dec 2023 12:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703019523; x=1703624323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSoJF2brXrDvmeNy4sAlYal40Hfmd/JEFr/Ur8rVqdk=;
        b=SLm7Rya5X5YW+JVCsfb49IL/hIxOY6/jIMR2HxHDErNB8ZvN6rnQX6rCxoesQ46yIq
         TXIs8h/Z+wcM7mzt6o1qtm3Ss8LcL7RLkFJdVjjx6wQZmkLb29P7Q5iNBVVJzeEgS3Hd
         uzSDDagav9o4M0pmW+O6ud9Ee55BynrlG852zr3mxvgQShIqvO+9cY0DW/bKEnrMK+TH
         L2NyHBEMjFW98iXd9VB4jO2t/VWxhYNI+2q3bodfG1hZTX4EoDxDyQSL/eU9FK3sWVbw
         rCbwqMdgiS2WHs6M8Wi1NOyb+8hZyzf8Z98KpEaZ1nQsy5EY6/gU6C6tm0rOoYSSUaQZ
         imNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703019523; x=1703624323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSoJF2brXrDvmeNy4sAlYal40Hfmd/JEFr/Ur8rVqdk=;
        b=gpVqMYkrV08LAaHN/iKtnFK1keAO5mFf+ojdzdKZORG4tOaTx1VaSpGtBPEMkl7ilk
         mQ6iC+6bNdBb/kNKdBIhK/Mqa2lNf8w/H6HK+D+Q/LBcSVZ6l50PPKjsqNz2+MbZ+oAM
         lC7vfpQNS0qLRVnnu3ypCKYnQx93FBHsV42RQ7aHt+45OlLCN0AhpIR5UF+GSIhXeaf8
         NuA7vuOK2v9ZEcFZVNpmPT6MUTeoJQXZ0eQ80+nkIi4DwWehCw0K96Yx+cGQ6qNsyKhQ
         NjTsG3key72ojHadm8tG98Qr+qwCtL3zJfCz932Ah/KTYiKU3pdcw4hf/gE2J3NEQgnt
         dtIA==
X-Gm-Message-State: AOJu0YwcPjOu4i6iJtBMbmAseWRh+PMIuYCyTJ/rly9kxXI7mFFTlh3w
	C26Fn4hgZ8B+xSKEP4dmf1d6BqZOuY83kyOYkyIHaGmfFaqo
X-Google-Smtp-Source: AGHT+IFFYyxiRUi+myfmspax1WSelMy/wc1DSYPtwg52WQ5obSoGXg0nD/r6TxR11U5FmF0ma/kuavLI2DbrOktMo3I=
X-Received: by 2002:adf:e881:0:b0:336:751c:9b99 with SMTP id
 d1-20020adfe881000000b00336751c9b99mr973413wrm.21.1703019522724; Tue, 19 Dec
 2023 12:58:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202312192107.wMIKiZWw-lkp@intel.com> <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
In-Reply-To: <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 19 Dec 2023 12:58:28 -0800
Message-ID: <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:54=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Dec 19, 2023 at 09:40:09PM +0800, kernel test robot wrote:
> > tree:   https://evilpiepirate.org/git/bcachefs.git header_cleanup
> > head:   89188fceb7a49e3c4b0578d86f6f6e647f202821
> > commit: 1db61740aeb7d6b1c7bfb2a98708a65a6679d068 [21/51] locking/seqloc=
k: Split out seqlock_types.h
> > config: hexagon-randconfig-r005-20220913 (https://download.01.org/0day-=
ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.gi=
t ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231219/202312192107.wMIKiZWw-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.wMIKiZWw-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    die__process_unit: DW_TAG_member (0xd) @ <0xc689> not handled!
> >    die__process_unit: tag not supported 0xd (member)!
> >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc697> not han=
dled!
> >    die__process_function: tag not supported 0x11 (compile_unit)!
> >    die__process_function: DW_TAG_member (0xd) @ <0xc6db> not handled!
> >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc6e5> not han=
dled!
> >    die__process_class: DW_TAG_compile_unit (0x11) @ <0xc778> not handle=
d!
> >    namespace__recode_dwarf_types: couldn't find 0xc689 type for 0xc66b =
(member)!
> >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc674 =
(member)!
> >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc67e =
(member)!
> > >> /bin/bash: line 1: 19420 Segmentation fault      LLVM_OBJCOPY=3D"llv=
m-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=3Drust --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/m=
isc/eeprom/at24.ko
>
> Not sure how likely a header cleanup is to cause a segfault in
> llvm-objcopy and I don't have the toolchain to repro this - could
> hexagon people take a look?
>

Is it a segfault in llvm-objcopy, or pahole?
--=20
Thanks,
~Nick Desaulniers
