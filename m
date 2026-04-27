Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9036D9E7
	for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326300; cv=none; b=VRIuqacK2d9lsy+KK9BklzVzlKeKcxX36ID9v0Igezuly55y5AJdwhrt8h0rYjxSVx6Xyy6EM34erBPN/RV797EMjJhFbPqrOoSraeiGKZUASW6CxwE5ikA1pl3ZryANEd/PYX05tNG9TW3xRzzgIgbVjuWBhS+fw76apWsbCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326300; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBxCJe8veWl1BV2dFuZT/JsGOXrQOHnqkIR2OVIZ584IRB/88yolQEgnYIveSIZ0a3/SBV4rKYn1EAwdVDIc3MW4C6Awlnzp9ouUPsUypA+AQV9eHOTptMNsO+mp0Uecz2sQcEWw8Eq5BuKsqAjJpPFKm18yxmT2GphETh+xAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MpoM2WN/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MpoM2WN/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c01854477so696550766b.0
        for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326297; x=1777931097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=MpoM2WN/oDZqRlLbg5Nkl27d59EVPoAK717mah2blyXZhlnSNJGA8FW/o1A0Ma9fYb
         P4RDchlhVwAFXW/6y5BKPNXcs/AOb9mHNTklvGEcaLXI/DgRNQTemjgVdeo03RH7qA2W
         uyd73ZaEjEn9fCwJCbq4OwGBmDgNMb3gMGgdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326297; x=1777931097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=S8Jh2V1KjHQjESlvjvjgFLoiYkp5zDT6cuoaIDgbFUDsSJ/kEEcOmOFEjkwTEhXQkI
         Jz0VhFqdn/N6IPYENn6uJurgA+v8by0gYcCb+wk/xJLRjMlzn2eLUrKTehvttTqR2wiS
         paZfCJaNl3Cp/0K3d5K0hV/nTIZky81WKpTYi4jIMcRSvGZBl1d/Lrw2Dyc0zn2BLUEM
         a7si+7qEyVTSOffZnKy+jmLiTOaZtdnYNnj6PngNN35BLYmU+6ol2HpCWkfqnVShyhZ4
         HE++3tGQ0i+ifXB1hiWDCiPN2hco6K1Yu6SzD8NQ8RybjkBP8m36A9cLMTQQix/2PQDT
         rIMw==
X-Forwarded-Encrypted: i=1; AFNElJ9dBXuVtScA1dKuod4d/IF0v5XlQESfJyuEmTwbHzLBj435Id4n03owK47fn+f1SvoLIUElXOuelLVz+lCD@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpqfMLobE/x8Gzsd8uKpKr0lCLT/ZNf1/rIPKde+nVJwyhmKb
	eA0TcZM4CT9YChXdHM5kmFGEaoCDz7zehp9T3M/bnDO4dCR8Fo9KuINagsLn3nr8k9BuXuRtKsU
	yi48s5teing==
X-Gm-Gg: AeBDieuiv54uG+P7IesIl14TU4W9UtZR1TCIJRfuVR6GYO4qmREw85JL1hXktIm/hen
	5GTfeoaAiRYOBChNilHDlYJoqd+PM6bzVmivjX5obfomsksOblefx4m0UgzftdSR6iQ0WcRdVGS
	+aTsrFe96S8HlMP9BQ2VnC6lylFj5KDyvNjDdcSfE25cCmXQ0VFufJuMjzWAXGoEAj0rThxFf8W
	XGC2aha41TOPvVs1+GP/Apr0lhIQT9My6Xl+Nr6twjkf5BifEG945zq4CQjmEg/lHyiyYJGYApD
	enY535QXDWh90QnpAEgEjfFI590fMd5ArkH9o0RWEkaCj6kQe4QklStcujh+uDE7Ki7uCtjep6L
	yYqhBtHgokZ3SaNT6N2ApXWSz+LWvoiLwh4+bzE8rSj7pmPpFNQ5IHOI6FHNuQVj/1LwvNhqKU6
	O4yq8CFLunXmd2eVLkkseK19vCAAXZ9BNVjyJYre/ht/+6zzkwL8VHg6bWivFLEQy7xahVQmaC7
	8t78fN4Ozw=
X-Received: by 2002:a17:907:9453:b0:b9c:7dc2:e464 with SMTP id a640c23a62f3a-bb802da8530mr28238966b.21.1777326296660;
        Mon, 27 Apr 2026 14:44:56 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b88698esm9406166b.44.2026.04.27.14.44.56
        for <linux-hexagon@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:44:56 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f97c626aaso849329966b.2
        for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 14:44:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80WNY4OS48U3px8RUzl297mzA+VMkLAy4xiFjejpPJ11HGAauu7QFn59+ew0QcrjVoofR6fED2kfZAWfCK@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
