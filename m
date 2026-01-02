Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CB309F0B
	for <linux-hexagon@vger.kernel.org>; Fri,  2 Jan 2026 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377052; cv=pass; b=G6rryNWifySAgkwPB9ZzG0vsPK6VarF1gGdGRq5X3tELZylVQ5ZTTMhw1YVFohJypqWwZ4oO4kX5AG1ytTJaMy5z7I8APbs5hz0qXCPQ0LGFlbALLlZRrTZdge678ePz0tJPRJLxJEKKKS13y73MNYi3buthb8jqMG0bpQ+NPT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377052; c=relaxed/simple;
	bh=ksPuzDhEsNwwadpdao9ypfLnzBz9TXOr7Qq8wOanBfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyD3tv/lD4fyZpwZQP0gakeE4b2Z5PderSeIUR8RVTRSjnBgg6hAGSbDVODkSE0bHuRdaHOxq1O9yZ+Q6UbbsSPqOoJze+qj6Y12paS/ISm2W0JhTnF1CxvgrohMyM9WXkoaSGMzf4QJ4OwO7W/0rdoYtMThVNdMV99DLEWL7AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdS5VSkM; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdS5VSkM"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee147baf7bso10971cf.1
        for <linux-hexagon@vger.kernel.org>; Fri, 02 Jan 2026 10:04:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767377042; cv=none;
        d=google.com; s=arc-20240605;
        b=S4rblK6Kq4goBvgipiioATOyuAbLBk/ru3ZWqcEBWBLsRMDokzirtFtW+Z5PhD/m79
         gTp+ZtqUiZzwLXpBvP/CPq6nYT4lY0Z0oaMjPEKPVDCQOvZqGFO5ICorzFg4LRK9C908
         30wcdFPK7Y2inaJIcYquTPy/QChBPzjzTalN8/JdTSwBKTaS7hLc1TmRlWctALQWSGsU
         SHZuLod4jgjdAULnd21bPDaKwjHL6AjBpb/r4ahcO1P9EMrnAo/KJXae77WhjHO3qzL7
         hQDel8qIA5kFqZNrRGIE/sPnD+wtznozvILKVPTbuP0jG0BbOiiWeNnDmQ9QiSWd3p/e
         xDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        fh=+5IaEXce9p6bfyvLjnLEI7NwThQWfocQsMGx9hSGqs8=;
        b=bQ0sXK9NAkacK25+qo2oqgKU7t69lyXDafvNf0dmhrX8xK259RFIGZgJbroFrZtZL/
         qYrMDfMZ+RmTwTxPmAoqEp0/ulrCcBDqm17jSTYqIH5XA2WeXOT3FehXzAwsgSjY1WvJ
         RgTU8MgTu7n6d4pvPBFNK5oPVK5Dir+xrF4ZGZEt/kVSMfMtySlGA0kaP2NBK+tVkBo2
         mUrE/vbFBcZH7wHCZ/luKDzuLeTxcirGrnpjFakAKYyCBCsnd1ipm6XqNEmoMrOjlevS
         ZmmTik1fYuBuVqL6cA/nXZaCg4+9J/Tag2Si1KpSaoPr13soAk6ezBS/ocD9x/SjSL4b
         jddg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767377042; x=1767981842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        b=HdS5VSkMl2fMvmYmBbhT/8bhZzDSgMLHBPooEAVzZaA2KhwWXpAsATKal+yDrYJFyW
         TsgNIKvbRz0AapI/c5ccL4QdkAiPoYIlFpWcV+zR9Y5vNcohp9rtvEFrPHpjgngO0nZ7
         V1bAPX0/7mnEwt0mNgAOEhpDMR3MSfUh+ZQ3QPXimeLalCGJ0uu7SODshg2WPqQy8Bdz
         W26QyDDP6cezxmOEP9xMJ/W5L07cZkyPMGJ5K3VQFcQetq6fJHFzI876wnCaFlQWksIl
         JMWqyRnvAI4xRryENHltmewZL8GO9iTvMwcz9TolLRPC3wqBcDe67kFnBVYL+bSw/Z1o
         1Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767377042; x=1767981842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VF7Ncw4qUW1QvZXNeYN2PHKmriSnoyG5jmMgiKLYwBI=;
        b=iGKknpiayZaRBTbwsIjTIyszuSDyWA6KJczBp2MjvYgd7D/tMt2TDQpHsptMbMMxPJ
         XboAd237ZXS1KHAeDvCJVuN47CjQ8Najj/7ND2Oot7Q7QZKWE4y4Ixn7eoKaeflu+0v8
         A+sJdwOKr8FX2B1VLqJQkKqB9X9zBcv0UUiNicXGc0q70j1DNqBxNs7iY6D/tyjCYAqX
         MG2H1HsUm9nTEE6a01liZ3oMeFPUrDypaJfsY3mcMT9KSPWsVogsP094qdBCfPBK7YDr
         rKvWvFHm0IWD0DZr5i47z4/COzFkTP2I/vihHh0A++T6GJJunS1Of+cphE0rs/1h4Chb
         NilQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVdZTXyJiY8cdzb2HPnDZ6fc6Fd/eL16FsD/ODg9Z5s33GQbbaykRlbc79yegXP2Y6yg/6zkRb/pZPYQLr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9TwF+57eb1yH1Qmt9fXkL6Jlr/OwENd08XWqj0xTS+ZKaB/pQ
	MzA59do/TBMcEOfjamoFtkatvHbFPrHKc8Cmvkk3RTpwA6ZjshCm6kpVTtAT2k1PBTMvVQhgQZf
	jz4zuoD6WA5L7uueCqm3UhzGPjXfU3Xde/C4jo96l
X-Gm-Gg: AY/fxX7jZJedR9yXsOP4xlxB+7iNfd2PkYtP0Qk/NN5biyDYGf/s10P7rTiRUJ7puyR
	ciRabskSuRwnAEVHXYv0P/I8x5nbXDAxVL7KXhBK/2CHLibutY+CDOuvmMc0tV0JBusz3a2HjDm
	eFksKaUfakgKYx+PqyeZTmYkvxtLgbyQA6aYmZPeM5a3Fuqf/Ddhte52TwlripBr2zZEIdDODYE
	NP5ibjMytyUx4oJA2sYiA+PXXPvZsp12b+Wd2PAO+tm7vqxa3P3seJjqPFAFUTschZ126w=
X-Google-Smtp-Source: AGHT+IE626c1niVbXfJuRnnEKb/XVpUT3xgOsgVHvUYmmAhOToE2K50Gpbsa48xtp+jOGlgqExM/NP3EnDee4koBR/0=
X-Received: by 2002:a05:622a:8016:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-4fbe3b0ad54mr14392961cf.1.1767377041692; Fri, 02 Jan 2026
 10:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102070005.65328-1-rppt@kernel.org>
In-Reply-To: <20260102070005.65328-1-rppt@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Fri, 2 Jan 2026 10:03:49 -0800
X-Gm-Features: AQt7F2qPng5Y0NvX0my5UG4cpefC6iiH19nIvMPHQLdOtt1JmQ_l0Tjv8FxQEzo
Message-ID: <CAPTztWaZZt_ygCDNaDdW9A_TtT1FNZW6hFzyiq2b6_xxMw38gQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] arch, mm: consolidate hugetlb early reservation
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Michal Simek <monstr@monstr.eu>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 11:00=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> Order in which early memory reservation for hugetlb happens depends on
> architecture, on configuration options and on command line parameters.
>
> Some architectures rely on the core MM to call hugetlb_bootmem_alloc()
> while others call it very early to allow pre-allocation of HVO-style
> vmemmap.
>
> When hugetlb_cma is supported by an architecture it is initialized during
> setup_arch() and then later hugetlb_init code needs to understand did it
> happen or not.
>
> To make everything consistent and unified, both reservation of hugetlb
> memory from bootmem and creation of CMA areas for hugetlb must be called
> from core MM initialization and it would have been a simple change.
> However, HVO-style pre-initialization ordering requirements slightly
> complicate things and for HVO pre-init to work sparse and memory map shou=
ld
> be initialized after hugetlb reservations.
>
> This required pulling out the call to free_area_init() out of setup_arch(=
)
> path and moving it MM initialization and this is what the first 23 patche=
s
> do.
>
> These changes are deliberately split into per-arch patches that change ho=
w
> the zone limits are calculated for each architecture and the patches 22 a=
nd
> 23 just remove the calls to free_area_init() and sprase_init() from arch/=
*.
>
> Patch 24 is a simple cleanup for MIPS.
>
> Patches 25 and 26 actually consolidate hugetlb reservations and patches 2=
7
> and 28 perform some aftermath cleanups.
>
> I tried to trim the distribution list and although it's still quite long
> if you feel that someone was wrongly excluded please add them back.
>
> The changes also available in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=3Dh=
ugetlb-init/v2
>
> v2 changes:
> * move the hugetlb and memory map initializaion to mm_core_init_early()
> * add Acks
>
> v1: https://lore.kernel.org/all/20251228124001.3624742-1-rppt@kernel.org
>
> Mike Rapoport (Microsoft) (28):
>   alpha: introduce arch_zone_limits_init()
>   arc: introduce arch_zone_limits_init()
>   arm: introduce arch_zone_limits_init()
>   arm64: introduce arch_zone_limits_init()
>   csky: introduce arch_zone_limits_init()
>   hexagon: introduce arch_zone_limits_init()
>   loongarch: introduce arch_zone_limits_init()
>   m68k: introduce arch_zone_limits_init()
>   microblaze: introduce arch_zone_limits_init()
>   mips: introduce arch_zone_limits_init()
>   nios2: introduce arch_zone_limits_init()
>   openrisc: introduce arch_zone_limits_init()
>   parisc: introduce arch_zone_limits_init()
>   powerpc: introduce arch_zone_limits_init()
>   riscv: introduce arch_zone_limits_init()
>   s390: introduce arch_zone_limits_init()
>   sh: introduce arch_zone_limits_init()
>   sparc: introduce arch_zone_limits_init()
>   um: introduce arch_zone_limits_init()
>   x86: introduce arch_zone_limits_init()
>   xtensa: introduce arch_zone_limits_init()
>   arch, mm: consolidate initialization of nodes, zones and memory map
>   arch, mm: consolidate initialization of SPARSE memory model
>   mips: drop paging_init()
>   x86: don't reserve hugetlb memory in setup_arch()
>   mm, arch: consolidate hugetlb CMA reservation
>   mm/hugetlb: drop hugetlb_cma_check()
>   Revert "mm/hugetlb: deal with multiple calls to hugetlb_bootmem_alloc"
>
>  .../driver-api/cxl/linux/early-boot.rst       |  2 +-
>  Documentation/mm/memory-model.rst             |  3 --
>  .../translations/zh_CN/mm/memory-model.rst    |  2 -
>  arch/alpha/kernel/setup.c                     |  1 -
>  arch/alpha/mm/init.c                          | 16 ++++----
>  arch/arc/mm/init.c                            | 37 +++++++++---------
>  arch/arm/mm/init.c                            | 25 ++----------
>  arch/arm64/include/asm/hugetlb.h              |  2 -
>  arch/arm64/mm/hugetlbpage.c                   | 10 ++---
>  arch/arm64/mm/init.c                          | 39 ++++++++-----------
>  arch/csky/kernel/setup.c                      | 16 ++++----
>  arch/hexagon/mm/init.c                        | 19 +++------
>  arch/loongarch/include/asm/pgtable.h          |  2 -
>  arch/loongarch/kernel/setup.c                 | 10 -----
>  arch/loongarch/mm/init.c                      |  6 +--
>  arch/m68k/mm/init.c                           |  8 ++--
>  arch/m68k/mm/mcfmmu.c                         |  3 --
>  arch/m68k/mm/motorola.c                       |  6 +--
>  arch/m68k/mm/sun3mmu.c                        |  9 -----
>  arch/microblaze/mm/init.c                     | 22 +++++------
>  arch/mips/include/asm/pgalloc.h               |  2 -
>  arch/mips/include/asm/pgtable.h               |  2 +-
>  arch/mips/kernel/setup.c                      | 15 +------
>  arch/mips/loongson64/numa.c                   | 10 ++---
>  arch/mips/mm/init.c                           |  8 +---
>  arch/mips/sgi-ip27/ip27-memory.c              |  8 +---
>  arch/nios2/mm/init.c                          | 12 +++---
>  arch/openrisc/mm/init.c                       | 10 +----
>  arch/parisc/mm/init.c                         | 11 +-----
>  arch/powerpc/include/asm/hugetlb.h            |  5 ---
>  arch/powerpc/include/asm/setup.h              |  4 ++
>  arch/powerpc/kernel/setup-common.c            |  1 -
>  arch/powerpc/mm/hugetlbpage.c                 | 11 ++----
>  arch/powerpc/mm/mem.c                         | 27 +++++--------
>  arch/powerpc/mm/numa.c                        |  2 -
>  arch/riscv/mm/hugetlbpage.c                   |  8 ++++
>  arch/riscv/mm/init.c                          | 10 +----
>  arch/s390/kernel/setup.c                      |  2 -
>  arch/s390/mm/hugetlbpage.c                    |  8 ++++
>  arch/s390/mm/init.c                           | 13 +++----
>  arch/sh/mm/init.c                             | 12 +++---
>  arch/sparc/mm/init_64.c                       | 17 +++-----
>  arch/sparc/mm/srmmu.c                         | 17 ++++----
>  arch/um/kernel/mem.c                          | 10 ++---
>  arch/x86/kernel/setup.c                       |  5 ---
>  arch/x86/mm/hugetlbpage.c                     |  8 ++++
>  arch/x86/mm/init.c                            |  8 +---
>  arch/x86/mm/init_32.c                         |  2 -
>  arch/x86/mm/init_64.c                         |  4 --
>  arch/x86/mm/mm_internal.h                     |  1 -
>  arch/xtensa/mm/init.c                         | 14 +++----
>  include/linux/hugetlb.h                       | 12 ++----
>  include/linux/mm.h                            |  5 ++-
>  include/linux/mmzone.h                        |  2 -
>  init/main.c                                   |  1 +
>  mm/hugetlb.c                                  | 13 -------
>  mm/hugetlb_cma.c                              | 33 ++++++++--------
>  mm/hugetlb_cma.h                              |  5 ---
>  mm/hugetlb_vmemmap.c                          | 11 ------
>  mm/internal.h                                 |  6 +++
>  mm/mm_init.c                                  | 20 ++++++----
>  61 files changed, 219 insertions(+), 394 deletions(-)
>
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --
> 2.51.0
>

Thanks for this series. When I introduced HVO pre-init, I noticed the
inconsistencies in init order, but shied away from attempting any
general cleanup, as I had only tested pre-init on x86.

With this, it should be possible to enable
ARCH_WANT_HUGETLB_VMEMMAP_PREINIT on architectures that support HVO. I
think that's only riscv and loongarch right now. But that's out of
scope here, though.

- Frank
