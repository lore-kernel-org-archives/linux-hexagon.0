Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6E6EB7C
	for <linux-hexagon@vger.kernel.org>; Sat, 28 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735367795; cv=none; b=oPSPNu/mWqodPXZHS+8wXsd1sk/JUppu20CCbJjI7fBTb4FU223bZ4H2vhTA2hkdWCvOpWq9h1dMesBaM5dSyds9ST0n7BjxYSKdwM4DKpqi5d6OCvcHmbUKxyMGDmiTfOYPdxGwNqLFpIXWDcn+LePjHppNrL1IoGoOfgcbwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735367795; c=relaxed/simple;
	bh=AnI+fDx8ege81551sFiwVqsAGZfaOg5IleFmbT3lTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGHXOfKd1fc3DF3I6U6QKvW06vmPgZ+yHAogigexWiYs9sEZ55yzqkbw2z9qvoPtT6oILXTOPZbrylv12HIq2mIL4k64ecyBupSfCQFRH17wZHfYcKB0w3pPfoN004zgMJo80iiFfN8q36n/ApYH60TRwPC+qfYLId0EiBBokjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c1VsAsQx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c1VsAsQx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21675fd60feso127783645ad.2
        for <linux-hexagon@vger.kernel.org>; Fri, 27 Dec 2024 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735367791; x=1735972591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9+aZKFL34BZ+QKJapn5mhTQ8zZC8UnFG8XP+zHLMo=;
        b=c1VsAsQxxYafqX4QhvhVwPbFl+C/B/yYf9xtjlaS9oIZVrjGx1a1j/7KXH00dYveH9
         kvNmW7VyvG9Vq3Wb5z7g/mZfsPR3363WfRVfJc69MDc9KSZw4kBp2SOTh9oTWszWY3Sr
         q0EtyVlloi7rjiZpF86BnI0d3jhHHDNHOBFIM1mNY+7nLzkFWjuZnuTlMCT46aCfYHvW
         8XeKY9H6k8pry6ZgrHqFiUDdX7hsgsrxxHU/hOWmYGo4/eFq67OrCGNFOho3nG/PrKDo
         HFdLa0RMlfKxPeD/tena4kjS4MmTV086fr/X8pIoisjj5+bFGx33XvT1FUrUCg7U6jlg
         Vv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735367791; x=1735972591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9+aZKFL34BZ+QKJapn5mhTQ8zZC8UnFG8XP+zHLMo=;
        b=Uk2jQdlRl3z7KvFHnZ86XledStvXJVn9TSRLrRAVOiXo3R7AzN/pQ3Yir9I48br86J
         lp3zH5SLLmpKbi8hU09QwNY+2vJ6mE7OwcgYFnlml5xQbDM/7ZyuwkiG5bYLW8CvLrYx
         y1NS5LeEr7ofEbz2qE+1ypuoSid6AEOIARH68qHp+vwv/yWeU1Akkxf4y/CWkpLa5J1N
         69AT8yiWfIKImt3p5yopnHmfvl6z/rzyxG/SSRVB4NYBEYY9wDMN+bdfSk9WblTpxWOf
         kh5jm8+KJaZdfhaXQtKx6fWE3hW1bCSCQ1m3lQfEMslA7JMf8BBNuj42rjZFcKZLEyxd
         tAaA==
X-Forwarded-Encrypted: i=1; AJvYcCV+KQEzV64zExbw2QgmM1PZr2v32gCD5JQ67iXapLEofG8P6FzDytONnXYhVXAhPw/s+PREMk/IyOtOOMi5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49kLuQW7Ki6oC3r8iJz+oSZBzFyeIvqtREib0YUB/3i2TMS8r
	0VvIiOcfoWxUFejovKUymkfWs52a0QBo1ScLj7kBdEdFy84dPv1O9SVgk+GR80s=
X-Gm-Gg: ASbGncvNI7kjB1x4UtJ469b2yQEnENIXgiJw0S0DtJ7ygFr+ctnKbTzRbBDhOup/Set
	Gczoml2g6++/c5001+xPqgxfsovUiZYXwMFFEXyOxnkp2ns9VzTs/AoRjBU3HI3gfzF1Pi7F+JI
	hVeU0pM/Wg/2nCzn+PqQK7Hxnrcu8tN0x/xcO2m8/dN+jPHvSncvdfcLYosQ0W8JHBNheFWL3kp
	F1I+Fj7Vnv35eglO1RSDtQbFLD+LRLT7tMZ6dPJqRoxTQednYkt2cIzMi0GESWglGz2IUk2deoF
	8g+LNYh+LBYkg3VyZg0VsulIz4aFF8tNwD2IwxOvUM7Jvq+AH4zQ/5c=
X-Google-Smtp-Source: AGHT+IHJr5/cBm7VE4sKmfeyqyU+nR3KXMBrwpgTBQUiz/94ds3IGaVh/bhouU9p0WQ7mj1Jxu9Qtg==
X-Received: by 2002:a17:902:f682:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-219e6f1480cmr399252455ad.41.1735367791634;
        Fri, 27 Dec 2024 22:36:31 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d7c4:e49d:ee0a:5f86:d7bd? ([2409:8a28:f44:d7c4:e49d:ee0a:5f86:d7bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97182dsm144536075ad.82.2024.12.27.22.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 22:36:31 -0800 (PST)
Message-ID: <2434dfdf-d4a0-4f81-9b65-51be86487fd2@bytedance.com>
Date: Sat, 28 Dec 2024 14:36:06 +0800
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in
 {pud,p4d}_alloc_one
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Palmer,

On 2024/12/28 00:40, Palmer Dabbelt wrote:
> On Mon, 23 Dec 2024 01:40:48 PST (-0800), zhengqi.arch@bytedance.com wrote:
>> From: Kevin Brodsky <kevin.brodsky@arm.com>
>>
>> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
>> table level is folded, as {pmd,pud,p4d}_alloc() already does the
>> required check. We can therefore remove the runtime page table level
>> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
>> the generic version, so we remove it altogether.
>>
>> This is consistent with the way arm64 and x86 handle this situation
>> (runtime check in p4d_free() only).
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>  arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgalloc.h 
>> b/arch/riscv/include/asm/pgalloc.h
>> index f52264304f772..8ad0bbe838a24 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -12,7 +12,6 @@
>>  #include <asm/tlb.h>
>>
>>  #ifdef CONFIG_MMU
>> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>>  #define __HAVE_ARCH_PUD_FREE
>>  #include <asm-generic/pgalloc.h>
>>
>> @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct 
>> mm_struct *mm, pgd_t *pgd,
>>      }
>>  }
>>
>> -#define pud_alloc_one pud_alloc_one
>> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned 
>> long addr)
>> -{
>> -    if (pgtable_l4_enabled)
>> -        return __pud_alloc_one(mm, addr);
>> -
>> -    return NULL;
>> -}
>> -
>>  #define pud_free pud_free
>>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>>  {
>> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct 
>> mmu_gather *tlb, pud_t *pud,
>>  #define p4d_alloc_one p4d_alloc_one
>>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned 
>> long addr)
>>  {
>> -    if (pgtable_l5_enabled) {
>> -        gfp_t gfp = GFP_PGTABLE_USER;
>> -
>> -        if (mm == &init_mm)
>> -            gfp = GFP_PGTABLE_KERNEL;
>> -        return (p4d_t *)get_zeroed_page(gfp);
>> -    }
>> +    gfp_t gfp = GFP_PGTABLE_USER;
>>
>> -    return NULL;
>> +    if (mm == &init_mm)
>> +        gfp = GFP_PGTABLE_KERNEL;
>> +    return (p4d_t *)get_zeroed_page(gfp);
>>  }
>>
>>  static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thank you for reviewing the patch!

> 
> Are you trying to keep these together, or do you want me to try and pick 
> up the RISC-V bits on their own?

I prefer to keep them together because later patches depend on this one.
And this patch series has been merged into mm-unstable branch.

Thanks!

