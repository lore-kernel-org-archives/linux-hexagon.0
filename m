Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F6361DA7
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143547; cv=none; b=SIou2VRr2d111j93XdvwV1uv2F4TYxQEUX+Hzn7uu4b+u712QOqMhWMDCT5m8w7SSq90wmk/+YUx16zllTk9azFZKr6VPItjfpCBCZIxopY9ulV1m263LA481FGiaNpjSZem3NFuI0chUWHvgMPUG3kKOPy9VNs1ZD+Zw5qX+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143547; c=relaxed/simple;
	bh=d+rXx3ryMS6H5qJLQveUmLfiQkANkRc6ykJIp1ZlrPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZ1jjxegtrT9rLGZfbaDoWefDICtPUaJFoasj+P0q9mp5nNJ8Yyk6NWl2sV/9rWFyOZsDvb67ZNr1ztLrcH9oUn3sDnui/dEFqn7Q0aa3DPpPK0DDTU1hCRdMr3lL93jrfW0wECDcguXo0pyqBQnZ6bBZrzN839rHNCtl1LqWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQQsj3eD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/OafWvR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQQsj3eD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/OafWvR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3ijBV1425424
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mp4QIRtSu1M/C1bdEc3SYE7h//9PsiDKc6JNmxteTMQ=; b=KQQsj3eD6lZ0ciij
	Ep7JqXJgTY3DbRPg5QTDL7NZ49NQitdDQL2LZF91rb4HMPFmzxiszAx6rpvuT7nP
	w8Iqo/HIvzi7fugctEDMTnAI/uqYNZKHsDdhvtLyaV4c/+W6jWiI8wVPTRh/z1sx
	KsnIYwVLhMBx+QMjAY6ayGMhiUL2kQ5zZ2gCUIXZM40xzdrEI3KqJw36JWvNdEwC
	w9VN1pYSc0DwUqJ0zWrw0W5Gz5OKLUCSxJXxvRDanf0oURChtO+eEJ1TK2NhPj1t
	3OzyPdaoCuohGzSydayRlmukuzXWjdb1eO7V+2tVTRx0gYpCjiiTU0GoGkFky5TG
	g+0k4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c2fg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:05:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9394ad7f64aso100567085a.3
        for <linux-hexagon@vger.kernel.org>; Tue, 22 Sep 2026 23:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790143545; x=1790748345; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mp4QIRtSu1M/C1bdEc3SYE7h//9PsiDKc6JNmxteTMQ=;
        b=a/OafWvRgc0QaKl3RDUWcM5jsorp8vY/UMj+wkT05aGgUd7y8kjnTmEWby6YV0C/+R
         7GSO3Z33ZuxeNP2kbZJlE0TRjTvcwq4ISq1lxVgjbf1r8kb5biHYOMLcNMlQXWi5LMK3
         stRvuzNoS5tKtrvlCmdQQF8soBS400O/zlrivZOYB6+isPDBvceggw5fyMJ10rI4bj3F
         GO0UR5LrbLIZHeNV7fVU65OF3vRQC7BI5cIpJ7Q/snZX51C3H4VKa8j/NmQulP7KyP/E
         eLw/C549iS0pCaMqdLPijUl089t1Vwm7Z8RMLYj8uXojMEJHgbjR3ZxTQMxKrH6pUAIj
         nBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143545; x=1790748345;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mp4QIRtSu1M/C1bdEc3SYE7h//9PsiDKc6JNmxteTMQ=;
        b=dSnullvs5lF4WAAH9JSGEUcBXlsV4hk1iHq4iImwNW5pwnNoJ01iz4LtiJ9B4DR/us
         8ZJVYMr09QfpKLJ3Tssur01ECPCQGorwoW9Ci3FddTES1MOac7+AmK2KOEvWz98s5e4w
         o4dk0OLxCUXAralqgumyXHj+kOCLXgtDmGFetDv226Clkavi0TdqMKM6pUoEncY2Qvv5
         uxRbptXFCN0aGnqY3YjfjklwttaaDLsLcIBQGVZ/EqSYr+YD6dJ3vHCqoPcnyO/MCmTY
         8jTO7r7QGFq/BT01tkcCs+d4Q66n8GvLmtfr2CZj7KeZgn8DyujmGwgHYAIfqauFJ25i
         Eh4A==
X-Forwarded-Encrypted: i=1; AKwUvBzShSZ93Hi2jIUCXyPkq0zAHGx2jJgdsJusdBm2YqzKq/3KHpg+m3DjyIrKNovv35XegnJJfJJ1n3mmXnCI@vger.kernel.org
X-Gm-Message-State: AFuF++k/SNjPkTefIZDZo4t2mVdOPP30GfnzSIEQonuwiC0I3BItgGww
	S9CoAEbIGTy2X3toDpPA13UqlhWewtZugkvGojsLCobuo5/la+/WeBZgHQgIT1Z1Om830/VcLoz
	mK1iVuxQyFarXI/iS7YDQB8Q6p1bjuamf70ipXTUmLAUM7iVUei9CT8PpT13D179K32jZElPVXG
	7NK6w=
X-Gm-Gg: AYBFou0n1Cpc4iFXwli/pCMtQz+B6dygqrc51Q+GrLm8yWhaa8MoMiVHuFHgQGy58DZ
	rTcf8qj5Ab9Hk2hi8SqQJNV7FPfrE/Pa91C0H51PT1EfFR2q6Sc0l0MePZnrnecPiWTtT84ZhEd
	s2I2wvcogoyLEHOPkj2PUk/Ng1HL/w+Xtk2qq3VOGcsl5ZGGBjI5sldmQeKwHoC5Umvh8FUB1+K
	8jBa4rx+rxd+YzuWMSMaHKt53eRerM/+aEFJwzqoIjSgkJP9MSAwtraY/wdZtFLVRZ/oR92ingX
	wk339K0pPOa/URmKjfHW8ZDva3nztN26IzJGB47RO1GqQ6DLgUm6sRqvyJ9hnjtHJIayeY5f8D+
	kAxqWSifqDZwMyfXGSydXKQ==
X-Received: by 2002:a05:620a:410d:b0:93b:d79b:9a5e with SMTP id af79cd13be357-93c2524bbabmr244270285a.63.1790143544593;
        Tue, 22 Sep 2026 23:05:44 -0700 (PDT)
X-Received: by 2002:a05:620a:410d:b0:93b:d79b:9a5e with SMTP id af79cd13be357-93c2524bbabmr244267385a.63.1790143544201;
        Tue, 22 Sep 2026 23:05:44 -0700 (PDT)
Received: from [10.111.131.92] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf99df60sm33095405e9.1.2026.09.22.23.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 23:05:43 -0700 (PDT)
Message-ID: <960849ac-e359-4432-a89e-88401440fd88@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 08:05:41 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smp: align struct __call_single_node to 8 bytes
To: Brian Cain <brian.cain@oss.qualcomm.com>, linux-kernel@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, peterz@infradead.org,
        pierrick.bouvier@oss.qualcomm.com, linux-hexagon@vger.kernel.org,
        paulmck@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20260906023905.2517725-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260906023905.2517725-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TLr_wYhGPA2veP1ArB8MPFWocsXVDFSq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX0tIghfq6VGOX
 aydBfT76rRjpCu6zyQspjG9+0eLezrRnJPEn/qqJSUaVRg4kHnWUf3GFnpjFtcBtCXPj3Ovx/XV
 tHh1TNrGolTvRsb4UMzl57Uwmmhc36g=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab36c39 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=eCNQ9IFXc1d5q8r-OqYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: TLr_wYhGPA2veP1ArB8MPFWocsXVDFSq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX0qgh4uTc6Zdy
 o39OIsH95aP9mdNVkMGA3X9zygTRY2V5GTQIwNTsapcGQOjQbiDJsKjnUTlrxIsRsNP31sklJQx
 6fPS1PxMBynaP+tDqDC3pIvx9gKVzR4PeZAnw5PejNu5VKAKdzQD1i59TUsO0VK4/CphRLN+wVZ
 UyBspb+CPXsmv1CAKaESLnRETbHKY5sxpB+hyi5F7CRVh8wkuePljltcKuC+GO1Z0iWnz6TH52L
 UWeodUoRhyCF0BFNV1OobcCMOWDPvwt//2lfy4wJHBL5g2F9FjN0LSU1hL+sM8Hh2kSpdxz39K2
 KYEe9JPBKym510srlZf3r/SrzZQDEDHimPwvB+lJfcYCb33rkPwo+wj3RfWoNDCslGUlnV04nGS
 L6mmBB1gzhroNyfdsV0lReoOC2oHnPKHovWcvyldY9WC+3T7E6UfSjzWWvNjkKOgQEHYVg6QhZn
 NOkb+vLRYDzLye08F0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230024

On 2026-09-06 4:39, Brian Cain wrote:
> Consumers walking call_single_queue cast each node to call_single_data_t
> and, given that type's declared over-alignment, the compiler may load
> llist.next and u_flags as one naturally aligned double word.  Embedders

"Embedders" is not easy to understand for non-native English speaker,
is it a typo? Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> such as task_struct::wake_entry only guarantee pointer alignment, which
> faults on strict-alignment 32-bit architectures like hexagon.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: linux-hexagon@vger.kernel.org
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   include/linux/smp_types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
