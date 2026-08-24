Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB034534AC
	for <linux-hexagon@vger.kernel.org>; Mon, 24 Aug 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586315; cv=none; b=i1UBVpAFn7IveoeZS2QebfHpIPrsDhltSF3VprYMxFKz3aQN2V3nqA02TH5LPrL0a0xlXdJFKw+stPx5Qfcxi29CPUYgPEQVk+3jkJar+Cq1kaONn5UzaIJN5Ru9fiei/QGGYZO9sEMhsaDeQJC5N70JP5U7uJ01GfVlC7HjlpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586315; c=relaxed/simple;
	bh=rH5ooTmhOET3vAsIUkA6yaGvEUpGPYpVuc1a+dr0RM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKC3WfRv2rO5TLozaaTPTVtjlUumBSM9cY9QxV8XxlXEDQNKCAYbXRHwiNJEt3TmYi6kfnHKOi2iklHxyZ/wSiNdd0lmWiVy0WF2demFPIMcEwUXxUysmWbLB7e/2t160BiZZ/3PLQF5eCkBWwr5iAfDbuHaxNL7euiQVXh+ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XiWO3OjI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XiWO3OjI"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc11a30a259so3778099a12.3
        for <linux-hexagon@vger.kernel.org>; Mon, 24 Aug 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586312; x=1788191112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=XiWO3OjIqdcETuZVZGtwjGh/ridNShPFkWNE3WtqLgW/OCUrW4ceSniPCnuw3SK9w1
         XTU8Ys9ZLukdPh1w7VDEanB/FM0sqiWMGyN4dR5evFWNqo6ePuO07HrlNh2fuCx4GNru
         vGoj5lnIz6IFL6b637DRdsu/jePBVR3paCUUy1VRsZi5Dp/5l5BDabEV2rm4s/++FuVi
         7cSrGkjkmZ9dSZmXjXXxqZfPXtq1iTfhvn/lNVGmVmKesYI+fa9ppS+0qqeikflC0VM+
         JFIvYdhKOwdGtQFELrlmbm4uwP6XS2FYISN62wP3zDXL1mZB+3qq3TjDJETwgSTW2eHm
         A9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586312; x=1788191112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=qjyVj6+UojK/2IoM5gwyoLPY63+DEkThDQD+hTtAS+NzuQ/kQAOoe7yU4G+mHH6IfZ
         nku3tuiz+wWvYPAuq28+UM+cY0YvG36wI0qNS1vpE0Z9skJbUtvBs/0dSMDdDOHhrpf+
         kZzkE1zQMbPap7LB2aBoniCKz6GWRuxMqkQ1qEiJoyHebi0v035THdGaw3QOfWP0S9yM
         9pRr3M06AZgpjtH94YbRArzDHX4yXcj+yXWeY6OxgfJSCjo7/t6WRcwH9vCCAN9/x49S
         ROG3hoXFcujSYuRUrtqElfa3ZYA2272il70w/0TNdKI1o24l3/VzPWkWvY9/XY588VN5
         AR6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoWfA2gaSC98bXaO1tyAf0381GPkUma6LTlsA4tF0ApCoGjvv6XIEURoIW2qjgce/XCYS1lin8T9G6RfMsB@vger.kernel.org
X-Gm-Message-State: AFuF++k71mqakN8yXoCxSs/0jnRQHTRvFZRnqVTJvAjZj9Al25ArHglR
	ZHbN1ZAOCRuv3YLMphvOSwoirG2DpDCmUJ08XGI6PLtGSGdCgyixGqXUgL4WLqELEXs=
X-Gm-Gg: AR+sD13Jbl3yxiy6Lrf7a/UO8I9/GudVVVe/22Uxupwra0MNICovjQjGuVoHhET2uwU
	A6EFW55T2XDAKI0R+hXAPdUpBo9ju9bYs5TVd+nDbualGF7RPSrPWAxoH4vDWqPQQFz6rtebo4C
	qcPUYVXLIYAIWmlmhPAi3EkRQTXBy8LSE1VRkvrkgslLwjNAGdNjpSQTbFcGk/+wdZ61oGUAjOm
	F8fHab4tqLJWsWMKHSoA+9Bra8+qP7RJwA5CH3/7SatVMLUeqfS5DzKv1XUwaKikDrPY+OmZ0y2
	9Bzi7mruWphXI7RAJ/XQcKUbGd9Rk+LhHRuFqqNzEogUJiPCAVLmOvKSxBSvPXEIU/gt/Q0Rj2i
	HDfV9XNUkPFsv7oQJLHy+OQxW0d6XNwTohXg5ux1xCnZCrTJXMtPpKCAkTGMtHqrCCvtEno243P
	d64vCbHSSTthbvsS12by1tfZ/OY4ZRBmYnTSrNlARw5g54eRIluMS2X5YTCu8mKo/U+vL6Ru4/3
	ETVdYR4un0Gzu4=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr39252435a91.15.1787586312489;
        Mon, 24 Aug 2026 08:45:12 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm23611a91.10.2026.08.24.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:45:11 -0700 (PDT)
Message-ID: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Date: Mon, 24 Aug 2026 10:45:09 -0500
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> Move ptrval_to_str() inside a header thus making the helper more generally

Typo here and in subject: ptrval -> ptval

> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  mm/memory.c              | 16 ++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..a5b514e55dd7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> +
> +#define ptval_to_str(buf, val)								\
>...
