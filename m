Return-Path: <linux-hexagon-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A73C0032E
	for <linux-hexagon@archiver.kernel.org>; Wed, 25 Oct 2023 14:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjJYOQg (ORCPT
        <rfc822;linux-hexagon@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjJYOQf (ORCPT
        <rfc822;linux-hexagon@vger.kernel.org>);
        Wed, 25 Oct 2023 10:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D61AD
        for <linux-hexagon@vger.kernel.org>; Wed, 25 Oct 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698243346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=/81fA64FEiSflbLmuEAcmfGAj2PLCOIEQJxZMC9ru3U=;
        b=BgHs90lIEtiotXpIBkqMyM+H8vwPypiNOhRY4JRZC/Zy/yD8LqNggNSGVIr9DTLEjLUhDw
        0Eml6LHDiDewkNc7Ce1TTZCph1PWIjodlm8VzsUnKdX6fZhpOtdcKkcKXGpIERlN4J3+V4
        rIDwJPVBY88J/o1rexwJnr0uFr712Z4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-zO2EHlJzOfaV3KYRoGen1g-1; Wed, 25 Oct 2023 10:15:35 -0400
X-MC-Unique: zO2EHlJzOfaV3KYRoGen1g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778a2e84830so751649585a.3
        for <linux-hexagon@vger.kernel.org>; Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243334; x=1698848134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/81fA64FEiSflbLmuEAcmfGAj2PLCOIEQJxZMC9ru3U=;
        b=cM/wiZ/8vAA5pbrGxFkVdmOtL62cq9ZccMkr5eZx1agAjKww2G4Ot4V4wz3PS9fPkD
         xXrDuNDcmK+Ts9sg5zs1tqShbUWMWIgdLMu6OzDg1aj6dc/TGrWyOVKDAS8oap0NZ10F
         g3lCJrboGXahClSFUSsdb9uiqGAeQvs6Ro+FMBcqS3knHKTKE/famJw29L3/tyr4osb7
         iHEhk51qaP6pm9yIZ+faff/197oR75rtmUXoMLmIJIWsmsZmU0QyKDyuXPgYibIGzzYG
         /Rp9Zff5VCqpGt+Y1JnGcYoj5AQwj4vxnYZjouTlY2Nx+IcSFAkRTK+uN/Zt2yjMw5GU
         wpxw==
X-Gm-Message-State: AOJu0YyNVWA8dgwiR9p8OjqZMtOQCVVo7jTscJRWj3WMmjPSm+kheG/B
        9KjWxR68Iy7ZiUQvQ1qXll0Q1r09RbshSAHbgLoiyGXWuJyDsPxBN/mi0jSxzGqiTdsG/s8Ueht
        MawXGbO6g5eAdFQkLxStnadhOWw==
X-Received: by 2002:a05:620a:22b0:b0:778:8bad:662d with SMTP id p16-20020a05620a22b000b007788bad662dmr14325290qkh.18.1698243334510;
        Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfE1VnLuzVl6E6EdvQNDTyIsiizJgc29Rhv6SU3AInZ2/AsqpNr4cVN/tUZP3SFyiWPzMDwA==
X-Received: by 2002:a05:620a:22b0:b0:778:8bad:662d with SMTP id p16-20020a05620a22b000b007788bad662dmr14325275qkh.18.1698243334254;
        Wed, 25 Oct 2023 07:15:34 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de. [109.43.176.238])
        by smtp.gmail.com with ESMTPSA id bk6-20020a05620a1a0600b00775afce4235sm4189754qkb.131.2023.10.25.07.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:15:33 -0700 (PDT)
Message-ID: <8af7e036-1be2-4bb3-9ae8-3ee4aa49b00a@redhat.com>
Date:   Wed, 25 Oct 2023 16:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: Remove unusable symbols from the ptrace.h uapi
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        linux-hexagon@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
References: <20231025073802.117625-1-thuth@redhat.com>
 <5e5e3e9b-dc16-428c-bd7f-d723960beb3c@app.fastmail.com>
From:   Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <5e5e3e9b-dc16-428c-bd7f-d723960beb3c@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hexagon.vger.kernel.org>
X-Mailing-List: linux-hexagon@vger.kernel.org

On 25/10/2023 15.59, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 09:38, Thomas Huth wrote:
>> Kernel-internal prototypes, references to current_thread_info()
>> and code hidden behind a CONFIG_HEXAGON_ARCH_VERSION switch are
>> certainly not usable in userspace, so this should not reside
>> in a uapi header. Move the code into an internal version of
>> ptrace.h instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   I've compile tested it now with a hexagon cross-compiler and the kernel
>>   compiles fine with this change, so I think this should be good to go.
> 
> I've applied this to the asm-generic tree, thanks for the
> patch.

Thanks!

>> +++ b/scripts/headers_install.sh
>> @@ -74,7 +74,6 @@ arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_16K
>>   arch/arc/include/uapi/asm/page.h:CONFIG_ARC_PAGE_SIZE_4K
>>   arch/arc/include/uapi/asm/swab.h:CONFIG_ARC_HAS_SWAPE
>>   arch/arm/include/uapi/asm/ptrace.h:CONFIG_CPU_ENDIAN_BE8
>> -arch/hexagon/include/uapi/asm/ptrace.h:CONFIG_HEXAGON_ARCH_VERSION
>>   arch/hexagon/include/uapi/asm/user.h:CONFIG_HEXAGON_ARCH_VERSION
>>   arch/m68k/include/uapi/asm/ptrace.h:CONFIG_COLDFIRE
>>   arch/nios2/include/uapi/asm/swab.h:CONFIG_NIOS2_CI_SWAB_NO
> 
> Would you like to send another patch for the other hexagon
> file? It looks trivial enough as we can just drop the #if
> portion there and keep the #else side.

Looks like we have at least to look carefully at 
arch/hexagon/kernel/ptrace.c first ... pad1 is still used there and the of 
offsetof(struct user_regs_struct, pad1) results in different values 
depending on the CONFIG switch ... but sure, I can have a try to come up 
with a patch.

  Thomas


