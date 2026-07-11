Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF527727
	for <linux-hexagon@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772967; cv=pass; b=bFv2zR5+5l3RwLcbYmAXy79aZqjo81HlR//qdISqc+4baZL77F7QRwu0ThhBuSHXOqRn8gRrdnD8D8o6SyJPWR2d2TQLTst+Glnvv2hys3c8v1X/spdG8/KmEYZ9QKp7H6pyGHSjuTyO3JPbnw35o+ZsosJXnDRT7MrEfwr4XgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772967; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n51OnNR2EJHP6s4FDY8ikpgPAfV7O7yhLpcGNGV5g4QsQyZegb/jJS34phenhluhgkKbDSxBbeVrqJ2i3Qice+kZCgzeszscz9cad28kh/Qqq8/1EgLfKWozEDx5ovyoO8NdKCvifA+7RR5WFkMD0OT5PxOs9yl9qZYpU2G3wu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2817331a12.1
        for <linux-hexagon@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=kMr01mtm0tXsaq6DIXKFejh9XGFp/eaxTVjzy3rHpfAxCb6GClPurqT8TPlbYVgdDc
         TRTYuk8IrRc/NcsobfHoSBKDeeKW3MnPUz3RIrhB0qW2TaheEl8lozGsv9con6AfgN6o
         /95TeOmlLc3gksgZbu/SBtohyykfTOBlxlzkbduKJ2HarIjHVAoNMjYYps0aWIVFIzSV
         ZvNfvJ0ViZBmtMtvRmv5/Z9jAnheD4tzj9ORvK3RVGiSGWczmQR1rKhu1AR5487G/K93
         DqK8KgawRW7xQFdSN1nF7NtvjMfBn1GA1C3WWy4/x9ZPkRPgC4MTvLHJXQk6p2iguafw
         cRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=d/1b9PG9DQRw3mdF0eelcWDFu3e8BaqE0AubgVPywEw=;
        b=OJmW5nx3LmBKEroWfZnKeW9Ba9UhfLOyxGOSmfAx2q7lEsXq1H3Ydb7MpjQPhGPPOp
         FlSN5/FihF2MWm3UoLKrKLk9i7xqO6D+3FyLoNqSuKqBmTUZn3NqJHpVMHCK0Xs2XRwM
         bnBu/nwOWtj9HfWtfm9ZUqr6MkWF0SPTAIrirHF97ELycvz3NKbsuIei0+cJtpxGWdkn
         cgCm4/u6VHGT9v0T9XhbfN2a39ZbwgXvq9qY5U+yDzsP17IsfVZIvP9aGkuL1qfEXQmd
         OsPmwKj9OL6nTCDcjUbkIqQUaipLldpk0HZzjKtGFnwCjWlksIlHWqtTI+myRTthNzbc
         L1Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=eaPPy/NtPcBDN8ttt1FTNLtA27ayMxsZR4mzTq/0sUGI93ZNOCtmOVHzYoJVReg27I
         tNfqjDcbUem/nl6rL07OrAHPBlMKg5LWsf3lOqG4yBBX8L23v/abHZwX9DmnI+OSvGxs
         OiW1vd4yY7R/KinY3SnAJY8xi0DQeYP0/2wmgTCmsWlQt1nitvpVnURsLi9tTfmsRoOV
         xKDtzmxD1Ger0SkvF/sNERsFuBNzW/Fc+XO5n9UuzuwGK02Vq42smqxh/eniZ/ct0++7
         gm1WTqYd0paaFUJ1eomUG0vPGFyqrdFVzXHw5GWb4I6edSk33YU3nQM4rhN/92ABdL6J
         pD2g==
X-Forwarded-Encrypted: i=1; AHgh+RoTwY+y/f+3JPrpesAGRdyOr3W47tSAmiBVuZHYwPjwpvd9B5BktU1xsRlHdwxF/TL/kAx7RAvJfkcCeJJv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+s2OimeCbCVTnUMu0JQ8mqmIw6hi3brirEYlBxp/m9SW2s9/
	pidCbsfyB0mZ+3pQoyJDRKYhmq+lfx+BaaOwqptR9tWOIqZmmvaZ9usfjB5Wuck6G/eRXYBmi6C
	RGWwNj73gHuDq34jdOg6F1iOReofDbjY=
X-Gm-Gg: AfdE7clYnXvS+vLwcJzV4lF9BHvoGTCSNdyfDxFHVllkA0bIIgz3TFzzR9328oFDF2t
	ICxZvk86s9+VyBGzNJE3ZqjfjwtlGn6x7ufa1Z5XOhzbQTso+GanDbe9mHnxmS30HCUGCZ5m2Lt
	elyKr3nnxRi3Bm38lBgxtrwfv3hZV2fRwNAiofwVINsnv+tOeJBZ0yWR/+Kesch1uDsBYR+QxXB
	BGhnGkPUQk6/mzmctL42CfIJ9ZeLRmW3Z/s6ulwh0UDLj75vGyg4VJfdA36nJzP/iG2KKPCEA4R
	NdCESd5jQqZlyEp72+1fZYkkCIfIJVLkaYMidu8SpwYDW24/lM5on5z8q72O6AM=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
