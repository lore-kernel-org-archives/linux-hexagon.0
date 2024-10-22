Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336E1C9DF7
	for <linux-hexagon@vger.kernel.org>; Tue, 22 Oct 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622627; cv=none; b=LNs3g9gyTB9TZTlC7ZP2numZyBvuCyZF89akrKvkYzZSv7OvOEmPAURVJ84E25JkY0BU2npYWEmOW9SPkAYxk3ZgVFVCFcujZdD2qi+iHokQgxtrwMW+LBH0fmazI+yfHjxpYGaOmu6zn1mPLxQOgInnsskuq6m4JuR623E50z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622627; c=relaxed/simple;
	bh=RH2Ku6mP7nFuCD6W4uDKjQlzj/bGbQJSMLTCqceTPJg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LHzfUXnzGWBgSHtqkpqe0nYGK3m1//M3qFRMN0oroOxlzKSEoFQ2xebnCIMrtwgg7//znmMZE/leU5XA0pQCh+JjkGtnQBVEBkNJRJz6WS/ggT6OWAYfdpjKB4fSEoHvqAX/lLZ/NyZ4K+TcS+8Xig3zCCks9LWJ+RY//M7FNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaOjtgbv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaOjtgbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729622623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9AEvrlOO5dp2WqlHWZRSpco8mcCd4ymRTcjk9/3f/Ok=;
	b=QaOjtgbvhKZDUMbqxh6bBTH5wHQ8xoKAH8BeXfQF3/4ZdGkE9+liSy5DZvPjvCv+8yd5Ge
	8lWeMneEqlJLzRO1rSAranipVZXK8JQP5P53NQRSjnaWRcAQT8LnGDc1Gbw238d33gzi4L
	7wVGJYwcrkal1tXWnzIwskiDo55OQYg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-5bzu2k-vOZ2kp-E0JUczhA-1; Tue, 22 Oct 2024 14:43:42 -0400
X-MC-Unique: 5bzu2k-vOZ2kp-E0JUczhA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315af466d9so41272315e9.3
        for <linux-hexagon@vger.kernel.org>; Tue, 22 Oct 2024 11:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622621; x=1730227421;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9AEvrlOO5dp2WqlHWZRSpco8mcCd4ymRTcjk9/3f/Ok=;
        b=BwP0or+ZAnsND8z4+wGWYcrR8+hg27RqAHDtk1qvYaShkmzL9P5Y0yG4pF48i9woAB
         4CcsFF6Q6tQc51MsV8p0KsI/+sc8ZifJ85uadntXhPPZp50Q30iq3HlUUg4OS9EYHVlc
         TxD8RZWW2UuE3j+iqPOwno0ZbroMTQP4Z2YsmVxnrRdQfFhUwPJPZweHJZZKHXm8e3h7
         BqsE7acP9SsKxJt4sWQM2bbVx/KETOAeBofxsWlxeLR1Kh8L/KcBzBd5DwW4IYzEjvBD
         AgL7bFAHxack+mDQ97SElySN79BATlouI8StKbeCvAR8m77/qeuFJ5zey5Af/UtXsH6A
         0mkw==
X-Forwarded-Encrypted: i=1; AJvYcCU0A3fiCAEsAHKB4Fa/D+m8qpEO5hq0czSwglG9q+uo0/2httKmcSA6YQu8g6SWU3Q57dzKInsBmuuIeuqO@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXUkvUHUDSdorifGz23x+cInWrnx1V64raoro2FKIZ0anBat0
	JyZp0xYi2d10fL5vfwVsQ7lP/okNmd2D4QRG7pDopz9cFdxZLJvf+ZM3R+V9Vhwm2IjwJRtrXPD
	bG9pBC/XgB9B0eGE4TLTdUzd8881G9pCsAX0iCtvLX7qDA0kLjxB+cdK5wgrUS/Y=
X-Received: by 2002:a05:600c:46d0:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-4318424ea03mr1093085e9.28.1729622620970;
        Tue, 22 Oct 2024 11:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSwRO3kXDdah/XTLL3po6/+T5YX6LneczxVS1SqFXwRJeZWJFqERrHWHyJw/nPnXTkTa+KTQ==
X-Received: by 2002:a05:600c:46d0:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-4318424ea03mr1092955e9.28.1729622620596;
        Tue, 22 Oct 2024 11:43:40 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-40-241-30.web.vodafone.de. [109.40.241.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58f0efsm96392775e9.26.2024.10.22.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:43:40 -0700 (PDT)
Message-ID: <3e80f240-e95c-47ed-80a5-18a722dbb2c6@redhat.com>
Date: Tue, 22 Oct 2024 20:43:38 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h
 header
From: Thomas Huth <thuth@redhat.com>
To: Brian Cain <bcain@quicinc.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org
References: <20240502173818.58152-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240502173818.58152-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2024 19.38, Thomas Huth wrote:
> The kernel function prototypes are of no use for userspace and
> shouldn't get exposed in an uapi header, so let's move them into
> an internal header instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/hexagon/include/asm/setup.h      | 20 ++++++++++++++++++++
>   arch/hexagon/include/uapi/asm/setup.h | 14 ++------------
>   2 files changed, 22 insertions(+), 12 deletions(-)
>   create mode 100644 arch/hexagon/include/asm/setup.h
> 
> diff --git a/arch/hexagon/include/asm/setup.h b/arch/hexagon/include/asm/setup.h
> new file mode 100644
> index 000000000000..9f2749cd4052
> --- /dev/null
> +++ b/arch/hexagon/include/asm/setup.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + */
> +
> +#ifndef _ASM_HEXAGON_SETUP_H
> +#define _ASM_HEXAGON_SETUP_H
> +
> +#include <linux/init.h>
> +#include <uapi/asm/setup.h>
> +
> +extern char external_cmdline_buffer;
> +
> +void __init setup_arch_memory(void);
> +
> +#endif
> diff --git a/arch/hexagon/include/uapi/asm/setup.h b/arch/hexagon/include/uapi/asm/setup.h
> index 8ce9428b1583..598f74f671f6 100644
> --- a/arch/hexagon/include/uapi/asm/setup.h
> +++ b/arch/hexagon/include/uapi/asm/setup.h
> @@ -17,19 +17,9 @@
>    * 02110-1301, USA.
>    */
>   
> -#ifndef _ASM_SETUP_H
> -#define _ASM_SETUP_H
> -
> -#ifdef __KERNEL__
> -#include <linux/init.h>
> -#else
> -#define __init
> -#endif
> +#ifndef _UAPI_ASM_HEXAGON_SETUP_H
> +#define _UAPI_ASM_HEXAGON_SETUP_H
>   
>   #include <asm-generic/setup.h>
>   
> -extern char external_cmdline_buffer;
> -
> -void __init setup_arch_memory(void);
> -
>   #endif

Ping?

  Thomas

