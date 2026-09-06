Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF53B3896
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661049; cv=none; b=ZnFB31P7Cn0RpKz/uA7q1SvOS7AHU7uwNKBPeVfqwBwh0Rt+sauSfjmnMJML4KlfUUQPY1QA9gUTdK1m5kZKblPMaxg7pOxfD4OcxJjprkTLOTpnZfhEJhbe+RDz1eQdjLM1OAPBzRi2H/l/kdPoTuEe9uDfidkcxtn4xCKu6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661049; c=relaxed/simple;
	bh=K0u1+4vmT9h2HoLR+JMpX6LTmHA/ghcQDr64gzj6aOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHISTR/NKH6mH5M+4pGKIav1Q0C6HwyUThWS/0QG69YzCQbezfenyRWzyV7rNB52ST8Gv5P7uz98tak/e6GtjL/pNgi9Ax4fGQnKKWGCGuXOlToj23Jlxx7rCf2N87BikuKjsYyq4Njn8M90n+mucT8AkRKRkipLPYXg5oAmU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5bJUnLJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XpKq5j15; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5bJUnLJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpKq5j15"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6860038w3740288
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JAUb8QaiYDBy0Nk7fVnjVTwTaEC5kO5Stsblp/DV6fI=; b=W5bJUnLJFKGBaXvg
	sR6/FyWe7RD2XHl2Jg8TkXvwUPPOyn7q0Y9NnsJk3HVuUz0hzu1XBUCRYe03autw
	WpsyNqHUngsP6CHKh9304Xrav99UpwfCMmBAg/+4CQlj+6SHK+2tPhGjDxSlgy+R
	onT1U8dxSwuhjEkMQLQfpJjWVS9fNtr8O97WubszTGDRt2xalR5IqqNDe8fFJNFt
	bvZl2Yl3z1ePR5ttlChVp/yj7UXYA9/27A4I8MOMD8h6KSyC8kLIxxYXsGvBVRBm
	E1lZR6lTyxeOmkkpcoyqRAEiKa1eBbMzjhOcsf72a52iPIMC1eZx1Io6n9hl6utF
	9I8U/Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8eq35b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so3857447a91.1
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661045; x=1789265845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAUb8QaiYDBy0Nk7fVnjVTwTaEC5kO5Stsblp/DV6fI=;
        b=XpKq5j15Kof/R5ZYJPsGM5HHtLvvY0xay4R7VWPtVt/NIjDUjQkTO4nsxkIsIwO934
         b34eddVlFblBqb5hOOFFMoCoFviqLmU+C76bwYNJ8pNC193hOMTIg/G98yH/Q+srmgVI
         h1ZaiQwyRQGRODp2WwIzTFQ+bafRoj+I1y2MECG0/62ca4WGhYSVovkFpmT3TMOL5WcA
         gxQPPWNk6YtZvmmSXG7R52xZnlukkf2KgcFRqPRFVkXRudd6O1yb95xAPRr1BQA7Mmjh
         NbjcbJXS35vXTuQ6htx1Fbx400yASrb+9llA2iWAXXWsbLJO3qOjnhAGP2Ki++QYWS18
         T0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661045; x=1789265845;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAUb8QaiYDBy0Nk7fVnjVTwTaEC5kO5Stsblp/DV6fI=;
        b=e5EsXS1shpzWO0rECEknKOI3rqkSjbSZodUg/Tk3a6snQPSugyonwJANQA4CEQyjzk
         XC1oGlnLu4c8VhJUYQ3IoqpJJ3F1AsFzJo91CPd0GSPCH5Dm1R3x2M5SBEME62BX2ni5
         31AhwXZP/JhmSQrB5Y6P5kyJVfI799npToVuuQsKgAnuF6KuYJl55DZKT3NiAzzLPraG
         oUi3CAW1A2ipFytjw4ENWTAjHgm3c9bU5e6Xr0oCBA+QuRxs5HD6NygqNZJhVBEJQvPY
         WYJHHuNJ7yyaq987dmfQHDWpmxNZcg65XyIaYLgy+jmSLxD8l82jCTFATL6/+fsavQRB
         3Jjw==
X-Gm-Message-State: AFuF++mNjtAnSq56ejVFLKVpxdiPRMwidjSwwsldOQlfRQsd/TNMCl4H
	XYRPSQAB6ObZYyFapp5FYSp54MNghy1Q7uyk2RS/OPjzE6+LxhFnlqGpMxrZ5wXhafTme37oK5y
	HAiBCH+4Ah7wuio02pVUoOz/fPJ/vUToLxwtEYeNPMnjxHXxwsFV+EIINMrs9xe3L1MU2RskyTo
	R+
X-Gm-Gg: AYBFou3EC+h5rhnpGfsOjO6qaWwtUeYZrmmBHYG2Z71LvAIyN2pWQIH8GI6x+nZYiYH
	IihxBi4JUzWhpVuWzwVHaHumy/cA8txOLm4LDwRrmsWGmDJy9nQxqTdgFe9V3nT2LGAq9aGdB3G
	jDGLWinDuJtW5mNOj8ACdFLNMGIokeKaf8AbMby67/NhF41rSVIrU8+knePH2Wj/5EErxP/HIJn
	Kpepo3Un4uE9t0b4cZjbIAZ/R25+q51baUBLTBGo8aBkF7Gk8EgodTGCOleU80maG6lgzwOoewQ
	A8G0Cw0OrE11tSeEtuVv/ZScmMJ2m5WQMWGC6a24B+trCRiW6N8CT19OUPA1+hg+CQrb8thEm+5
	KvVPkGNp5297Qpay+jt8Z7LNQvplG/9dLiX3jpv20wS6mbwAG
X-Received: by 2002:a17:90b:268f:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39b2612eb96mr23900006a91.8.1788661044319;
        Sat, 05 Sep 2026 19:17:24 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:398:c3a3:dbd0 with SMTP id 98e67ed59e1d1-39b2612eb96mr23899285a91.8.1788661039195;
        Sat, 05 Sep 2026 19:17:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/7] hexagon: stop passing -mv${CONFIG_HEXAGON_ARCH_VERSION} to the linker
Date: Sat,  5 Sep 2026 19:17:08 -0700
Message-Id: <20260906021712.2498266-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
References: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F61nsKhN c=1 sm=1 tr=0 ts=6a9ccd36 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5pC8xwT9wLh8Ou6qCxgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX9Yx6BoMkLqPx
 0tNxfgm3YxwjF34uazd2uNBBluKEydbfKN68uRtJVyxN5s47ZCd9vpxuwKtqU5kn+SIbV42sFdF
 eBXQWWYBq8NvTwTqIfQT/Kcgq5S0wZg=
X-Proofpoint-ORIG-GUID: OwJEu6sopkVuPQsBTBf6I86YHAIniC1o
X-Proofpoint-GUID: OwJEu6sopkVuPQsBTBf6I86YHAIniC1o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX7sT0TaXHwtTm
 WtsLeaCR7XDE0vpgnHf5s4ec9N8eUwWqK4g2FdtjPzLq8zH2YAJlJalcvdPYK+IiH5ReydLkebZ
 uUcDOR07Mxt16ryA+qWs/MgVanbNas9HuQrv1mzT10189/Ip/0JK+y10JM6OnNpZcjJMCypo4HN
 ywkBVMN9nsc8j6cj8MCvjXKUmLaywDxY3WHX+aDRcbSnMDgcmYbP1nHSTGDeQRpT9HSfvNJ2Qau
 +/G4sOkPE23ZWmwTorBA988S6qMzq+twlZxm6CV6/N4JXMbfaFQqXt3IcuumKMvtylbQLE7yq6j
 TI67upWmkMzJxEfl/njA5c4KanzkhtRyaD9lVA3Vo43mkO1Fz73Ig9Mg3PUQmFqI2w1w3EsHW9H
 6xyaqu9PhAvjeE5/ZOXESF9Zs5YHkPjdSXQ04D1JUtESVWnESmVVIZFCS0n6iAolLZT8gY5DzoG
 GKHbmLMCVD5yPtzu84A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060022

ldflags-y is probed with cc-option, which checks whether the compiler
accepts the flag, then the result is appended to KBUILD_LDFLAGS, which
is passed straight to $(LD) -- the linker, not the compiler. This
presumed the linker was ld.qcld (aka ld.eld), which does accept the
-mvNN flags. ld.lld does not: it parses "-mvNN" as "-m vNN", i.e. a
request for an emulation named "vNN", which does not exist, and fails
with "unknown emulation: vNN".

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 4d393bd8163a..86c96d11b329 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -26,11 +26,9 @@ KBUILD_CFLAGS_MODULE += -mlong-calls
 
 cflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
 aflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
-ldflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
 
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_AFLAGS += $(aflags-y)
-KBUILD_LDFLAGS += $(ldflags-y)
 
 # Thread-info register will be r19.  This value is not configureable;
 # it is hard-coded in several files.
-- 
2.34.1

