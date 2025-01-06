Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974F1DE4C9
	for <linux-hexagon@vger.kernel.org>; Mon,  6 Jan 2025 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169805; cv=none; b=ATq6DrG7PwgfrOrL8lm+nTFZ5gGY55Bu9QGiEnym4GMzeX+zvGeXJ1cr9gUJYTVSXBbu5PzkemvCOy5XpKX+AM3xifpEvu4dsXtEp7B1pe2uuXrjCpGgu3cuQY+JkdNJKH7lA5jiPSBXg8YzCySVYVTnCSaHUe+dcaj1qv0F8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169805; c=relaxed/simple;
	bh=AslleoXTRiRbWr13FtvX0Ckl/9sdreGxSQ4NH4wFg4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2gcB6g2WMk9L6BrfZP+qVDOmS1ofh5W6878d9Q5joJZbiYM/aFYEd3iyQlM3VidqYqMtD4LMIT+EESK6leGWSEuJxkNy88nmWZm6NOxXqrmucfK6oE/g1E/3SUcu3gQVoWtwL5p07ejn2I9k6AnBCidJAsX6qCkHFFYi9uLEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iI74JgsW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iI74JgsW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166022c5caso181427065ad.2
        for <linux-hexagon@vger.kernel.org>; Mon, 06 Jan 2025 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736169803; x=1736774603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=af8Jbj+kqP+p1W8uyVyt9V0YBDVs6Wu8XxDGXWv1rDo=;
        b=iI74JgsWTKG37DnW1YB/IMki+ScFHLvhEOk3vxDv9FgI6CI9jtlHtVi79I2xbSTyM0
         VdBztaV4PlDix6fx6Q3JW9PtPijrK1Ant99fgmA3is03DXu6hHX041PZwIdTpkeOjtKN
         LoDu7u38zHH64G1Ap/bFiO2Ul4iVjxZgRJ22LavyqnEuA4hlfThhKkPpKvqpm+Yl4HWd
         0Y10N6CsIor4KJg9gJ0tR5ljeF+yarKareNh75UOnmdOXB3oHayFxKL/nV0iYlWUDX2N
         n0o/oAxFwFOpZhIRnap5aLfCm/HwMLi3b9miICri0ljBKer+MO7weBR7HlkCSFvoh1c+
         NJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169803; x=1736774603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af8Jbj+kqP+p1W8uyVyt9V0YBDVs6Wu8XxDGXWv1rDo=;
        b=P7f3WA4vtQdSPoFjyPKTfYxS9rmrjT6cgiQLCUnOSw2icG7/LNoySxnVw/ju92d/0n
         0b64oKz0EczoCv4w3ZRQZ5EbPMAZPuk2d/63c0P3uanD6BDARxCXE+fFhW+P7e93KJPL
         hRDc7NHYzBxH1G2lsA+vJEf8f5cDwQbQo3r4Kd6n+gLRdKw6/S0d3R1543KNTBxB0UDm
         xwJQi82H24869IQFgSB0NFWUgrYladbGFmmI+473dE3mf6x7UefJ/H2RMk7v0jnr8ELn
         XiudmncOTgjUhAUckMO82m7uVQJGHDzwd6PPxIdJoQIPte9WO9I6yK7qeYu8kw3MTLZW
         WUBg==
X-Forwarded-Encrypted: i=1; AJvYcCWd01otjq5/vhQoJSZGUlaF1tbIQlbuk8OUu52rNqGb2HmhLvW7kbT0I7opxGzAtNCMxfh6j+yuly0MG5m0@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHaQviRwT0pZd3VnQD9t/XbhbXS3uaU4lW3K0h+92ilFw8Lvh
	CsIsaY6xMvYi2v0Moh8UARNyxKxcikgXK/uCxYt9vGpSey2RTLclbjeUEOQuRSo=
X-Gm-Gg: ASbGncuV6VcjZayr/scYno+7Pez0luDpR0Q9J7oAULlxbX7xTSaxhLhixuv/XZxwY71
	eDUBsCfqWW8QFRPKZnElfellK0EFk0mjMGVbULF0hDlr2fSU2f947VbcrOaRB9oy/n9R3t5bJte
	Xgr3Zuv2nUAHLpiNoIPrffd5rdvLOXtpNx6nvrR/2agxlWHe9Z8wa8Plj9FFg+8ef321Ti9XOE0
	JtwnUHvkoEgNAKkF0HMFUCyBedVCRDnwdgpG7iSiQswPfKqHZUoNj9SVp2a4aYTzcVPkMbXFmD7
	UTUld7sSS0a8+JUywU8wxgdPW7YgcV9S/f9FhEyqKrN6//tGSE1h
X-Google-Smtp-Source: AGHT+IE/ZrXmD5LZyqp5+IF7XucHWltqSucrfnZMLD6UEt/qaBj6OXgwMq9je0lWMbXPRWlni+TKWA==
X-Received: by 2002:a05:6a20:2d07:b0:1e1:b44f:cff1 with SMTP id adf61e73a8af0-1e5e07f9c06mr81291446637.33.1736169803320;
        Mon, 06 Jan 2025 05:23:23 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c149sm31371677b3a.191.2025.01.06.05.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:23:22 -0800 (PST)
Message-ID: <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Date: Mon, 6 Jan 2025 21:23:10 +0800
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
 <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 20:36, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 06:55:58PM +0800, Qi Zheng wrote:
>>>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>>>> +{
>>>> +	struct folio *folio = ptdesc_folio(ptdesc);
>>>> +
>>>> +	ptlock_free(ptdesc);
>>>> +	__folio_clear_pgtable(folio);
>>>> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>> +}
>>>> +
>>>
>>> If I am not mistaken, it is just pagetable_pte_dtor() rename.
>>> What is the point in moving the code around?
>>
>> No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
>> that we can move pagetable_dtor() to __tlb_remove_table(), and then
>> ptlock and PTE page can be freed together through RCU, which is
>> also the main purpose of this patch series.
> 
> I am only talking about this patch. pagetable_dtor() code above is
> the same pagetable_pte_dtor() below - it is only the function name
> that changed. So why to move the function body? Anyway, that is

Ah, I just don't want to put pagetable_dtor() in between
pagetable_pte_ctor() and ___pte_offset_map(), so I moved it above
pagetable_pte_ctor(). No other special reason. ;)

Thanks!

> just a nit.
> 
>> Thanks!
> 
>>>> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>>>> -{
>>>> -	struct folio *folio = ptdesc_folio(ptdesc);
>>>> -
>>>> -	ptlock_free(ptdesc);
>>>> -	__folio_clear_pgtable(folio);
>>>> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>> -}
> 
> Thank you!
