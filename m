Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3B340294
	for <linux-hexagon@vger.kernel.org>; Wed, 11 Feb 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840874; cv=pass; b=G4O9tt69tkI6c92Td/M8lgmtqaBJPas4Oz5N2+h5OCFHaCD5PxyFchWYFcKCvCP7E791nh71ROwUBJtAjR74xVRv2NqEUICrr3XEKzVf6/TX9yH0VWY7HO4SmpGrFCDuvNa1/fhz9e78NUtsJFCZBy3Tjoh05ILi/iuLmBXHa/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840874; c=relaxed/simple;
	bh=XTU0SZsxOmJ3FoM/DLxyJrm+s5UGvDwm08Uhn3BjVVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJzoftSCTuqK4OcmIZC4C9JYELXlr9nWh9t/Zvb+2eorOK4mCZHdoWWm+I9iy8B1dtBGDRv9HeFN1//9JI+FzLG5NFp2RkKxsX9tvp8CPji2sNqxk+4yS4c7ohoGVrn60IbgBkZjx0fc8bMcHfdNjQgQl9HOTT7M1tI2QwIiK18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APb4+MbR; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APb4+MbR"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so9678115a12.3
        for <linux-hexagon@vger.kernel.org>; Wed, 11 Feb 2026 12:14:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770840871; cv=none;
        d=google.com; s=arc-20240605;
        b=HIKwgRK2r7ZkqR29myUh8KEeMixl8Wd3qHVesyiSwsZG7C2Er/k4bNspCYKx55aIV9
         cmX1gJ7E3i9awkBw/cBHAkW14WYwyzRbSvZ/r8R2V40aPqxvzK/t1lHDJ655c5W4hEgE
         PEguF6NQgOll13mXPPZ06/53baE2gWudZcnmusuax3+hFk66um2ob/P3PBeFgmzkSxWv
         r4z1M6f78d3EaeIVZ6y9xO5V6QXsjRvVHxMUljefHHZwrLVbE2KmxUsZT5xFKoRl3xCu
         eaVEnXnbaDV+WDtIPaHgZBZrT9SZyhcuodEvwHelr/g9pNKl7IMKW/Azs17V++9Iualt
         7ViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        fh=uEO558Du9Pixx7IsmzzA1VlFIk/80UHuqSL6ksObJs4=;
        b=llcmxB4Ww8XXbghK/zB/ERZ4ENhtZl1GO3O8IG580vY+LashUAYNdRTt2FD8fzTTZa
         LMwAEBS6UwlsWqVCwGUd5dGvAcEntqML31CCkK+htrOJnjZhSAaIrLFqWxStSbBRoSFF
         vBnLbbr6+U8mP8dP1ArIxnU2nSA0U6cIWsu1OUs81+fMn9ubWXGeYv738pzZoW3EnDGG
         P3JcMvfekRkGaj0Hju2ly/O4wTYTyyOWGnVYEcFUvJ6Xd88cweLxClx72aRe7z8UiWZD
         LnrPblE3oxe7/J0ugveT9NBEkyl9E2J4yr4QqOawtMXe2xYyEH9JJBTPyBHHoxKr0qNf
         irfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770840871; x=1771445671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=APb4+MbRhaKWB087tAeEmwP4Lu08rdhv4sI3dkqV/YTBKS/mgYlB4ErJ/k5iCsIhES
         Dyw4yDNNlDLkNRi9ufKgKfoCSPhw1aSEB0/poC9PbO0t1/cNXY8FT9FWmqb2ZydsqZgd
         53dDCxe/YzpA/t0cV+IuTD4fKyw73qjg5LCeIynNVe7Hi2tyRKsLAamW+zTJIDsSswnY
         IGlos9hWFaX4FF+o122mFll2sqWsBCEXNdPmDDBvTHhOzo5VINHjmH16G9wTMe2fYvsc
         df42ezDoaRiLAol2+Y0BhdzgWhRvx874hQwyXFwYh7WvP1MprulEETQ0RPLz4DYSv9nK
         9W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770840871; x=1771445671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28hr9LjidhOb4+7vDtUZiT7dYr2nuAMqMlceW5mXuOg=;
        b=sFqkBp0n8YRbfcstCeImXFo57uDo2a3PMqU0eEyj6MsExITyU/l58XeVvqSZ6+8QQe
         kpkernSVHeXNEjRB06ZZFNg+G+PCJl4e68gEK5a2VjSiEwURlFvMxVVJ+rncnn+PUeFi
         aPOLHHPufFaM9y2G6XE+p9Hti9PEs3PIT9BJXyzyuY3dvzoyvtng7kilfTT+6Sz1EsGz
         jfg142hx4QPXUGT22uM3HMN1DsUMtVQ11gUVCiAz6Ui8zIutxCkjO7Oe8CtnYP1HUShU
         Ykal22GpalRTzrrOYwLzlbo9bF3AjQdqHiTx4+S0IkwvKhnKEX4MTg1BZ2zTr2grgPLZ
         2u0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTh6CethPd7VGQEIOfccKc3q9zoK7cfikAg2h+6DIMMkeiHhokSyIpbF1rXpl6x60r/O5OXaD4Hkt2b/pW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mhfGZvwRfesKJxYEmigI1r7+mg33RmyZGLOEftBQYck7LwpI
	dK7kdSxdBfdfxFmI2pZRXSIyaI0dI0JFYVtTuxVxELxisnTL8jjwkW2KtODj2E4wTzs8GfvfRWi
	tSVXGeAldefG9yZFV4kwH5p/4H7nllKM=
X-Gm-Gg: AZuq6aJJ2kq9szbFVaqlg0NUJTpJnl2sPeOWi+2zgJDTBpyQiIQDYFeWhWWd6RleL3P
	de1qdQadHCAN6a9qrwXvM7LWEL0wgCTgbpifDkEQO54N4qlTOU88cwgz96GuUvGU2TVihsSXKHj
	A0vb/mehHFAYjxCws3Lg+0S7Ba/qYZhKaEN8phtuLDTnggEjrypNEybhaSfDrsH12tPVUevDuru
	CHjjva/YDfpBTSdii9BHT1l3sMygskcxzBHA/eZjl6QHVBjdzOHxBrFURlclYSrXcLD+bel94CI
	TU3ayGhB5i4bFWsRvcG0QBeC2FKsRhyEXoNs0LJX9w==
X-Received: by 2002:a17:907:a08a:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b8f8f72d91emr17643566b.50.1770840871149; Wed, 11 Feb 2026
 12:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211103141.3215197-1-rppt@kernel.org> <20260211103141.3215197-4-rppt@kernel.org>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Feb 2026 21:14:19 +0100
X-Gm-Features: AZwV_QgdPAvH3hw0825YIt93LQPupYFvh_AV-2zMkwGhubC87cSa2iVxpdoZwag
Message-ID: <CA+=Fv5T07oBJweU3tURD4Nuh7VRWovsf0zjHtA1nDAVNmO=D2w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@kernel.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 11:32=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
>
> Every architecture defines empty_zero_page that way or another, but for t=
he
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
>
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to th=
e
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
>
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
>
> For the most part the change is mechanical, with these being noteworthy:
>
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boo=
t
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the gener=
ic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
>
>         /* A handy thing to have if one has the RAM. Declared in head.S *=
/
>
>   that unfortunately had to go :)
>
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/include/asm/pgtable.h          |  6 ------

> diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pg=
table.h
> index 90e7a9539102..12a3c5f8ece8 100644
> --- a/arch/alpha/include/asm/pgtable.h
> +++ b/arch/alpha/include/asm/pgtable.h
> @@ -125,12 +125,6 @@ struct vm_area_struct;
>   */
>  #define pgprot_noncached(prot) (prot)
>
> -/*
> - * ZERO_PAGE is a global shared page that is always zero:  used
> - * for zero-mapped memory areas etc..
> - */
> -#define ZERO_PAGE(vaddr)       (virt_to_page(ZERO_PGE))
> -
>  /*
>   * On certain platforms whose physical address space can overlap KSEG,
>   * namely EV6 and above, we must re-twiddle the physaddr to restore the

This looks good from an Alpha perspective

Acked-by: Magnus Lindholm <linmag7@gmail.com>
