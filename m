Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FD396593
	for <linux-hexagon@vger.kernel.org>; Thu,  2 Apr 2026 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120274; cv=none; b=lnr8+5Qk1kpYLfjDyhGpCOWMj1K3JUWfw+bKq42Q6QF+v8mPZP19ohP+DdoPfP4Jor7q82ev4PFaBmfBsRd4DanTpn+sNLaB8NrYKGNyP7YbeROvBC3kk2AjWIP93E97tUoFK3YcQxWC2qaAEZ7QVR0tsefa2QrBlxg0Jo2Ka1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120274; c=relaxed/simple;
	bh=7tyJ0+wz5LzsOmdaY0Yimnd2RzEPrZZv3nZHEii7oEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6FrOcUzGDS8+w0J59q7OEME5qknuRJDkAjHjx4UYYaLsGkMBoU2XXdgXnBmRZ7vyiNVGyIn78ZZk9pT8+JdhZVzcRhdGb+BDgl8i0vY2W8OdiQ2Q4TP99bRzm8B61ZIBsYfDfVrKGTb2lCZsP6GWX5DixbaQDlLc4ScLiX/56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N43yz0Pb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N43yz0Pb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso5220065e9.1
        for <linux-hexagon@vger.kernel.org>; Thu, 02 Apr 2026 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120270; x=1775725070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=N43yz0PbY37tKQwLI7fxz/TezjohnBPHceaTDSIHXJZ3lR+l7erEdzyuYI3/5fRC/P
         aKbwZiXH/cRosXudrYOUKNUT8TPbaLVOs6PeIW/HuQH5TsnCf4Fm5Sgo24YdKsa6ii/U
         /fju0wbiv5lfrFjides8gma93qJvGrmo2JqMyd4NJj0a7E9wY3w+nIAyjyJTMEfvk7PG
         g3zBjCmG4+hbFTu/luNZzrq8m7P9/XsoiMeRQT/rmz73FwKb6JnSjpaUqV0ZmOFNtuUi
         vKFA8PaRd5wgturtCUT32KaTz75xIUFFg4zOpfG2jjDwyipSacuYVDVzYgsXBFUpnDzh
         LkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120270; x=1775725070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=MjsOZeEq86EtVHKmnfPMlO3j57LkLTY1fPE2gO2nQbzOZHiT+wNhn0AnFLOHJOouMW
         B0IYLuZ4cMj91NRycHusX23W+R2SVZK04EcMgFXE1RtGoQLdjjIhuqx1b6rwZTBnWAW8
         2Lx908p9uUOBOdovwus/3OWtQu17BkzqoGBD3CJSfloh4fsUjXi3OHhsE+4BwhqLLcqx
         sjuNzb6DjJTWUCRMbK7PvYCmflOudOhxCE3vBZxGs9hy/tZ82LI26HxmdeOGThlU8bOD
         DmBvXGfiLn//taP+K7TSdcgau8xbTN9hCRi9xQwcaDMNZv8EH5RXD9lAwvZeEmWsBGWB
         hJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYucv9gD+jTheu5BsxwVN2+eQ3OLo1Acx7zh1PXxSC5GeB1b62EkbZszBN3wGQ+blT2ETumGj0L7a4aC88@vger.kernel.org
X-Gm-Message-State: AOJu0YynVXF5L6nMqODumT/lmR8FA5xRC2N1qUM5YcwLajQUjsdFtVuM
	c5bJQvK3lW12T9lZ7zBboGDWsIcLSOPjvW+RTD0IRl75paloBrVWD5gA
X-Gm-Gg: ATEYQzyHm69s0qJ4TSWk8kXgyU2uM6ZHBXZGnkEDUTSxR9KxOOqdcRbulrqjLc9jI9Y
	ieDAlGCt/Q+x59JcGAPpgxG9Dpe7UgZdWKvp5UcfjSJBkWFDDW3OcscGwRBnbUEnXmc5slsWYNm
	h8SAo1CNMBt/0nlWH7QvV6kBAi5lzL5y+H4w5hox2mpmrSab/RT++nlqW3iPLAzPJqDIkHl8MUf
	VswQ+Neoq6PQP119oHnKtvxCb6vtsjo+PzxYv9irRCxRjS+mn+ygDGFASkG2rtwe6vJ/hB5fA3M
	Vex54IbrnbQIg3ZS72tieaRPkMu3tCAtAxUKzWaz00FGB98AXrJUIUYmJTKY99hc3oCEofitXTy
	rXU5lgPYlZAnVGM/c3H09hdqqurViJx8fWAUqhl8mpsgn4vzLkxXhD3FAunfWNQKmxxg8Ko7WXY
	zFamNZxPgYcTSwKcLF7v5IpSlBlc42RAa06notMbiNkuHNigpW6LMWfzuQYAub
X-Received: by 2002:a05:600c:630f:b0:487:288:1198 with SMTP id 5b1f17b1804b1-4888359da58mr102555095e9.22.1775120270131;
        Thu, 02 Apr 2026 01:57:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm217845265e9.0.2026.04.02.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:57:49 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:57:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <20260402095747.6efbd456@pumpkin>
In-Reply-To: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Apr 2026 14:56:01 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The old value passed to cmpxchg() is semantically read-only: it is
> only loaded into a register as a comparand and is never written back.
> However, the macro currently assigns it implicitly to a local variable
> of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
> when old is a const-qualified pointer and ptr points to a non-const type.
> 
> To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
> old local variable in the cmpxchg macros. This explicit cast suppresses
> the -Wdiscarded-qualifiers diagnostic.
> 
> The new value is intentionally left without a cast: new will be stored
> into *ptr, so silently accepting a const-qualified new would allow
> callers to store a pointer-to-const into a non-const location without
> any compiler warning.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
...
> 
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index ae1b96479d0c..b4b8dac759c4 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>  
>  #define arch_cmpxchg_local(ptr, o, n)					\
>  ({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> +	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
>  	__typeof__(*(ptr)) _n_ = (n);					\
>  	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
>  					  (unsigned long)_n_,		\

That looks like it loses the check that 'o' has the same type as '*ptr'.
Maybe this works?
	auto _o_ = 1 ? (o) : *(ptr);

  David

