Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90838A717
	for <linux-hexagon@vger.kernel.org>; Tue, 13 Jan 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299577; cv=none; b=edFiEgWBDs7Mt0ffKco+/BYX20NSk49trRnenGpBafBekOXSksNBOsFiRA0Ur7juSDKiRLREQnKDfSahe88CYp1V3qYFNsXjh0DMwfzIGHBms/2Gl/z5SUnoVi08++czheoITZz0kh5poM37IEpC7OeKJaEO1y8i2UyoTI6dnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299577; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aLiHbyQ/R9umkkCOfWXb10BTB9AUwlHQWtCvBrXdT0cE5B69B+ATWHwaf/bAekTGscY3ELKh9EFIdbtDoiI1UynzsrWXaH6ZSGkaXEx+a4IzfIPQdhPGNRToqj/ok8a3LaT5t+YKpoLCK+JGYiBV3PSI1CAzz7UE9K3J96CH3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViZcoV0N; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViZcoV0N"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-382fd8aaa6eso53821861fa.1
        for <linux-hexagon@vger.kernel.org>; Tue, 13 Jan 2026 02:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299574; x=1768904374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=ViZcoV0N01xJpwy0khBNerDcEKcMgko9Oa7uP+pNw+ZPYQMQMbS8BWGpwy30TPDcU4
         ODbK18rwrx/+1zFEx1LMWksB5rTmYXed7Uizqj/hnYZFuy3SKxL4VJZzncfKJejhEwTz
         1vFKHdFyz2Y9LeZ83yitxDpJo5SpcmqtfpUux1QbYIJ0qYQszRMuJTQGpWOC8HZ+Vxqq
         t3bWIvAisNd80sALWCgviHbzCjrf1SpYtWBTNGH/cJRSCZK6NJOGOqtOUpsZP6sAtjh7
         a+7xFHLXmzRvI6ZvkmwbQrKqOY2Rz1Usb3aZBaUxSEKgWruheFDnpguJPwz9lKCdQZ2e
         YMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299574; x=1768904374;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=tph6q3U/Bs4OuZvLANvMczFhhCN4QMArnewKAB5p7qqJ9M9HuKlrg+P07szGsBh5m4
         S1/Z0V97NtinMjL9XiK25M3pszdcS2FWe3GTBtOI5ZU0xYjAXRozdZh+N+zCobSwU7Sb
         2ACKPdYhUfbBczLz8anGSkVjCaw1mE0YZu1qqRwfLRwZhe30wgER9ixJ1LN5LusqNOn5
         TNCPa5n3uhVkWUrsNm5EJUuP0v+4jKdhsBgr54mK1EnYlNYkzGeHls4MpdZs9CxrR6bz
         ZrGKAXOhnEuBRdoYiABzvaT+p6p9Sw+CtOCBf+uRe/vIAGSZ217K8gxw3ct+LpZA8UE4
         mQwA==
X-Forwarded-Encrypted: i=1; AJvYcCVg8GH3hgC0ZOjkkKna/fkzLPHOeg+xqFMa2O0Q0ljOJu+Ce36oZj7FpzScK8znvZ9f03eClFyEchgF4+VP@vger.kernel.org
X-Gm-Message-State: AOJu0YwXC3zXAP/gq+hNtNZk1YQpg/vAwfTCBbsGy1vODxwIQyNw7BUb
	Dx88/uuFDf+vzqNtFJMiJeXV/hqGgnxk6FP8vWnUNQf7ETyhUUJCgsWE
X-Gm-Gg: AY/fxX7UsV7SQhY48G0gp4qSKko5mlhNrjRm1A/s4uVsYqYqPPsPUuSDRHcvZlcqrMI
	0bAKBUN+uRo7EQpMqHMRzPktfL9YiJ1CK3oWVnhdYcJVtVeXgOWX/JIOtkHcUdiRFzHnPfHedHo
	MTVlORALpUzC4BgV2m7vFMalI7n24SOY/1bvYvioNSIVib/TZqPbOAAWYc3t+HqkQ3VI1rFWPu5
	gIMzTDLfZWMgnlk/GrcF7xPIn/dtFyqPdIqi14bqMUz7sigeQQ0Q0JfB5Te6tEAeqVuXUNddm+7
	St0LdIp5HsiRQ8DFS6EOLJY0n84/wVJwqy13v+OY6BoSr/i9am2d4Ik0+G6VX8+PAoy3bQAXnj8
	WY7vi9KkrcrS4OByo5nBSfbXOEMv9R6p+MWiwJdAwR3BBPrrN0Wjyy91netNNn/N+HSVaTlW+DP
	YXMbYA5fWBnjtmv3/8H3NHIusnaTZOsYk+Av5bpuK56v3g8RV1LKQKqlcP2A==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
