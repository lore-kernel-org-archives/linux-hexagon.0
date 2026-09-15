Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A0F3D5C06
	for <linux-hexagon@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494729; cv=pass; b=acyGG+nN/bu1/y5O3Bflp8YkBRgeF6vPgd+rvJ1/B0tLopOFZS8BDpRa+qDYZ0KmQ5rxbmaYQDuBdtAEUfbyKmiVzZfgFeqD1aMRsYhD8EMI3dokb5nqkGcJvOUvxO5EaC+JPgSEt5aXyrIWpYRDVJOKCvb98D9GWvLn6x/5dfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494729; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl7TMPFlJ8PPi2roC3Rx87K2x2ULHTKuVTh1/2F7eAdtQzKN91MOYGVEI6+ciWfY0qSMV8zPH0LB0SGf6FJYrCdCa7br8g10LF84WSzG6QajOQtxLtyLvezMXiU+F1buEcQWd+wXEhJH8Yu1FsOGMxTywxYniILVDPZDD1kY7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12135ad.0
        for <linux-hexagon@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=hiB8TIfoOF9R7TNC/MitJrqFUnrSSVheRTalELmSgsdcS7KqzzuTpAxfm+9DKJhq9m
         cuy9s9VTnudDTxp4IcY9mC8wUA0BD2S0cW4Ax9xgmrfZ/2rk4214fjCU43F7K+Lx0/Dd
         Ok1sWnfuTZIvFfv7EmaPnMq5x9GmhYNrWCEPiHADzZVShdfNpm9CwVuNCnLGC1S0bd7J
         uV1hllGnnLq1OGXeVmTR05c85Jilxo4OsIrq43lkxtiJWhK79DcGbBfFr0ypFd+oyTPt
         DfkgJviwjopjTWjP70G8FL7aibX92Nx9UMx0e5ZlCISz2uAM2/dty1uvvoXzE3jRgVxU
         kv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=ss/qY/cYURm6zsmwLk1ZMgK9udzEWBl51/B8XF6pjBU=;
        b=jPo9TPkvJQQHPhsMmPZ/CO51N8fAvSHDieRefLqp9DK/oWkXdc/ziZR0qpUHe5Hyjk
         WUPpOpLLVpfIw2tDLXKtZOkfRVf/7Bp3baTvLFX8sUBqusHSWyNwwuPQ1K0blkEbNYw2
         OnCQ35lR2lCc3Yr5JRAp+PhC4DwPNc7O3Zj4xefpYIU69yHhEnLPdrhOElOMjm2NUvcV
         YwZgQDgwaIn0qauMHQofDyi9oi4zy3GsgW0lvzfgNvrfNq9RU1claqF0CyIve8dCfZbu
         2EVdw3bhEEvk5/9sZjC0kyxTUCtnwN0ZsxWYPDi1qgtitS7V/EpEtfEXXOKXkHMmIocD
         wMaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=G7FRZLyK8JHk/R3kbcfcWoC9tMQLtyCRZUMsgbKFcc0Nw/+Hq8B8w58nE4DQuMCpkA
         uP1cI2w2C0u9ZmvvxfKRPLUF3A06JaYP1+5BjPwdpPrhMJ7UycWghpkScnOJgK8j6U6Y
         XdQiD2769lyE34820AWZuzWZP8fvVscgzt/V5A16kJgJOWfn+9ErgN/QSQqeY5eO0D9I
         oiEQTOUL3Fti7KuyjzsqhHFLjPd3m8rFKIESgRFOX76D6Ik1SRh8bFXoN1jg2JUaiRzX
         G/UxT1wXZbCKj8hA2LkXLeVlBhRe0Sv4gyTTGZdqyNCTDLt5DoIFcAOnGVPxnEnBBuTL
         Ci3A==
X-Forwarded-Encrypted: i=1; AKwUvByDwEheekndPCJ540Oiz+KCTkP38IcE6jxqjwmQZQNRpvCIihKnlRsmyPgoJSAbiTjEp7zbURZQ5KSibVlX@vger.kernel.org
X-Gm-Message-State: AFuF++n3FDKaJiTPujoSg8wgW7FVgZkc6KpHpuQ5eK9SnGpvoUDdCsOa
	egvlCVfHwPxuDGyVj99YAEALR48aTP3XlJgEaFZdzGnoZ7bxCHRyDi1cuxMIJXi3roH+cqfuCEy
	rvS6JkMg96p/YcVxwq6/Ty2NVo0xNuXDn6HXTJuin
X-Gm-Gg: AYBFou0Wq4cazOYGldG4Q2C/oWIswcTwUL3DtLeorG6ZoqDCEzLOpF8QIQ1GxGJNF1q
	UoZOJ0+Cg/eNxFuPi58vn3b0IgE1DZv8noAHsqguQ92GMmZttAlc5IBPdsLOdFXFyJM0F0YMIY6
	O+ZEkFdAWHlOXeBtoGbrXs5HA6sqVECooFGU+Vato+P6JpQWT1/qSQw17Ooi4COMjBuJy6zgFbj
	HPKtSV2ku319aS/qoaQ49Me+If3iy7QpeGbVSASSNfDUpibudGcrad20LEsvqMQSySyMMV/jOBR
	FYQU1vd+k6VfRwSZ3rjIM39rUMrcb3nYKErg600xN+zxzIgqPwEDoyMxJl2+ofd32dLx1gaQiZ5
	kbEc4y82hP1jaaz/i33bh8PkBb4dVPegxvYzUFuC8m77NKSvYs6E=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
