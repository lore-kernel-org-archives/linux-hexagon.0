Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AED3C9EE5
	for <linux-hexagon@vger.kernel.org>; Mon, 20 Jul 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584879; cv=pass; b=DPjDFZuaAe+7UbxrhTj4kJdb3TiL8bM/wgfpLuAI+mQ/LEOpwGTuhA5xXN2wdCijE+tC37KkYfk72vyfS+NiWSrPFEKaKbArymjPX2uB6imGGSLtzYpwS2fYAKa4+NZlTdgLrtUcQypeKRNUb+2nBJ7YFix7yuIusR7+lbhBUww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584879; c=relaxed/simple;
	bh=j/7Pu0goIzrDPISYd7UGXNeACZWMCvQbsT7AmxUh2RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7fkT10uo8fQfVOzj+v4+GU4sdVC1rhfoFUs56ELFFldLuQ3LEGw4xwrtqdXITmSZbHzbkCr/VBufMVNXSfQlecAsCtgz4IVxjqg/b2HVOLmjP4ItjxvtO5PitEjHZ7XMgDtrbTV09mBQDmhpvjPSGjqDhHDs72k1tWu1zZMnXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMey3lva; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMey3lva"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so11991050a12.3
        for <linux-hexagon@vger.kernel.org>; Mon, 20 Jul 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584875; cv=none;
        d=google.com; s=arc-20260327;
        b=AizNVEHBjBsCUvvqSoZAxfmNQClfdhdr+gQsmSLUW/n/jldwnKMtccXkmBCplu15XK
         lIgl3O61CItvqDy7NS+sJmefJbVFD5Zm11AF/dto/SVU0qjz7PjqA/JC60f8zEvAT/1I
         3nHD4FsSgVG4wD+ICuOfKxt4QzB1EfW5It+7vt2IEfM6nTrJUT9McbJFNn9sQqX0TkfG
         ItQvrbPz7rgl+YHJNx3+a5j6HL3USktE+wG12NqpgWhbXa9ezY1Upfs/rfroe806GE5P
         iIl7Ykhu7uiYBnwrvYGQPR8wtLfopFORuXCY3HbS6MnPw5zCTV6+Tpu1g0fCCknw++5E
         HhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        fh=0DWlLMQnmFetanYUerJf7t01sfWEiEnX1YKYW/8qQtI=;
        b=X5mlG67D6rkXinRVe9ybLKqMkz21j7UDPPpVrkyQUOyA1hgCKmQRtDkVUC7s6he2Tg
         bfKzqlpvO7etMYctRrSOFgLZzbuzJONFSItNlqqeX/8QIIDWJi938VEG1Spg2UQu0Z4q
         SAfEACaSB0PrXTUi297Qug2TFV/DChVNqAhNowTNuZKj4iugf3pxMQayal2qA8+9zVAr
         1eUL9rgZXEr/go0qehmpFNhpiMIqDyYAFErhtaENqbszLlkCdoI/GLm4EFen0yUaxIF3
         snKKW52Q03ajKIxv6aPRvfScFfAmOaPACfRCcWA0hqOP6La8VOf37qZv5wAt/kyzfNlX
         5q2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784584875; x=1785189675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=ZMey3lvahqP+YPW9LamnWQzczRxQiZ4wg9gw2Nu7P3y1v17JUAuMM/AR3JTiQFFKU8
         d9noasqw2G++q5S+mCeWeywDA5kpg8MuVxJjECyua9/y3jlOjzMIOYlRYZqO13STHgxR
         WQ87V1/rMYJN18KwPy7Kt1f4oO1hp7OTlSg/lmBFsB1gkADDpu+GAYd81uYxtDWFgDYj
         g7E/fCVHIhWUawA3wQ30Wot0eYDovRLDP5gkADBspVyzhS4siR8fFKxsvW3/xg6aPXXq
         4tTUNL4YjCh2lps4QkQgZ6MAQbSDaAHnlH759VBDRh1kPBksK3QYu64fJW2a6dhpi8jy
         qpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584875; x=1785189675;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFKHaLiuiIMT2s5Bf3SZwWbn7++lylaBZHxfNpeM7Fk=;
        b=JZ2jYCx7EmXRZ5nzXkzAa16ws1JN0EAV+/dtGYXGvtKKTWSBUHAvsSVcyObtPgvdRH
         X+EIKe94L8TCRvesSzRUO+Drbe4BHkl+4OTWOjNPhMj5tBQj3CLNU15Br/Ul5xirKJZ/
         Vw9zVzRwce1kaTCBnOuzGYB1yiiLSNvrZWsiLKOHqaZjep2joyJBQIfrtl8QYV06oyeL
         qAm9y3oXEZuA5JTxZzNoeZX9Nl/kPE/9MFFxCQwx2H8pdAVCCSmDshhM7mkSqa2QE+dU
         JYoGFH76WYOzuPixEnJTq/407b3D7d1sahgaHJFH5qqStmo9P1zXuUHPZoTtUEVEqQba
         sxrA==
X-Forwarded-Encrypted: i=1; AHgh+RpgOJmfgTboI7QDBv9LoVY0NCHJn8OwygF9wURwyFIQJyQU8pfV9k8dGDknsN28mLO4yux67qeC0l8Qht2+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rq9s3ksulAVtH0S00Lre3IVmDd/3m75xpB2u8UlMw+E5/mjU
	zGGeeGaslNS3jrAfx2NOG9OKa0oU6kjjvTXsSJ/cIO2t3XJKF0ML+fAD1QJXatUj9SA/EwaUk9w
	PeHcnCFnoRxA/GVs11jCRUcep5t6ZzoI=
X-Gm-Gg: AR+sD11fvLGpQz5WvN+w7Z7it+w9m8PTMXGm4ROCYfPlG5A1jT+2jROfNAFKMd8jNPP
	gTB441MX/RxckWB061WB5WrHvhAeZen9PnfZxeENC5hxVa1ERw29I47A0E7RZ8zf9p5UiuiZDYE
	dUEzqK54oH0OtYnD45FXvFhlZk9BrBjZUNehxOJCRljcUsaj6A84f0lGgiLmGnXZ5oMKVE60Sdy
	/5oNS2hF+VlbJx1Vn6juWDuCeYwjrqPWdEwUmdzJc5m8uoufSjB6gYCqx5j+9FD4tKeHkapD8iq
	kIBJPe9Ir3AmsgsrcoPzZff0gSYDx1o=
X-Received: by 2002:a05:6402:2356:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-69e6525c770mr6536246a12.3.1784584875096; Mon, 20 Jul 2026
 15:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <CA+=Fv5TDNH8+JAojV9_W36kUkEE68uiA00FQ7i0vJunebqs1sA@mail.gmail.com>
 <87wluplb6k.ffs@fw13>
In-Reply-To: <87wluplb6k.ffs@fw13>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 21 Jul 2026 00:01:03 +0200
X-Gm-Features: AUfX_mw5696pn_wiz_LjCaJHiFU9IchwhNNUbBWmuIdhtqSFIK3TJnj9-atYCBw
Message-ID: <CA+=Fv5Sd5+-K3-MOiEc2N8z_5CoLQPVPUwjiugSj3u8cBWJXXQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Thomas,

On Mon, Jul 20, 2026 at 9:21=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
>
> Similar to what Peter and me suggested in the related discussion
> vs. s390 which has a similar issue, you can just have a dedicated
> syscall_return member in your pt_regs struct, which is preset to -ENOSYS
> and operate on that. You have an unused padding entry there which means
> it won't even change the size.
>

Thanks, that makes sense in principle.

One complication is that my Alpha GENERIC_ENTRY branch already reuses that
former pt_regs padding slot, while keeping the pt_regs size and stack
alignment unchanged. The extra syscall-entry bookkeeping I needed so far li=
ves
in thread_info rather than adding more fields to pt_regs.

So the padding slot is not free in my current branch. I can still look at
whether a dedicated syscall_return scratch value would be cleaner, but the
tested version currently handles this by setting the default -ENOSYS result
only on the no-dispatch path, after generic entry processing, and only if
ptrace/seccomp/BPF did not already provide a return value.

>
> You were on CC for the V2, no?
>

Sorry, I must have missed that.

> The whole pile including Jinjie's seccomp bypass fix is in
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
>
> and is targeted for the 7.3 merge window.
>

Great!

> If you want to base your stuff on that for 7.3, I can add a tag which
> makes it immutable so it can be pulled into the alpha tree.
>

Yes, please. There is still some ongoing testing/review of my Alpha
GENERIC_ENTRY series, but assuming it is ready in time for the 7.3 merge
window, an immutable tag would be very helpful.

Magnus
