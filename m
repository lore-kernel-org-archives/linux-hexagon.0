Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70803BB13C
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143743; cv=none; b=M1Oge1aFy0cgyoec4DFOKpkzqN1t7NfFnpKjUYZKt/cNDIhEs8bqBcjIaxKzZNBs3x0RiiVtlfeLqHXRuwokbyY78e8W70ka9jrIo8H456WP8CV1dn/QAReHIC5H3kUUc57rB9XNHbmgrdDT5ph9Zb14+XylUtE22YcJa4mXaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143743; c=relaxed/simple;
	bh=RM5JnOwx7sGRs3q2+JWG0rZECDYyQsmlN5xGRLgZ7FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVoMyR4odkcuspOYbtAGFiRYphXA/qOmwELNHxnx0/sYl9Ru7OXuxqOdJnJ+1khNROrxEBmhX3SGecZSOm+OSe3kKE9N8nBKJgSVPiZ+0QXtJVNCckedF5uzJsMTuI/IH1YDHSgL8Q5aMSL4p4K6qnSM/X/kdJJL/Az4zmSA3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7YaMNie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ErxzTU0C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7YaMNie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ErxzTU0C"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iR322247656
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5SgQ0ti2oEI2IjJGeNTH0HemHzqw6M4MvavgH0WwsUI=; b=p7YaMNievXe8rU9Q
	oZM6ERkXVR7wGdxvugfeGMgwiFExuFjlsyDgHXcUcH5chd+5+QRKMJTschx9A9Un
	mbBz3oZY6sWfhXhTJ+8npTri7wVHssrPnENgFGB+cJqlpscR1vFFoRe46/dKFHz5
	KY1kCPILLTG33E7F9pHBmmZ9Icg9dYkH0BRhrH/zQvXD0CdIzJiBl2UfarH4RJVp
	URjphgZBuKDD2qBHVayyFBsgUtv0uUp9AtBB3rHtZ3YlYo6crFBmeX6Y1dC7Y+jJ
	S1uQBlRLQtJ2ig87D9NsdwAXnJfBDraW9fIZD968lraFvHwV2IXRB5SKLRFmg95l
	p7GnSw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guymw2bdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:09:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936708f129aso105085385a.0
        for <linux-hexagon@vger.kernel.org>; Tue, 22 Sep 2026 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790143740; x=1790748540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SgQ0ti2oEI2IjJGeNTH0HemHzqw6M4MvavgH0WwsUI=;
        b=ErxzTU0CbQMoGqY+9ShWs+HuiOMnBEAfrE2bpGYINulOXoogd1PBMx9VWr5eZsekkJ
         whH+clWHfopOWbZtPi1AGkPOifWB2w5Z/WntaAlAb8ElrEXifzwmbqOI8gPdbj+LWCXz
         3RwDo2fh67tcylXije/Gq2o7rE0hRuQO3HyO+SYi6RCVxMWaPInSHhrMVwcBukssL2vp
         wn7D5X8CwL5vVGQmXH8y9n+CD8E2qZewcHQ5nvx9YTtlzE1vDK6rfyHAtkWL8PMK0Ud5
         JXsUfL34g4s52JtTRY0cailGslX5x2W3hIbrVf1lRXD0ZzXoK2Z3pVQ/otCCuy9Q/mUn
         jSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143740; x=1790748540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SgQ0ti2oEI2IjJGeNTH0HemHzqw6M4MvavgH0WwsUI=;
        b=idgQbCPYXjGUwj1h4LJ+uCNCmK2pI9Ycd3Ib3qLIMPjl8K3Vbsd5+xXY+kdyEF2gQK
         UaguF0UWFAlcvUpUfYplLxy5eENipj3SDlFjCI9Pn72pAunRBvuTGY2VzX+AM6cwO38N
         X2a9TyG1MLnKGU5vJ7FkKm+Nl0nwqowWvS+Htm69IsFAvbQerR4VjlmEZUJyzMipb+O1
         KlsIbwuQXcxz92+P/dBZH7vYq5AsJqfMyfI/FWScb+3uFvQxzhjneigKmiKcepylnd3R
         kcP5t0j249AAPvNLI/rmxPXU0xOsfHxv+Q61H5j0BImsdQ8CrmRd5Y3Y3WMvV5Q+dbdr
         I7Eg==
X-Forwarded-Encrypted: i=1; AKwUvBwRT1+AwaC09DywaRt26TH8ICFak7EC273IT9YEve069Kqb5MdYq1Vp8CL3xKXNJ+xxyxfb2Zglw6shN+dC@vger.kernel.org
X-Gm-Message-State: AFuF++lJNJfY1IPbFEpt4/hQx4TI4pZo0Dg6WwAV+Ara12ScLDfjGCww
	r/ZyznBK/wHB/jJX8YsMjG90VYvLBo/1Av7ETl8qdMv0pBu3djcflyhU1oImUSzvWizC0ZCh2S7
	xcRfWSz2kA9CSPgrX0XM6I/NFBjG+F27qNUX923iQ231Mg5zqAJ0edioDN9/cE26iWPG7
X-Gm-Gg: AYBFou0YUxJm/2mY/z7HgHoCPZiGiCDBplwE5vCptNiWpYmmrkcNBfjqB37Tuzasib6
	cMSltl+MynCCMJ0b6PMxGpbCyi5mB4o21uDMXJ+ws/5a+ibrVad/oe8GKanqN7Lfi8pboXQmVDL
	sYrtDshNM9J/XX+pnDkKVpAdtruiS4i12pADlKlOYmxV6T+QXd/c8PEQZsbOBXy7Qv90xrJ4mgb
	IjJ7MOcBtVlG4kt/z8yD1WO5XHDfYk9cwUaPcd6wcdB1XK1aohbR3oj6N/S9MpZM2cEECbtoeBj
	M1Hx3fLN+oJoi9QLP9E6pp4ygIxhbxeICKZknAuQLi92zH+JR4rlPbOixIA6UZ4Hzwq770JvH0X
	pYJUAM9OVw3WepfVxMs/vbRpoNmdO65Ae
X-Received: by 2002:a05:620a:1a0e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-93c250813f3mr252076185a.8.1790143740028;
        Tue, 22 Sep 2026 23:09:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:939:5f4d:67b0 with SMTP id af79cd13be357-93c250813f3mr252073885a.8.1790143739561;
        Tue, 22 Sep 2026 23:08:59 -0700 (PDT)
Received: from [10.111.131.92] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c267sm4248507f8f.16.2026.09.22.23.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 23:08:58 -0700 (PDT)
Message-ID: <88fcd62f-4a5e-4be3-92c8-1bba29b428fd@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 08:08:55 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hexagon: define ELF_CORE_EFLAGS for V4-and-later
 architectures
To: Brian Cain <brian.cain@oss.qualcomm.com>, linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
References: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
 <20260906021712.2498266-3-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260906021712.2498266-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX8tzpQopb12Lv
 HeKebseZA7edWrtAp46O/ZUegU/x7wpsoP5otjE7pBAnmpuqPzIHG//Delk9R+NbSnX+Me6gU52
 OwHdBJa+1sFGusq+m/a9LNJCcRisiPHLYo2uwJ/FirrBo6i/dDryRxjPmX+rhqHJxgCVCFgond/
 Ojw3xFWVpiKK48ZMpLDVgvQnXlXMTrNToLnSF2fVt73cKI43cxgvLAzFhTxV4ytSWA+G2ulJpAw
 ANcTK998WyqsqcyHnKEK6PjBuvSxwc08LnetFv46skfpKATEbv5VX9G7SDF/sIwarIun+ZRpdNO
 6/WpMKN8Jl7h+VrlPqC1LUwxcx70OSSEbrpjwtsVVGa6yIa7XrTwpuD7Mt0xdsPQX6R30YxcSa1
 q2mYgPeHI8Nn2svtkWf7//8Wt0efuajy5m2DUBOt1mFuzHbD1xNi1RbKnAMLvBswRExwSFaqCHA
 VrVLmAN+mkpPr9/twBw==
X-Authority-Analysis: v=2.4 cv=feI4WEQF c=1 sm=1 tr=0 ts=6ab36cfd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: btbihm5GgDkiXoau2_5UpXCQARwYs-89
X-Proofpoint-ORIG-GUID: btbihm5GgDkiXoau2_5UpXCQARwYs-89
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX7Ul6Muj0U8WQ
 hh10UAOKLn0nIn6CY0SxUAVdq15H2iFQ6L/8HUggwfl5xQU4025mNZxOpo8GotjOXzWKdC3Le0E
 GnNP1eBPCqdkUf247EBCC1OuPsgWyWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230024

On 2026-09-06 4:17, Brian Cain wrote:
> ELF_CORE_EFLAGS was only defined for CONFIG_HEXAGON_ARCH_VERSION
> values of exactly 2, 3, or 4, unlike CS_COPYREGS just above it, which
> already treats V4 as a ">= 4" floor rather than an exact match. Any
> version newer than V4 left ELF_CORE_EFLAGS undefined and ptrace.c's
> use of it in the hexagon_user_view initializer failed to build.
> Extend the V4 case to match V4 and later, using the same core-dump
> e_flags value V4 used.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   arch/hexagon/include/asm/elf.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
