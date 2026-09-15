Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2A38F92F
	for <linux-hexagon@vger.kernel.org>; Tue, 15 Sep 2026 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488174; cv=none; b=VsdDpxdSmSHBv2SX+MkVjmyDu3plk9szvwE8VhXKwVtlxt6qIE7MFeOoQS/0RPD3favwjbvAjoYydAZKvBrrRonqujqmP0tICkKkq/easopSeeBrEurvA3o/RagAnKQ0Il6jWgJVEJyFwUDw112mVRL/L1lm6vavNLExtOQLJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488174; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thnVg/fpqVt34JcTkAJUwHI4VXtB/JbyQfdZSom9nb6pdy1GJYQpdVHTcPqvkiniWg8YBI9sDHFOLqvMKhhkY01cmcx4aVOtCuE+4aHm5wyFCg83y8HZ6MVaVR0g5KuE4c0WrqmAbtLeXeTyZEGUEKJdkOI7X+qnzks1vgDJ0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E+D+7M3D; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E+D+7M3D"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so2031661a12.1
        for <linux-hexagon@vger.kernel.org>; Tue, 15 Sep 2026 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488169; x=1790092969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=E+D+7M3DRkVpJfuMahycnc8zb/8EkB2IQNAur80nkXqSWB/Gxu2vMF2rRw02vk7gi+
         8WDo9yWdiqG9bsffdnEkagwnEll+jZxtjsNfkXJe/Tr9gDg/ZbyPWVrYWN67gTss+Abx
         xndt5ghl+H18F0feevq5unu/6GHXlDKvd/yQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488169; x=1790092969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=GqW6/QHhbn1d43HmNqFCfwg78nq5ij1TWS5lKHbQnJRzpg1zIzrHPRNOhQc9c3Q9KB
         bTAtb9c+Obf9Bl56xncIXIQjZz3zS/WJtZAf7SeJv6jK2TM9WTYDyZ8nZaSgKqJCPioC
         rbZViEAY2M8pTivRqpP2h+jr2kWLNQarmlzrBHb7YTW8ec3R6BCcH3US6voz0mG5csbK
         KZC5mkJ8JwGegjMcb8vXvgqBQn7KH3znLzrOY5A9pez4wVYt1OV3PQPieQQEX3mPqOcW
         Cl6gZHTEZgZWi4CDHj7j4Wq7uI3Jt12+1f74DZXhKPZxQyrUW9cDSUY3yMrXsprKg5iq
         52IA==
X-Forwarded-Encrypted: i=1; AKwUvByrnU0XAamTZWqiwRXe4jCX65eIEQV/Ir84Fcv8oWoMCGoQp1VN13k0b8xagpJm+Admklcp8nGxLIxZVfj6@vger.kernel.org
X-Gm-Message-State: AFuF++mFKSioT/drCUy9a7bWDPzBVwMbSV2K8uim/KFMKNCGHbWk8dVH
	qgkXR3YCpkuAt4kbBeuO/si9AUfzaTHkGj7sPNiBjhGBXvtoJ/inRY+VCjpEvlu7Jpnv0ftPNSf
	X10mQbww=
X-Gm-Gg: AYBFou1cS7NBnbbEwsAN6YJfw7z5JqZlD45oyrHe1k5KVH7l3wMN7H4nV3jeKLsyzim
	ViOkfInSu169ePdupf2Cx78NWPYBR08mj9WwBymL7Aj/Lc2Juq09nnRZuqorwibBfN42mjAfhTB
	NRwybwBLBPN17OBqpyBU9pH2/Ro4rbKLkXEmigMm6uFonBDFV75AktjREjBTHDiDKvIl1F95rFT
	P3EF6/pludMkqD9xatejxKwQsoDxdO+ercDCQgn+j5kGDzGoJiVN5EeGknUeDgXYpv9sOIV7odh
	Vn3UMK1aOGVpsgClq2oqHiKNlQHmEe6x9r+ZxBAyv4FiEkWDd2UeDT7nEeI3txHq74FUDc30erD
	yMeM935vwO/UAcj/ElMaTI02TJIFmYp9dQE2Qo8+QsjLHd1KWSkEtLvZ80nSHBl+xEzJl8Tu7Az
	9gjMhiQIFjn5EBWMwBToYZqybzOFtOKGbKg36fR7YurxI2pSRUjuI0gK8JEGBL9RwAHFIpuI8YH
	fFeC954vxLheZxhLp+T5FQYUrJzjcG2M3aBsmH+kxF0ThGKcg==
X-Received: by 2002:a05:6402:428b:b0:6a3:691a:9d71 with SMTP id 4fb4d7f45d1cf-6a9f6238594mr5381325a12.11.1789488169256;
        Tue, 15 Sep 2026 09:02:49 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b58f8528sm6143478a12.5.2026.09.15.09.02.48
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa4c24cso537076566b.2
        for <linux-hexagon@vger.kernel.org>; Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEeAeBD2CqZOKCbpQpD8G/tZdNsreNca7I2RvA0eq+On4+Mwc/r+y0tSx+gHpUgLk2nPYS3f0VTVjVmF+T@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
