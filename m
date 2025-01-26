Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A535672;
	Sun, 26 Jan 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932358; cv=none; b=qcCWY3gMQtEOG3WhjcYRh3S7LOoIsLrbYfT1WgBMKx1cnRJ4oHQ/QLl6mE2z1amWqmrCJL8amw76lU9TFouFcZ2PK8gtLo2bnliBYTDLlXqXS1ZGFqa+v2tGlUhLhEbUL9igdRKwDQp2sJEOktMaZdEwv1YNYRy1waZZA7V8U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932358; c=relaxed/simple;
	bh=SWG77j8HWBRxd/IScgzSiQx7pcj3Ype7K3Jn/Lv8DAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtqb1qaor0Vpv+HkaRFHCFkQLOD1WEsgDS65Yu6aipJWzh4YgI13vwYkcfHr4OPbSurW/f5ohYQlHC/PSVS/QvN81WnqGMzg4V6T1tUMhUlEy63/B21S7ZEH+pUCUtSOOs2KdQPCUFtNcMEwX8Pq2VkWIA0PPWFHtDMSxf5BRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oNfp7CtG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oNfp7CtG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R/+wUpWmjSp0M779ri14bonWhWmXh5PhcHk3XOpjzyA=; b=oNfp7CtGe9xGPIIV4Szf28WnKY
	HnU3HVTKToB5IxUwfkjLc0hMeN88Cp+Kd/P8iBS38obNe80sCaT/8GpzqJ2FvkG1X+6BxHjpEs5BH
	6mbhS5lfY4D6c42iS8hxsUlVsxjt5G1gji7+fOM4CD52nNkBIQHsJ5oUFSIayabJFw2YbGkIFKZOi
	UQVHepDGcFANQpev7l9Hwz6g3YbNX/7MG9/aEuqJ3yegvkUdolrqeTNYPl17PE8LnSB9zh4uSzqFi
	TmaIslM96lZaG6NQKeWRdLBkP3uXKhk9MdAUw8skOShqukfjzVROD1s9lTE+8iWWe8u/BX0OgkBFB
	ZpGO3cjQ==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tcBav-0032bW-EZ; Sun, 26 Jan 2025 23:59:09 +0100
Message-ID: <b0504158-e9e2-4f00-8a9a-a653a6a0e313@igalia.com>
Date: Sun, 26 Jan 2025 19:59:00 -0300
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: fix using plain integer as NULL pointer warning
 in cmpxchg
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-hexagon@vger.kernel.org, bcain@quicinc.com,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, edumazet@google.com,
 Willem de Bruijn <willemb@google.com>, kernel test robot <lkp@intel.com>,
 mcanal@igalia.com
References: <20241203221736.282020-1-willemdebruijn.kernel@gmail.com>
 <CAH9NwWdODq0GXWJb_4jQNhgWjjAYfZccGLLLe7a=LVC95ew2tQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <CAH9NwWdODq0GXWJb_4jQNhgWjjAYfZccGLLLe7a=LVC95ew2tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian,

Do you have an estimate for when this patch will be picked? We are 
getting build reports from Hexagon in the V3D GPU driver [1].

[1] 
https://lore.kernel.org/oe-kbuild-all/202501031246.AD8Jjze0-lkp@intel.com/

Best Regards,
- Maíra

On 07/01/25 07:17, Christian Gmeiner wrote:
> Hi Willem,
> 
>>
>> From: Willem de Bruijn <willemb@google.com>
>>
>> Sparse reports
>>
>>      net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as NULL pointer
>>
>> Due to this code calling cmpxchg on a non-integer type
>> struct inet_diag_handler *
>>
>>      return !cmpxchg((const struct inet_diag_handler**)&inet_diag_table[type],
>>                      NULL, h) ? 0 : -EEXIST;
>>
>> While hexagon's cmpxchg assigns an integer value to a variable of this
>> type.
>>
>>      __typeof__(*(ptr)) __oldval = 0;
>>
>> Update this assignment to cast 0 to the correct type.
>>
>> The original issue is easily reproduced at head with the below block,
>> and is absent after this change.
>>
>>      make LLVM=1 ARCH=hexagon defconfig
>>      make C=1 LLVM=1 ARCH=hexagon net/ipv4/inet_diag.o
>>
>> Fixes: 99a70aa051d2 ("Hexagon: Add processor and system headers")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp@intel.com/
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202501031246.AD8Jjze0-lkp@intel.com/
> Tested-by: Christian Gmeiner <cgmeiner@igalia.com>
> 
>> ---
>>   arch/hexagon/include/asm/cmpxchg.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
>> index bf6cf5579cf4..9c58fb81f7fd 100644
>> --- a/arch/hexagon/include/asm/cmpxchg.h
>> +++ b/arch/hexagon/include/asm/cmpxchg.h
>> @@ -56,7 +56,7 @@ __arch_xchg(unsigned long x, volatile void *ptr, int size)
>>          __typeof__(ptr) __ptr = (ptr);                          \
>>          __typeof__(*(ptr)) __old = (old);                       \
>>          __typeof__(*(ptr)) __new = (new);                       \
>> -       __typeof__(*(ptr)) __oldval = 0;                        \
>> +       __typeof__(*(ptr)) __oldval = (__typeof__(*(ptr))) 0;   \
>>                                                                  \
>>          asm volatile(                                           \
>>                  "1:     %0 = memw_locked(%1);\n"                \
>> --
>> 2.47.0.338.g60cca15819-goog
>>
>>
> 
> 

