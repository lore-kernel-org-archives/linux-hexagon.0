Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102176;
	b=bgkBYufngaWaSuRCeFNrt+vjHBkj448SeopzEqnPn9Tcjb7q5TYlm26WyXJK08Ykfzyr
	 XfgfdGjKrHeDpuW1a7SbHcoZuqB4JcZHDKNPvmPCHkGds4+jnZbW4d6b+0geIpInLN66P
	 YLGVGMsVlS5qVxn5HEkwQ7ZhY7Ks4W3LoSJheGNuEMyffMxynJwlY97Dy558sTujXoRlU
	 m/4KHJgM8IkXjdlzCHfR36XbvoTdhr99yRnRVslSL8PfFSN1QkUtbmtCZQDJxt1VSsgDN
	 A/2gj+qjU0P6o3RB+HRdJVF3WhDECbL40CN9szt3HsQp+ynK7XdeCp65H+zgCO2Dheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102176;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v5cUsGgc+atAsF5stV5tV/fIiIx8O+mmL+wOysOWcic=;
	b=uhUu7z6XJdpZ7zzpUrMNlv3uTOs4ulWHAV4gMwChyqHxD74HuMoVT6RyqGT8B087flrK
	 y696qR4kf/85E/oxShYRgnT5mHFkrZvOHFQjVyQybMXYtPPcbUJkY3FEbVI///c4gsEO8
	 a2E3kHX0DyxSyN0vPXH7MrSoCEyJjgWxlarJ7zSmAojPdtNgVoXz2cgTZRbdEWQHyTzp5
	 +C7nsJj9RZ36G11yaQZ9EKkCp+vWjUJCkhqmO3U2+BGcfus8giI6hik7rtAZcM1uiXFnt
	 ReMvOK6TeuHa6CyJ9hurJs9ht0zNYOwrxgJ3FA2ooXuNmqEUayQzFSmzYvWfFZjSW9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mcy8kg0A;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWe+YVvf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6364606A324
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 15:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6364606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mcy8kg0A;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BWe+YVvf
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF69Jr3284426
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 15:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v5cUsGgc+atAsF5stV5tV/fIiIx8O+mmL+wOysOWcic=; b=Mcy8kg0AvoJ3OPld
	Ex82XNuYnDZkpq51FRzaSYsHthFTnGXSbbon2T8F7z4rRN4UTNxSt5YSoN/WGNEG
	iR+8j6IlxUnmDIGH/ZkCAXVHXtRloclejs1HFLJ/Xr51CQsHPv1EZD1bSDkP9LiP
	vVaAObiYsd+h21SVW1i5HyB6DMjJcFCc0qlcpNQdwX+8trN1b+nygddRgk1GZPmn
	7o3ncUQsL2uePn7K5v4DV/EVjXmpATLKA2Br27RioiAa/hXvUIbffUpUeCUcSX0F
	IXavOUXfw6l17o7CXVL1q7We8ckhy3z0k+i9wE8Rom5VpV16IzTwD28yeIUkmLdN
	93Dq5Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xc6sfex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 15:29:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-55d33f412b1so40633821cf.3
        for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795102174; x=1795706974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v5cUsGgc+atAsF5stV5tV/fIiIx8O+mmL+wOysOWcic=;
        b=BWe+YVvfDgJZLjmM58UZvNmhQDXIPlB/BXWK6Fp3Xi01pVy70MTJZHXQdrgR5eQnad
         cFPmZGjqLM9clPsywixR8R37VxO4JJ2ba4/TCko3URMv2qbEIogQdKiJ9/OywAGzPvsj
         8AFkAtsbePS/G/iPoWOa/GqgfhITF33ABvwYSPYoh93XFSSVHeDyXWApzUjSJxg9w5NL
         D98LA2HU+oXR2hNOeGIl74O6Q83gxNClAnGcXE3YSCOdXeip1rtoLYMm4AYs8A4uqnqX
         bgHi0brB+hdCwcUV/NwnltyKpvxDY28hffCumOvz/YJAs4lWBHeHn9twGT5Oc0jgbcH2
         vSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102174; x=1795706974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5cUsGgc+atAsF5stV5tV/fIiIx8O+mmL+wOysOWcic=;
        b=EEtdN9ebG08LOa0CfnjHoXDbkzEqAWzhhreExrJ9fA56Jva1sj44pSFewaGHIS2+94
         Bunqy3T2WN3NhJOzoFgt8xqAJxDxANjlO0OBLMfvZhsPGsofDbAEeW3gAI3YfQG9oU7K
         UV0HbE1ApDoY4uiaKdtTQi/7/kFhzkoNtnE1CFMNDrHtCQI1JlaAfpty3gdtNtzN8OQS
         x7HctKwoHg5ggC7V3l6POxqAGXPBMrY747UgjKoRV0n4EfBorgVP4IoEfaFu0z0JkSdg
         iFqfRNgPu0UBfgaHAcSRPqmkxV6WNv3zyvAL4e07uH0U0Fjx9Tg9mLKjzK1W3VuTN+vD
         gkbQ==
X-Gm-Message-State: APuU4Z+3MUY3iIs0soblyF7m9N4GTC5l4DstGtCHvNIi4xMFbihhmYLF
	GgW/6lzHYVFTXRhbTU3QtKJ7qyzjI5ri01x5w44LhHwmZK4A7ySlm1lCTmtZfoJLykY7qDr30lM
	Q2Qvo4Chkmv0qz7gaHFzt17z/Xwh5GIjsUKvKhLo+bgEqP4MvaaYWlMbUzJ4xJ2SEfvCiZj/S3c
	Hk
X-Gm-Gg: AYBFou2diNvq/tzs8vWpgBRdzsAIJmI8KxKnCViwJcoR66qZD3vhBWsaCt67Lo9+Wgn
	NUYNKKUl4F8rcMT4IgkdiyIA2VGv4JWFL4+BlpP655nDBzp2AitTlwO5q5gdYLxda0ZsC9pUfDW
	fOBKVrzPWJLObmiUoqss+QRG7/SjrqZbWf94guunBa48K/MaKoQUG3coKeCc3Ru0feMXJw2VpzZ
	y38758sUms527dnUad5l6A+/z1+FbxA+TxOB3Lkx2I6bCKLE3zXyi2GpoA+8lyzY1xJHNfGTB3l
	4ZW35UikuQ9gTdnAByje4bvx8lWMdbwlzK9jhoRGUtNWFoNEmPghnTKHPyZDumW8QYYcp9sUR8n
	r+FJisAqCMwlA2hkG/qM9HwxD970VsapWNOcZUZcG+bvtJweRGJdS3r68pXxRzeORrPvNCYkyXy
	3Ozt9bddaFK9qW2yH4bXS552212Ykt7pn2oGMXXA==
X-Received: by 2002:ac8:5d08:0:b0:55b:9d8d:f299 with SMTP id d75a77b69052e-55d769e8964mr4142371cf.21.1795102173787;
        Thu, 19 Nov 2026 07:29:33 -0800 (PST)
X-Received: by 2002:ac8:5d08:0:b0:55b:9d8d:f299 with SMTP id d75a77b69052e-55d769e8964mr4141931cf.21.1795102173243;
        Thu, 19 Nov 2026 07:29:33 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134048a4csm1356346d6.37.2026.11.19.07.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:29:32 -0800 (PST)
Message-ID: <93431e17-4d61-465e-8499-e8270fb03a3d@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 09:29:28 -0600
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hexagon: allmodconfig does not link with LLVM 17 and 18
To: Tzu-Ching Yang <shingekinocore@gmail.com>, Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261119054908.2988120-1-shingekinocore@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119054908.2988120-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aff15df cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=aYQzck3Sp6WxtQezg1cA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX/oF7DU8Q53fg
 CjfKH0AocmdzQCVj/+wMrnUzDfS79QUuyx3/FVMqS5liydG938qtaCcFhNfSTC0OeVHUZKxmpB6
 UgHwppoja9QNcC4eisqsLmZxRg8tp+uPTtm3W9plXGeFARHSXe6fkjSyYPrm2kznjPFvqUhog8/
 xTSAxAfZpjyhqU5grLkCuPkHjmLiOf53mSbQec2K58YSTUC9co8p0HXN1moPG9bjRAstCwJAdN+
 94UeftIPXk/BTagT7GME2jW34tiXWzMr8AkF6dW+XsF1GreYk4j+1Lfg8XTkj6Bc4ouNhE7Y+Kb
 LDMt+TeoYbfyw1zLsaO4YbbtFWObzucd8gZ/xpla5WSoH6rLB0/Ei9HWWIVaBLLlKjHQZASDHZq
 lAU1FZAXTHdLowEZw8A8wtszqcp5mT86x8srlJ4cT2JMGsHRHtZVtAIouT12ic/QyxG4Gi3fvoW
 FhSV85IWIm8mzun3hbg==
X-Proofpoint-ORIG-GUID: Iy0xZWldoPyQvMjaadjSmzFsviXskHaS
X-Proofpoint-GUID: Iy0xZWldoPyQvMjaadjSmzFsviXskHaS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX+rv32YSosyCk
 NexMzGHNtTdgfzYvWiX6pNKAu+8mXTVJtQxnvKtNF0HlD9+emsll19/YvUfifcZYZH+QSsr14en
 qaU1DEntdJRkeLYPUSbuhlNsSWSWr+c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190061


On 11/18/2026 11:49 PM, Tzu-Ching Yang wrote:
> Hi Brian,
>
> hexagon allmodconfig does not link with LLVM 17 and 18, on mainline
> and on stable. Your hexagon-qemu-virt branch has the fix, 09df35bd9d9f
> ("hexagon: constant-extend head.S calls to out-of-file symbols");
> could it go to hexagon-fixes, with Cc: stable?
>
> With CONFIG_WERROR=n, LLVM 17.0.1 (the minimum the kernel supports)
> and 18.1.8 fail with:
>
>    ld.lld: error: vmlinux.a(arch/hexagon/kernel/head.o):
>    (.init.text+0xd4): relocation R_HEX_B22_PCREL out of range: 2242552
>    is not in [-2097152, 2097151]; references '__vmnewmap'
>
> and the same for the second call to __vmnewmap and for the calls to
> __vmsetvec and memset. I see it on v7.4-rc1, next-20261113,
> hexagon-fixes (0304683b4c43) and v7.3.4; v6.18.63 (LTS) fails with
> LLVM 17.0.1 only. With LLVM 19.1.7 to 23.1.3, v7.4-rc1 links.
>
> The calls in stext go from .init.text to .text, across the rest of
> .init.text and the per-CPU data. On v7.4-rc1 with LLVM 17.0.1 that is
> 2.14 MiB; without CONFIG_LOCK_STAT, whose per-CPU data lies in
> between, it is 0.76 MiB. ld.lld before 19.1.5 checks R_HEX_B22_PCREL
> against 2 MiB instead of 8 MiB, which llvm-project 64e3466fd09e fixed.
>
> 09df35bd9d9f does not apply to the trees above: its context has the
> "r2 = #VM_TLB_INVALIDATE_TRUE" lines of your series. With its five
> changes made by hand:
>
> - allmodconfig links with LLVM 17.0.1 and 18.1.8 on all five trees,
>    and allyesconfig of v7.4-rc1 with LLVM 18.1.8, which failed too;
> - where v7.4-rc1 linked before (defconfig with LLVM 17.0.1 to 23.1.3,
>    allmodconfig with LLVM 19.1.7 to 23.1.3), vmlinux differs only in
>    the code of stext, in the address of one local label and in the
>    build ID.
>
> Those trees do not boot in QEMU, so I boot-tested your branch
> (dc370baa041d, v7.3-rc1 plus 24 patches), with 3 MiB of test-only
> padding at the end of head.S to make the extended calls span over
> 3 MiB: qemu_defconfig built with LLVM 17.0.1 and 23.1.3 boots to a
> shell on a buildroot root filesystem under qualcomm/qemu hex-next with
> -M virt,hvm=on. I have no hexagon hardware.
>
> Rebased onto hexagon-fixes, 09df35bd9d9f applies to v7.3.4 and
> v6.18.63 unchanged; I can send the rebased patch if that is easier.

If you would do that, that would be great - thanks.


> If it helps:
>
> Tested-by: Tzu-Ching Yang <shingekinocore@gmail.com>
>
> Nathan, once the fix is merged, the ClangBuiltLinux CI could build
> hexagon allmodconfig with LLVM 17 and 18 again (disabled in
> continuous-integration2 d9d773a8859c).
>
> Thanks,
> Tzu-Ching
