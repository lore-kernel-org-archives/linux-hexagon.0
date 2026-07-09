Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F71435EE1
	for <linux-hexagon@vger.kernel.org>; Thu,  9 Jul 2026 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614427; cv=none; b=V0jNAcBH4R+pbFsr2BGBjYSO7h+dp2jqurm7WpQbiCFoBJUtsH3O+7rcvOxHBnHCU/cNEo8lAaQ7Tnhr+G47yh7VQMfpv5GmFpQnhwLn+W8WyKCmmZXCR2G/ZySSG7BL0ybOMZw4umZiyetI+PUu9w/uC/S6Caras3xXfmPn8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614427; c=relaxed/simple;
	bh=S/xAtxH9kCAjFwM1/MAEgEQMpcNiqhEBM0MEXLopRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FELSPzNx7ooNFNzuOTcd+6ff7zRl9WETchUD2E3B7PSPKRfCwmq92hFdTZiFj80feEHkhClxBJp1AEiEPDU3/ayROsNUSOve+gjg/RCVs0cJKQ28OgEV8iE2squewnaJm2o9pU6WrMBGNCBivyYuADqKr+zKv7azKFlBlHBBcSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f66IYRb3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f66IYRb3"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso33935e9.0
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783614423; x=1784219223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=f66IYRb3W3n4wUp60vuJmeagFdempVA19+GvfglfbGXQNr32Jgf6Zu59Uj+bcep6dg
         jsx4MIO/Rg0Jc8lrVT/RQMxMMW76zzTchDs11lEHMl8wueX5jr2m95gnsMPuCp+FiVia
         BXcS1RfCaig3WVexG8fiT0f1WyIZI2ZFqmCdfMorSUHquBf0Y5WGXwn3lYxbxm4/2faj
         NWGL5ZyKcF+WzWoxiQjAkz+rxwePY89gZ4a0ESMuDMMFx4G3ZLECB3j0O5NlKwsrjWw/
         4IqBiE/i3mAHjgYbMO+ob6qHoEPfbgtS+ClBm3imDY87X4M/jBzC1B5Fmge7V4/JxTvX
         p0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783614423; x=1784219223;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEOL8DOWD1Msvjz7k5cAG0xDAOqwGsu0BnpwMff10wU=;
        b=DeE2Dm/IIMMKHVBF4n+RZwhT8fh0gixPZFYSCk8RvZt+5zKobc1cbAQplV4ix8/NsN
         izOjr+yM9etimJtW9Nar1ivW/Gj5d8FCh05f/CpcKAvROalOYenFrPfPvju1JZ2jegSu
         3S7XpQqGwd/OR5aAEM30F82tWF/hwOr6AsWxTWSDs3zEZTpCtC+eF6itHuIaTE/N165r
         BrYklnLNEFXLEwy2HfBsTDkoBKf9BaG1BDD8FI0PQnK/etrnLQ0qqcJnyq7atHjX+ZKL
         K5SBrzHlqrohM4bY2QVK6t7nNTlkvFCi9G+IAfLFGGy185eY1A51hG0VVJ55Uu1OIHQJ
         kPHg==
X-Forwarded-Encrypted: i=1; AHgh+RpbBjBlupf1gQAu44GC9fPZCBwKY9ML7Qtdtma6pmio9WUXdVcmfgB+7RmA/5PXnJDrIaJ5Zz5Gc5e5KDgM@vger.kernel.org
X-Gm-Message-State: AOJu0YwlE4b3c4a6kwII4ivDBydfp/1AAMFxiP2r2y+g5tBw6y6w4xWL
	ykxYv1pWVeaZSzSSGGVxI4qDpifF/MKuKuwOnZtUQU2X4dqW4RnXQT9n
X-Gm-Gg: AfdE7cnjXJFDVOu0l6rbcDydziFCNiTCxpFTXw7eW/7xTmi145IWgMt3eAQWCgNuMtL
	z7MQMEKCtgzDbFqcOoEZbRY4FYyWzNxM/J5/mN1hPMf8zTHnrDsBaRSSMyw5/RvIOjT9ebBuFNs
	RW2ThMvNqieFw2qSbZG5wdVteCiKZlr4KEpGrbnIZin/Ce2mnpoxA6vRoV6tJaZ31ewmCcg1JQK
	6woNdD8AcP2NsZ4ry/7kQojlkL0LxHPcFYDaIaMN3TUpkIbaTWAbnssGFX/aOyeETB20BSpeGXa
	ZJovH8QyoLu0hlOnBQVNGaOI5bQD00pxwcmemV7nuquGpC9SYWJtsxeJvei2QLvAJ+bPD7ULWeL
	R4etOnFmW+L+fxLrhzc/iiuuhFd3We/C2hHXTLBfLXSiRPvq13GvqwScM0BKKVP17YUscpr85pA
	1Kc8zP9vtJmihYhO4aCM6tGChTIQDsK0tpSkMy1bQe8iAXww==
X-Received: by 2002:a05:600d:6405:10b0:493:eec0:2b8c with SMTP id 5b1f17b1804b1-493eec02c80mr19641245e9.12.1783614423204;
        Thu, 09 Jul 2026 09:27:03 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb670a41sm70023415e9.0.2026.07.09.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:27:02 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:26:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook
 <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Guo Ren
 <guoren@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Weinberger
 <richard@nod.at>, Chris Zankel <chris@zankel.net>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann
 <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Will Deacon
 <will@kernel.org>, Brian Cain <bcain@kernel.org>, Michal Simek
 <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type
 bool
Message-ID: <20260709172659.7040db33@pumpkin>
In-Reply-To: <87ik6pqdkf.ffs@fw13>
References: <20260707181957.433213175@kernel.org>
	<20260707190254.338083894@kernel.org>
	<ak5ySpil83TNWxeq@kunlun.suse.cz>
	<87se5tqkyp.ffs@fw13>
	<87ik6pqdkf.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jul 2026 01:14:24 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Wed, Jul 08 2026 at 22:34, Thomas Gleixner wrote:
> > On Wed, Jul 08 2026 at 17:52, Michal Such=C3=A1nek wrote:
> > Q: Is it perfect?
> > A: No
> >
> > Q: Can it be made perfect?
> > A: No, because you can't change history and established practice.
> >
> > Just for illustration. Changing the logic in trace_syscall_enter() to:
> >
> > --- a/kernel/entry/syscall-common.c
> > +++ b/kernel/entry/syscall-common.c
> > @@ -9,13 +9,15 @@
> > =20
> >  bool trace_syscall_enter(struct pt_regs *regs, long *syscall)
> >  {
> > +	long orig_syscall =3D *syscall;
> > +
> >  	trace_sys_enter(regs, *syscall);
> >  	/*
> >  	 * Probes or BPF hooks in the tracepoint may have changed the
> >  	 * system call number. Reread it.
> >  	 */
> >  	*syscall =3D syscall_get_nr(current, regs);
> > -	return *syscall !=3D -1L;
> > +	return *syscall =3D=3D orig_syscall || *syscall !=3D -1L;
> >  }
> > =20
> >  void trace_syscall_exit(struct pt_regs *regs, long ret)
> >
> > does not make #2 magically go away. It's still the same problem whether
> > you like it or not. =20
>=20
> And just to be entirely clear, the syscall() interface has to be correct
> in the first place, but then it's all about performance.
>=20
> So the sequence of:
>=20
>    pt_regs =3D PUSH_REGS();
>    syscall =3D pt_regs->syscall_reg;
>    pt_regs->result =3D -ENOSYS;
>=20
>    arch_syscall(pt_regs, syscall) {
>       if (likely(syscall_enter_from_user_mode(pt_regs, &syscall) {

I guess most architectures inline that to avoid the &syscall.
Otherwise you'd want:
	syscall =3D syscall_enter_from_user_mode(pt_regs, syscall);
with the 'error' return being selected to fail the test below
(which -1L converted to ~0UL will do nicely).

	David

>          if (syscall < SYSCALL_max)
>             pt_regs->result =3D invoke_syscall(pt_regs, syscall);
>       }
>       ,,,,
>    }
>    pt_regs->($RETURN_VALUE) =3D pt_regs->result;
>    POP_REGS();
>    return;
>=20
> is the correct and obviuosly most efficient way idependent of the -1L
> return value overload in the original implementation, which this series
> gets rid of for clarity.
>=20
> If an architecture decide[sd] to do otherwise and makes up it's own rules
> which only cover parts of the problem then it _is_ an architecture
> problem and not something which has to be solved by claiming that every
> architecture has to implement the same nonsense as you falsely claimed
> in your RFC^WPOC^Whack thread:
>=20
>   "However, the API should be specified in a way that does not require
>    everyone implementing such flag."
>=20
> There is _ZERO_ requirement for any architecture to implement that
> flag. Just because S390 decided it's a brilliant idea to do so does not
> make it a requirement for everyone.
>=20
> No. Every other architecture got it right because they looked at the
> historical patterns despite having correct documentation at hand.
>=20
> Feel free to prove me wrong with actual facts.
>=20
> Thanks,
>=20
>         tglx
>=20

