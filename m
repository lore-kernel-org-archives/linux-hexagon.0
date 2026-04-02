Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169413DBD78
	for <linux-hexagon@vger.kernel.org>; Thu,  2 Apr 2026 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135284; cv=none; b=VuclCak7SbJsaYma2A2TM5wbkA6AQNFQnEpe7RF6trIxtiorLX29k5LgdXqS3RHtcOrtsyrl3LBD7xyjW7ssgcNNJqrbU3+pGwH7RzL4hOD1b1wM5ysgxQS7nL90K3Trv1t1iatnWhUu7XVIlmo+uSyqxySw0fPseGtQxSK7ERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135284; c=relaxed/simple;
	bh=J6KuSzBKCDeaYiVgmtuuUSqnvej1+MF06b183JPn5yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdc5Y+Gj++AB4rhjYU+u6IcqzkWMB/gKx9cQsFWxX60J9j6BQjIqXkitfN2sNO+HgQAYkxodM+CklXU5IfSojwm71UIXuu8+/fBNRdOc5X1NpC27lkuD2v4iaGp5trP5ysXF13O8jqpGcb4c3uhKmKZT9pWSqSKuzdmF4GCRkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJY3Xeej; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJY3Xeej"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so497398a91.3
        for <linux-hexagon@vger.kernel.org>; Thu, 02 Apr 2026 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775135281; x=1775740081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWxJTOWQkri5jmv5ZKMT+tNuIWsfKgbRVKTEMtbqloY=;
        b=PJY3XeejgWRIMXpyhMO+u6jxmLwxcfufASnNiIpFCkeNcvwAsithilHAfhY5wy/vng
         3OIgjRGhBHlDo5N7PhFCoMz9TVsP5yETjR5N7Rh3OlGy17wuPY0IkACiql1W0ukMTSqo
         4KvtkNtw4f3WQUJyfGvDBYgAX7NkxzjN7CDvbMU/GWg+T8UtV8yaT2+0UTb5iIAZrys9
         clV/yGPMxreSzrM50jf83Q0/nyNXCMX0BSbHk8PawyfpLZbdrSkfZyovK97mRRnBNt3W
         pKYWlCXTMLNkGPJ/Sf4MSUpboNvn+sfYQcnjUa1aeRK6+dLoCAcQehPMWL8oFNC3pin4
         1z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135281; x=1775740081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWxJTOWQkri5jmv5ZKMT+tNuIWsfKgbRVKTEMtbqloY=;
        b=NPCdnY5umapkCLpGnKlxzYUHOATPBWyb0jooTokdYJ5UXHpY7O7L5KLG7PgA9pp/c/
         MzUhFcMaobb+/Py4fJQczD5DAfoVpKD9bcM22T/05121qDr67riAhRQ3Qkwr2PxCwg+O
         7a2IM/bx/JYd28VsOcIfGWKvDy30XqtzKjE1jfb7aoEpoM6qPpRwmkSi2wjAmqz/ATTC
         buHmCQ8GIWJ1lbIE/iEdGzGJfX9R6oKUcNHXa+6QM3e1lgPOC75h3a5BRgGLkx6y47CN
         Ak3eoqvzTwR0X83RAT2mTLF9OnGQSBK6zRSv5J7lLOX4UInYSn4Y/iSWotAmf829oZ6j
         SlxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoKqEt+keVVZRGTDg2Hgx4GVRnIfCDMjuywzBuA/FmhCVQGDdLBb+7v1qmDwBce3ut2/NAv1RZyhM/ofkF@vger.kernel.org
X-Gm-Message-State: AOJu0YzNf6wK+XREQgxUXoeVSUuioiOXTeYvIXuO7d1/5CcMbjsk4/hs
	G/cqb460qNDBLH/sILzizyKGXrFm1sxBE5O4NsI2yiYyQxfk4kz04wZs
X-Gm-Gg: AeBDieu06P8tyybqBgSKhWGVQmhRWbpoM/skHbH7OL3Dul48Z4vTka0OHhwNOuee862
	ELBEeHGu+yx60cKIrdANx8hlt9/gg+0sw/3vnTvuYv5F2S8xDtSgpYO66kEROrhdSH7bKXG5pWv
	b81JnAnKI1+jm55X/25eyr4xA6g/N8s5JjMPYRVeLMaZyZ6tpqZfZfaNqDdTgTesUEPpldcfIss
	UPd1tJE1TrAF16eDYYvkdub4AIcCL6i0ASeP8VwftAaOrDfjEk2gJw3soNv2ZmEz7Wip2vO+bNL
	JPuNc9PLFg15Amfqr4xcCbNIyivcKzH2ANoE8UsO1+cyXxRMQ9wxKCLJtwDHvO5dBRYiFTufXwa
	a9nZzKtXoS+zCpFjV4YdA+ZO17+ta8dHCsdeOaRAGW1+2s9dYaUHllWJnAm6SmNPRygaVjchGh2
	aDKMeBCMlpJgyLtBL9+ouoRM6fxco=
X-Received: by 2002:a17:90b:4d81:b0:35d:a412:3c79 with SMTP id 98e67ed59e1d1-35dc7079cb6mr6805318a91.30.1775135280985;
        Thu, 02 Apr 2026 06:08:00 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe41b11fsm7822915a91.0.2026.04.02.06.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:08:00 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:07:45 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <ac5qIUS5azbWAc9q@fedora>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
 <20260402095747.6efbd456@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402095747.6efbd456@pumpkin>

On Thu, Apr 02, 2026 at 09:57:47AM +0100, David Laight wrote:
> > diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> > index ae1b96479d0c..b4b8dac759c4 100644
> > --- a/arch/alpha/include/asm/cmpxchg.h
> > +++ b/arch/alpha/include/asm/cmpxchg.h
> > @@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
> >  
> >  #define arch_cmpxchg_local(ptr, o, n)					\
> >  ({									\
> > -	__typeof__(*(ptr)) _o_ = (o);					\
> > +	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
> >  	__typeof__(*(ptr)) _n_ = (n);					\
> >  	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
> >  					  (unsigned long)_n_,		\
> 
> That looks like it loses the check that 'o' has the same type as '*ptr'.
> Maybe this works?
> 	auto _o_ = 1 ? (o) : *(ptr);
> 
Oh, I didn't notice this. Thanks for the comment!

Best Regards
Hangbin
