Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF932D05E
	for <linux-hexagon@vger.kernel.org>; Mon,  6 Jan 2025 03:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736135401; cv=none; b=HyHvN5EkK4ASNJuO+O5lcNaz1q2Zhj/qBTEXPHuEbfH6IqCIQKp5faUBLKitDmV/8uzzlx8wm80qNdUfs3VrMuNx0Hu6DuEeqchuDA994x2qyHEJHctLZpHI3Z6Rn7JcqMAcZPCfS4eGCvJjjJtR5Dq/AGEfaIagfjzrdoUypM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736135401; c=relaxed/simple;
	bh=4dk7AAJmezfFi3ZfUWBsyuZRMbx4LQ4Y67CoiCMSr1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eayf3cCX6XwDKEYpFPRUhg4mIvx2/5U+f67Uo9gUvw6Vuk0PG/HeDtM1yRBVLzdpz/SsFozOEzZpCCuh5SdFVJ6ExFixSi9nlgcICruvn+mMZ+XNlKRceDnuKQoZ4BEGFxoHUhhbnkyp+kkhBXdXkRi9vjZMkOH4m8i0S2EpaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b4N51bm+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b4N51bm+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso15659646a91.2
        for <linux-hexagon@vger.kernel.org>; Sun, 05 Jan 2025 19:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736135398; x=1736740198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/CQCfwbCGmNbncAnjTVlLDBhrllfolDtdV4jFWfmgY=;
        b=b4N51bm+5ySmYCAAyjdX6ff237xAtmlGkxKFy/7WJODVou3GxVwNmKyE0vdFbXu5FV
         HimJUI6lCu35w6OvX3FWLN5DLsAVB0/vY2hd0dIv4yPdhz1lJDHT6NEZ1f/nF/YoNxOe
         ixziRkNULlpHzxcfnM5iplY9rUFj8PInfkzRTSO0eLPbU1Guy+rJJUPMjK1saUkRu8S7
         rhK1JIQ7fVjbR2E5BhtDu/Y9LmNp/TXkBqBxPS8j1slVDGC2CEEEm+hJVP8808GGslE5
         YUEo3glRfEMH80+stASPYBTHnFRBdLlR4C866/vM9hNYWlj9YlN8KOIUPvT4hTHk2BWi
         JDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736135398; x=1736740198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/CQCfwbCGmNbncAnjTVlLDBhrllfolDtdV4jFWfmgY=;
        b=d7h+cZbCeheFFQkM3kECYGtVGq5bwjzttbdKRaScdzzI5aEmi10HA0/yAjaocg+yL+
         xcSh5fhVek1SR+LLGGeCkfvsE6rtnK5JhR0l4PlxsZ8I5JHVV6fP/jh/dICChw349CJa
         KGm7adykAchgUWHKh5KqMM7UBQ1W8rE+g+WFLEt6meWYJFAFGCqfL+cHiy3WmgGiEQ7S
         vkWhf/wZV2tdMQkjGSK+6j+hJw69EzJCWksZGTrGqE+0a0sgazNt7i5cVi+jlh2nAdFX
         X3boHpk1cGBqg2SB4IqzBpN1urMyqMCwjS8ijpDLSJZgaGLBwbJoEZ+wsv7e6MHE5x+R
         7vJA==
X-Forwarded-Encrypted: i=1; AJvYcCUfXZY+uA7ImNf/GG0Te81wr8ltPOY6gBQQvf0KD/5n4JwXR3ocNfUMrfE0QMFBXRH9ZZm5mLP+MFE0OhYG@vger.kernel.org
X-Gm-Message-State: AOJu0YwCR15WZads8PEZb7B97PdImofLMKEq/oKKqQYOLnD5TdPq7mjT
	S/OUpROzKp+Ay7Z1PNELhBt+680reqx4amJFsIISuAZeluGIx/DqJv5WemHC4yA=
X-Gm-Gg: ASbGnctvbQgNSkaYt63jV0cd0A2BDyTAY9IpVDkRQFeg+PXc59lXSuVzJ5+Tbkr+S5h
	oS5ytRR46iHxKiuiLX5AsWu4ekAf0Ba/iyA3v4tCfVO2EP2CbUhxZ5CW0gjK9LNUggqjapiLggj
	eGJdXcHsaX3zPIWvVNXuJUzHudHUlU/rC0S8T8BR6JA+xwY1OQg4ZZpiZUk/6Jz67cdPQLYqIRE
	h9YiACp1yzLSGZwx3fujrOOQvoTUuPNZ2RH/b2oiHUKXWehbyrRfKxkUZ+3s/2N3vBbzSTpyw+k
	U6k5QA==
X-Google-Smtp-Source: AGHT+IHpHJsHb9mpdlPf1WMyDHeUmOQ71xKKXnSQB+gdiLoxCAO6i7uhLAJzOXuDIN6Nxvn4zgv7zA==
X-Received: by 2002:a17:90b:53c8:b0:2ee:c2df:5d30 with SMTP id 98e67ed59e1d1-2f452eb11e2mr54849162a91.26.1736135398510;
        Sun, 05 Jan 2025 19:49:58 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447799048sm32821110a91.10.2025.01.05.19.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2025 19:49:58 -0800 (PST)
Message-ID: <de8756aa-dbf7-4f6f-91f0-934270397192@bytedance.com>
Date: Mon, 6 Jan 2025 11:49:41 +0800
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>, peterz@infradead.org,
 akpm@linux-foundation.org
Cc: agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
 <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
 <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
 <d9a14211-4bbd-4fb6-ba87-a555a40bb67a@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d9a14211-4bbd-4fb6-ba87-a555a40bb67a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kevin,

On 2025/1/3 21:27, Kevin Brodsky wrote:
> On 03/01/2025 10:35, Qi Zheng wrote:
>> On 2025/1/3 17:13, Qi Zheng wrote:
>>> On 2025/1/3 16:02, Kevin Brodsky wrote:
>>>> On 03/01/2025 04:48, Qi Zheng wrote:
>>>>> [...]
>>>>>
>>>>> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
>>>>> and call pagetable_dtor() to dtor the page table pages.
>>>>> But __tlb_batch_free_encoded_pages() is also used to free normal pages
>>>>> (not page table pages), so I don't want to add overhead there.
>>>>
>>>> Interesting, can a tlb batch refer to pages than are not PTPs then?
>>>
>>> Yes, you can see the caller of __tlb_remove_folio_pages() or
>>> tlb_remove_page_size().
> 
> I had a brief look but clearly not a good enough one! I hadn't realised
> that "table" in tlb_remove_table() means PTP, while "page" in
> tlb_remove_page() can mean any page, and it's making more sense now.
> 
> [...]
> 
>>>
>>> For arm, the call to pagetable_dtor() is indeed missed in the
>>> non-MMU_GATHER_RCU_TABLE_FREE case. This needs to be fixed. But we
>>> can't fix this by adding pagetable_dtor() to tlb_remove_table(),
>>> because some architectures call tlb_remove_table() but don't support
>>> page table statistics, like sparc.
> 
> When I investigated this for my own series, I found that the only case
> where ctor/dtor are not called for page-sized page tables is 32-bit
> sparc (see table at the end of [1]). However only 64-bit sparc makes use
> of tlb_remove_table() (at PTE level, where ctor/dtor are already called).

Thanks for providing this information.

> 
> So really calling pagetable_dtor() from tlb_remove_table() in the
> non-MMU_GATHER_TABLE_FREE case seems to be the obvious thing to do.

Right. Currently, only powerpc, sparc and x86 will directly call
tlb_remove_table(), and all of them are in the MMU_GATHER_TABLE_FREE
case. Therefore, I think the modification you mentioned below is
feasible.

In summary, currently only arm calls tlb_remove_table() in the
non-MMU_GATHER_RCU_TABLE_FREE case. So I think we can add this fix
directly to patch #8. If I haven't missed anything, I'll send an
updated patch #8.

> 
> Once this is done, we should be able to replace all those confusing
> calls to tlb_remove_page() on PTPs with tlb_remove_table() and remove
> the explicit call to pagetable_dtor(). AIUI this is essentially what
> Peter suggested on v3 [2].

Since this patch series is mainly for bug fix, I think that these things
can be done in separate patch series later.

> 
> [1]
> https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/
> [2]
> https://lore.kernel.org/linux-mm/20250103111457.GC22934@noisy.programming.kicks-ass.net/
> 
> [...]
> 
>> Or can we just not let tlb_remove_table() fall back to
>> tlb_remove_page()? Like the following:
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index a59205863f431..354ffaa4bd120 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -195,8 +195,6 @@
>>    *  various ptep_get_and_clear() functions.
>>    */
>>
>> -#ifdef CONFIG_MMU_GATHER_TABLE_FREE
>> -
>>   struct mmu_table_batch {
>>   #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>>          struct rcu_head         rcu;
>> @@ -219,16 +217,6 @@ static inline void __tlb_remove_table(void *table)
>>
>>   extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>>
>> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
>> -
>> -/*
>> - * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
>> page based
>> - * page directories and we can use the normal page batching to free
>> them.
>> - */
>> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
> 
> We still need a different implementation of tlb_remove_table() in this
> case. We could define it inline here:
> 
> static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
> {
>      struct page *page = table;
> 
>      pagetable_dtor(page_ptdesc(page));
>      tlb_remove_page(page);
> }

Right. As I said above, will add this to the updated patch #8.

Thanks!

> 
> - Kevin
