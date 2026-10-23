Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792787521;
	b=Gty72da3lgcUzqsGfoR1HbHNAOY6d36Rf+DHkgmmFT09IK7uwvYgD7pCKEqTNzn5Vju0
	 0ghdG7ywIRVRlKHksOIAi1gNWRslh96Mk3xBGdYONDdLeKUAJTvfopOhFLR8QGwWX+2TR
	 +iIiVnUYFPaATTXDCa6+vCnwRmrB6BMcooe5Exv55Mp7xGzdXMy166tVxLvbZfh0G9vSr
	 GwJQcu/oVL2An2sLWEmMHqhisoC4pw5DevIExAvZ20btCEKsNlbJY5Xfp/mJ6uifgAJH0
	 Xad6Nba92EE8GTE484R2Yu224qWBMGeX43P3+Yl0sJDkePZqKkH75htM3jZ4CFoGF+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787521;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=M3CksnXcfFZv8Mv2aTb14UhB7R/567agzBhpVxUupjI=;
	b=wiV1HZZjhR44dNvesllsim7OyjabTkKSCI59Dl2n3j8UWcxpk6tFrDwRsMt/0lVgvokP
	 Co1PzeBRsauZyRVA1w7prq1lxiHzbn4WNlTtb/Rri7qE/I9eDnhFVB5l5RHDcGB9ESYNd
	 ijPjeqdPrd7CherI6llakHxe9clFM7QtaRICHDdOq7iviPETmo7XGp/XmX4ii/gLeXglB
	 lj/EaI3iUedCGGi3og3/Ppfw0EMsddpIysswq+f70cGXj9xJZypMmDhZZgAvPZ5xt7K6w
	 gdZtgvNR3HaRvQZkXNEjRT8UQ33XRFwGFGjYLg0FAV/xDC1kMEXIR8VsWrTsvjzzAng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EXPRiohQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="CC3L/zSl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC42606A31A
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 20:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EXPRiohQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CC3L/zSl
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NIa2NP3259916
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 20:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3CksnXcfFZv8Mv2aTb14UhB7R/567agzBhpVxUupjI=; b=EXPRiohQnh6UaRhh
	EEATDN2nQWp9kOvlO7lPbqsrACUrZeDwcJTdHa5xhcZqu4nQc6DyjMulqBlTnLQ6
	QgQcChYSkVbF2Wlknfs9af8HNHOHIOllM8a+40qbBsIVq6MpKiAzWNow20WrRef0
	ZyMF8YfGkVg8aTXAe1DC76/6yNhhC7hk5lj8/FMRau3EovAWTyPXPsjv5ipB/9o5
	2Oj8IaB6WTBeVHgXv8bN6og6KGaSdehbhFq0Gp9XOqXYU6PsstSlzn7uY7TCu9Ad
	On+9FfnP+lmy/MSmDf3NmQ/Nxo1bxK3wpFcV3r637otxCclqdhsz7p9Ug8R2JnIz
	Mij2iw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgas6rw9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 20:31:59 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0a8c1b87dso21485027b3.2
        for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 13:31:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792787519; cv=none;
        d=google.com; s=arc-20260327;
        b=oYZKsmnm3w+CIgLPpCj8vktChLXVPM31iuml1Lsvq5B3A/r2jOCpk1VqJFcYTk3yf2
         CnVoJBmu2BdT1oOj18sECGPWMNtC7O5kjo0NAXsMDRi549mmhVHlRl3P+G2Z2blZtETc
         U2J1iERdLRMPVHcJdqTdlGrRTq3lsjli7ROQTM2vZpAloSmEnXFUI0gjXoCsKNnB+Ozt
         qNAzVSaBS5cKneWFI5dBl2GHhc+DfY/rKszstfjxpPXLVQCH9fx555f6+xTv0dRPeU/T
         tD3pZizhMlnLfcSIiVg8vzO8TE3ieE7xjf756LvvZvBU93IZfXxCv1s6zERgm2w3zPFl
         IRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3CksnXcfFZv8Mv2aTb14UhB7R/567agzBhpVxUupjI=;
        fh=8Jdc5r4QG/HYzedEu5VX2oS8AfqsgFen1idO94G9TM4=;
        b=dowS0EI0rfT0lshzBYN/yh7P7OW1vpE/NG0o3X2RtfTJTu1XYA9IO8UXpmDIFd6ZUS
         Jc4d3P1mUdc9ziJRVMaljQM0QFvch76d1mPC+LueMsvzNhAYYOHgjaRFdemY2evIVyrQ
         5VK5uNEMw2QSOJegj6u3oPyfsVrtGanWVBH1toVmvlfCSxW1aR3526EwmfRw13bgMYaT
         3p6jJfql91lqbX6dsoDEE4Yxe+3t+CftdfS7mxwbOVReGnsvWwKzqP3UOeuWBC63gJbJ
         0+cmBDStCEK/4k+JhGBFCW4HhwJ7v+soD7jewULRzEqIJnk62UcO8tPWJmusHEJAtD0a
         mLAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792787519; x=1793392319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3CksnXcfFZv8Mv2aTb14UhB7R/567agzBhpVxUupjI=;
        b=CC3L/zSl0jg3wYIdI6VwY0zxFRdcdvTTQjlWHnVERBpJaGZlBTKNIVuTlWbityE801
         d+pMaK7sm4xxNaOJx4u8JX/RNmC/ZtYLG64IdpgCGbbOCisO9C41JErFXpjnL6bXU/J0
         SnuIYPJLrbpwt1S6y1GP6V/Odts4YC0X6RKHtLMD7HqslWilB7JEtM1COEUZrgs/Bi5D
         2tWagHQJPSsp5dhzgEhsdl41UmJohgPsTO5/ffPefQdBZGnMbnpDcY+VVNdjgzUF+LfT
         5Zi6Q3aakw3ALTIBXPnoryVXARxu7pJsQ19FHqrbgTslfg4MAZsjzAF0lwzA+l7Dm1DN
         znEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787519; x=1793392319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3CksnXcfFZv8Mv2aTb14UhB7R/567agzBhpVxUupjI=;
        b=09A0IGqwoidQ7MaoEDLWv0tKiIQl4Y5nK4eya/MQPlSOe4qDZwAIsFjcWNWdw/CyQv
         9aHaDEbCHQH9KJwsQg1Z21ZuNOtqgovbx75oZdAlCTpDZiDHxYqYMebb5z0DsaBjIShJ
         YY5BoHOYfaNtEQn1pQUwFOdGxLJHFVUz2MKK49i42vUhmOXd/sKLwa56qBtLPC4ZrJv1
         ULUsCbpcR/S4xsMZJe0ATVPPh3bWeXo87HZg/kj8GyA8Q88w7NQhWsNsJ6qXkeIrVxPW
         I0BeswO2IbU1Axw79k61Arq/UhGL7rhvGOjDQHaw6m2IGwGmCs16wqkd/okVzAbsR6+W
         t53A==
X-Gm-Message-State: AFq9FYIpwQdzWkzA1NYhd36J9C4E1GJvA/j8LXdIh6ry3D/1RsTO3v/2
	vmzIoQpb6eJH9ugojS8Jl93MwqM3GBM60Do0CGEJ4qUJ4cdU2mYtORrUyUOqWddU1whlpEviSj2
	KaFodz8QCX6Rs0Xh6C+TaBFEHOup2k1xFpzQx8Ad4CSBnKcYrFDZ+cm9jTlMYXVDfKUuAqrRQMJ
	BTp0TCQ1hTeKD48ni4AMinUsc6tyD/HeaFn78LpyjnQLA=
X-Gm-Gg: AYBFou3akqWORCEaz/SES8tvTmJBr7aXLd82Z1wyV3HkmM3wryJD4ZN17jUwJhVEhvv
	Kj5NzDHZSMwI0sKCYwAWNIdpt6duO3KE7TF3RMo7zsXLdV0RFsfy6xdYS4f0Zp3Vi43ZBvE4FKY
	vAMTqFFSUyDFbs0BcKalFwg4qWTxWGDBgQHDEay+awZboXI7+IY07E3EbFu1o=
X-Received: by 2002:a05:690c:e1c9:10b0:8b0:bc6c:9229 with SMTP id 00721157ae682-8b166c41cd0mr1795507b3.27.1792787518609;
        Fri, 23 Oct 2026 13:31:58 -0700 (PDT)
X-Received: by 2002:a05:690c:e1c9:10b0:8b0:bc6c:9229 with SMTP id
 00721157ae682-8b166c41cd0mr1795227b3.27.1792787518121; Fri, 23 Oct 2026
 13:31:58 -0700 (PDT)
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 15:31:22 -0500
X-Gm-Features: AclHuK9i94ql6Xgrum50sseUDW-3jGQPeHVVf4sf1XToWYXIxWgXHfVR3I2BmCU
Message-ID: <CAJpW4SV5UhYExqmgtfTAt9eryXA1-+QdiqqHcU4PxCSnYqbDcg@mail.gmail.com>
Subject: Re: [PATCH 0/7] Hexagon build/syscall/etc fixes
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-hexagon@vger.kernel.org, pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4MCBTYWx0ZWRfX740malu7beSu
 ySro9cIgVZGz5BNXAd/9XIpB1zZ1MjfgrwWMiFlW0fTNymBe1x6D85+UaY3xLY8ZxOGTpt1alPA
 GcLfy3KbaCRUgQkFchKmPRBg59JOQ6GgADaZZK3+y60cXdaGjHVCSsnORXNCzkMrO+cL95nTCzd
 hWQFw43L7Hd9FJ4s2IZ1jZ9qkKuzSyxtYecE/0qIbC0fS6UgtNi+ZbF/f16N1ib8J0FckzlJh82
 kWLlak5an5WgtQmrTxeonMMLbvs6GA8H8oE7X0kYhX2isr7hPSzL5y0BNL4j0JWLeUPswk2512k
 htDKwIT0fkZ2QGe+rwvdkuHC2l4rA7AycmNLipXRqsAAxRtGbv7Ap27TWOByxdpDaGxk3V4xfwK
 13TVUWygvOWQZTMW5cwfK3F5B++I1YlbCnM/Bn6geoXkXziK+8deCjhHT3BMb1lPf4fqJn1sgYP
 wF3huNQx+cB6psxpMbg==
X-Authority-Analysis: v=2.4 cv=DK0acCNb c=1 sm=1 tr=0 ts=6adbc43f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=Eun1QSdBXWjTrmcyj9AA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: PpUFK7DB4BszZ7Adc7Wd-kxKNFhXlFKG
X-Proofpoint-ORIG-GUID: PpUFK7DB4BszZ7Adc7Wd-kxKNFhXlFKG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4MCBTYWx0ZWRfX2GRoUPleJEDw
 t1w7n3OtUD8/mejVnBRX4/sxtUhqoLTqgvZ8l2YuvUAwup+SNW123CN0xCRGDZDgCylPmGHVSQF
 YIyzxFVa4Q7lXKAIDJhZfTTiV4slR40=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230080

LGTM

Reviewed-by: Sid Manning <sid.manning@oss.qualcomm.com>


On Sat, Sep 5, 2026 at 9:17=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> While working on the qemu boot configuration, several issues were uncover=
ed,
> this series contains fixes for the bugs that were found.
>
> Brian Cain (7):
>   hexagon: disable the LLVM packetizer
>   hexagon: define ELF_CORE_EFLAGS for V4-and-later architectures
>   hexagon: stop passing -mv${CONFIG_HEXAGON_ARCH_VERSION} to the linker
>   hexagon: read the thread-info register with a volatile asm
>   hexagon: let do_work_pending return without pending work
>   hexagon: set the user stack pointer in start_thread
>   hexagon: return -ENOSYS for unimplemented syscalls
>
>  arch/hexagon/Makefile                  |  7 +++++--
>  arch/hexagon/include/asm/elf.h         |  2 +-
>  arch/hexagon/include/asm/thread_info.h | 12 +++++++++---
>  arch/hexagon/kernel/process.c          | 10 +++-------
>  arch/hexagon/kernel/traps.c            | 13 +++++++++----
>  5 files changed, 27 insertions(+), 17 deletions(-)
>
> --
> 2.34.1
>
