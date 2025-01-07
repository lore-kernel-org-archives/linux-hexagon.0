Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CD16CD1D;
	Tue,  7 Jan 2025 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245040; cv=none; b=koRuLc3U9XM/xFCUJKqNgIV9DgSIZe/GCMxZda43KrHSRvk/iEBVcOWQXrMce9qeb+Vhv1f0DBwkHyOQZVzxQf58HDFH6ofPzoOMXoLBC0h8TLapFPzEFQPL9LbwomNPS3HI8hgM4sAsGTRqHAXWc8w4oShBlU6oX9I0QtbhWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245040; c=relaxed/simple;
	bh=sB6ibKWqooV4TrO24wyTEhncE2JH+iI+C47w05RjPzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZ5NxHvwOESMqYEClfHWoEWwCr1xKcIHWuCSJ+lIJXlX+MLVgVvlhinaBgPeMqqI9MVx+ub+Q+6b0JA8uYS8Zw6F+U0Ri3DdF601OOwNxNlZTWqhu0JyrSL/ut7R4sbkmjQsb0UsKLjb+15579JWiRNV4S4Qyh/9AlcDhzvHWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLn9exHU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLn9exHU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163dc5155fso220217215ad.0;
        Tue, 07 Jan 2025 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736245036; x=1736849836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pMzQ6Q3lA1IoUF0MYLdAQ+qNWyHW+mV0tesj2qqggOE=;
        b=dLn9exHUNjZ9Q5C2smZURSKRWdzu+n5dvZt32L4vjROKb4HSYdLX2ScPMNgfht/ZdG
         5WAd1hLABaERMXPHK6fdKO+MITVr38umPU+RDetkZmpY6zTem02um/6Nw2JtVzuK+9Be
         l61x/2qUoYnvWBehoJj+jaOGScjsOiDJvViy7NRktsbNspyCXe5AmxnEcGEujkauadm3
         RuYfYHWq7mPeqZ2H/wW3DdNgLRxYjAP0/Lxog8lSIyR+Sl/DZsCj152tCTDbS6GktWXM
         E0Tf0xjs1GMlncaYYH0Uw39iKnJybN5g1+l9eKGrr4uDaF1KzGLF0Uuesd83Y99Oeu87
         eupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736245036; x=1736849836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMzQ6Q3lA1IoUF0MYLdAQ+qNWyHW+mV0tesj2qqggOE=;
        b=O3/II4hq+Q7Ww9qRcJ5Jjz9Zo7ZSihZG/PswhG5G6QKQETJqy/M3ACNCX+V2Yd4zNT
         AP2awZU/4DVOE+nFxDq1L5gG95nicQqn0LMxXb398Fh4gOV71Jzyeej5CNdQcxdS8uFm
         RMCW6W1tKOBBDOcvw7SXpVaUDxzZx+ropmVIrpwOEsPAVjd57tlzTrwIjP0RXg+F5gme
         a0835uoCK+OC5RJTDOQJkHdngs4JFF8S9YViBU0F67GPBSRh7cVSo+n0fB2KcPzwEqTz
         2oVpc2R1hxS4N/lhn23A1xJvdwm7vwpu+OC/TPC5FUKu/YBskSpt+R+ZZWrh3UCLQptl
         Bhvw==
X-Forwarded-Encrypted: i=1; AJvYcCVz8nFz16b8ITHm7S3q5ihbWztDj25RX/eEt6CIlh3vASd18XS5Eu95dt94t+tWe9SsYVG5KwhQxxrYkog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lP92YO+fInhhWnsUHWald4zskesu6XStZ8FIiTlxn5JBnhiM
	XBEGL5+mLsssIOlwtFY/mqF5OyhxnbB4x6GcBsZ++EfWEGzHu/xVApurqM8qZVSJRDdDuOwqCaT
	MHPdkhNyHMA2k6GSfRv1UQwrRMD5qBCNB
X-Gm-Gg: ASbGncs6+Tr1zbBdbxNKV+RFlk2uomee8wE1uvchm3IEynQ2KjK1yasl32KHD61b4FX
	TDR1iBKh8DZV3vWFaTwaYR+znhWaCh8GMhZCd
X-Google-Smtp-Source: AGHT+IHll4tyc6RZ7e02wN1kdQnkXSpdRVZJJwvbbY1teESSc17pOqadXOFSQImkyAaJoroAdpFU0FT5N9QwM67q1hU=
X-Received: by 2002:a05:6a00:6c88:b0:729:cc5:fa42 with SMTP id
 d2e1a72fcca58-72abdeac3d1mr99127976b3a.20.1736245036403; Tue, 07 Jan 2025
 02:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203221736.282020-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20241203221736.282020-1-willemdebruijn.kernel@gmail.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Tue, 7 Jan 2025 11:17:04 +0100
X-Gm-Features: AbW1kvYM8FZ8prh6MwGP5ae8XSjDcClN_njbi_-kMJzEFCtbpkLV2BHLJ0ACdSI
Message-ID: <CAH9NwWdODq0GXWJb_4jQNhgWjjAYfZccGLLLe7a=LVC95ew2tQ@mail.gmail.com>
Subject: Re: [PATCH] hexagon: fix using plain integer as NULL pointer warning
 in cmpxchg
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-hexagon@vger.kernel.org, bcain@quicinc.com, 
	linux-kernel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com, 
	Willem de Bruijn <willemb@google.com>, kernel test robot <lkp@intel.com>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"

Hi Willem,

>
> From: Willem de Bruijn <willemb@google.com>
>
> Sparse reports
>
>     net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as NULL pointer
>
> Due to this code calling cmpxchg on a non-integer type
> struct inet_diag_handler *
>
>     return !cmpxchg((const struct inet_diag_handler**)&inet_diag_table[type],
>                     NULL, h) ? 0 : -EEXIST;
>
> While hexagon's cmpxchg assigns an integer value to a variable of this
> type.
>
>     __typeof__(*(ptr)) __oldval = 0;
>
> Update this assignment to cast 0 to the correct type.
>
> The original issue is easily reproduced at head with the below block,
> and is absent after this change.
>
>     make LLVM=1 ARCH=hexagon defconfig
>     make C=1 LLVM=1 ARCH=hexagon net/ipv4/inet_diag.o
>
> Fixes: 99a70aa051d2 ("Hexagon: Add processor and system headers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp@intel.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Closes: https://lore.kernel.org/oe-kbuild-all/202501031246.AD8Jjze0-lkp@intel.com/
Tested-by: Christian Gmeiner <cgmeiner@igalia.com>

> ---
>  arch/hexagon/include/asm/cmpxchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
> index bf6cf5579cf4..9c58fb81f7fd 100644
> --- a/arch/hexagon/include/asm/cmpxchg.h
> +++ b/arch/hexagon/include/asm/cmpxchg.h
> @@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
>         __typeof__(ptr) __ptr = (ptr);                          \
>         __typeof__(*(ptr)) __old = (old);                       \
>         __typeof__(*(ptr)) __new = (new);                       \
> -       __typeof__(*(ptr)) __oldval = 0;                        \
> +       __typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;   \
>                                                                 \
>         asm volatile(                                           \
>                 "1:     %0 = memw_locked(%1);\n"                \
> --
> 2.47.0.338.g60cca15819-goog
>
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
