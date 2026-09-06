Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1893A380E
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661040; cv=none; b=Zi2GCaKgOlQg3iFPCfBjjCAISovebiuKrsyKF9uIOdhvSxT255Av8j63VphEfcyDs0gSOf+389+/W+Jcvd6QzrBK5PGpc6G10cxhW17MNOgKxavvGlR3zS86eFwF56QMX/hG94h+z2uxXFhnQptoIvAHG8Z/7eqMvmBt5dzH9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661040; c=relaxed/simple;
	bh=VTWpauJAZpbTWCB0+1j0Ga0OGWJzHTsp8rqRM4UgFRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU+hos1svpiTdaEjqf+NKmPp2ibLTYRgm8MOvwp/P6PpZbagyuKRb6Od3tYa8Xs6LdnrCsviiW+uMINcd+HpLocbUq+/R8Ml87Y4ehxFJQMFxdda35Jb1zsEEkYGcn1Pb0mnW6Sy02SBfT1ad/V1+PPkBF3N6Z6Bz3fxY5qlovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e7F9fo78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+ywXeio; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e7F9fo78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+ywXeio"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68600Wav3214040
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HlqAjn+KhnOp63OGkj5XK+D6V9ainu9BsbKf0Luq6/c=; b=e7F9fo784ZmTyIZ9
	9Gth+bkk0Ui7UubgTPXN/4JG2oLAdSJl2IpXl9bCy5IySGlUPCHCYQh7Yca7zKEi
	utNwbTUWiM6NT7JUM1shB937EINRF0lR+yj5EZlFkmeA2QowkDa+7Vnc9DcSP5GQ
	nJiUsz0Z9ZtmvJFhHQq5HSB6TR5aTb2f4lDh+aRtck4h/85tvEFvG1Oys1JKR3GE
	6buoQSl+Zf1rQ+Faz/8SN1FPRpWTbgFUathfWk7exHyamRE3TJLVYbpDkmxCXe5w
	eIN2jC93x8X7l8rhJ+3WAUsdnGYvochx81nqRQHs3CQ1J0e4CHUFn7PwJ7o1t0z8
	e8vXVA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuejnu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so2871161a12.1
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661037; x=1789265837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HlqAjn+KhnOp63OGkj5XK+D6V9ainu9BsbKf0Luq6/c=;
        b=i+ywXeio/BIP1l0Jz1Ib2J7OYO/tJTGrxSiSdiH154FxIiTE1Te1e7bOzaRAXBm5lI
         bypCV1OhNFIVy5g2dzpmPedBl2z3El5XLA2Yn5Bi/mocqT/3omQNH7pbs8KZIVQJsTnN
         MDKOQkM0ZKfc2j5QSkMerpHChEpuHywF81XhYX/IsYaQQY9xdBU00H1IRbPEdrKXRQ1S
         mCf4+slKHzcqyBkGtwBDXa1owSMsXImZtrpjSodp1RH876sBqfH0shMBhcJAfv/pBIc+
         iS/zQy8x7aQ544Yd+5RKrLWq2ajqUn0wRCUkfiaXuWcIeCWYlsEC6ikweCjVB4hIeoaE
         fU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661037; x=1789265837;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlqAjn+KhnOp63OGkj5XK+D6V9ainu9BsbKf0Luq6/c=;
        b=kHsfxKUQ9UlwfljhQZPZfFRMse/FWIl4Ms+V45F7fZ67CjrUOyibVKenCvXqjTEA0V
         Il2y2w76ZTlLznOvsaFkR3j1yzliCHn5UPWXHpSa5BHpiltDXzF3iB9VdyBQzOA+ZNud
         aj9mevA8h4/UY/QZfPt0asUwrrz/b2P3Ry9YmHDnUc6bDhKrK33X4pK8Fi5YNihifiNf
         fO8LZgVcJLTB6F8qBylDTDw8ZDgmMhed6DlorcQ6w0VpfY0E2pYLWO0f231N1tz+2TZR
         GN1hro7RUDs/5u5HdLnZEoYBCWbqkRtTQzAg8cCUdP3dHfQqZPjx0YmeDLr1DPZI8FAn
         lgEQ==
X-Gm-Message-State: AFuF++mpjuI0WLVQ4usr1vMOljLQM9WPwXwnFsZD6rU9Mm0K3Ri/uJ45
	nBo1Ox8rArSJWegg3dqNqjc1KrryJg5rAAlODB0RQjOn6PlxdzhFQRzR5SwGUd4xEldu8ECkQ+V
	lsfh8YGoScL4T+iXePteA7XPGCCRRS5OgzaLRl2yceE5HUJem+prZ1S0YclkK5P84mKSYma/+hA
	6R
X-Gm-Gg: AYBFou0cKJxfnhWRDvzjJ/Df2v05DCtElwuOx5NKFRdZOYiKd0Ya9RfEXTcOoY/fNvf
	KI3IrPawCshnHzaieyCvcQPqTWULIBN1wQ9hHL0WgUG6XZzsgTdzkXRYs7dhTg/FgZwWQ+2iELv
	pbBW7FXOkbB9Hg6oFP7LBjztT77MAhJDGui3H1PVBFArRj+ZnaJZq20t9l0nR10FYAF3UiQZKi+
	tsoMbcphrHozcWewgpMiSk4GX3jHBBYg6JWfvf52vi3R1szvLg4k1yqJA6q9iRbHZjM1gFv3JUc
	rWrkyZidPqCLDC6NcbmdCl8ThJoyqCnyY6dO0KZVyh3BR7BdwcjMwLwjxaiu9+WjxoTgKQSJWmj
	+xpqmj8N3hADvELBYitSCXcacQCYAG5hR6pFcpmE74ixDp7ZI
X-Received: by 2002:a05:6a20:9e4e:b0:3d3:ae40:51e0 with SMTP id adf61e73a8af0-3da3a045196mr23400040637.20.1788661037262;
        Sat, 05 Sep 2026 19:17:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:9e4e:b0:3d3:ae40:51e0 with SMTP id adf61e73a8af0-3da3a045196mr23399998637.20.1788661036792;
        Sat, 05 Sep 2026 19:17:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 2/7] hexagon: define ELF_CORE_EFLAGS for V4-and-later architectures
Date: Sat,  5 Sep 2026 19:17:07 -0700
Message-Id: <20260906021712.2498266-3-brian.cain@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfXyzBQ19ZdsW1M
 Np6re7MlAdZk76Td5xPze2edj1HQPXisEbJWMOyXkaCDmv854mQKKd9cihuHk2uqzGH8nG9I5E7
 LkoK8PHEYUxkDq5p3CfrJKwVyw9kskOGh7v0j4AV28mGOcmlZUXfudbXBSebOzD+IgVxswhymGs
 o0tGMto4vPeHd/FDvacA8mPOnqr/OI24Kpg/fAnHebiAAf9x9m9/+sCB7uxBbNQnmxaq366reMc
 i58zbMDxm4+vhbWQsjbYW/igv2XNXDcopbuxQR8deaj2z23hRc59hvQwiHoYv0rmyWLLOrFDuG9
 rpnJLk6ojxrS0JTLWXb8CF3aUEclpKkcfyS+EGW5tY9oKYapgrOFMNRWTDEu87qVMgTph44O0+R
 iBn8eUIyv5EfZsFXS59aRLhWlhhS/r7HRxAqJwaochyHqaemmH6odtJFYAK+dSqVCV/a/ywkhUD
 aQEAVbYhPov7ETkx21Q==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9ccd2d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=G2nNwrqXqVwFLZrhp1kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: R0VG6Z7hr9Hy5nm48qQdijiP_aigq2Ae
X-Proofpoint-ORIG-GUID: R0VG6Z7hr9Hy5nm48qQdijiP_aigq2Ae
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX3TQBV3bAe/Ro
 RHPTTuUZpekuRAaGyKlniFN9XctC34HPamXEOq4hQaF1F5jbYg307TvHIpaajPMzBH0aj4urqKk
 rBEJbG2g1qNjaA1Z22dnZIC15tIpKvs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060022

ELF_CORE_EFLAGS was only defined for CONFIG_HEXAGON_ARCH_VERSION
values of exactly 2, 3, or 4, unlike CS_COPYREGS just above it, which
already treats V4 as a ">= 4" floor rather than an exact match. Any
version newer than V4 left ELF_CORE_EFLAGS undefined and ptrace.c's
use of it in the hexagon_user_view initializer failed to build.
Extend the V4 case to match V4 and later, using the same core-dump
e_flags value V4 used.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 5bfdd9b147fd..960602ff7bb5 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -168,7 +168,7 @@ do {					\
 #define ELF_CORE_EFLAGS 0x2
 #endif
 
-#if CONFIG_HEXAGON_ARCH_VERSION == 4
+#if CONFIG_HEXAGON_ARCH_VERSION >= 4
 #define ELF_CORE_EFLAGS 0x3
 #endif
 
-- 
2.34.1

