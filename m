Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164D3AE6F5
	for <linux-hexagon@vger.kernel.org>; Tue, 11 Aug 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431378; cv=none; b=nGjVuzIxf6b7PVNgVdZv6L0oDwINode5KByCysesOCqXM2s6hcThE78MIjgYj8zrM12yQRnJNt+2+51IVPRS1P1SbUHY3Uwj366QYBnxNtkz9X9NHNgr2Zu6KQQXwRFHgp9lHyEvFFyWTyLgCm6HbV1CYU0TNvBr4hcoqvcUKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431378; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozEA3A/sjn1Pq5cE64dq2s/Ql/BWZVeerkR/Cn/UAJuLYgtKFaJrvonDWEBczTflHkaIVJ9VwPpqFFuPwiRLHruOmfQeNeMq0B/AxlujV5C7yU5pCZzJKai0dE70NvTBPV4snIXTM4bSfpP2/Y14kks1o+SrMgCzIp0+QvXARTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so39457135ad.0
        for <linux-hexagon@vger.kernel.org>; Mon, 10 Aug 2026 23:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786431376; x=1787036176;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=SWdqndVbCJuNVxudtOzc0lFrCabsfw0sPPsAs90lT4e0yrxIjavP3hGtHpz/ans2+9
         PfoQiBYByOcIEcpuz7YinPzPMo/0Z1SBXTXkDaOdQ9gixDd3jfgOjRL+9gd5z4Rdwekl
         0JooY7ZJsJBlnKvbKLbOtd6bFKk2H6oYKtxL8UcD5OUn8X9AO0oDWujWRwsroZcjpoB6
         hFsgW1O6yuZNBk4f+aNgSlwnB3wc8jrb3LkobI5R7GeJ3x3NtdyGBpqvqgVmb6BwYfiO
         25E899QRvtHlhn4zmhWpnJe8mZfubiNjgQOuI75J96E9TNzQ1Lo+TbwKAQvWoOTEZxKb
         rwzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqGiXujZudxN17MlmIQaIz/H7FAjc9aJ6GXLrzBOn9SYKWFV09+QbIDhcF/yd6R8ZWXkKOiKeVCmd/nKXP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3CSMbi7WgLdV7plKcqBhpLZZePiNbh4pGGgG7WEEVwENoiTv
	n3yavaNaZ1XMdxSeP90P51NNlgRiYCymyVIXcOkDWhT8KkpAtgqw/KzGKhvaUAEf
X-Gm-Gg: AR+sD13HmSCNBMBF4/lOpFZ67RTThR3wGXMGq8vO7B025TzmuhozygA/+HnpvW1ifJG
	Dss3Tfa90NBhQsJChJ7EBuxzDsxZYLEG6KLozOc7eh55G+8JRtq5IQtKt2K6gzuWjMbq53E9WoP
	XfzzfYKE1el9PmRz3pWcDhwHoU6No3cWR8bOHsrGLVJNkR2WnAimNpbni8GzYF/Kh5IYDuVIGzr
	LZv7hcFppOBRWny2l03CccZuuNZ7XpSh7EgTtxrkp/beDN445ziBs87tvJx0tRx5mSIcYBNm7dE
	deLs6CerMbjuXdsvA+Y8gmdcBXyulpCdLqInlyQF2mRqcp2KGgbDsdlHt3i1wxplUc4TjIWUlgn
	u61WNysXxl2NToosEspo1rteiFD73lRp5dGQQyC3QGQPSeGqDcXYl5ozTdE0F7hKnxbmwOTJjot
	5zs7BauNcK+ERnCobUFIsgFBj3SDx9SMSQezqpcNhdgSTIQmchUXQ/HZB1G9MfAaRIYfk665mbp
	b5Ow8iRtLnSIq9aDZCTKXOrLjzcsA==
X-Received: by 2002:a17:902:cf04:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d31778b004mr16912085ad.4.1786431376211;
        Mon, 10 Aug 2026 23:56:16 -0700 (PDT)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d31623480csm2680705ad.74.2026.08.10.23.56.15
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:56:16 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84874b52eabso3448555b3a.0
        for <linux-hexagon@vger.kernel.org>; Mon, 10 Aug 2026 23:56:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMfXzMn0dP6aGDQnzo9vu9WH531JSsjdaf9LjERAtBo8MxxC8UoYvJBV2rOCAQQ3P3JYt7d8c1QmZY/WuG@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
