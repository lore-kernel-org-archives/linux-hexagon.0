Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001C40FD87
	for <linux-hexagon@vger.kernel.org>; Thu,  9 Jul 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596154; cv=none; b=da93puk2D/LLTuNuWpRb8s8O7QzWNhfi6FwdHk1PBLUniyFh72ZWkxjdiwz62yCuPOuahtmFEOQ3T6qvkMTG9nLH3ux+GTKBLz9y8fQIJG/3ShhKkZCbPhB7pDRrGNMM02pns7I8yQroL5s5tGorMRaQ9vdlo3bIDRX5MH/X/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596154; c=relaxed/simple;
	bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MQPBxdbVjJsqz5n6SrTU5utSMJM+FV+BIiVnMW8alcoFumiQRnFV+sc+nG5pgwlAAhee3ODyYvy1Lap6mtcfoWGZhYc4mKXsJV0hZESXdNADH26TdXKvdxLb5WQrhneq9c6PrIT/8CX6YNYRP5mvxTqpaUTqdRi89fwjoIUeopI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTI7fkXQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HNO0+w7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTI7fkXQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HNO0+w7l"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Aws4Y1470050
	for <linux-hexagon@vger.kernel.org>; Thu, 9 Jul 2026 11:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=; b=jTI7fkXQl7cmfY8u
	/6bNS+Fwu0N0JYJjqKlpNE/bUkl2mhzeMCIy9YTKs/eoShIUpl8OQCJgxUcCe1Qs
	3cJw4qK9vv+hDmJX2IozRyra6X37WE8v8Vxl6bxaUL0j5/MLQKzhvIKs34reKXrh
	QWs1Vb41u8wIG/o9knrL4GgKq2/ZBNYGTwPnHTuT5u7jJ3EMLnaiRdEBXGlLErlS
	QMBDjPbvcSMQgesyK7qkf9Xbt4GVvlCDF7pU0Ep4e6tiqGpO14UiKVK+WJIifgMb
	eFDVUlYtLgbk+5e07s9PeDWnBLvsQTPHVnHxEKk6PFxWS/VH6saUNZqOsHQv410+
	3wCVHw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3h5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 11:22:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d7886cdso16217271cf.1
        for <linux-hexagon@vger.kernel.org>; Thu, 09 Jul 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596150; x=1784200950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=HNO0+w7l2OsxUbsOybOYNyKmysXf0kKE7WQiIln1AxSJ8JozCERuZdfdJKyE4Z0IkF
         VjOxhwMV/hxBDUBFVguCHTwdYe5JoJM6LNZmr4Xxz+TguBPBPr5+W/hmbg3C07hrEWp5
         Z96xzAgOGQxIP4HhUe6klo0o6XWvnZl+4RNupW5yEWFUKmpxmpIfM16PliPA6EKXKbKe
         CO3lTT+7+pppbRBFYUBUCYL18rihfaC1srGVO4eIlIeBqd7jUy2nQLMvIglOURbObLet
         P7cZAM1JE/WZNkWWbChcZcU2/4o2or9j01jFVDrcNFyaOddANc8dyqVKHG87WHrHWZhJ
         RMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596150; x=1784200950;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=GkJHhmR/Jz97ncLb7dOW4I3iKeb6gDY6I2+5vHW+WsYUCDOcYjH/9p4GNcEWt0fzcA
         xoS7PFdPqDbuIYJf8js5tuMCMQHnFsRghh62dhena9/YEldLiqZKKE9WlLTIcTrPkN1G
         /VhBbr1/jI7Wed08Ld8xwEQwOicHeK7Z+8R9FkNwTrAX/3Dbp1LOuZnuHCaOMfLX2+B7
         qkviMsdrzyPwFT8yrIM7pHhfUOtQ/DqME9u3GT+pKfTE0xxQK/sGIC146Ei/InjqSsyV
         t9kVRV+JCJ10XvhJQy4MrSiK09oV9WCXFY6KSrREF3jNHsQHgGd0myv8wT4ax69m3u3N
         LtWg==
X-Forwarded-Encrypted: i=1; AHgh+RqHmKVrOb1f37iKa5jp6gm5LvMrvLveo1R0XWUeVFQJliAUMkJb1VkrZx9Q4MGhxQaWYi8zwqeLV+svEvhJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OFaKKheVJFkiN8TqS0INGFfNcxKjfKLsV7jwq7wiZedRt82Y
	2oKFRFXlR/+TA5Wg1y3w0YZhgTYHCZFun7hDM1OsjuwuTf3xnUIJdq6KOD9UNrPMG9RYh+wRLdJ
	OsyDbHXd5+ngs6roxzXyWxT0jotHhCcXhPq04PIIC0HTMvqVACmrcTW5ndaW6R9P7p2np
X-Gm-Gg: AfdE7cl6RrpyRT2pd3MxNjvTPpGutOpbITfzvupp5QqfP4NlKlRCEhWJvoqAVi9yv2S
	lKDwQaWzAuFp37LpDaPsnzSUJWhWp7R+WLDi7LSk31mem4P9G+ec2WX88fJaAl+3/f/gOsTAAnD
	UJVz/5kopS8l0I4n2Bo+PF7uo7e3QHDxlHPEdruhpdI0+3cHPhOBi20mGuqwvptcXQZR4wl4Rx+
	dR9iDpw1p1wGJRtvc+rGKiHRY3tWyH16NkIMYz3vwI/iDztdZDW3kwsUHCHR7zIdSRvcdcygUew
	Q+OLuIV3LCOvD6ZaFvAMFbGzgR2hNtEz7F0swRwR7QV1FVthZ0AsYhDCrTffctmBk8AF3V38IuS
	1tCwe+DcNPt9foI3Ik2TvPsmxENHyMh/b6MNFt2uKrveaEc53eJQjxckUtStEqw==
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987641cf.71.1783596150572;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987351cf.71.1783596150195;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50814277f8f.5.2026.07.09.04.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:22:29 -0700 (PDT)
Message-ID: <ea24e611-91e0-4397-a49c-1493966094f9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:22:26 +0200
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
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
 <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
In-Reply-To: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX5Shpyt1FUrHx
 Aojq+Zeej/y3SAyk2cEJILUkFgmeN6JjrBpfGzfS3/ui0TIkC8EjZI0c/JqKhyW5rjBDMmyeHNc
 j5q7V0iRoskT9AsWfwL1HthXjAFkU/Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1jCVx3jgGBP1
 d5EsQzDD1NcDgj3gEZ/OByjKajQnhzqP0QnOTwOVeN81PwYt8SieG0vU11AozW6RE1dfLBhF80E
 jT3bwsMsm6IHqNR8y2AMzIgO4r65AgsgtpjuGK/VfkAy0Co9EcsDi81hA2La9baUhm6scyXFAh/
 a3uXE/SmBREmWqULxDDdGAh3bXc4oN/PqrNYU7JX3ndnzq10mXJoaIge/5Hy0wws1aHSRa1S6tG
 WXs8oIjuhR+EODrYjK8eewlmYD22mW+MwIWPjFRyhJuu1gJ5pEKM9LBZTtSEzJ8S9yrVEoRR+s5
 di8NcIBK0fx7kAGuao5d7bWEHdOMO00vePXg7cAjiaGCDHrluT4IJzuUCkVNURDvs4OawKTjxpK
 B5j+BDUdcm1tkmPakk7TXrbF1h5FSRlMJTh8KezhT50QpGuvG+7rnQDCct3aBpoqq1qmtV0zA8x
 zmvrb2uKWDlpE8mhZMw==
X-Proofpoint-GUID: WShubH4MOrjyz5Hk8ftw1UjKfLt1CCib
X-Proofpoint-ORIG-GUID: WShubH4MOrjyz5Hk8ftw1UjKfLt1CCib
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f8477 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 9/7/26 13:20, Philippe Mathieu-DaudÃ© wrote:
> On 7/7/26 21:06, Thomas Gleixner wrote:
>> rseq_syscall_enter_work() is invoked before the syscall number can be
>> modified. So there is no point in rereading it from pt_regs.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> ---
>>   include/linux/entry-common.h |    9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

