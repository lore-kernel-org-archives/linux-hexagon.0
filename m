Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD3381B0A
	for <linux-hexagon@vger.kernel.org>; Wed,  1 Jul 2026 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925598; cv=none; b=LFJ2NxcWjj5z4cQ3pgYTx20jwVHPINKL1vGRDg+6tDL7y0Uv89FgjPblbJN7gptgTSQJBKkyw2m0tBTRYnrjGz82M3OUuyeR/unWamYw7aJuW3rtOhByb/rXsw/PlqpnlI+RHrPlVXk/5HoDz2k3wSp3ojinS4d+Jj1NeX9DheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925598; c=relaxed/simple;
	bh=JgNyjnXkZ4IAkfrQNLtTTbl0+irC9+TiBNmugwwIuvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLlg4RJ/H95MQStZsWneTCW9o1iaCeRMUdIfPSS3l7nHc+TH6l9f8Ufitmmx3zoTV8Ke+4IGuf1hR/oNt4ExuZ8De8yEXgVnF6w4owaIhB6JOfeAu4aXuhGafdwnYxrhCFxV8V3EQn/LMME9ZiaVKOaeGTKJXFXodOl+sssbsns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FU0noXjj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MEGcO2yu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FU0noXjj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEGcO2yu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmXKk1710551
	for <linux-hexagon@vger.kernel.org>; Wed, 1 Jul 2026 17:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6eZIaHDykI6XJ9s9FKsW8D/6O13gN/UWOUJM7W01Ixg=; b=FU0noXjjft57TfDz
	i7NmIVyUNMaQgBaJE0ZpzIQH10O8IS2vbVPLpY1Q6vNoM7xAiVHd18G40bI0Fl2Z
	tyAchTTHYUky5cAkfMpTO5GAmwUL8na7+8+qwjA497aog2BS7WtuGUo/GTOLhNjF
	9hOhMMIbB5kXoqUNjXn9eF5BR6WSRniHqfo/mfVtxQW/lHf7kjpY3xGzrYsB3m7v
	ECdtqMURE5jqnApUQKgfF1uScuuMfW3/9foAvrADI8YQSMUf8WYJ12lTTS5ZAbjC
	+TC2PMsBNaazNvuQlnQ5/1SvcymYvdYCwmxWkI2Fq6m6UR/Aebg8McgXhH5+yx1G
	Aq3g3Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gpr51e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 01 Jul 2026 17:06:36 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-737d34a0dc8so964548137.1
        for <linux-hexagon@vger.kernel.org>; Wed, 01 Jul 2026 10:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782925595; x=1783530395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eZIaHDykI6XJ9s9FKsW8D/6O13gN/UWOUJM7W01Ixg=;
        b=MEGcO2yuuz88v39xP2rof0ydmVM3GXiyBO8qksDl33p01npqZ24ep4rA/oZwaXi33e
         bLZ21R/ndUzvIs2TJlTsgX8gYIk+8yveSscgHAo9/zpmetYYGrsF5zlGgP1bq5LyQSLt
         tulTrmj9O7O6DUc1RP+rGVVktiHuPdJJqlU07xIU8kE523Qa7gEemOFeh02hNjMFPHrQ
         SGzLefU3IOOOujmpLTa8ZeR2W5EfZIi1xSEGjb3ekhYcq9g3HNehQqBbv4xqji1Hc659
         zaclNzSp4tGB9Fqsi3BjadB8QnwLLLZFqo3uHAZ96meDHnNePJdWqVKUO7Xd9cxpnFIK
         YPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925595; x=1783530395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eZIaHDykI6XJ9s9FKsW8D/6O13gN/UWOUJM7W01Ixg=;
        b=YK1Do8iMc3gnPNnMTpqFmPipr66jziFDEc3lP89C5V7biOi8V5jZTUiX5RW6cAVhCt
         rMnGA63rr8EXFI3Bx5xlGpso7Uy/8xfRMiyLkYi9/hYiK42ssfVUqyO0K+V15jA3uB/L
         GijCGS4p7pNjMdLIVqU21xA+I55J/MBt16PWUEZzBDHj7LQsapt7tm4JZRgaK9VOXGGc
         admutsZlHp4BttZsmahbxi08POThL99tZB8ich4AvCLlUC8MgSo627F0WW8/xMWc04uU
         7icBrLcx6xQvxT+woCYGKKSBJBUQO5TyQPSpQQqP3j64llO+INvzV5KLbByI8qzJGxox
         M1Iw==
X-Forwarded-Encrypted: i=1; AHgh+RqlmZhaYApVJtQ3tV5YtvqTV+65joviML+RR28/ONREZzRSpRk+m7lWsylFNkpFu/8ug0WqD0V7A0dgTV6O@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEPGDUhJoMXTd1TqnolS5dQpNFyUZYBmoQo5DKUvafVmAsLAM
	epGJbCzMVVwhMjMZC4y/dDleT8VccF0IVLnCV+ZerhMZ91Kuf4ZgBaEj7SGLtjMZRtB39JO4jPK
	5HxxCuoj1TvYGm9m8HaeF2IhE9EF53k3yg6cMJ/KcGOtQZPuCu5xFNK/uxFLbjSpCZK96
X-Gm-Gg: AfdE7cmpeDT7NQ7EWGEofRd7C71S4/y0tFUlPj9lvJse0pUSMikMOFLumnSHapUWihn
	iaJv12JfgJwsz5mSaxCo3427llaL9KqP2cnqiDfxdbTTbQ4fhADJXym+NpnCESjdYHQ8l12WBjD
	8f5IvzHpLEjJ19WPGI+hpgjLbxMOI641xoG45sXTmER8GKqBzBBNocL7CJZy3+KEmel108Nda3F
	r5WBTz+GN2X9mzpXShUmuqYRWRU3VAPrJYJxXeYI0UhiP2SwC279fIv5RJwSdNWcw43VLFG+UOL
	8Syv4lMFVD+3fdKw0gouU7VAfX9i9cY6H6JM2LLi5nGXKZ94BGqAx3BKhBLNgKfu17sdH7IZFlj
	TEQAMGvHKY2jk13ZLWX3UH2t1I6auxlVTZg==
X-Received: by 2002:a05:6102:2920:b0:726:cd42:d039 with SMTP id ada2fe7eead31-73daabbec62mr1472668137.24.1782925595597;
        Wed, 01 Jul 2026 10:06:35 -0700 (PDT)
X-Received: by 2002:a05:6102:2920:b0:726:cd42:d039 with SMTP id ada2fe7eead31-73daabbec62mr1472610137.24.1782925595185;
        Wed, 01 Jul 2026 10:06:35 -0700 (PDT)
Received: from [192.168.0.138] ([79.127.134.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c21f123sm3063693a12.0.2026.07.01.10.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 10:06:33 -0700 (PDT)
Message-ID: <233e71c1-c87e-4b18-8137-3e48ae83bc89@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 19:06:16 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: remove code to handle nonexistent
 CONFIG_PAGE_SIZE_1MB
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Magnus Lindholm <linmag7@gmail.com>,
        Andreas Larsson <andreas@gaisler.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        linux-hexagon@vger.kernel.org
Cc: Brian Cain <bcain@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Helge Deller <deller@gmx.de>
References: <20260610222357.108394-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610222357.108394-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE4MSBTYWx0ZWRfX70nT1yyZq8G5
 qXJ9MV+bMQmGIAjWQMLrw8hsI6T06CD+NWQxhOdXNqB/fh9vZ9X6BftMbHf2QkGrC6yudDZhuBe
 +xjYjdQYIxVv4MM4GOJcYj6f7HFshmo=
X-Proofpoint-GUID: dZzHFGCplMSy2EpJOYqAevWzwIwS2d4A
X-Proofpoint-ORIG-GUID: dZzHFGCplMSy2EpJOYqAevWzwIwS2d4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE4MSBTYWx0ZWRfX+TJnitwR7sMo
 ZkbdKSPnhkRjvVjx+FmTcJyg3XX8IMVbSBJ7HsYgwXJ3FYc+/V9h8ey+NjO1ohTkmVGmj0aRR3C
 ABanPh57/FWOsidyEkHZ5CzDkVmbKTyJz1aHSmc5Yejdw1KQOKj0G8+n4J+LW8yavRZCgz5G+JM
 0Tj34Xl77H6T+ZolOAxQjR/BscHcSkLg2zkmehpGPN6sThbvltoMO2ZTpjpKCwsECBX5yJ64LeF
 QlXjuXlpfz3sK5DaZdImMKUtU/6Rp8y6SlAVUGFETQUAHlaipPnC40bzaMD1MnIf02JnRbxyIGd
 OcocuqeffZs0kCtCF/FeoSmN6QJLcg3djc7vtGwBfNxNjASum5MWTh+pS/m3sZWxdy5T+etaf4M
 AtIOvD9Ovt3yo1CXjeVei0Nk+JMrGL8D1ZDFP+DRxNPt93OdH3TAa7N/dU5frXEsYU2iSKAeG3k
 WtlM+yoGOV3TcRO2ZlA==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a45491c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=Js8H1uCOjlYa+gbBZlwYwQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010181

On 2026-06-11 0:23, Ethan Nelson-Moore wrote:
> Two Hexagon memory management headers contain code to handle
> CONFIG_PAGE_SIZE_1MB, which has never existed in the kernel. Remove
> this dead code.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   arch/hexagon/include/asm/page.h    | 4 ----
>   arch/hexagon/include/asm/pgtable.h | 4 ----
>   2 files changed, 8 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
