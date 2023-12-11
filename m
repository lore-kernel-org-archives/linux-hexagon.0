Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVFvbCXm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955269E
	for <linux-hexagon@vger.kernel.org>; Mon, 11 Dec 2023 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702311741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8Z8Ra1IdyFp35IPv47Pv41uAN8QOIjS9aUiMKff1qQw=;
	b=FVFvbCXmJx8e0PhUvo4t3KOzoB/Kff1wozeH4PenNe5ndUS2eFWme8afHTcwE54qbKFNu2
	z5+WL4K4BI3ixJ+01Rt0JISVGyXIz4IQcsgx7yF9p5dtaOA+FLqlND4zjUpxTm7s7TtG2f
	gaP61BGLQqvkXGoA0zHhaeuvl+kBagg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-2yiA0DB8OPqO33mm5OVhwA-1; Mon, 11 Dec 2023 11:22:20 -0500
X-MC-Unique: 2yiA0DB8OPqO33mm5OVhwA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40c348e529fso23957215e9.2
        for <linux-hexagon@vger.kernel.org>; Mon, 11 Dec 2023 08:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311739; x=1702916539;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z8Ra1IdyFp35IPv47Pv41uAN8QOIjS9aUiMKff1qQw=;
        b=rxVBu8Cp2GhiHwGcTzlIO2xjg8pvAnK1SgdjjGcri8Qn9ySxIrtxSyvm0XsXOT19yy
         DoPETpVGfGh9CPifXy19RiyTNba7sRQTPuViRhWnS9ApPCgJzF0aWVRqMBjyxDkkXegO
         x0orQGsOmUUHWkPxXzl510n93TMYteovWeOEQpnMdXflq+kq0lNGPRsjJGEnwJUs+NGr
         LqZ9PvB9qG7yLMVvDk2FrXS45by+Msb0nAeEHMftklr7aq5ZvGLRLtLMrn//3xCRPciq
         om3fQyFyhWm9GoW6KpcGZxmzPa6oN2MLH3Zd2TDl/aXROhxG2voZB0VUGFQTcG7Ccn0x
         L0Xw==
X-Gm-Message-State: AOJu0YwI2NuAbcDYIRKT9Ji32JdZ/QUf1TmHmfWCMyTZAi/wqXyiofBh
	5AgBudB3KmM9zAhHS/ZPnarGvp850DbLGEyl5H9pilNM7KqThQl5w+KBMpS11AJM5nxC3eglkV3
	uRV13d1bJW1XOJoH51q6dzVuk/PTifr2BNg==
X-Received: by 2002:a7b:cbd1:0:b0:40c:2acd:824b with SMTP id n17-20020a7bcbd1000000b0040c2acd824bmr2246950wmi.144.1702311739090;
        Mon, 11 Dec 2023 08:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGw/g9p3N2gA4plY9cwGBI/bsOsgKG3gmwvRUnyoDgM/XHlz7WFewFFmIZ+0PHxILUrXnAtfw==
X-Received: by 2002:a7b:cbd1:0:b0:40c:2acd:824b with SMTP id n17-20020a7bcbd1000000b0040c2acd824bmr2246941wmi.144.1702311738715;
        Mon, 11 Dec 2023 08:22:18 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-178-138.web.vodafone.de. [109.43.178.138])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm6577710wmb.15.2023.12.11.08.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:22:18 -0800 (PST)
Message-ID: <e137a521-c546-4747-a6f6-258a82beeffe@redhat.com>
Date: Mon, 11 Dec 2023 17:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from uapi
 header
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 Brian Cain <bcain@quicinc.com>
References: <20231026113114.195854-1-thuth@redhat.com>
 <SN6PR02MB4205BBAD065D3063745AE0B9B883A@SN6PR02MB4205.namprd02.prod.outlook.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <SN6PR02MB4205BBAD065D3063745AE0B9B883A@SN6PR02MB4205.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2023 04.42, Brian Cain wrote:
> 
> 
>> -----Original Message-----
>> From: Thomas Huth <thuth@redhat.com>
>> Sent: Thursday, October 26, 2023 6:31 AM
>> To: Arnd Bergmann <arnd@arndb.de>; linux-hexagon@vger.kernel.org; Brian
>> Cain <bcain@quicinc.com>
>> Cc: linux-kernel@vger.kernel.org; Oleg Nesterov <oleg@redhat.com>
>> Subject: [PATCH] hexagon: Remove CONFIG_HEXAGON_ARCH_VERSION from
>> uapi header
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>>
>> uapi headers should not expose CONFIG switches since they are not
>> available in userspace. Fix it in arch/hexagon/include/uapi/asm/user.h
>> by always defining the cs0 and cs1 entries instead of pad values.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Based-on: <20231025073802.117625-1-thuth@redhat.com>
>>
>>   Compile tested only (with CONFIG_HEXAGON_ARCH_VERSION set to 2
>>   and with CONFIG_HEXAGON_ARCH_VERSION set to 4)
>>
>>   arch/hexagon/include/uapi/asm/user.h | 7 +------
>>   arch/hexagon/kernel/ptrace.c         | 7 +++++--
>>   scripts/headers_install.sh           | 1 -
>>   3 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/hexagon/include/uapi/asm/user.h
>> b/arch/hexagon/include/uapi/asm/user.h
>> index 7327ec59b22f..abae6a4b5813 100644
>> --- a/arch/hexagon/include/uapi/asm/user.h
>> +++ b/arch/hexagon/include/uapi/asm/user.h
>> @@ -56,15 +56,10 @@ struct user_regs_struct {
>>          unsigned long pc;
>>          unsigned long cause;
>>          unsigned long badva;
>> -#if CONFIG_HEXAGON_ARCH_VERSION < 4
>> -       unsigned long pad1;  /* pad out to 48 words total */
>> -       unsigned long pad2;  /* pad out to 48 words total */
>> -       unsigned long pad3;  /* pad out to 48 words total */
>> -#else
>> +       /* cs0 and cs1 are only available with HEXAGON_ARCH_VERSION >= 4 */
>>          unsigned long cs0;
>>          unsigned long cs1;
>>          unsigned long pad1;  /* pad out to 48 words total */
>> -#endif
>>   };
>>
>>   #endif
>> diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
>> index 125f19995b76..905b06790ab7 100644
>> --- a/arch/hexagon/kernel/ptrace.c
>> +++ b/arch/hexagon/kernel/ptrace.c
>> @@ -74,7 +74,7 @@ static int genregs_set(struct task_struct *target,
>>                     unsigned int pos, unsigned int count,
>>                     const void *kbuf, const void __user *ubuf)
>>   {
>> -       int ret;
>> +       int ret, ignore_offset;
>>          unsigned long bucket;
>>          struct pt_regs *regs = task_pt_regs(target);
>>
>> @@ -111,12 +111,15 @@ static int genregs_set(struct task_struct *target,
>>   #if CONFIG_HEXAGON_ARCH_VERSION >=4
>>          INEXT(&regs->cs0, cs0);
>>          INEXT(&regs->cs1, cs1);
>> +       ignore_offset = offsetof(struct user_regs_struct, pad1);
>> +#else
>> +       ignore_offset = offsetof(struct user_regs_struct, cs0);
>>   #endif
>>
>>          /* Ignore the rest, if needed */
>>          if (!ret)
>>                  user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
>> -                       offsetof(struct user_regs_struct, pad1), -1);
>> +                                         ignore_offset, -1);
>>          else
>>                  return ret;
>>
>> diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
>> index c3064ac31003..f7d9b114de8f 100755
>> --- a/scripts/headers_install.sh
>> +++ b/scripts/headers_install.sh
>> @@ -74,7 +74,6 @@
>> arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>>   arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>>   arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>>   arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
>> -arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
>>   arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
>>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_SUPPORT
>> --
>> 2.41.0
> 
> Acked-by: Brian Cain <bcain@quicinc.com>

Thanks!

Arnd, could you maybe take this patch through your "generic include/asm 
header files" tree?

  Thomas


