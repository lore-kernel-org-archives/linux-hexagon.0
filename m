Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFE145A18
	for <linux-hexagon@vger.kernel.org>; Fri, 28 Feb 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710675; cv=none; b=oQQ5q+xbao8O249L6d5lpboSG5V01O8XsZXVz1fWxDTDIVgW77ziELWF4T7F0L8Sx7xi+jxUqoFuwyVm9+5IbnGPvgXjLeSuPi/PlwwM/TBfMryxTlm4+vYEx8WF6mRz38mqn0WIKGWJq7bnpqlJ6JgsyH6glxOvg0oQ6Ik68Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710675; c=relaxed/simple;
	bh=0fz6H8dlUgf8ko9N18YypQHlBg79eNoT5rDDE25IBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2eK1gOFczSOb6fn/hqV4bs6BW1qH5O7DwlDk1ypbI7HxPGEneimOwoCHy3KP2xEweib0TvvraN+uANKgTIelmZa5tZ40FTd/ZXZU/dx6NBFKr0Er+S7Y9rbZE3ZDJDPHmDmdFrC87I47jmX9CWEqtbKbZGKq0GmKZhQumhE0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cdGvg9LM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cdGvg9LM"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so3639685a91.0
        for <linux-hexagon@vger.kernel.org>; Thu, 27 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740710673; x=1741315473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=cdGvg9LMCPgA86eF1veU8MttIzjFc4M9bOp1Q+ej90hvu2aZr7uyASxs7uRlr3D8kE
         YQQQANN+KG+nVURDCNJSv5gXBZoaa0W0i35WiZlp+mcBPmLoJfGx/iPTsUQgBx1Od+bK
         riOJ/vkAG14G2L8zko8aUF3QwPxJv+wmmzqITfAAwEEj6QVyvyt382VqOYTnBuj9KJAU
         HZNHwiMw671NsErHZxT6yRYWcQ8PvZzb/ikpwi5VOwlvOlu3HTNLh12KwEYvo2mJ8GYP
         PjXRKUtbafnl+V/PCk7t9Iw7EHZB8TYDo5psvQDupJbFjo70IVyq0wgSs20gO+qgyNoS
         eNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710673; x=1741315473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=vJm67OQbhRYz/ipgv9/Yt8/wSi63Ee35KhlfrDtUgm5Yu677p6KX7xCZz9bzMmXyYa
         kyJcY628Fvi7L10L7y8Z+QEVJMG3wHYtw5AZ2WgcCIVmo3giK2jpZReS/p1dR3CXihZl
         kmCv8x3kF90minwtvwEA+qZU17vcLxka0wftKET5i9VS+JLviHwekovZ1BfsjtJuwDxw
         hV/XuclXyxDaIbhcpxFAwLY8l8ALudAVCwmUOEzBetP44kMyWxLmaU1hKCEjgspkoSqF
         +oNLCHBUEE3j80EnK3ZrAcdZubPX8nCdEceMWZajrEDXmjypinJ7ClUUu2ZXM1odnIt/
         Ukxw==
X-Forwarded-Encrypted: i=1; AJvYcCUU1+RmDur8tOqLndO8d5tc2c/iK8vnjttNWy/tMkkd4soi29JiQxOwLise6Vileq98ONa47YscQo/fVPAv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8txvC6wK9QVmdZy2VuHYcgbBOcFaKvu0fPb3WGaGvIBTy9gMj
	r3co49Yuqvwc194nyNJCsrjHRlJ03Xog1fR+MZROANjyZrYCtY3XjN4/NhE3IFI=
X-Gm-Gg: ASbGnctiPpZ9pKwJZsRI8yrfmTqaliNzkPpDjFBvTfzCj5ePFDX7/Sx3WzrShnBNf2k
	GLF+LY8F36rm9MA2G0iK0TI9jEsG4b23mEx/2HsiPdfms/9+OOKGOLfpowc4yMCQdjL0XPmrLMW
	VI4/U8hwFvqnoMrU8xtP1rN+SJyy24j5DTKMYde5VDKZPEViRoKW4nQuKs8oZkyTp0XSKfxxQKF
	fThpE35LhLyX+YOCIspg9/s+KMRZ7QflGmBluat/Acc1E861X/Bd9Sbrb1zqRpHhgrdlFq8Hwxt
	7ZzfKeWO2Y1+W09dnBvGRm/7q/6DZCrWZeWuLT9gIfrRkyQu1Q==
X-Google-Smtp-Source: AGHT+IF4hsdZRiz/aSbemK655CZrsY9ZUuvu4Xu2ENST8y9hxHTSO7PJo35OmCgDgimYWycuvOakGg==
X-Received: by 2002:a05:6a20:1591:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2f3e11f86mr2902815637.19.1740710672736;
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm2559832b3a.71.2025.02.27.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Message-ID: <e5f4e310-5bcd-4901-8ec3-757cf55dfa64@bytedance.com>
Date: Fri, 28 Feb 2025 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 9:21 PM, Geert Uytterhoeven wrote:
> Hi Qi,
> 
> On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
>> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
>> or tlb_remove_table() for page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for your patch!
> 
>>   arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks for your review.

> 
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>>
>>   #define __pte_free_tlb(tlb, pte, addr)                         \
>>   do {                                                           \
>> -       pagetable_dtor(page_ptdesc(pte));                       \
>> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
>> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>>   } while (0)
>>
> 
> With only a single statement remaining, you can remove the do { ... }
> while construct, too.

Ah, right. Will do in the next version.

Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

