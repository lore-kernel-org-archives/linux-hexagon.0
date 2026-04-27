Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FA35F60A
	for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327237; cv=none; b=JeD4lwolsbE/VJ4CSYp9R/OAAoXras4lQlnOUA+/10HwVA7Nr4p/LPUQ3Mx4GUDO8rOBxLrwBqbJ26EKLlgQxK1QlEVRX7NxGFFtxZQekaFjcJ192K51xj1FhMRx4kWLyrF0F1vxlZiCLCtGonUuyFgsuP/Fv/yp0OBDwigG1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327237; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDVJ5wRAu4UFe5YIS9V3smVDQsmEhtETSKAX4yP1s8nDJJkqaid17qKuW8hmmdXglRPtqhXDK1dSi8c9Rd66T+FVOlgk0oWvMi4tMr0eOCwDtJtPwEgHbg9vDrQLF+p0VdiX80RUtShqfIcw7YdYRm8gKgPodFQzKNj4cTwUvTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ACGAWGcO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ACGAWGcO"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso1582163566b.3
        for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327235; x=1777932035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=ACGAWGcO4sGrvS6SWqmIXqGZDSAy58ZqEboMJhOpPb/l3p/l5gLuYgISlPJA44KtyR
         Hwcdqn0dpfz+4AlxeIXu4pzSmw9QHm/v9KBd26EKxW7ETfiaAh8hcqI6Bg6ogEcwm3Rb
         eOrOuHGnC6quTi/MOowYxDdu7CFLpAoVq5dWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327235; x=1777932035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=R1xPkCuebay33PEOyHqJbppduRquMTY5u1PCo3jYulxaeIFGce2TLTQ6ZVzLPyTsZQ
         PFX2q9fH8zzBu+nUKILtwtLWeQw70KplhH+40nqZ3FDqVk+ptBgbagudl/lK5AzFqkcq
         arYdhtPeXIJjd0rBHnULrmeSIUU6rKy4zRGleyA/1dbnFHolIRjjIV2D30oK0kUIc5GV
         nIA1FWBlCBuSmf5rzbFJLR2aKgNyfCNrg6cXLB6kVN/Fe8v363JpO4J3v/Y312PaiNwQ
         DuqYamkLQkAZkFrgpGIlKH6Q8P7WLHYaDYCqP2557+wDx/ovjzaPdEdNejyYlWqseO5a
         +X7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+LakB51UMP+BfpPQH9m0R7G7mup8ir5R+Uuj2wqgA4TYjP+OcUgBqF5wM7CsDEEFfX0bpocSzopQ9EkdKV@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXs6/DidL/gwwOlxYYDPVB6Eeol7mNK2zzZaJSVhmswp4F1T/
	klhlkzXNJKfmWOTHw47B0dnq9iAsit9LvaALCV0JXEvPu8MJLlnUfBNumc5XbXoBcm+qxrkAJQW
	F2cQAniTDVA==
X-Gm-Gg: AeBDiesY2GHzD4czrHVGr7pPlzcijzn6qOj9DUrRMV90poECAz6lHY1MF4qB7ncrvFp
	U0VqpEGJSUc/0IRQvW0Co85RUd/1neg14Gq7QkUfOccsHHb6gg2jPypZtM5l3kb5pv0aR2j9SIv
	MFd9V/tJgaZ1XDwYKVKKafX8TOBTvPMal1J96O/7fFlwtRAalDEQSxK/Nfu4O8wvrC+IaAKDCei
	LPABMywHghcDdoTB0Be4s/o/fOYrwNBjrzxrR9UPuk0rJkV+ki8NRKSoTxG+aUl+F9OQpNoWFMt
	QybG38a+qwZJVUlztA4QsEMECkP0bTckviAhh7s2yJ6m/hdsGGjExvvrzT2avOjS7dCPDd01Yis
	yaTikIOC22/rcNipw/uHf2vzmydv5c+kEjPJ5/MHmr5lIRupbb1AFttYti7cZ1RRSmgXhTse96X
	3nEGZyRrrlOm+H8XY8dtT4jCMr24gV+icr0Fsa9mItDgC4mwI2kxcra2V+0hZ6fxvYhGF26F8Lx
	M6+lY+JC0ev1vG/XiiLLA==
X-Received: by 2002:a17:906:ee88:b0:ba5:7cce:9794 with SMTP id a640c23a62f3a-bb803778b96mr30205566b.30.1777327234553;
        Mon, 27 Apr 2026 15:00:34 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c581f6esm9975166b.63.2026.04.27.15.00.34
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 15:00:34 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9401306a12.2
        for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 15:00:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/U9z+wld6TEWp1GcKZcWvC7rGMCSr+x7aFVgmUPbIYXRLICxNZPjKTSB8zgT4Gor7rKm9YuKM1Bd8VPUAJ@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
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

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
