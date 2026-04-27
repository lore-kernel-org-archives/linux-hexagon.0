Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703703E8C59
	for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313256; cv=none; b=jzjQ65PJgnsai9Z3l8ixczKb6TCtz4Oa384twjtA7M9yCnVskQYf3Lk/CVtqYqxidW3nDYlNDf+igzIaHTKdMxAPTNMSsREZKvpXlzVMpwR5IARYE/NTBcPe2645S5n+OpKjdH6cm9Sj8GwyxkHnzluSh0sgWusdRVeJZO6DwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313256; c=relaxed/simple;
	bh=LJB/6F8gRS18jiwpo8qTgtmT08hQ2iYqeOWrm4IbRjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mmujwuGCUeSv+RGrEimQL9GapU1Ma9rrGeqrw7j+oloEKVWUOx8CAy8oBZcoWTJna+Cwxz+gsUz/uVsdUbhFR+rD4V3tmpkJ+gcl2qKFYcVUOIUky+bRX/LXuIngAWjEG450X50dQR3uxmyj2EvAuO0FAZtkrG5dTpCjPiDG/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPn+SATK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPn+SATK"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43d780757eeso6990921f8f.1
        for <linux-hexagon@vger.kernel.org>; Mon, 27 Apr 2026 11:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777313250; x=1777918050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=cPn+SATKuQe+JOM/S0y9YehIYvugeCOq5rAxKMXfxKK+HYTUjsNnOR0yVrIzvX4r2g
         DkCwv8WMJM0bFqL6Q1MTpaeN8Kzf/djGm/Z9E9tyzqUTSlefq/B1oqqWYHPq92z8599d
         jSJ34C9mcPaflWs9Lkrsod+7aOZ7q7kzlW2NaRw9K+M4/LVBB5Paus9kqhXbvh5xbusq
         6Zsgh/pkGT7LT1at8rk474twLKrJqcCWyaPawXIFA4F34mV6UVbAPFxd8BFU4K4U1vwG
         VusBi9r03Y/j7QAjoasRoSju4+uGyRT8cdp1YRZxubLO2i+2GANpj53djrwGbhJHU2Yb
         vaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777313250; x=1777918050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxkgeF4LNZGOlYkWj+Rbzgew6yzkspsu2lszfChr6II=;
        b=VfVqE8XjBfdf7MLrtW50gbeY0Ea1vM7cdYf0bToUyS4TTR/4aPA1ZF/PVBI+xUvARx
         7poKtn/7cxheWYpK5+SHxYUzlCO69fULxBR3HKVT1s/FRRnIlt+vLfoIsfQCcJ+LEdhZ
         OxEOsZc5N5W56YzVg4umUlwbpx/zeHWdhcSMRRmMkmN1cb8vRZc8rvdFQJkr8QKIVpj4
         u61bejq1mVWjzGRfkdqCvjLmeqLMViZrfdqUXyW+2kpumOPXLDS9Tn3YBC70G9lGDyGf
         bHqEapZL4XyVzC7cuewj29XMFFVM+jMseS+kTVmUJ9w13UwGHcSWJ2gfUDDlhc8Jrf77
         ejNw==
X-Forwarded-Encrypted: i=1; AFNElJ/ONxoTB3+OKFmpV8lj3ikpZllvwuTL862RIxKaCQjIIgaJNseQv7wtHgOcyPsaNqMxZ/b5pRDI/xbWVjAN@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVCsFUA9zuaulaI36ikXWCyy5ZVbW6UMLTjbluv94zMJr8kr/
	v9SNqjzfuu2AnfvB7/G0wqmH6bvzb02TJvdsCi+sWWSXLpMd+VhEMCvmoborpKLP3Pvwc2ofN2I
	UMX724OZQIv27Ud/B4g==
X-Received: from wrmd3.prod.google.com ([2002:adf:e883:0:b0:43d:7940:a11b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c7:b0:43d:799c:b2cb with SMTP id ffacd0b85a97d-44636a393e7mr256856f8f.24.1777313249648;
 Mon, 27 Apr 2026 11:07:29 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:07:28 +0000
In-Reply-To: <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
Message-ID: <ae-l4FGDPLwBuDXM@google.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
From: Alice Ryhl <aliceryhl@google.com>
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
Content-Type: text/plain; charset="utf-8"

On Mon, Apr 27, 2026 at 07:13:46PM +0200, Christophe Leroy (CS GROUP) wrote:
> diff --git a/rust/helpers/uaccess.c b/rust/helpers/uaccess.c
> index 01de4fbbcc84..710e07cd60ae 100644
> --- a/rust/helpers/uaccess.c
> +++ b/rust/helpers/uaccess.c
> @@ -5,13 +5,13 @@
>  __rust_helper unsigned long
>  rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> -	return copy_from_user(to, from, n);
> +	return copy_from_user_partial(to, from, n);
>  }
>  
>  __rust_helper unsigned long
>  rust_helper_copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> -	return copy_to_user(to, from, n);
> +	return copy_to_user_partial(to, from, n);
>  }

No Rust code uses the return value for anything other than comparing it
with zero, so you can keep these as copy_[from|to]_user() without
issues.

Thanks, Alice
