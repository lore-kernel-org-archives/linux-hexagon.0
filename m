Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF525A655
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661039; cv=none; b=K+/SJFTqYWzSocZ2S7XLO3FfOYtJYzj+PgBEGRNtjD5MW+oeVgC2AE7AySdwwLEeP88lnYwrW4bDLOVg//Ci6xnWTefvHbuQx5oHoj/e2wf2woaPBfGWPswz7lnOMvHz3OVm3YiB3unhhGkKR05xxhpY4aOVEygC+OU80tpKgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661039; c=relaxed/simple;
	bh=dSwPPmeE01+9LHANAZ/nweNPmX9U6FD7zTHpB0uQSgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAJySMXLRfCBgYGIylWshWxacH66OcEv54KqagJJGi8wIxijJNDA86bz8x/i89WVVydWKB8DnSIdmmZTP5uGT3OKQTuleFVVyWcwUCVkImd8T5MpAIpqK05T1GZc6VrDDFxOgM8+ulxUg1rOv4QoXZbdzL1y09aIXUrQlRxSaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTxicMPr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GOY44JyF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTxicMPr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOY44JyF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685NxJK03746481
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fi8sbxY0OA8F9bYaIrqSUFhl0B2b2+gBidg6Z27Ui24=; b=LTxicMPrUvd0rt43
	VjPdHUGa2KCzIfioJzMSESDVzPwQo59I6mhYiztB8xDupNYU/KlmZPmISKZLFyGI
	63p6M4W0iMOCsRmXC3L4LPFiCYmb+b66hIIf9ipf6L21Nt71908xFRHepV9l88LV
	SFHMFXi4UGQQAXvmnKhX058hfgF6OWP3ISyxYOdw/yJnaH82oXUcATHhN9kfE5pm
	f/xYOIdQ+f2jgyZYiU/lJtD4QU72CSkb1VgPfxPnSWvbqhbiC39zHh8pzrsQ9slw
	SufHHH7yo4FbZxTThc36KaI3Ps8hlSDS/UMWA789Ts+EfpvE95eZub1qidMtVFTF
	E+FhbA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggba3jnve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b10so2848737a12.2
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661036; x=1789265836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fi8sbxY0OA8F9bYaIrqSUFhl0B2b2+gBidg6Z27Ui24=;
        b=GOY44JyF5pBXYMMFDB6/eX78KEHDJ+xvRQT0Kogj8w4JwljyOTNeCo/6CgTu0WyPPX
         +38p9l7rysiHp0mBCLGFlFbZViy5oFxpwKzd0EszbiTDqV5eNboCiz8bZD73tB0LOcdI
         fLoi6UEs9iv0hKFEqT21WfmaNyjgcDiHB1qJSjmRqa9GK1K/Rl8VacxNRGLSqDSyHrnV
         ivkLS1w1i8KT9FdXhmGn4TLqKrhra0tBdVnV4PgUzh2pPueO2lGloslvebygauVR69Ma
         dSZhcPn+egi908luvZHtPk42Voig0fYO5Y3gmrZ34sWH72I3f0dsS3iMckNmQYIzXmUf
         sp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661036; x=1789265836;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fi8sbxY0OA8F9bYaIrqSUFhl0B2b2+gBidg6Z27Ui24=;
        b=KCPUV2zXt5VBzx7dh/9RfIFz6R4n1rVXVTlHEVcRvnUlf5bb033E3lxAwwFl/yno6i
         X3vFzxJQqoqDxxAzAGIpMJWPFpTPxAD07ogVD+I62LFQXQhEspn0U08L1a6Kn3PXNC1/
         QduTK39vT5Lru0lLou5npyF3TtN6TLGdwzIMASEgh3BTfunUf7XunIE/wCmMaOtanqSQ
         1XuWyoHPKHf9NOZw30+9QeQ87ZHCpQLwiOZaeRQbOMWHSGpfOMeQ8F22otLPPG2drlYr
         NDJP29sMv+oGdkzFFTaWE/ddlL4x8MUY4sJrT4tLdprBVMWd6kAFevhqWEkKdOwc6Uei
         niIA==
X-Gm-Message-State: AFuF++kkZbckE1Ye2KT1vvdOETToUsFwQEmZ0n6mRs5Cl9rGq01w5DJJ
	tPKwG/ieGvUIYNGJaz8kZvqYNfHBh8U+gNv+XpGOR790xEayqE89Mc8Z9i/XwGgaBZh6O29dvua
	xtaSuqsIfKvRJz7pqyv0Ql3/HXQ9rDAKibvp0nBJXEMAb4zPcRPCkLoQJKIP3qXOMoGH9vTGRMK
	9M
X-Gm-Gg: AYBFou3uU/uI4ssk2epcS3HL8glZ5KsCobCFHUJvyXRrxQTZ90YC/94qdqF7dpfiZVh
	tEAAPVrwRL+8UwzV9s4TKCpj74wwKQqzLfwQuG48NFzkCoJXANssnt52c6opJlNpZphaAyYjsPU
	K1a7bH66W5G0zOYuHG/UAf95SKt5XoiZozwuOPDS+UnWrLfXxxgvKsCTWU9KisnP+HGzwclW9f2
	oNuNsq/WirbbapFsIubQjYajSfwygTaMAtz00wvRHUVACAx7AqrE8zbzPdO1LdcqXEV8hRadE5x
	/VFfiljZJ60mRnJveTxvvu3OX/TC32Kr7AW7qgKtD9w5NChNZWhI7gUneU5S8u144XjQpI6ikuI
	j8NsDKIY+U/hApQMnnFRe0cDPWY1T3/unJmXGIBm8YO1DSdDg
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr22264321a91.1.1788661036072;
        Sat, 05 Sep 2026 19:17:16 -0700 (PDT)
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-39b260d28eamr22264262a91.1.1788661035528;
        Sat, 05 Sep 2026 19:17:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/7] hexagon: disable the LLVM packetizer
Date: Sat,  5 Sep 2026 19:17:06 -0700
Message-Id: <20260906021712.2498266-2-brian.cain@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX5GHN3A2v+mi2
 fZYD+TlW4JmVhs7ieTr9m7FPV6mYoYrfSVDO6gV/sH0anweclL6UxtDu+BC2sOCNGyBqDZkvpZj
 ZGsI3PffM24MSQFed4AIncf1Yl11X9euUUaRWGYOi2euLlKDs4+9+Jh3/udfSFOZZMZM/CBb+Jp
 wOBy8i32HwUV+BjVZlxUu7hBUdy5hHbqmc2hQyqsRdlgDZWBBnWkaFljxHm3aLK4H4dKhwyZ76U
 UWtcjP0vVa2FXvDFCfTEB9oVSv9KAcU7xz2aL2ILbm+79llPjh50PDSSeoM7PQCkcOlzo+aAF73
 r5+IXy4nyt3TBs/SwV+7XhSFjsPqVLaG4lvSVmkYMiNZXWol1WwGD4dXnmt0Ge4PXmR1iYv6/3m
 rz6/RXxfRobSBFnMUvcq0FgVWSWnTTgFfbvw/SZvFF6mNLL7N2IOBCPwAZNPu5DRcxZ6dWi5Fld
 5pyjjy06sy9oCaIJtCg==
X-Proofpoint-ORIG-GUID: 0CxKTT9DaYM2acdriK1vZlYb34xMDRvr
X-Proofpoint-GUID: 0CxKTT9DaYM2acdriK1vZlYb34xMDRvr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfXw+T+/n+IRJ14
 NGMXPmTFMZVoMcxzs1vjv2CJMyCf70Gb60KUHGO24ohWIgfHZlnOhX1TkW83ikzOX8we7r3L943
 oqSlGa1t5dz/gKDjsTE6eqUX9HFoAu8=
X-Authority-Analysis: v=2.4 cv=Tf2mcxQh c=1 sm=1 tr=0 ts=6a9ccd2c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=W7kercHRWMgZY4Omfp8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060022

The Hexagon packetizer can emit invalid instruction packets at runtime.

There's multiple distinct bugs.  We'll re-evaluate after 23.1.0 to see
if this can be version-gated in the future.

Disable the packetizer and new-value jumps unconditionally.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index ff172cbe5881..4d393bd8163a 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -7,6 +7,11 @@ KBUILD_DEFCONFIG = comet_defconfig
 KBUILD_CFLAGS += -G0
 LDFLAGS_vmlinux += -G0
 
+# Workaround for the packetizer generating invalid instruction encodings:
+# https://github.com/llvm/llvm-project/issues/178338
+# https://github.com/llvm/llvm-project/issues/218083
+KBUILD_CFLAGS += -mllvm --disable-packetizer -mllvm -disable-nvjump
+
 # Do not use single-byte enums; these will overflow.
 KBUILD_CFLAGS += -fno-short-enums
 
-- 
2.34.1

