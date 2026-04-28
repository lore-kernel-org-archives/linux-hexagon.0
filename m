Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB726396D06
	for <linux-hexagon@vger.kernel.org>; Tue, 28 Apr 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368643; cv=none; b=FzYCGpqronpiws1vW3rka2CjoQ2WwSVOaoNGd2b2ofxzU5CpoMDGrsnJt+nUOudK6qOacLM3RbsCdo2GuqOpo9M4HcYsLT4OA+o7FBnZ9WMw/mOLztWxFgwWfew0zjV3HhTT2vVYy9ALtBcYIaDTRuoJZFXNEQpVqK3jtHHbiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368643; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW9F/lkV80eqkSffvbJM72YV+Qp3SPYQy118elfq+Hrh68zAlNzCnvFITIILFyQ3MAuOLwWT1qRunVBsR+4JhjgMqon375aUtrFHJGLs1tq+mpit8VYtnKPyU6E3+2clGSqYXDmO6v6gnhOcjE793Kl1W3iT0WvpNwzWF8zxDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so311907466b.1
        for <linux-hexagon@vger.kernel.org>; Tue, 28 Apr 2026 02:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368638; x=1777973438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=GtNea9Z/AebUb1PD/lzI+k7E4vt4VAjge7oSkDhZuSOm8l1hQhbX83u+rL3axtd71I
         ZjEqt4yhgiDSD/BOiQakAdMOs+5nthTA/N0ANM9n8wzoTozERhpN9j64zHbE1p40by+D
         mLj+gub0wDewqT+Mqic74ipR2j7Q2jAApf4EewnxUHZ6/LTbpwLYm6YID0kObYvTVvCT
         dYLLGh5IGrXdlYmZSFZlmTYv9LD76FaG/A5ZkmXe0Wd1ko2w0JAX2Ztdj6rgGoui6iZp
         SBp8hHb1gnRxFa1eRSSV7eRQhgc9B0fvnN4lxc2bHl1g0yYHQD/bGe8BOYR63FKoyXi7
         Woig==
X-Forwarded-Encrypted: i=1; AFNElJ+CBv0plUeHqV1YKr2ZDBc/SMUqJuzl6Efq/N3cHgUdB8Rt0xtG1G5LshPv/m5r+5xZYAPB1tCr9UvsIeqp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZvXV9PY6Ex6U+tCkk60Y+ologv2uACiVyc8xZrb5XVp5xpOE
	EiOFx3CnHJ7Xar0BRGwWuMlo1EwiI6pPr5PAyoAE/0r8b0352k6eKBBy1nXUMMFu09U=
X-Gm-Gg: AeBDieuZHmbo+BtXpsFz0ypzsSthxmbmp+hO9VawBO0vwHciPataiKJBiQaDgLnxw7w
	TuFigxuKYMA4+25wlXXexChd6rL4z5s08dsLFGuLUZtbD8ZAAvzEgttVm0cEPd8LNqEt4WvUSFq
	HPUcXGONacXSaT3Ucc2arEBSxHfM9rLb5xo/193HUPhBllpDq3TSgB+JtltxrAFU9ENHIqPR9uO
	xTghNZqMOUwxMEKi7Ek1DBx9HCoIF8RqvycRcL0BSh6bNgBx5p+3JzpCZLotlvfOf76gatSQOVw
	0UZMZUMX+9Kz9JQw0cKfLy50C544IgHgh8JxaETNNpgSdk7MwUH+wpjOZBvgXe5Z2ZifMlK5454
	FJdMV5bhLP5kboHXTpkOG3bxrXyfWJc9vV8pWD3mvTZeQ0xJZG8hvZmVtRiIRAtAiEnFk+2LqY1
	uDnV5txoFaPiyzOtesJ5iiFgiGO3xvpwqRpsy8/a8S5YcnTtSNvOl064I4gEER5Ne/RNEi7rI=
X-Received: by 2002:a17:907:d204:b0:b9e:8e4:8765 with SMTP id a640c23a62f3a-bb8020ca22emr130350066b.10.1777368637896;
        Tue, 28 Apr 2026 02:30:37 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80902237csm73367266b.24.2026.04.28.02.30.37
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:30:37 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso15349842a12.1
        for <linux-hexagon@vger.kernel.org>; Tue, 28 Apr 2026 02:30:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/7bV92ZccqSQOzY1IcdDXHfcJzL0SxL0OKLx+02QLCmzMvwfRD91qaVNEpj6xYgIVMdleb1V8Sgpz3XE+o@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
