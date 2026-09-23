Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847A3955CA
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143702; cv=none; b=tUyRzOL9Kyx4LXsDKjeXFfGDgyk7kCAImMm373opbmj7wBJr1O25vpLpPcuwpJegQvyiJPeEf9vV2svGZ/UWNs5p8OJaKY7rzK+4+ZYeZGZvbCmy7va5wh8E6yyDIAsj++iOngotDCPfpaAkktZqAoLtVbPEaB3Es4L0t4QFm3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143702; c=relaxed/simple;
	bh=DwA6bR85IbHA2RUNA7poyQ+I9rmfWo0oSzlrE3gsBzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2JRYYwu0FjtQ4zNnw/bJD6wdC1dPX0yMdeisB21zWapAL3MFzrRJ+tz34+QcH6HZgWeWLdpWdkZH+sXLp6wQq6FeFtn6i9fCJDbwlySr6wKSWcGxiNu8+Pnvcm2TuJ3gBt0Gi1bpEUDvcEQ4ND+utsTyn+6qs07D9vwUvKyNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GtZ8tGvE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fRi0auTz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GtZ8tGvE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fRi0auTz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iTcK1590643
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hqZbtl22DA9HG0tqTTJipRIQB2jCvJeUDv5asEXJf6A=; b=GtZ8tGvE+Bil842Z
	ieOisf5HHVZauJKzpUZEX0A89il9q0//GoyMprQDyqACb5YwyG68WRutbD3Gx5ny
	9YZwAKY/LDapM99RmGO9yGpwGFPlVA6gnluFqtdxNZxTuJksLpuZDDb+qsaOdPV1
	71MNmHvpw/X6fSo/M2VGVVBYW3Mz7hRPKhZvt1M8YMQv6c2tSwtr2OFeSuzsJHKl
	1xNAFjIIK3Kq/E28NaN1oTHWxCBemUR5Olb8TEW88HqQlHE1jLaM2KwYdNCRspI0
	gUzDeFrSBGYmhrdeIZYLj9cQwLYJjKXGgEMmB/pEznM+mq83K0DvmyHGDzRIL5oU
	1mp3VQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gurntcq6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 06:08:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9390a2c895bso167747185a.0
        for <linux-hexagon@vger.kernel.org>; Tue, 22 Sep 2026 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790143699; x=1790748499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqZbtl22DA9HG0tqTTJipRIQB2jCvJeUDv5asEXJf6A=;
        b=fRi0auTzrXt2eSiMCvRbDc65AOd6cTEfWQQuiSGoiCnqWoDXoH9Ey5GO+T/KhYbgKS
         gu0eouiq5jPpSyjW+LM4rNRyCNC7WXrnMb1bF0INV7TLHzcLV6E46ViBWANPvbGsTWAz
         O+9tZckl+EofU+/67ub/uV5xgMs6vU6Bo/r5t4JeY8CK8eQSRxNwecdCd2dkqTseU4lt
         CAsgZNW4V9NpN3ghfSOIeSIZm9HRdRSRQVh6X9HJbpEssksJEVb7stdENLIkcYL0IFtL
         Htik4rRGLATjPSh38/og6kqP/7GCZ2DrqgW0vkrOWJmvMXbqdQCidDz1mR2s//EM4G8f
         0KYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143699; x=1790748499;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqZbtl22DA9HG0tqTTJipRIQB2jCvJeUDv5asEXJf6A=;
        b=qaol21EboG5PEUQWknKitg23ENUz8JVyYnpL/eUELVlBEFPklsAqvyc/xfzZ7NmTFt
         ALX9Yuc8fp3t9YLeOPlQoYkf4tP0bU/HmQveZfiOX4qsFvPJOWtUOYlloOcBvJzoy58E
         mLqL/fAc2c+BXTbRL8FPyoLea0XmoEivqhsP882fQ7JMZpOaUy1jCNFN3ARfpzb3jozK
         7TdQIlN4zng1AA4wZ0+X0VfhX/a8rkr7UbrIHRqkpKbo9Z4aBD0vywhrrJV3XtapVlNa
         KEFVxL8pjq4XlZ6AkjNJxxG6lNYKDuiK1OIhiJ63z1Y6/ltBaNXVywx9H0g4MthN212b
         f6Vg==
X-Forwarded-Encrypted: i=1; AKwUvBxb4FKGBJs0J3gs1exykCmWmITkzHTfeMkP6oGPRHzgE2viHu9IFvsFLUtAmhMX3jPVT+F/s22qwV+zO5sw@vger.kernel.org
X-Gm-Message-State: AFuF++nqJtIFB66OsgkF9/PWZWautrzFMUFBQt6X7E/irsYBJ2GFgkZ9
	1A8PMepjU24VQjp1rrJ0ENlxtFO/OynM1T+47xiCKp+HtoiwiNTVTxVGVAgpyA4b5qXYgfdmrw+
	z089K2HBWt/wOcWUtD5hbpuSUMBjfsqf47APuyYjGWiWHyyH5FrWV2p+njzC2K8GItvr+
X-Gm-Gg: AYBFou0J7b1s2OLr5EmHGHL8CoFwI4hMURbuOv2lt6+6M2MkUQeEPlAhbADj8IaxBaU
	2zyYjNu1yP6dzDaitr6kWvY9F8QJ3AHFt1oe1ags7hv4wB2a7PfxYFs0CbuqI32pyU8gQSkW38g
	bJR+vIEy7cmTHr/ubDTPWAA37vyS7Vcogx2WLFPSqk6vyjifMwjgRDt9Zq9+1dIKiHOhVxUiD7l
	+hppS8b6oJL6lHXSC9JvC3n6vx9I9VKfnO53cPyRFPhlCX8dCxPp5D+HDwHCv/hICW9D8os9hr6
	JQVo4CrSJG7za1BqNtWpLT3dPaE7Ci9NFMKdDGqQeKJ1R2KNMertjTjci+liS8AYOqcoKHbIbKE
	bMCnqGFigzlMEgT/cEl/MWA==
X-Received: by 2002:a05:620a:4143:b0:936:eeab:307e with SMTP id af79cd13be357-93c2509fb8cmr237612185a.9.1790143699352;
        Tue, 22 Sep 2026 23:08:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4143:b0:936:eeab:307e with SMTP id af79cd13be357-93c2509fb8cmr237610885a.9.1790143698977;
        Tue, 22 Sep 2026 23:08:18 -0700 (PDT)
Received: from [10.111.131.92] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889130sm4043408f8f.37.2026.09.22.23.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 23:08:18 -0700 (PDT)
Message-ID: <3b97c7b5-38ca-4735-b91f-e63603974eae@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 08:08:16 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] hexagon: stop passing
 -mv${CONFIG_HEXAGON_ARCH_VERSION} to the linker
To: Brian Cain <brian.cain@oss.qualcomm.com>, linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
References: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
 <20260906021712.2498266-4-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260906021712.2498266-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XBP1p1dQgSL-vn36amj8PDM0pkDsRrwI
X-Authority-Analysis: v=2.4 cv=eauo7LEH c=1 sm=1 tr=0 ts=6ab36cd4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfX1oAX1hPLD9Cl
 zps7SDejXhjX1e6ov59DiCSPMlLLS32qowGMpS4yX8YRusxP+cfPXMuaH5DXYL/awdhELcBSFPo
 uJ9eq6hFBFpTCeKAnAc0bpkP0PBPD/dkiW6B7S1MlD8Jkik/0h3n0zzHuAgLAHz4NSR/0BTGiah
 /LTnFSyXsxfws75KN8Hz6aFUfNxjcSY8Q16MivNdglq1PPHbnCpirb8wzW4Cn/l5qaq2uUo0SqM
 4kA/QjdWsiym6SKusdb8PWQn9cpASsVLlB6hvop6PBLKvlauTpmBhIEmp9SZdp1jcK+jq//8kDy
 cLNBFdywjXuLmmXLqxbbMj0D+PgdJKT0iIAu7AdPcJbSF4bHT6zWxEfDlQ1kiSw3zjctU7xPZO1
 A47P8GbnVmrZac2P6eR3B4an/arvQr30tCxDioZXtsBkHecMurIl0JPW51rG8NeHsi1Jubf+MKY
 PDIDHgu+CYfkeaf6uGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAyNCBTYWx0ZWRfXy+Azv1VRXFz3
 Pwb7phB+A55e5rG5DOrCjMK//vr0Ie5lMT+yN6BUrWfaIZnUbxiOIB7o9BjoLm5nT6N+BF++snR
 Vp2yRcZy8kDfA9oqDo7nhCFC0z/YTzE=
X-Proofpoint-GUID: XBP1p1dQgSL-vn36amj8PDM0pkDsRrwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230024

On 2026-09-06 4:17, Brian Cain wrote:
> ldflags-y is probed with cc-option, which checks whether the compiler
> accepts the flag, then the result is appended to KBUILD_LDFLAGS, which
> is passed straight to $(LD) -- the linker, not the compiler. This
> presumed the linker was ld.qcld (aka ld.eld), which does accept the
> -mvNN flags. ld.lld does not: it parses "-mvNN" as "-m vNN", i.e. a
> request for an emulation named "vNN", which does not exist, and fails
> with "unknown emulation: vNN".
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   arch/hexagon/Makefile | 2 --
>   1 file changed, 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
