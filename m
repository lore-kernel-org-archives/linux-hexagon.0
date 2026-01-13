Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3638E5F3
	for <linux-hexagon@vger.kernel.org>; Tue, 13 Jan 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307610; cv=none; b=QsD34z5Oh0pFBL1oyKju/yK48BPBzpkHiFzvA0KVUwcfnZI7ws0r320hwbAeGxh6pd3Ju1DIxfs+H6w7Uag8Jf5rr3OhJ/0udnJRP+Wbg9k4bC4pM2MdIdPF6ziydsq5VTOcrOmOF5SPbBEdNVvJ8Ql6FHUjX41Mp34/IcTfzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307610; c=relaxed/simple;
	bh=c2pQGNsmx4TXSTG4ks/OmiO2LMby6F7I6nhF1Yls93E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HZenKxVEGwtPIZUh5K9lNqSJ9Bj33kS0TMJJ4sjS0PxaGIjYUAOY/Ee+iWSMbOdEoUDWJRYUKugz+WhAUC4zGXt2SbUTdyjzKOg/Dh/f+j2iK2ifQN/8wpvg1ORh1dhow8RjmARw3WLM5vg2ruW/wu7pK+n+uA/gFKWe5jaEJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCrBvpZe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCrBvpZe"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c27d14559so4255627a91.2
        for <linux-hexagon@vger.kernel.org>; Tue, 13 Jan 2026 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768307607; x=1768912407; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=GCrBvpZeucBOdNpJseUbRKNa77J3jEjSKSr2rQltUiOSzioURb4448Kr9GVdc4A4M6
         EeRxRTsOfiRVNkUEGN4mkvBWr7+cqibFBBnbNCpse52V2sMsMNI9lEm95Cnlek63otZl
         syjrb7MRSUA4zfswNNSYnSNoKl7QdqKysebTzPHBsCeNlTTSfvgjmp0e0FuW/B95Alst
         oe/iuaWn7B8uGt+o/gTqlwZd0wTuqVGIQR6mFwzUCdAVrz2qHLtEl1u3M5lND7sa/YIo
         WJVxnqKjY+DdRZteDSadMj1yuf/MI2IqhwEjkDmLAD+876PYUwT4dDvY2csrpor9dpk1
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307607; x=1768912407;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=iaC1HZpWTzIa0hg6zJdHFL71X4hXP60UpY1LA/0e0Al4eEfAIAOVHST5gKPzyjNDIc
         IuMDGQ3DCVSooaiqaEZCNUkbbrVjX71GT2VIfDvrJDPNzyGIwVhrUknmml03Pr4odrRf
         MJQqPQfYlNFgZGCgyvPhdnwDbE+Hjk9bFS8DiJ8mpVBHow8ruT8BG3RfQiD0sgmHnNd/
         rAMHacJtZdRHx5/jLgxJBy8AfaCidoyJRIoGtTalZRtvgjDespAhpUaME4kwEXUEVXg0
         8UIEEKymkZSrF7EB/OBIbCF4yU+5oGxwDOucMC7iQdusr5za7StX9/ZBcFwVsztBgadn
         AYMw==
X-Forwarded-Encrypted: i=1; AJvYcCUvoJY57axT/xlqEszEPicGhfBGV7U9Yf+Ww4iVtMJtLp7Wysq3GNkOcLmOqnHon5WGpJG7QHaFhBeWn7MI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos7r5QPuS2tiJGlJUTikYS/AhFjf/Ig78oJ4+OXwIMHV6yyEk
	StdNY0YPx8S+Ju/UDZN6MiSrZ7x7kso5ncSM6DVtKWBPjzF43yn3e8gn
X-Gm-Gg: AY/fxX6R3zU4KNWEtXFy1m1blKx1QN5mB0mRmZK8mPENjAbI0JIcBAlw443aQnU6C7D
	ty7PMZapEaxTfnk7JVcb2TJhowq/nGI2PnDYaCfaj0uc6I7MSOIkOAZh2wxkO7pwWvJagAjay/1
	t4BizDLSPsnH8o9M2rn4pXbpx3X34opulfsJEyGrUQkTWWAvDLsYdK09KV1FQdeeDUeon7ftSqL
	Z0m7BBRot59ZdMKlJT2R0u+Y1C621xRToYGmKcLXTRtQebsKSqnhP7Yvy+4tHWe4hBPtJknEkfT
	3ORrIlrs+IlFRM9h8gfygGDWIcnIMPVbC7SRiVu4iQnHo0kpEtQSPYUJRwsqJjO5dGGT3L65mwq
	6eT0rpt+fbU30jUHHy2f6zEU/DtbMVPv/AwptD9UXrxFlhV2zTBVBcnfI7Q+qzYwbNpLS4wrhng
	VMiwk2
X-Google-Smtp-Source: AGHT+IFw8NQUhXWsNFLNcy9VnhtaeqSccMp4bageDierszWlx1Kxyih6osyfD1+uAcqTN4o2oK4SYQ==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr18570023a91.35.1768307607428;
        Tue, 13 Jan 2026 04:33:27 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fd6e343bsm1428958a91.1.2026.01.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
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
Subject: Re: [PATCH v3 15/29] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260111082105.290734-16-rppt@kernel.org>
Date: Tue, 13 Jan 2026 17:59:49 +0530
Message-ID: <87zf6hu24i.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-16-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This v2 looks good to me. 
I have also done a basic bootup testing using Linux PPC CI.

Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
