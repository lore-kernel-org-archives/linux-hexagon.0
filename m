Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC07411681
	for <linux-hexagon@vger.kernel.org>; Thu,  9 Jul 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596052; cv=none; b=sJDHEXMgSdMKVb4742cLM42YlooL5MoqE86CDswIB/jufr/TINbrDMCSTu7fpGs2I/xuSI9QQ9XVGkwnkvSZax0ED7IrYgvwDP4UxdQftjHZWSTpSvUYGtga7mQ5mxPlEznP5dtNi1xG+OhztHAysLXNM4qCZo+VIMHJpRTK4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596052; c=relaxed/simple;
	bh=R+aFi5Oqdv0TDSr7wZR2WAPngeBl4pJ5LsNFoxiZF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1nrhCMZWaYkwfqYdIyBt5gCNPSbZhIVicTtgc5dI7TqY7um22sebVhtYXUIT4NBNikVUVNFxGZDSBLh2vQuXcpDXU8a38UaB1W1T35uY7rUkkDrLT6LUnfdiZQSnQbK2jtR9OIXxRHI7JzyZjrvZU6k4amn3vTf+ykOU1d3Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOWfjmK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IV3ibm3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOWfjmK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IV3ibm3j"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFSU1434813
	for <linux-hexagon@vger.kernel.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftvr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c01ff996dso17579701cf.2
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596048; x=1784200848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=IV3ibm3jgasq0s25tfTTsde+mb+cbf0EiYjotNWeOD6lhtkHYfP2NAvgo3fLSIlUov
         awVy4ec6gUG+6lxF88vREvFX/BnAW2XtnXM/E4JYk8LbH2pnNKv6JRm4+/odI7GT6WSw
         o9aCqNbOOPo5mJxVtnMjUCgjDg7UbJ+oDXXQhHorU2xCYBjgAs94FosLKC7YNfz1EuEO
         FWMkNhgguy/XKB6GOEnwwjaWaA5LXbHHvWA4FfdMgXQG+86Zds/kXMxljOv9W//PYxl2
         OBUyoAWmlW2J9N199MquiObfB1jyw8TCul4WpEMjMdIUFrcq3Ym9tBCiae7oUGfKnIgR
         uZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596048; x=1784200848;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=L4ASCHDaUtEap6Gi1zBO7yY1HUG9JloGPmD08PkQ1nd7+HA4Vk5FJRkPFCqtFDjdCZ
         cNLXcaNRy7sr9FoEBRmpzW4xcEVrGOIn7T0iWiNTi9e8Wf+13kgXMEsueVcL7DYGZECd
         emySsA4JepDvI1hf+LOHiC5AgFFlJTlUKvKf2oIxX25qMCaVAsABwgxZuulpTtXjdCFy
         i8e0DxSIOB7olVdqJLDWq2TigNQgaG7hSn3OWPQCeZTEQ0gtiBbkgXx+OlvOS7YGGBqU
         DfO54xsXRHlkn1plpwtb35NyGYdVSlPexhzDb890MlfvZ62HxVOeu0LXDjWIIYaX9yNi
         Thfg==
X-Forwarded-Encrypted: i=1; AHgh+RrGskCEC29Ge47hLIc9BqmHlytyvrF/muHTnUQ7zPv7aPQ+g/QR3rX6Jt55Q1w/PB2+p9OFqTsvlObqj2+m@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjeIduUA79H7DwGbAuonEMfzm1MtIKcDougYwX2YqSUlIH7m+
	Ztm+4xzkq2oZv7OkcIy49DAGRsEe/1CJnw4msxLMxmG6VX9puu8YEQh4yRmKjC+Wz95VjsjTk+K
	2/WmbDbN5UC+XDjCqKBom99LncLEg6Saljvn3aJBRWvNr/DhP9AN5TGgEuVxFwYcEwjo/
X-Gm-Gg: AfdE7cn3zw+Z+mMVwEFlQQec7VjC6xYs5r4ZcWpeDWQwrqC9s5rwzI9EeYSNS6+78Cy
	hyS+gk/4NBamf8AN00J1SIcNNqxCTzWVnor1GTm29hVlN7Uc8zCLlYOgch8R/5iAKRr8PuR4wX+
	FG7zKySzSjSvlb00iVBZHm4vqqRgCJWdv8TIL0SoUtiHTtxMb1KOcR+tcfiByZPG1BBVVNMahj3
	DdckKUvb4C08v/5KQYefxwJZdgkHlW+kegOO+pwIy2yNpAYgJvR76BMRlapjJMD+YlEsKV7nmwm
	T7RARmjRC6qyourF6jLbXHS+HejP6XQVyl64cUH+cnOCxyad6f9Q679LyKD4WpXK60RYhKqgVIl
	qL+PLJ+PwaOgiAo2vdk0zwaI5d/ceebf/JoA8X4UDygJv9bWuia0J6aBSYMJasw==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754961cf.27.1783596047579;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX4nJacQwJz4T+
 55PQQm582gSAVFOfMomId6rf/Ix8fKAv7lNKdTDWHiavXnzW87qJMKW2WsUezSle7gvEYjVF+um
 6jB2SnzNpTx3j1E02gEv0TWLbuoo+vBLTI/UAPVy4PPVhjlamut+sqMlnvNFq5BBvsL0RJaaD9t
 K012WzXD5cIVtHQSQLyYyNidpU4SdE5A5MFrq7hB1bsAx17ZUkwqKomWFg7ejmjTPy3JlP+Iw4V
 WWXyYjBf+GE5KMdigTufU4UyaOJV6JG0HCdFG9h4rAds4CiN/LyRbs0q3ilYfXxrmMik0egjm8G
 U/nYsyPRuiNJX4g8V7F08kkpZJIEY3oU/1Wzo6lABQogwG9+SONcLNtg+cx2WrXBUKEGMKsH92X
 7xPjPy7X1lUdsV5flFetScvbrnX8c6ecf/sHQwJhjYnxU2MvIWQjyzlJ/ZlLkOAFVoSXDtZ1j3i
 K0Xw/RAV19qijt3nL6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX4VJqfwzFsoIg
 sBx/L5hewItRrv6kgUhGWd2/+Sem2zPkEwnZkUOEZd9G0vMdmP+wOvbr9TXYJ4N8cYLo7WCfWLc
 joIGtuRtMWII24vvMA9j1yw5zEGjISA=
X-Proofpoint-ORIG-GUID: YgVrQuBc8PcdUo4AU0bS31QbFAnXUvnw
X-Proofpoint-GUID: YgVrQuBc8PcdUo4AU0bS31QbFAnXUvnw
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)


