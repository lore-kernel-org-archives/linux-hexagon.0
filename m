Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08504D1790
	for <linux-hexagon@vger.kernel.org>; Sun, 18 Oct 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337251; cv=none; b=Q/9idy2a0Dziz2UzKZSxuFKQAHvgzkfQ2GtK0gK0LXXziiXzjzn8Ni2PVGO7dOkhwu6Wo2jiWCnnnWV+HrsbJUhdpuKBicRVwnHfpn+2QOA+7JRFMKm6oh4kc4v76j1W71gChKLSBKLC9q2O6cYCIsO0kEd8O5Rj4WkZuvWyPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337251; c=relaxed/simple;
	bh=Tc7Slxp62tn7lMBuq2MMamCQYVGOw9llz5BUjwRrgmU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N1Ot/tTGVByLnU/RAP02vgN+kAJrPrfoYQYocrna0wi8RjlatW06REUl12Vx3RoxjF4FVHFYCXKwASIu4DB9QmjtnHSgS0uYhEfw+gW4FJNK1P4qg35imt/XdN2UAMLoe4bEmnw62qTBg9KilwPUOE31ZNu+bXqsxVTAHgHslaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWU3XXLj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWU3XXLj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so17839b3a.1
        for <linux-hexagon@vger.kernel.org>; Sun, 18 Oct 2026 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337249; x=1792942049; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PLi9hVkCsH3YiZ+w7j8S3/cxhLWAMV2a1RCiWoqeuBU=;
        b=eWU3XXLj1apmWWABy+WJ62AjGgj8RaOGCfKViHbBK82fHbhDBRSgK326S3zh3D2xhQ
         IisfQdTU7oQsdCWMIx9HV9yNzFKRJhE2ngceFeqe4RxhLTd02J1N9yXBe5SLuETgdodU
         BjL4oEpzZD0qZT8br4rz/wIEI87FAix1Whp+3Fmgc3mtFdoC6QtTRe7JaD9leWLlefyy
         LpSZ1Uc4TrSgWZ3GT20MSTV0KTO4jIdoCu67X8jxOmB2Lpvcb7nHB9c4/zKGxSfvAxoO
         cU3mFNz7BXbSxFVuY0Xv7Xa3UcAfExLB62GFtC9aQd8GFkGTbtAVJkMmhI7Bg7TWzWH9
         kX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337249; x=1792942049;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLi9hVkCsH3YiZ+w7j8S3/cxhLWAMV2a1RCiWoqeuBU=;
        b=BBzD+2hbBwNi/IjdDF5jQf9yw6SgpdasdVgli8nEc81ISSL8oakMxLRhpbnU8FJxM8
         bSEqM2N7jsQidRo6R3eo3tbNn783jvdLUTRYEdvLHPx8d3YMMiRccw92JF0B+tAnuluk
         pUmZMrlVuZQkFsWWpQmiVzkGi6EVqvCamlQZayZuY00KlsUEZkoHS/YJPbLpfTslEOSW
         uhlucnAEj14esr8imts7ekxW6tFJMI8B82MPsDKBHRZtRLeJkHZgLvUW7aO+5srnygEo
         l7j6wEU1CpNabn9G8r4sBz5NivC8c59bmG8E206a67d74mWtKePfRnLqXuN1DS7cfORE
         7h+w==
X-Forwarded-Encrypted: i=1; AKwUvByTOwxnBR73NmO5+gQgjRLaM45jBuZIgA6IZpXbT43hLxg4qp4/GF9Frq/HmVhmgs5xhrLGP4/gE6FVVe/R@vger.kernel.org
X-Gm-Message-State: AFq9FYJtEU6gHvJYGfe79dSIsy9vO96JsPUPgmCzIHu3htn6b+4iRVbq
	9+a2TRhkceFUv7oSqa4g+DqGFJjfRM3b3oK1Ignt8+lWUw8uVpOol7p7
X-Gm-Gg: AYBFou3Ctw7aFjOflSo+r4ltby3h4+XikwvD6SSY+onVDpKHrB95EQp71qWrAwkvWL4
	b7H4D4zW5TeRt8VKYVTXOzYeN18/JwLxF9rZc1CenA0r6P19wMmLL/BSSfVQD8qcvtU2dVQBM3Z
	UGAdUbexlGbfte/DlVPeVEolFvpGerdkKTcW6JoaSFdBpwyXGL7TXEv/kO7ZYlJL5CEx0ChqZS7
	3wiop+d1QWRczrcCN7FuXkkAu5JtSe+DSX15dJO4JC99klE4lWmePKY5Om/oTjGnwR0mvNygLGk
	lWzIoCAyQfzT+oe0YADyUGwRYVH7zSR5B9XXwxrCr/N8/YOs0j1THGsmiJdnbcUF6Nk7EB4qQCo
	H4IeuQ3FloejiQhfGThS62H0gkcbe9iDL3eh/ktfTiZ618cvEm/rwpHCmtcaZlldc9iUJwNTibv
	QMhV6UW/+AZRINOL+/Ygl/IvNJPSA6sED/fkoVG5PBb3+X6cJB9mwtpmrjK9/rgGWgxFNI9d8Tp
	fqAK0AKtCjbm7Qx/zR5EYAQfLPnFUVz7Nc1TrZ7xaSChb5I9hMIvTIgGsCxt9umCT9mdi+1QMDP
	Th4YFWCCfl00jA==
X-Received: by 2002:a05:6a00:b84:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-8a04cc24de8mr4216832b3a.32.1792337248874;
        Sun, 18 Oct 2026 08:27:28 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm2997008b3a.42.2026.10.18.08.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:27:26 +0000
Message-Id: <DM82J03M6JWF.39ILAQJO5Z6E2@gmail.com>
Cc: "Josef Bacik" <josef@toxicpanda.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Jonas
 Bonn" <jonas@southpole.se>, "Stefan Kristiansson"
 <stefan.kristiansson@saunalahti.fi>, "Peter Zijlstra"
 <peterz@infradead.org>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, <bpf@vger.kernel.org>,
 <linux-snps-arc@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
 <linux-openrisc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "kernelci.org bot" <bot@kernelci.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH bpf-next] locking/atomic: arc, hexagon, openrisc: Define
 arch_cmpxchg_local()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sasha Levin" <sashal@kernel.org>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Vineet Gupta" <vgupta@kernel.org>, "Brian
 Cain" <bcain@kernel.org>, "Stafford Horne" <shorne@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261018132907.3823160-1-sashal@kernel.org>
In-Reply-To: <20261018132907.3823160-1-sashal@kernel.org>

On Sun Oct 18, 2026 at 1:29 PM UTC, Sasha Levin wrote:
> Commit ccb88db8dac8 ("bpf: Don't hand out a linked element as extra
> element") made alloc_htab_elem() take the per-cpu spare element with
> try_cmpxchg_local(), the first caller of cmpxchg_local() outside of
> architecture code. It doesn't build on arc, hexagon and openrisc:
>
>   include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit dec=
laration of function 'arch_cmpxchg_local'; did you mean 'raw_cmpxchg_local'=
? [-Werror=3Dimplicit-function-declaration]
>
> raw_cmpxchg_local() maps to arch_cmpxchg_local() unconditionally, but
> these three architectures don't define it, and unlike nios2 and
> microblaze they don't get it from asm-generic/cmpxchg.h either.
>
> cmpxchg_local() only has to be atomic with respect to the local CPU, so
> an architecture's own arch_cmpxchg() can serve for the sizes it
> supports. arc uses its relaxed LLOCK/SCOND variant when ARC_HAS_LLSC is
> set and its atomic_ops_lock() variant otherwise, and openrisc uses its
> LL/SC arch_cmpxchg(), the way arm64, riscv and s390 alias theirs. The
> hexagon arch_cmpxchg() only handles 32-bit words, so hexagon uses the
> generic version that disables interrupts, like sh, sparc32 and xtensa
> do. Linux has no NMIs on hexagon, so that is sufficient there.
>
> Fixes: ccb88db8dac8 ("bpf: Don't hand out a linked element as extra eleme=
nt")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://d.kernelci.org/i/maestro:78b65519ee4561df1fbf1e72f1dec9da=
7e5b153e
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610181750.BoqAddaF-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202610182048.aEaiBP8W-lkp@i=
ntel.com/
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> The only user is in bpf-next, so it is probably easiest to take this
> through bpf-next with acks from the arc, hexagon and openrisc
> maintainers. A similar change was posted in 2023 for objpool and
> stalled once objpool stopped using try_cmpxchg_local():
> https://lore.kernel.org/all/20231121142347.241356-1-wuqiang.matt@bytedanc=
e.com/
>
> Build tested on arc with and without LLSC (including both KernelCI
> configs), hexagon (clang) and openrisc.

Thanks for the quick fix. Applied.

