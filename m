Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F5378D79
	for <linux-hexagon@vger.kernel.org>; Mon, 16 Mar 2026 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703398; cv=pass; b=gIHBddxpscCsz/N8OUEmjXZTvD880JToDZcKAmbP0RxHZ+817YU/QkEIgX1WGA1QRs+LQNfa+zIjWeE9E9ErT6F2oTzgn8hoEH/QncZarU0dkWlFE7OIqqvgEon3qqwd7o7sEU05/DeZpD5rekIuEJ89kQJc1I1L0WAJEZks8dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703398; c=relaxed/simple;
	bh=XTOZYOCHUctLkYMS5qNPCkNocPEUYtAP2iODWNe7Wt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/QX0kU12U++MGM/3kr+kpy07J/+hshOOVmtEkOc7t7+yDfr8ZtQ3av7jOx50t717oyyKEJbJGJCCxdZA9Dhuy4yi7rrPT1I1iB0gEtytcGIrrQoDGxUOF4fwHR9PNpIxiByDM7lf0tTvXCkou/MuDapTaQ+STIXHp/rCrxzNBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eZ2/MpmH; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eZ2/MpmH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab39b111b9so21638185ad.1
        for <linux-hexagon@vger.kernel.org>; Mon, 16 Mar 2026 16:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773703396; cv=none;
        d=google.com; s=arc-20240605;
        b=hHTS7qnJixhJqyCaNjJtMjP9DGc6AGVlFas0DeBeA31yfHZhCA/YeV9L6wro12oCmT
         zYGDH/aUr1gqd0hxyeqB1cl9ZvFXfhEwJ2K6ZtOXsNALRJt7ohrlWjWOhv+JEo8iCNKg
         EAsVuu6kkK40B8bsWdKItsIQVKbkJbmh2iJyTWFMb7TSgVMR868QA52MyUvCHHvOHJl9
         68SO1Dx2wlgf4g8922TZaDlX/31PlLfBLgU7I2d6XeRpVXcHdwuOlHRLI/3vUIJmucD6
         /ttwsWpSaHNVmlwNASuPdBqGFnwgXFf8LA5oU0VWWQJULu9tTngmdk4n0F3sFE8e36zM
         2dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        fh=DKpC4T0ZjBwz5HbPUKQKs6CKJPNcFV4DP/MVgLYkmr0=;
        b=LTWXazkEwr6sococ7FZPD+bu9MzEmfIDKiXfDrrN1gJP9NvuFbFZH/vwBkWyS5vLWi
         W+ZJ1S2pEt2ranouKz+LfDpel8xGOMJK7CBCZRw5I/UxAUQRVFJXbNH73mGs925lnChC
         rqeM2TRzelncxhOhVHpsSlwDfVcN534B9lKJ4EgT0IcnSK1Med1X/IJ9LjYrhbatc5lb
         AnNmR06cXKPbJNWDmTGowOO0Fdb3aFzUDdO0WdKl3Wbk2fTFibwS2yDzVjWTq0kxlG0z
         EAb8TnpP66AM2SuIxBD2NDXrEdB9dJQC5ruz+LZuYj9zw6fw5PVI3kbsiEBiO4Kl4sku
         1QUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773703396; x=1774308196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=eZ2/MpmHOTbFFzLcyxFQukFAMHAT6YzxNyylE8gye2eZalHZH61rGfghB43hOFP5Xv
         i8LhnDq4eVj23kn8GYeN6ZuTHEnAtMqLvYP09F5fURs+lpwlM3ncS4FXsfjjksGdZXZV
         9yjImmUjtDqg7ttiY4suwVHEZ7MAy1KjYM+0rSeHBMpOY3NWRyv7xLZdiy2DaYBIu66y
         s01hTO2v+R0ZTDj9a4iTTP6Bb3UMZ40Y9cer+/SzSmu6By5v2qA9I/rfZuhJQM6P5IN7
         sDRDxWgE2TUkrdSS43j55tIFZuKCmHxFtrHB3fL8Z7Gg1rjgs/kYO9IDpoPQRvu7wc6e
         sW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703396; x=1774308196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OjoL/xI+JfK24mJlLYQ/qQdhvwGI+GcsV2kW/9vszrY=;
        b=ry0JIxT596X8j9zqhYOwOiQIJ/qq/wRWs3fEyc8BekIeLybcV1K3x3kHfZOin7mcI0
         +Q+D7EtatZrcDsm5HP3JjFM9qkzZS9kyGG41I3/JP/AaBsqalDs4HVjM2QTzI1sGAUFJ
         NK45/YCtuXzOngiZ5dbi4iih2Cd2mLi3plXb1AytUXPvgqibIA4ZhTqD1wLm7Kjgty7p
         TIByR9rJeXjrhdFX9sbAkw8h+SyvXWokC93jTWnQnj6dAAb+R2nDyFqYO1FIb6YNhw9S
         q7gXoSyHXTMhbysnjgqkGMrCrf/ItNzxq2aMBp2RlWrFs2AD/5amscrzDwWGNRQ/Zs3O
         9gHA==
X-Forwarded-Encrypted: i=1; AJvYcCVFTg122PUbj4TM3u0U0bybUVHP4DbUW6MZjlANp2SGx+YEbu6c07a5m+MlOXqhl9DSQ1lzkNAvcm5h1qXN@vger.kernel.org
X-Gm-Message-State: AOJu0YxcomlWxfDuuDTEqktVNvLpFHhPwaxl0poOeYv0JiBi4Lm8X3ya
	NclXg1rq+1hYU1p0q9k944cqQ26QpEef2Jm2D03N0B6rYyoK7QGDe+j0OzG+pdJmgxS2uOrBVrZ
	e9o3jteUSig4q5ZY0jqNTsL0L+eeBx6PbZLVrcgou
X-Gm-Gg: ATEYQzz/BhKlpgX7g5NNrjHyufscl8smXy7TTdJDnkHSe9vO1Am8ucEqVXFL1ndTiCd
	PHv1O3ha2rPiPBST3oGKa8sz73ULfgQVVMJDpEgHQ/+mUQgapz+8w6YgobQuJvgNtIILJjGoGLa
	nSr2H5v+gMNeDJRudBv+zsLmCF86IoAdXJZM2hInaGY0HopPSjnVLzl2xLp7s7Yq12JMNkhIXoH
	i3PWTfPrF/3NUXvePeUpGxJvz9iZqFFOUDJWgHW2d9ZXekS3CxEga4J+TLNIk5ewtjx9+53hwbs
	kmtyPeLyGU2CuKw+ww==
X-Received: by 2002:a17:902:ea06:b0:2b0:5c3f:c0d8 with SMTP id
 d9443c01a7336-2b05c3fc4damr40223235ad.47.1773703396327; Mon, 16 Mar 2026
 16:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773665966.git.ljs@kernel.org> <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
In-Reply-To: <063af0422d99bee0195589aa63f8f44edaf409fa.1773665966.git.ljs@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Mar 2026 19:23:04 -0400
X-Gm-Features: AaiRm50DdYFqfixz3H6HRwMmLfdf5osoLUZfr0b1blDqz3IzGNPvd_xOI_ajOas
Message-ID: <CAHC9VhR2T8ujtfvz-HgkgSFByptTLmhbCYS+scY53aYg=sgfqw@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] mm: convert do_brk_flags() to use vma_flags_t
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:09=E2=80=AFAM Lorenzo Stoakes (Oracle) <ljs@kerne=
l.org> wrote:
>
> In order to be able to do this, we need to change VM_DATA_DEFAULT_FLAGS a=
nd
> friends and update the architecture-specific definitions also.
>
> We then have to update some KSM logic to handle VMA flags, and introduce
> VMA_STACK_FLAGS to define the vma_flags_t equivalent of VM_STACK_FLAGS.
>
> We also introduce two helper functions for use during the time we are
> converting legacy flags to vma_flags_t values - vma_flags_to_legacy() and
> legacy_to_vma_flags().
>
> This enables us to iteratively make changes to break these changes up int=
o
> separate parts.
>
> We use these explicitly here to keep VM_STACK_FLAGS around for certain
> users which need to maintain the legacy vm_flags_t values for the time
> being.
>
> We are no longer able to rely on the simple VM_xxx being set to zero if t=
he
> feature is not enabled, so in the case of VM_DROPPABLE we introduce
> VMA_DROPPABLE as the vma_flags_t equivalent, which is set to
> EMPTY_VMA_FLAGS if the droppable flag is not available.
>
> While we're here, we make the description of do_brk_flags() into a kdoc
> comment, as it almost was already.
>
> We use vma_flags_to_legacy() to not need to update the vm_get_page_prot()
> logic as this time.
>
> Note that in create_init_stack_vma() we have to replace the BUILD_BUG_ON(=
)
> with a VM_WARN_ON_ONCE() as the tested values are no longer build time
> available.
>
> We also update mprotect_fixup() to use VMA flags where possible, though w=
e
> have to live with a little duplication between vm_flags_t and vma_flags_t
> values for the time being until further conversions are made.
>
> Finally, we update the VMA tests to reflect these changes.
>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> ---
>  arch/arc/include/asm/page.h        |  2 +-
>  arch/arm/include/asm/page.h        |  2 +-
>  arch/arm64/include/asm/page.h      |  3 +-
>  arch/hexagon/include/asm/page.h    |  2 +-
>  arch/loongarch/include/asm/page.h  |  2 +-
>  arch/mips/include/asm/page.h       |  2 +-
>  arch/nios2/include/asm/page.h      |  2 +-
>  arch/powerpc/include/asm/page.h    |  4 +--
>  arch/powerpc/include/asm/page_32.h |  2 +-
>  arch/powerpc/include/asm/page_64.h | 12 ++++----
>  arch/riscv/include/asm/page.h      |  2 +-
>  arch/s390/include/asm/page.h       |  2 +-
>  arch/x86/include/asm/page_types.h  |  2 +-
>  arch/x86/um/asm/vm-flags.h         |  4 +--
>  include/linux/ksm.h                | 10 +++----
>  include/linux/mm.h                 | 47 ++++++++++++++++++------------
>  mm/internal.h                      |  3 ++
>  mm/ksm.c                           | 43 ++++++++++++++-------------
>  mm/mmap.c                          | 13 +++++----
>  mm/mprotect.c                      | 46 +++++++++++++++++------------
>  mm/mremap.c                        |  6 ++--
>  mm/vma.c                           | 34 +++++++++++----------
>  mm/vma.h                           | 14 +++++++--
>  mm/vma_exec.c                      |  5 ++--
>  security/selinux/hooks.c           |  4 ++-
>  tools/testing/vma/include/custom.h |  3 --
>  tools/testing/vma/include/dup.h    | 42 ++++++++++++++------------
>  tools/testing/vma/include/stubs.h  |  9 +++---
>  tools/testing/vma/tests/merge.c    |  3 +-
>  29 files changed, 186 insertions(+), 139 deletions(-)

Not that the SELinux changes are really all that significant, but they
look fine to me.

Acked-by: Paul Moore <paul@paul-moore.com> (SELinux)

--=20
paul-moore.com
