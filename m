Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7B3932CD
	for <linux-hexagon@vger.kernel.org>; Wed, 19 Aug 2026 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149096; cv=none; b=DZnF59dQZq7da0tcuxkNwpjnBtmP9otQOsZKZ3/9ZEz9BrZ2rqy35vts0vios7a/tivjiATju/DnB2XaTYBzxQy4slP6BvA8JLKNbDvTJT4IOgNAZvwtEpzLO2HlH89ljzBu9mY9UdZP6mesDWafmFXpS/dk6MIdal0aKIGUX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149096; c=relaxed/simple;
	bh=9zxh/CJLkVP3OrrEtq55iqxQYKe6qEcvytj3jfZDZac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFRrBQbjltuTMcCMm232W5APYB8qAuWP/dGRe/L3G94ZdKzm3ZJZexzCp3P2pK8o5CQa5U8LVMQSolTFPl1estsS0jAv6xA+Jp50ORBgH9bfypc3nzmUO4h2yI0Bj0XdoQvrXsqAQab8Kn//U48i+eh8Ei8icpDgWSX+ReNyrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4jedMCZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isvopcDf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4jedMCZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isvopcDf"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0D9U901429
	for <linux-hexagon@vger.kernel.org>; Wed, 19 Aug 2026 14:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g2BwNGSka6tvRzxG+P4cIb+djFTtZDTW2AfHp99NNAU=; b=g4jedMCZrw5YyQfr
	FjL7hpU7e1I78hr95CWVtU054Cw4PPhU9pHOLYQgaj6Io8zjebsfzJZJkgAUsBb9
	ZcPLyb8KIO6r0gOFzjJYL8LVf+tS7I6VADlgzQxHNvEpAvxeZ0p3jYei/tOKMzjx
	CHiS+qMRu/h/neTyaRm278EPT5ZVcJG/omORg7AouRaiatbGcm4phkmg6I/3XYJe
	8W+UTAmQeXVPkcLfqVBKeTSQ8EVYZlXWpq7diFpKL8l5ok2ggr5s7aYVyVGqeurx
	QxH4GE+ZlT3nDuVEAxdz6EPbl2prdTK/GUeZdNIHLc550oNlJEyXL5loQSgnWYNJ
	zw8BJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpukcq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 19 Aug 2026 14:18:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso98387785a.3
        for <linux-hexagon@vger.kernel.org>; Wed, 19 Aug 2026 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787149093; x=1787753893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2BwNGSka6tvRzxG+P4cIb+djFTtZDTW2AfHp99NNAU=;
        b=isvopcDfP7pT1mXg4QxaUv4ptZ3Jd4zqKirOZ+bG4Lp6ooo3kyhRC5ku6PMSOPCf/o
         tCmrK8iG9LCoN5psuA0RmAD8DDH3pxaamx8vKcTMooBeZ5re0Pdo+UfdwvRTJpdPOLkS
         gNAP3/h854htFA+1F/+FcwD/Higb3X8OSGhL7SjKxcbjIWObf38bcPJu3nCZrRdEhJaY
         vVsMxjLByZxo2VemnMI2n8Twd5cNwn3uzlxb/E0HzmG197H5knxdR+6CspH32UWcynr1
         neDb+7HyCYU2n97SakITZyJzdTl2fu3LZz25IOTpQ2poQ1o1nJ6ZtmBQbKM6cqTdVcyf
         9sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149093; x=1787753893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2BwNGSka6tvRzxG+P4cIb+djFTtZDTW2AfHp99NNAU=;
        b=mmm4RI1frV8VTq9xmrJ63m1oHKvHwKDsGSC8NQnHgGXRSn890SDJPFE5DtP6+d7JMY
         AanoFHDNU0dppLSsawNhE26NvyX/oN3VVGqWziwT5WXVLL4dD7SqwVB94FFuYDm6fuA8
         KdInSVFwHjFNq50pXgEhNGly2B4Kra5gVzJ/X76Ow11Yu8VYaIZn/dqrCdh99jDl8G2M
         9eWf3jJGCy/C2/yGEjc+Jw7oTUN63+t3QTi8X+iyN5/3nytU524Ok3KhUboKfZDDPZJq
         eZGfW74m7YzD1oli72Fqssg8h92due9fy+UvVmtptK/Sgx/JiL1ZgKHt/pXqsSVsJPZr
         FqgA==
X-Gm-Message-State: AOJu0YzfgSlQxHerWRqxlYf3OYxWlaRYWmf4G/vgfwoim/2mw8732smC
	y3dcr/1uZaq7bwQ7tKkyJR5d8lgrMEIBGpLGrW4bwQ5kZhnfqNmH+v8ii4zyjwspwB46qp7/e0p
	mno8RUGIHIILfPt78Uf2xB9JuJEHLGYQyx2hY/8IvPIxAWNZCmFWVKy0m2R9gMaJT2iTE
X-Gm-Gg: AR+sD12OOnONXqQ5EZtc0vvNA8CUuCzpuyrcBMibi/MvmFCUpxmI/H3knBAyw53KZk8
	JDkd3DkTXB6LiTbdmlhYFNul/iuNkRlZDYqpRMCGI/gIMR5NKb7EJA8ZV7mUkudtZRwve+ewMsj
	gQomlnit1XltBWto9yWaxqAzZ45Wy44QBk3/MRhsX4um4KHkmBUQgdt8QXbzuu01plEUFOixh4X
	93DNX91cDh+4VBpuv55AynCtllrAeCOIXlr56J2kI/VUeQC5txaV5pORFtwI1fJ9VKMUQvrJLQo
	P09x3eK3usWWi66CsGrVJyDQOcG2cro1SoOAeFt5+XPtGj9RsUBYNLeFfGEJ2+waQXPSCaYvj2Y
	BcnFKMJhNGqU/Rh0VE7IlmJ8vEm7EHyKjoavj/XOYwyRCY5OpMCRfSDZ/bzLZMEy6
X-Received: by 2002:a05:620a:319e:b0:930:1d55:a0ca with SMTP id af79cd13be357-9371e67ba8cmr384717585a.39.1787149093565;
        Wed, 19 Aug 2026 07:18:13 -0700 (PDT)
X-Received: by 2002:a05:620a:319e:b0:930:1d55:a0ca with SMTP id af79cd13be357-9371e67ba8cmr384711885a.39.1787149093085;
        Wed, 19 Aug 2026 07:18:13 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788dafcasm576648e87.41.2026.08.19.07.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 07:18:11 -0700 (PDT)
Message-ID: <9b5eb6f7-3d30-45c9-a00c-58d28db4c442@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 09:18:08 -0500
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools/nolibc: hexagon support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LGC65ZXtpp0OMvN0e4zyKXb-kEb2fzLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfX71KPHe9a0IZd
 t4GcotvIIfE4X2a8nbtWtXudjldButKYRmzgCYYs2Rmk+mPFpIuatpqPlDM928n0h9rX3R99qGs
 lcUj5RgyRIpfYOossUlehU4prwE14TzMWNuV5hf54D0xB0ypRe7KdihL2XttudmHO9RKZ8pHkC7
 n7SsZMqGqhmASgzaAr8ty3NJv/xAzhGfdTL0YFE+wEgD2gtLtD234ql3s2OoCcj6bTKOib+an65
 lHnbpaV7RIvc5GiNZlAE7sC2QIcBU1qZGS7BM3d7H0VjMa76rAKE19uWbE2jwOBSzPQZlZh8Pv6
 tY2X82fhdLgi6GBwMyPu4TFtcRaObgOZWDGGsL/6n/IgyklLxhBOBwTtxQOCCkuIpgzP0F9TyKV
 UqBt/so2cz4MyKQbuAF4+7uADFnPetYU4ig2y920cD3TECt1GXeZ9KqNlh7FswE2zBpT9ZwRfB4
 3xjKOTVUgKA2nOrGF5w==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85bb26 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VTue-mJiAAAA:8 a=EUspDBNiAAAA:8 a=9gZS5Jy_wUGHwPJKxtAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-ORIG-GUID: LGC65ZXtpp0OMvN0e4zyKXb-kEb2fzLu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExMSBTYWx0ZWRfX4JQdDuj3Ypcy
 soptTbkfZ8ijGlRItgBlcfSNBJcwpCNuFctGF9dRi1oludvfF92LngrMuNDygZ7whCRBsKnKIvN
 cQA5ia7ZulB03G8H4WYBzwHo6bfi+s8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190111


On 8/19/2026 1:31 AM, Thomas Weißschuh wrote:
> Add support for the hexagon architecture.
>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---


Thanks, Thomas!  I've got similar nolibc patches in my tree that I have 
been sitting on - but I like yours better.

Aside from the copy/paste error Willy identified, LGTM:

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> Thomas Weißschuh (3):
>        tools/nolibc: split the architecture list into multiple lines
>        selftests/nolibc: prepare for clang-only architectures
>        tools/nolibc: add support for hexagon
>
>   tools/include/nolibc/Makefile                  |  18 ++-
>   tools/include/nolibc/arch-hexagon.h            | 164 +++++++++++++++++++++++++
>   tools/include/nolibc/arch.h                    |   2 +
>   tools/testing/selftests/nolibc/Makefile.nolibc |   8 ++
>   tools/testing/selftests/nolibc/run-tests.sh    |  20 ++-
>   5 files changed, 209 insertions(+), 3 deletions(-)
> ---
> base-commit: b58afc8d1cf85688601b8d7e271125fff666f661
> change-id: 20260511-nolibc-hexagon-3f8891f4c7fe
>
> Best regards,
> --
> Thomas Weißschuh <linux@weissschuh.net>
>
