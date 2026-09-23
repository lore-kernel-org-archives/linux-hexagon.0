Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9083B47D9
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178196; cv=none; b=AuULAHUkggaUmbmB6eQNExxCJ5eq6O2MtcItLm3iqi21yTNQOCqOo8FggRjslPzSFhJEKVYZEjLMoPdfWMeEknQhZcayHKvK+1Qzkv40X/ld0AMospzkYx6/VSLkJv8fotRb1CxM4PQWSOG6Olk59sBjBuUo+7hALPYxNtc4+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178196; c=relaxed/simple;
	bh=ngrEMwBHoqSrBzOVr3vVVpoFr7ca+FoSsZWu/3nVPSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=GnjFXO5hu+TMygJKhrpH4AewZw+S5Y6lzAhGGn0rnM4ptos8hT1Zi2OKDDh9rieP1TWVZFob01eo+k1PtkoF4vj4gJCswZXOQ8CvNhykFozOh/oMduTLzPJoVXqBFoatnYzfY7+vxe65tYkUWkoyIlFt48oeE/kg6Vswexro8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BebfA1LI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O6w+i2BW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BebfA1LI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O6w+i2BW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbU4v2637904
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 15:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:from
	:message-id:mime-version:subject:to; s=qcppdkim1; bh=px3kokqR7Yq
	JFvxeVNtGq39hKU5pCWQ04iMYG9ZzgDQ=; b=BebfA1LIHP/rtgOG3RB+tLSGuis
	noOs8tcOFAX6jQ+xpupTmws9yn0tlTsHp50qHqh3n89aU5M6zdU8vs/kCYz7jWLT
	N39uQuD1xaDgs2+klbU3j6tpDwy1B5wfvheBhbVAWQLXwSArrSfmKRjYDPzOhRoi
	Y/ilTgs2/zYBM1MPRQFwKhMaU/mTBHTQWes8Tpq55/bb64wWEmcHxCVVi9mgCI5p
	NZmafk5r7oYwhWqnce6gGQmqK+QSJLif6QhjfzekuTBypfrdR2E8eCq2pssjAPtg
	HiqdyDkBAeRY3YRdNLSrS5o9ss49rLX/FSPeaQOD5zk8wHcBXy2+XuOVHLA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqje64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 15:43:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78fbc5a4cf8so2433078137.0
        for <linux-hexagon@vger.kernel.org>; Wed, 23 Sep 2026 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790178193; x=1790782993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-type:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=px3kokqR7YqJFvxeVNtGq39hKU5pCWQ04iMYG9ZzgDQ=;
        b=O6w+i2BWXI5ePnP+RKIVEQ/ZVJSGhY093ztYkeuXUFY68Gc2Z6+ju9rmPqzMxLJ+c1
         zc/IhmL/zUYRXSvWAoUIsBRaut3LbVulKKnqckG7Lco1SZBvK4YA6tHdCqgghViZpUgs
         xQQZzUh+WtU1FgowyD26VQbhYkzoOSSDDrMqNFVuEcr4FDe9VaX63aiZ71onhxQu/ZQ4
         pj2Q9D5tMB/lYnCVl64QNNC5EQgw6gCwK1uHg05XcKQCIPYJA318vp2y/XFavJWwpxKl
         6ravu2JbGfv38dvR6cvgELjHsJs31j5oyOwgxQHbym7Km4FDbKp6wZl8GjGcTlThGjZn
         vC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178193; x=1790782993;
        h=content-transfer-encoding:content-type:content-type:mime-version
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=px3kokqR7YqJFvxeVNtGq39hKU5pCWQ04iMYG9ZzgDQ=;
        b=guw5xa9yoDcc1pqwRHWJDt9oh9GkliBDR1wxbBmtGwNk+HWG2t61lWZM9itmHOwEhs
         OuHLB+it0FXf6XsFjNiZZoL8NVmpxio/j9F4ss0AeX96VAEYwOAiywLgVUC4KqQp8xrd
         bd77P9RoiFy8P0jOTZFCX6/+KCHWkC6hMqeNTQkzAVRbUV58EA6tnIAMgegu6DzVJ3iz
         c0EpfjdjP0s6vn3cxWhQSFcai57C2hI59mlGsLcYgDgcYaVFiIMIQtKG2kps62LyyDsl
         RynKZiNXJWvyNLVsWoE3XDrBy1YbAYsjIjnn8+mc+yhQRtGN9bLKCJcvbpIHUPdK6uEX
         cEiA==
X-Forwarded-Encrypted: i=1; AKwUvBwoVQc2CJMlMT/KrCNDwHNz4zFyMVrXKQi/SwsITsYdE0Uu2RStrwOyXokBiGEFVZmb5GsY0Von7n8JXpt/@vger.kernel.org
X-Gm-Message-State: AFuF++mHlikCMH/AMmZPzMZN4iRrUiGqs62BBGd47EPrKsvyIQs8Rwc+
	v7z0e3aXLPJDPeAbbFC7vTLKPZd2OGXWxSGTd7DedQA1XrLg0ixG7ksCsGPMXBwsPTHF33AAaZj
	GTrqD8mhbYEVsuHOfxlZ7+rJ/LkA63PFABibUbUm9/xkFdvsOc/cXoFfvwKyxMLj+3VxqkiZfun
	F0
X-Gm-Gg: AYBFou0y2aO/SvcgX+z0EqKz6F0umjQO0J79QXivwMVB54zTwK6nb3mwHXq4QlnKsUx
	QEzMP2sH3pLY9QAHcsh4HKRb10Ye+5nI5gtwxF5d1L485A0BDETBih6MVHvehb520mED3mb42O0
	FjzpVzF65J3+jopxS5B/INu4eXcgc5FUv95RbLM7Jjc5ZmcV2gedqwXy0PJx0rvd+yDxbXPxGE+
	uaJQr+jFzGq8EatTDm7GtcEF4SGjaho2OFfVvYllBvsYBAOkBLni7drQJMzNk02YdUe1vbLnLPs
	pvAUoNpfy5jSyodqozFoG+ZU4v7RilQwVH7qqZDmXtglKmExEFsDqkpABdtKbKQ0LWCV27Geq2x
	gnyeeqX4D+HvaveeiTiUB7pnsZWciseo8MfeX4AppHknFo2g=
X-Received: by 2002:a67:f818:0:b0:7a1:f2b5:646c with SMTP id ada2fe7eead31-7aaa0f22399mr4953211137.41.1790178192704;
        Wed, 23 Sep 2026 08:43:12 -0700 (PDT)
X-Received: by 2002:a67:f818:0:b0:7a1:f2b5:646c with SMTP id ada2fe7eead31-7aaa0f22399mr4953196137.41.1790178192233;
        Wed, 23 Sep 2026 08:43:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848646dsm7043804f8f.10.2026.09.23.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:43:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org
Cc: pierrick.bouvier@oss.qualcomm.com, paulmck@kernel.org,
        sid.manning@oss.qualcomm.com, peterz@infradead.org,
        linux-hexagon@vger.kernel.org,
        Brian Cain <brian.cain@oss.qualcomm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2] smp: align struct __call_single_node to 8 bytes
Date: Wed, 23 Sep 2026 08:43:07 -0700
Message-Id: <20260923154307.3625611-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i7CqImNAwNBob4MGYsPaE0QtpsK6urhv
X-Proofpoint-ORIG-GUID: i7CqImNAwNBob4MGYsPaE0QtpsK6urhv
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3f391 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IZicBOMgkkpEp8HIunUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfXx2KeKeQMZsuE
 jyPEg5G8Zk9eijZNFtHf69x29i0tMal1dsQJjZGO7iZlL7r37SooSO2YYGoD9PT4zKHxfjAGYRa
 OZawIrj2PJDZlovCE9GiNnDPPZBlqHI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MiBTYWx0ZWRfX/J+aZSHp5w1p
 BL0PYqCwKV1US6SlD7jEuVawENm5k+h6cvQxEZDHlHpL4m02c9LWtq/My8PdL9h+HpmnCP03pci
 foZG9N/Km7BuvtPSQWLHTGFaLd5hjyH0v+BWKkRr3QWr/7SXX2PGRwWIBgHV25IRHBiOFq7wpzz
 baaqpToYbrKwC+P/dZ2+sTDxOEH4SObYpe32H+tjec9QVjjU5QA8URzg32kZEMNc7qiWlJsyiHv
 VRhWtA/f1DPFp3jX1hDPvVzJLv2VPNbTXd4xQpv/aMVpFRGMMl4FDXgE+9DF+97irAWE5eN7C1M
 hlChnBuSRPxVLcKDTgPBLsLO9FmJpIAuq4zZ7Av8ZCEbz56/2h2SIoS1lWZJkW7KRh+/GbkHnYY
 CjJZNdPP6nM8AJ9LNeVQs84ARnHubP4zCp7y/ZM7xhrRKa90Pno15YpFFqBMZKNDXFIHMXCVSHe
 sfaECm3bgK9jvOULIlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230062

Consumers walking call_single_queue cast each node to call_single_data_t
and, given that type's declared over-alignment, the compiler may load
llist.next and u_flags as one naturally aligned double word.  Fields using
this type, such as task_struct::wake_entry only guarantee pointer alignment,
which faults on strict-alignment 32-bit architectures like hexagon.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-hexagon@vger.kernel.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/linux/smp_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
index 2e8461af8df6..5773e1fb2660 100644
--- a/include/linux/smp_types.h
+++ b/include/linux/smp_types.h
@@ -64,6 +64,6 @@ struct __call_single_node {
 #ifdef CONFIG_64BIT
 	u16 src, dst;
 #endif
-};
+} __aligned(8);
 
 #endif /* __LINUX_SMP_TYPES_H */
-- 
2.34.1

