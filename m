Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0038AC75
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788662351; cv=none; b=h/pzuKwxoV9yMCmNhNbLnoSTBMwHh8BGz0cV64Cwj4GOfzjo/x8sbEwx2BOrB1cJtiS7FXnJE3xGVmNPYCjK/MMMPqw6IwJJ7Jn8ze3jPxlixJYwLDD0i7/+GcQiKmR2qSlbZV3HKl5QiqS+VWpm2vgdOWz0pAcv2ptt10sgQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788662351; c=relaxed/simple;
	bh=SVGTLKUb30Lm/RYwYH+hHVl6Tj5Iof58VpK34Deo4Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=o/N8fkUNF1Ux/xOsjZ9fLH6ffoSianqC/G2zOwNGqpsp0Z120opHJI0WfRYXUuQoPDcxJPnoQ/ZtNkFpG3krDQ9yEJ77eup7kRqtV4Rl0VcDubvg52OTGHejSwjR6ZfJ6IaqqyzI8Kf31VHPg1e2hVZb4JBqZp42TEOmTjjrVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K7S6ifwe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OSZ/JvBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K7S6ifwe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OSZ/JvBs"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686001lD3115776
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=83/rkrL8x/Eru50N669+UN
	QbQcvXfJGu2hrdeI27dEo=; b=K7S6ifwegAFOafmYG3TtaGlYFoO7z1UyQfKu0y
	BZsGejngg3H7+j0liNL18sJsjT8oY53DSrRHyQ8WSH/VmRnFsmo/sn7sTgGjRQt3
	8UordHU/tmACle93Wy22ZOCTFoO4AELU4ZjTOhyHnD8qTVv11OOvHuL/1urjiM/P
	osZidvsXEXI1ohc4PT2EXR1U7Xux4qhm4YZg+ypxvyEmhAFD+Ii0bbtfQdqq9HH0
	3Dy72Lkwlge5qMf5KafiaVZh9FX0Lp1eSUxGd8y7nL7xU/JJ2qCL+BR6WDEge4In
	vJA0D0i2hqcTZyOU//05rJWinVNNxCCDktWvRzebYL80wgaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbf8jn35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:39:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94f086fedso33131745ad.1
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788662347; x=1789267147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83/rkrL8x/Eru50N669+UNQbQcvXfJGu2hrdeI27dEo=;
        b=OSZ/JvBs5D0Um1epSpQHU9ML3QpUxhy5faisZgdBVhTute4uud1o4uFgD1KQBbkI9m
         62qjbeLEXUFuO0fFMIS1oSmpegJOmaxlv6v27ih5Ek72K+l3MkcmOBSzHhAytmFpGGQO
         OvcCh9J//oMX9JKNH+cblYpGObPAenhyVcwa6BSulQSbPwDz+4enST4oelootRz7tXOu
         K28xDb/frVg9XDUqHc2N+vvqI4UdVwVQBKmRLdQFCDY3HIfJnxj8uBAdGJFpGUkZA4jm
         gmYVQdsQO5khPZyziYnF2wSQzcCf9HjxI5qozMD6dSrmzCenyY89yH6od7uShRjQakO0
         KqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788662347; x=1789267147;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=83/rkrL8x/Eru50N669+UNQbQcvXfJGu2hrdeI27dEo=;
        b=i+1ZAgBsi5pXrAU0TTo0JchQbIoyu1EatbLUTehoAN4T/mo7JpnTu2MUtm93QyXnw+
         yEMQSBDzbhmPBUxKj9NrmF1KSyx8nyaokN6SVlSXBrVjcYE3Cc0RULCiIKN4aSoikLnt
         EFKB7al3B/lPyB4gZsFhCfLxJjDmRzuSe134xr7vjQs4D9WIoClkj+EiUyxuQqymhVGI
         Z7ughXlm9YLwWiijYzI+3dfwavg0fQbSmn/67fRiOJZCCHhjS/yrCGaHny/QMOWjI+wb
         TuKV3PqOc/Wm+5KwuSwzZWVoO9pN71+EGQtc6Xb4RH9Q0A2hKUhTrxKLggUTssvlWNYs
         19pg==
X-Forwarded-Encrypted: i=1; AKwUvBwl3IModWcczBSGaak75l5Hzo9oDu3HawVB3XF7i/kSeTbtt/U9DWX2CT7oObMLwYNlsuS8aKNMmXZh4310@vger.kernel.org
X-Gm-Message-State: AFuF++mqDoq1V6JfzngxStDyqCpsRGcU0ZpRAEOglOfLquGGyADCA/TY
	jq+vyk29YojzA6jHv6tpzqLIV6FOn7dyifnW4uv9cj692HnTDDKdXXuSGQeYXk3IATnH1od61n2
	nhwaJvt6Ylt6JlFKBRDuxFOHEIJL3ZpP6jUdVlDP6yEDmfCCV3/3v3Ax4gl37UnwjyUFp
X-Gm-Gg: AYBFou3PwHq4Iehf92fyyUwmlyhZkEvBBVHOTx3hHriZI6Wfl7g2cqdeHWPGWwfSZzE
	GNVi2jFoi5nrWC/otNTAd3gnXnxrKoGo8EVLig5HUzS+mg5g5hMqS/uRwVrUBc3SrTEHdSvJFNB
	rVdh1OlHzw20WeHG1E8F9kyWJ/ur1iGLMmyxS0BjZslwd/QNzWjapdRURQpHBgDH8ETnW6X42Pq
	F0WqyFkz/COxfdsYqOh+Edr3z4sVvj4noJvByoXHjQyb+Md/cPTT/hymnz5zh0xvVrkrTnxE5t6
	Zj2WWmmJiw3Qnlt2LS/FOnJZdPjydtZ8AI+jL2jpRa+yAMS3rHKI19qB2brlveYcGV/wPTH87/C
	VVvy1GddimwM0sMBV3Vg6rZsG6eNVl4oaTUbvTw/IGhJfl3h0
X-Received: by 2002:a05:6a20:cfa2:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3da39d0cfd9mr26157672637.7.1788662347496;
        Sat, 05 Sep 2026 19:39:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:cfa2:b0:3d1:c0e2:936b with SMTP id adf61e73a8af0-3da39d0cfd9mr26157626637.7.1788662347044;
        Sat, 05 Sep 2026 19:39:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm8951234c88.8.2026.09.05.19.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:39:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, peterz@infradead.org,
        pierrick.bouvier@oss.qualcomm.com, linux-hexagon@vger.kernel.org,
        paulmck@kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] smp: align struct __call_single_node to 8 bytes
Date: Sat,  5 Sep 2026 19:39:05 -0700
Message-Id: <20260906023905.2517725-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyNSBTYWx0ZWRfX5pU9mniyyBrV
 FyRPi6ZE/Q7FRazeRYjY1RP0qMsLACfzzB6BMCpwO2D/5X84kVpe/GAZyjxGrV1KbgHxz2ZXSzw
 mreaL2fbzS3o0EEIHl5OIEkwn1FViGQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyNSBTYWx0ZWRfX9uPsQcbYyvzF
 rlyS9P+BEkOftwBxLMwdNsg8r6e2aSPtc2ebse+TfYakxAGF06gcXG1paqcQqRlW4TaULfEVA6z
 klBXTkfmZ+sG/akgKwk0AObZEpaa2I2sHWN7+/7agqWu9We6aVO1W01usgvBt345oi1ffjf/q+E
 aEEOCN22kYcatbDyli3umxN+nuBxplCLsP3ck0SSArcUjEAET4firszxso3a/RON7GGsSMGzvcP
 Oam8OnUzeVF35EMJNjMwwGPmSUMq8nw4ccKsKjrbHQBMtM2ylQIFu7Nu9ixWRF/kfVPSRIxO1CK
 RHTBLVUmmCK6rVc2MZkJfY3QCHm9STMOsV53EQOjBnF6ubYTjyZKRxBJWo3LWT/QEp/FJxrITQX
 4htAytJuFYCcqQlIOhYeVoYithYZqGICz0Wtt01fb0G/VyjltFsjafGA+PxGS1z9xqcEQIHsiGV
 MW4DXfm0P8nvpas1IDA==
X-Authority-Analysis: v=2.4 cv=UIjt2ify c=1 sm=1 tr=0 ts=6a9cd24c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K8hMu20Jjl3dzlJuOMsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: nqGj0gUIiHDzI9VmSgp24PzChRWXuXU8
X-Proofpoint-ORIG-GUID: nqGj0gUIiHDzI9VmSgp24PzChRWXuXU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060025

Consumers walking call_single_queue cast each node to call_single_data_t
and, given that type's declared over-alignment, the compiler may load
llist.next and u_flags as one naturally aligned double word.  Embedders
such as task_struct::wake_entry only guarantee pointer alignment, which
faults on strict-alignment 32-bit architectures like hexagon.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-hexagon@vger.kernel.org
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

