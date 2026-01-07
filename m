Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CA299A84
	for <linux-hexagon@vger.kernel.org>; Wed,  7 Jan 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825872; cv=none; b=ujMoRcfFeWeftD/1MoB6csNpLyuxqXe8YUxnBv6TiQYxuHcHAPJn+UPPRu6QNts/t3theRy5M+PyctKtiKlx70pa2hYHgWYs2mLmjadCwjJ9FsYWfaXKqao9J70ChXGbeMxk997JFxnrs+Yu07eqipvksEH65NvkAKOT1lw5ryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825872; c=relaxed/simple;
	bh=5sj/LaImL3OHaTimRFMqAwYSglz7oIYZIOFv9qrG89U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWdc0LuriQErjKts4Ku5k9MPrCsAbjP5xSAxwlVCtGRzXKRWmCHPvkR5WEMx/la8yQx7soGCliE+dOuc8t5/vV9TRCP/yCOYcsFqtNGO+tmC+o/x5SJf6bmjs2KkH7Xl9iA9KkkCdNFcGRJVMqvf2STWqOzw1JO/U6H4NBo/4Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ummpt3SS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoJpXMQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ummpt3SS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoJpXMQY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607KTqZB1642747
	for <linux-hexagon@vger.kernel.org>; Wed, 7 Jan 2026 22:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+dTwAX5MIGepJg0meAkhXz3AGg4jggW6XsxG7ftChkA=; b=Ummpt3SSf3XkRULQ
	XprP80gVWdlBy1zDI+RbePxgMEdqyKP1l5n57Y3IK0blkUaY34MItA32BU7Lzcbt
	HCMCk+0LBzMxgLksBjj93wHEsfYXQOVrdYQm9B2wl4qYd9KCAA4FX2QdFx8UXj7A
	7qfMzEz3RUxAWlORHZiKJcI3dmyLunFb1+jopclLRmDyD4euQV3VFsjk7wiVC/H9
	zNrGeqTJvXnFkwtrkEOf8HryqWTKeaUJiZdjwuKYbZNeVtAeDT0MuXh5AlEk46fH
	tPrYHKNt8hjv34/vuMeLt0UI8BRtx5VGYGA6Vi93XbG5yth6111aCQYFspr7faWn
	SndviQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhgsfk8de-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 07 Jan 2026 22:44:29 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79043e14dfdso37386167b3.0
        for <linux-hexagon@vger.kernel.org>; Wed, 07 Jan 2026 14:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767825869; x=1768430669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dTwAX5MIGepJg0meAkhXz3AGg4jggW6XsxG7ftChkA=;
        b=hoJpXMQYdFus7RZn6t8Ag3S9iTXO0IOvdp4FOxzwDNUV7zByXgxSuNb8Nt9o+fHyvJ
         D4OVHmsxRGCyODJgyqdV46lK60UV5M08bTBiGU+kiNdeVx8iyrDHjWTRstyYo7ujD6PE
         XpnH1SrWA4Bn9X71Ph8/sMxuHMt3s4B2Hq6e7qZfosF8wKAk8d/3+JXr3/ndidZdUHDr
         GYEERWz5GJL6/Jhy0xuU4B/FyiN7xl8i/hyNTNL0tdgveiUx7kRc02tVCMM1qEbVFYik
         fd9Y6hq18cS61HYyRA3tX0NN8LBOcUFy2MprmKucMXKRm9c809U08m/397CFURpAbahm
         FruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767825869; x=1768430669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+dTwAX5MIGepJg0meAkhXz3AGg4jggW6XsxG7ftChkA=;
        b=BQLtEIgOF08w4Tk00ZtjiYTBV/BLIy+yLVVG+z+SANAJPL8fjGqLmwEp1Rd1RnlF5I
         ZnPAgKT304agVKpw6vSey12GGmR1/DprS4cql9n7aTos8IHPrlL8EdFBbZ99qA8RLCQo
         55he14kDvQqdYlvUdpQ2zUQH50ajHQoFur0vJDvNE3ngBrFjpbhHyntY3/jyU3jFbWzt
         24ur8FStkQr8C72lTNcKdh72gq/Xzwfb3Z59hbTsdBq2rgZ1ym41J28a5FtPbpRGQu9w
         nil+GCqSDCRWjSMk3ulwI/opIQeVaXlLC+5+wXe8iUtLWBs/lmw3SR17hW4RocT9KESR
         GC0w==
X-Gm-Message-State: AOJu0Yz4HNs6WC0tkOBuHQQQMJXoVeQs7PolqfAh1fd9sY5EqUDWto7e
	rng+Gh59o6XQchkzE5D8sNtE/WQBjJdYlHPfr3d5vcQ1i6Ru/CGUrU04YTQZyXHpd+UgHJGqftq
	jAvnvYumX7/OcluzfZ+xwW58GTaSoF8H/qXeAXokPVeC2/CIy6GeWzdeWzI5oZmTZH4eh7bgAhB
	qlwJ2B74f41WklC1LFQ+PlpsWnBlE6tnDbT4XOIcLeFr/DealpM2EbsQ==
X-Gm-Gg: AY/fxX4MR4G7dG++OvJoYOy0cJBIbelPAFRXszYoNcvvGyDFNZeIuUiqEo5+1NtTDij
	s6x67tOGP9A1Rxha4LwavYiJZoGkDBjBaJWCfQ3VbweAKugLKc67XI27H42B4YF5oWnHRQpB703
	d8j3eAJ3tJgp94HegQSPlHsAY9RX7y5OzZZ7YqOnMvSh7y+BHQZ52oBAYvdVYTPwlyRt6/
X-Received: by 2002:a05:690e:1449:b0:646:6f6f:65e with SMTP id 956f58d0204a3-64716b0011cmr3461224d50.24.1767825868964;
        Wed, 07 Jan 2026 14:44:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1xP5Cc/fAYuZrp0KPXvlIBLQzPeVWJF/UtEz/7VlXpslROa1vKoKrDEIw4jbt4chALJykB9kN4bPlMIlKd6c=
X-Received: by 2002:a05:690e:1449:b0:646:6f6f:65e with SMTP id
 956f58d0204a3-64716b0011cmr3461208d50.24.1767825868602; Wed, 07 Jan 2026
 14:44:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68f83fb5-4564-4bae-b214-44cbf2a3a4bc@landley.net>
In-Reply-To: <68f83fb5-4564-4bae-b214-44cbf2a3a4bc@landley.net>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 16:44:12 -0600
X-Gm-Features: AQt7F2p3EivtVIwHgWfRjMJJ24h1CfvuyotzzYpOa335ZeogxcGvWqOPUZ2D714
Message-ID: <CAEqNhNY9HqnFgm96YkgGEX6SF=xwEb3R4ve34MbJ7nAfXVVJ=Q@mail.gmail.com>
Subject: Re: Hexagon wikipedia article deleted?
To: Rob Landley <rob@landley.net>
Cc: linux-hexagon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE4MCBTYWx0ZWRfXyNi6QKkOmnfG
 LnWZPznIBbP6bfLKeN4vwG5TvmR0dZXHwpOsejRKGrJLgY9z8RA2w8z6zy57qXpNFFVKral69fT
 IyUnpIksybToDvIKR4qlb13QE3y/vS4tbDYqCxpvLDJ4suPGfY7oAGY/IkhyNEaqNFEU/GhJpwz
 IdbS+VCOW1CMbUafdYYQbfLY03ZTfQPmqSzaP8P1HHRu2cmBrk9NGcVrPn9oKjS6/PV+T9C4a42
 AeRo8I6zFTcxmNjrBAR8uxsY8jegPkviOHci4yJun9hpWRivfldFBGhGWe21+uCyURe++t/x8Y7
 7ut6o1EzTfEcIc1ZZoiQbP+L12LIqYjIYoFr/IgtmefrGXyXHNl/PT/kODstTygwOuxXHVv4cYr
 q4lBnYQzzoHh14TWDCdqrFcfqCB7dw1Ye2gpY+mg4gg+loTFkK0qQFiVyep5BNo7i4TDewCma+W
 Q1hrl7VYZCwndqqB82g==
X-Proofpoint-GUID: ywGl_3-b7BPt1gUTyzYZgtc2FiF-KTJ1
X-Proofpoint-ORIG-GUID: ywGl_3-b7BPt1gUTyzYZgtc2FiF-KTJ1
X-Authority-Analysis: v=2.4 cv=Abi83nXG c=1 sm=1 tr=0 ts=695ee1cd cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8pif782wAAAA:8 a=y5Yq1ZyPAAAA:8
 a=FBzj23p5gcN9798a5moA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=PoVUXeey_BepnEeCpHdp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_04,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070180

On Wed, Jan 7, 2026 at 1:29=E2=80=AFAM Rob Landley <rob@landley.net> wrote:
>
> Was there a reason...?

It looks like it's been restored in the meantime.

          DigitalIceAge moved page Draft:Qualcomm Hexagon to Qualcomm
Hexagon: Revert erroneous move to draftspace

>
> https://en.wikipedia.org/w/index.php?title=3DSpecial:Log/delete&page=3DQu=
alcomm_Hexagon
>
> Rob
