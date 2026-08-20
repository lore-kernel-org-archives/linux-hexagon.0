Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57259380FF6
	for <linux-hexagon@vger.kernel.org>; Thu, 20 Aug 2026 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239503; cv=none; b=SDeMkfb4zW3OFRBgE2v9ZF/T6pKVZz88IBp6IKFgN3gZaj9a8YetB6pq6lwIS2wB0+3345COARDScZ4/bnIRZCmbYIjMcEB5Lui45R5e/WZ2mvYqaXN8E+uViznhTAJyoWb3DskmcGy+gMB50M8Z8zw8UfZRMX6+X4LnCcsblBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239503; c=relaxed/simple;
	bh=eE53d2jyXSz21PeM9cf8CETUbAt0aFGmDm7pljVQkPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAGcHtXQnyj0Xyvz8fwePR3aYatFfPXjbPXnc5qTgtEa2YXW5wASaBkUeI1U2PuQgwPH1KOS/3EMoHEmfi8sVyhTG5mPT8Ne20SsUM9git+XhxcaYhLbhZMajSSjU2LXtjRe9vJfZwQoqtY0WIeW/qb2EP6pwAvRywoFb2d89Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fLvniwF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwFBAMgm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fLvniwF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwFBAMgm"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7WLN3665899
	for <linux-hexagon@vger.kernel.org>; Thu, 20 Aug 2026 15:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OKu9p2Z6HFGUhuOsCYesWd6I664clFOsS01M4s75MYo=; b=fLvniwF9CfjfvCno
	Kpea4ktuJH3jo9088z/57hk3AztBhPUmc/MDLMKczVlKEdfqs81bADdb9dq/WVh/
	18R0pQwUEA8DxtPp8yR//KAi1fbzcYVTk9BreMEPkpN0kKbZ/P7wgq7R+nQdHmsu
	n4PFrQOrrF60YT+fBZMyQqqYr8/QAhDsKzpLmVBfefI2EQuYNxn2N8/NIjrKzM7e
	KT++RYiZVSNEEd/Khr+6kTAW4L15QiJZDDDhFXU6WtL8klczlmvUpqsSMidwylFW
	J82hszgTdt/FDUFMsn2U9yUb9KnHKN1ZWkYxN+p2uxZzbM1D4An9D/HiG+lZ6gsn
	LDB+ag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg19b1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 20 Aug 2026 15:25:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52dd69b00cfso23958551cf.3
        for <linux-hexagon@vger.kernel.org>; Thu, 20 Aug 2026 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787239500; x=1787844300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OKu9p2Z6HFGUhuOsCYesWd6I664clFOsS01M4s75MYo=;
        b=kwFBAMgmq7HzrKp44d5oLoQtpHB2pvc80BII2ectu+vRpP+wPwNyqWU5oxHH1ymC/j
         dB9pn/BStU8JB4TmCSyrGUkTo3hSK1orGT4GaCcMB45FTViJJUEObjAY0mHlcM092rGi
         w++/ciXtUDVE7Be4mJbUKfB2LE/3SCmwuFJJu0F0DfFKrIesYhweQwMWu4x1a1SrF0y0
         g8OTqo7Us6gHqE48pFI3tWWDLS4s4YvdMsDCN1WWga2BcXsb5OE1/Bv1AHI5fnoqLo56
         vha6X+c+GDUTKTiIdnwN4uABzlbQcPvyEAnJOboefTJVVdywigAzrs/9kR8j5klHXV8A
         KZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239500; x=1787844300;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OKu9p2Z6HFGUhuOsCYesWd6I664clFOsS01M4s75MYo=;
        b=IjWZQlRabti18nMb6nQTL/QV4TTsWNuYcjE/8R3XzFwieCGiIczzUUMsnBGrk9gsfK
         TUjhyH4jpYOhl/yMoDcJ7EMoaKdRrj/CZOOgvcgrmLhybDrHQLy9JOk7quX6WuifH07q
         HrddegpB8rWeq2nMXnGHIGgfs1QI9Nc0tIW/eROU1HuvAnNEbl4iAsqF3NY/uq7CISU7
         Sa+GpvvW/uXmXAC/sQOBqu/qSFvkZbTlWiUrmpKIZb91kH2bBj8eZbaz73iixNJ2ytJc
         V54ASyKKdpnd1mCrhAWBSb6i9vsgektW/mpt8llY5BbdXZTuNE+4/e0g5bKCz59vvI5r
         gxtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJQTCKrutG+NoIYwxBKbVp6kP6bn7s2emPs96cSwNNgs+lEzN3dRJHda3uEl/t2EYmsmJCK47xU6Nofdv6@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBziIZABL94+YcIFefN1GZBl+SkQeqVf1O3zKANc9k4UMIKeq
	LguVlQ6dOWieO07OJXqHM6sF6FGyUYEfkZ/iWPfSUrlb01yFDT9Qs1HmnN1z8QvZatiAVwaSy88
	m3esW3+FfXimFMPDOH85+q3otAz/KYrbI1cCcZZj9HMU99l+L5HKBdZWttI4tXgnnqM80
X-Gm-Gg: AR+sD106JccboS8QH+tFlWHedsJWA7NUjTo1rmbV9Z6r61N7/GAWlwk+lYQETevCfPI
	ulU+xx3cne1zfvJ85AqAejSsAVcPbwKD1xT3HJwdipCUeINrbF+1/gx492eO6/PdS8HH2Z06kCV
	Q250LeqdbDyFZzVnVn651lhKh6Qxm4ULRavmEaEMWbzxlZZshcOe7hAceP270Bc/85+baQUULhV
	pCg1qLukIqu0aozg1xNCnKux/bV5ZyebFH2BIJToUd5FTssyy2BbE659oC33FZpAYEjLgTp73rr
	c4SsAreQXn9vEIGnz6w72VZzsSLzenPvopYZnHYMVSoDPBujsBKm2v828if/aVcgVwoDGgrk8Q8
	+dunZrLYg5S5zx1H6TpfolccRm8XEXjtzcjUM1w1J1YCeWJGg1k7a5CQnhJOYRonl
X-Received: by 2002:a05:622a:116:b0:52b:6543:d8b with SMTP id d75a77b69052e-52dd5771dd5mr127086981cf.12.1787239500435;
        Thu, 20 Aug 2026 08:25:00 -0700 (PDT)
X-Received: by 2002:a05:622a:116:b0:52b:6543:d8b with SMTP id d75a77b69052e-52dd5771dd5mr127085871cf.12.1787239499755;
        Thu, 20 Aug 2026 08:24:59 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b6b1sm32758131cf.3.2026.08.20.08.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 08:24:58 -0700 (PDT)
Message-ID: <41d88b1d-38a2-4a34-9cbe-4a2feca29999@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:24:56 -0500
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tools/nolibc: hexagon support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Brian Cain <bcain@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        rob@landley.net
References: <20260819-nolibc-hexagon-v1-0-6bc3be591f09@weissschuh.net>
 <9b5eb6f7-3d30-45c9-a00c-58d28db4c442@oss.qualcomm.com>
 <944f4ad4-6473-4058-b0da-25f9ed45cfae@t-8ch.de>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <944f4ad4-6473-4058-b0da-25f9ed45cfae@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: EUBdFB6qxTyfUsjDISkA-NT734C4T4fl
X-Authority-Analysis: v=2.4 cv=G7Is1dk5 c=1 sm=1 tr=0 ts=6a871c4d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VTue-mJiAAAA:8 a=EUspDBNiAAAA:8 a=9bBJL4KCjqmvrfcZtnYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=S9YjYK_EKPFYWS37g-LV:22
X-Proofpoint-GUID: EUBdFB6qxTyfUsjDISkA-NT734C4T4fl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNSBTYWx0ZWRfXw/QIri51akSA
 Z39rUYmXHFQYMfHyomnTM6lTtAa8JXvRN0qQQziiyscshKONjBbGS1lB9/pqCx4IhbioU9OwV4E
 0lgI/MzeZlivdfcXeCbKXykPUD8ir54=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNSBTYWx0ZWRfX5rMn5jRsYnak
 zl6YiQjahGwH5Yl9SJOGIxDS/SeNfo/D95/WH2psnhV8q8ISlEo4ByF1I20S5uIxP4q2HeeGzPo
 RELuGODLH7PCW+zhM7LWIpIEoW4P0+BqKGrAI8Rm3r4/WmcjJuADrA16CdtYGgaPpW5U5nuOfqE
 VEwumOgVlPS85k/wLkPQ2ek0WDDQ00C7QsMLrKcCkdvK2jCpxh9K/H2hvPXfTF3LnzY2WzAHb30
 /PbpQ4oQ5UEvcC4u0pIjTG+gE2VwowrQJn9LiJpW6FkAhY6EGk+Na9iADKaBXxe20YFIjITqJUn
 /JzICBCGgIQf6S4lQ0OoDfYmGV/DqB1Niz9yXO3zzAHLHUkZKxZAaTfBXbYUogx02vb7TOpf5TW
 6YaoeGmoXV1d5yTCZyaONmF5xCMpqRPmfc6PU42P2NBrIXqONIgCSeLvK1qleBp7c7anOke1wUo
 Ax0st+ruPSOZWTUnSAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200115


On 8/19/2026 1:30 PM, Thomas Weißschuh wrote:
> On 2026-08-19 09:18:08-0500, Brian Cain wrote:
>> On 8/19/2026 1:31 AM, Thomas Weißschuh wrote:
>>> Add support for the hexagon architecture.
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>
>> Thanks, Thomas!  I've got similar nolibc patches in my tree that I have been
>> sitting on - but I like yours better.
> Out of curiosity, are you using the hexagon nolibc actively or was it
> just for fun?

I have some patches to enable booting the kernel on qemu-system-hexagon 
and when I shared them with Rob Landley he suggested I give it a try.  
So I did :)

>
>> Aside from the copy/paste error Willy identified, LGTM:
>>
>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Thanks!
