Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066636;
	b=0H5CJ0+NfPFGJJYKdsxmxd1Vpp0mOmgweI7j7PZfc6d67QiG+cftF3aK8AxDPCwkfsPq
	 UfKdUfrbo6FWwQyx12knNnK+jThnW0YI2OQCZZj6T1MWtwVPTm34SZ4rZ5AOCFaMstyyT
	 eOcck5zPglSSnbg5vcw82Yn53hW2SPHAuVirlUh5m4awHuXau7xfhOLsStHrEWbRCbjq4
	 Tyyu7Ugn0NkMRP2IclEr1l9Mfiwc4IWRnikhEYGLPf2138I+vnUozydMDHL4i3CrD9GDm
	 zrgwJeW26YrSP2E+kwBKYWdJprSyvdnrD9wwBVSstflknLO4RDbNlr0fyZ6Aq1swgFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066636;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
	b=rdwMZIXa/S7XwnRrTkp28pOot6oikR7JYeBCQteo6I/PeZPMhl14rzvPQKB/WWxNhWme
	 7kA6jPLwb5BwG61KLKpc9kroquZKrfhsAT1c+TpO3geLkyn7b2wegNQ6Wx+ZJKL8TRteq
	 X3ZvfhqZbAZma1W2lv8lrTXths1w+w4E89AVD1jawHuL0U+XOuzZXxhlGlYSwn+sRrl79
	 yCbSP63FCWmRgrQRcty4tR6PuttOLhhwrH3t149PRIxsAAUzVOiaOch9z0RHCkKqO5jt6
	 EZ3xKlCM9jeQ9YVOA12E+BzI6MOmRsyt1Re/2I+rFrZYE9olPpQS1wDLZTDV4OoPozA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aJYwbou9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jH6R2Ods;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADE606B425
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 05:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FADE606B425
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aJYwbou9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jH6R2Ods
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ1B1fp1444715
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 05:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=; b=aJYwbou9o1/UPQ+J
	xkqhiHpIVeQUOiIk8ldF4poGvECw3lXj8r9Phir65vm5e/5s++idTxpRfJFjNPPE
	JEURtN29gzHQNQSASetnPP1GfW/c5f5xuPBRn3nXC8zwPBdBqHllTn55yuy8bBOH
	o69+Ijt5lDp4KZkFRyKcqCDHg3bu3isHex+QxRAjVhg0RSTYwaGUNX4YXItzEQQ5
	RxHGVC1yC0w0HlalEl0DIshJh2bS8iHnrIu0DStpbTRkWTyTQD8oj94JkISWYwe+
	UUGEImr4TVf346/fMp1HvqxG+yV6kfDqOSbt6OQ9dnJf29ao25POkNoCBnCfDmOZ
	lCXhDA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qu9m8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 19 Nov 2026 05:37:15 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-862b081153dso635611a34.0
        for <linux-hexagon@vger.kernel.org>; Wed, 18 Nov 2026 21:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795066635; x=1795671435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
        b=jH6R2OdsqaQH9r4jz6vuZ7Cig6Tjp4DtN+pyyUeo1PCfEVwUJE5oFQZq8fvJO6ecEm
         HmoXmwUvIcedlXMQ2XnR9lDp6WikH8qQyIg2w9gdcqzymVqrDzSMyFv5lOvi+8g0T7fr
         jBtLH4WOFV9ASOrNL4sENf4YBlbNpijccZta4Y89pV/HW0U7ZSQxHbkeWbBqdIiJX/t1
         S9Msagkya+cmyd5UcdZCjWFggS7scoCmJxuN9uY/3J/5oXPBTrU2bT+oUEaHM16JC6ES
         50YYdmaqpqCc8u9Y56lqRmkqY4lgjc0kiafPXaBBQT4pFa6xP1pgjNjI3BIBbIyEcORh
         bnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795066635; x=1795671435;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kXuNtSAmr+Pqww7RppGgLBQmvifOl6Hq2LhWjIe71V8=;
        b=yHdkOfneWfppM+h3iD8ajJ5u7JhQZb1x2S6FvFVtUNdX4758oxFwCvN+AyLm9QXdnb
         QiZIiHPQeN4Hbh+4G/MUR2LwWdQUocMpEHI3T/nBqYlnaGBROk3wOMJqX5Ghm/yTcwvT
         xfDKLFx/2F08i0UUhkcNpMdWbygnsHqgSacMe/kf31keSrVAyGO13++m0aKdtN2Hm9RA
         9VmQUxyzgnlLXUYQfZNy0AR2/GXKyZoYG+0s9azaxnwKr6meZMuvOBWIkg8K+tp1vCBb
         scIElD1juPC2m+We6uP14AiiwZDeqrvdBkri59G5tYr8PNHwbvn/5trrXmLxK8fycjx5
         J+YQ==
X-Gm-Message-State: APuU4Z/bgjKChy3adYJDh7jXUe4arND6pk7FdhKZgST/OYXIgc1/JD3L
	Ng3OSh7BK03kuMgplTa8c+c3JyInJkI4rxtnD/i6cachyaPYhangVjGAsG3pyOtxdx2o0X0ftHd
	JTpQ6p/8QcdssCkdYofyFREU4x3STMMSRYqAse5Ns7kPSutVXaZwcRvY+rRzbgKjLopcg
X-Gm-Gg: AYBFou3bwWIh4d9VSwO3lHzLH8c4bCMUi9LnLRQmFLYXFkhopvXG6XDrLVQ5PzpKTsp
	k/k95lDnqujJQqh34nhq4WtdTRl2IY8yKZU5KVnE3Yot8b6vO8CXbuRRhb/mIDNZmE3JrbMZ0bV
	KEvCqcdqbCJVIkplcAHdfwJc9Yz2IaIj9M7SViGLGl89TbU+to87JxUYr5IaKo08u2ldW699lvQ
	liNYm4Qfa0CuayMMsSBCDV5O7F7TQ6LnLADmxfPySW59E3u5084aK1ChpZJszHrLe+E6D6NgZbD
	yE3ugLxb73VUnlxdXQSNSjPXtoAHqnI+CJQ4FluIr0KQZ4JzZfdGqI9zgrJsqmBYIVrT7AmkUdf
	O0nSLax2yFuZaBsmhfEImqE93NmGXkI+KFj+crYXkIzxWzZuJvVH1sijCt+6zJLJjOBvG0ZpQNy
	+x+Cv9SkAWOxBXyIF7W6/r3dnwHTotANzI8FfyRa7n8pdPuLQDzTfO
X-Received: by 2002:a05:6830:2543:b0:862:cac9:8ed5 with SMTP id 46e09a7af769-86308fe3689mr56298a34.2.1795066634663;
        Wed, 18 Nov 2026 21:37:14 -0800 (PST)
X-Received: by 2002:a05:6830:2543:b0:862:cac9:8ed5 with SMTP id 46e09a7af769-86308fe3689mr56276a34.2.1795066633920;
        Wed, 18 Nov 2026 21:37:13 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net. [104.54.226.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f0138042sm3494162a34.2.2026.11.18.21.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 21:37:13 -0800 (PST)
Message-ID: <7b19010e-54e7-418d-9fdd-bcab69d8a885@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 23:37:07 -0600
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hexagon: bitops: use the compiler builtins for ffs(),
 fls() and ffz()
To: Tzu-Ching Yang <shingekinocore@gmail.com>, Yury Norov
 <ynorov@nvidia.com>,
        Brian Cain <bcain@kernel.org>
Cc: linux-hexagon@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261117054939.2126980-1-shingekinocore@gmail.com>
 <av3-Nf01tdGw62lh@yury> <20261119053249.2098578-1-shingekinocore@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261119053249.2098578-1-shingekinocore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f5gujt7naRhI1AqbFCOL9EPr1lqSYmPm
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afe8b0b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Ikd4Dj_1AAAA:8 a=G0DxCgSbUnPEjjFRZWsA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfX8oV6gAxfgyNF
 Tq5pM+WEBRRslHhHzwPozjQN8G5zVAuXH0iaT34KkF0QLFHsLR60mKtyhn7ixHgwvb48Y8/UpZT
 8+/kYzKyoF7dxl6dM0IJHMsaZA9nFeQ=
X-Proofpoint-GUID: f5gujt7naRhI1AqbFCOL9EPr1lqSYmPm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyMiBTYWx0ZWRfX5kj5uPInjW3+
 vaspZ+jt7WnmemGK2UespKhPYAUDZ+H6wr+oI3yG7eoIi7ON2xyNKNpn+7XPWeZPqg8VvKfhx1+
 dLU7yglU091fHkDcsWX4I49+Q4KKQkZhFksCa8t2XhSCd6SskiGDYA9WPSScbF365CYHRYhMYY3
 j4MZewLjuFFTcjVtQ6iI7qe072XOA5cWvpn4VnDiJDqGDULmsn0fP6ZOK317NN3NJiEsrn6TqWf
 0y/taB9YJwi/vp7ezjdbjHrYXeYNqjH9jM2uAI7BGT6cWECaCit1fjEwcGzd3ekeGWWPebK7Gyk
 f3WMQuSJYEIveVu9i+oWGjIhJWw2Kf4OpZFDFRoLRDlNS5TPB4PPzMaU/W30OPGy8sohEq+ST8S
 L1dk/zEeNCPU2KNxKB/2R5Ao7au4Kh1k/5ucBMs3noHUqTce+lVYVoG4qzcB0vImTV157KPQHZu
 8EFe0L7cOHMmgzO7Exg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190022


On 11/18/2026 11:32 PM, Tzu-Ching Yang wrote:
> On Wed, Nov 18, 2026 at 02:36:21PM -0500, Yury Norov wrote:
>> Reviewed-by: Yury Norov <ynorov@nvidia.com>
>>
>> Would you like me to move it with the other bitops material, or leave
>> it to Brian?
> Thanks for the review.
>
> Either way is fine with me. If Brian has no objection, please take it
> with the other bitops patches.
>
> Brian, would that be OK with you?

Sure - sounds good to me.

>
> Thanks,
> Tzu-Ching
