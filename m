Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844F3B3888
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661048; cv=none; b=IbCk7Qojjp1WO3Vqpo78DGr54nkwJ+Kw0PACVLgCQ+Vh8j0yHhL/jebRZ84Rg/9omz5j82ZViyV7kAtQJUuBBfhzbWVjdS89uB//4+VZfLf7OYRCgIk49ixL8z2m/bcRREole96h6EvqCho/elJgsSpw/vj77D0cjjwVJ01qTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661048; c=relaxed/simple;
	bh=5KgFY9O0B5yhJecSo5ZhBhV+Y+xCDadY+2KVHyexFxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Irm+I4ioPBvX7gHbadJZ8AIEbgFQQVLW+OAdanVkQpQUOWEEbhy/J5mAcPfGOb2a/b4B9fCaJgnAMoBy7zLKv+2hF7eByNMdnTyosWMNE0rvMpPakbsKtJh0lPPv3rp7S5zia3wDo42m7vu1I5D9NVr2fdBIyPlFZeqIN9yE+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I1lveuHn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUmyB6XK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I1lveuHn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUmyB6XK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6861c34R879247
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DwkrAX9N8458zHjgo+6SDbNoLzh2CVUkwfR3Ig4y2lI=; b=I1lveuHn2og5b8BP
	8m9bONl7f4USGHVAyc776KYz+bTkLyBZm/W27p9umtQ7TxwSQwWUEaIWLDJWC/Sy
	vlBFpuqdzXjQ6nyHuzIavCkLrt9a+wDIHThEE+gCbHm7oL9TjDYJ/3t+OeaU3IWQ
	fOir+DemxBge74EA4HjciSaWwm1DmOxZ7xZwdn0vxPj6x3wAV2f0nepv1TntLQfv
	kR+FLZcAjdhwrj59AzM8Kve4PMOlQ//IZxhDEUbCgWa356KURV7ZMuK6ic7HOaOd
	oRsWk2wH4JtlVh7TsKsYIHCZRRNFQWYz4bZvmQUbUssnV2jwyKdvlzVfs03rqxXq
	x4PrpQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8sd340e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfe48ca1efso29486185ad.0
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661045; x=1789265845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DwkrAX9N8458zHjgo+6SDbNoLzh2CVUkwfR3Ig4y2lI=;
        b=aUmyB6XK9zEUMZAmvhRgEacA8X9AQVtsitIOhKDgOyhAn/s+g3VlGoD8u9qXRNFLap
         KR4qnaHYhIEaGgkfbllcoDnq+WtDEqUIWNRVwU8gGyp+R+kpKFAqyKOs1TxRS1dihFft
         fBKpgdgy+kdW5w0SYc58s+X2HKHW6K69lGuWyZAfqqjxDh5hFTGw84Py3C3eLwfhRRLI
         Sz6v4xB2sJZeVCLKVgnJeHFE2ieXUH4FpQkBI+DBewKe1d3IBJqQ/gitl/0Cfp5nAWkN
         BCnKGukJomooyheokNU9pcOGpuvBUYxeFCYDyeeD4/qdAQoaTzJzOZuKn0r5lk8QqrtH
         49Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661045; x=1789265845;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DwkrAX9N8458zHjgo+6SDbNoLzh2CVUkwfR3Ig4y2lI=;
        b=s5TnXMA1bE6Xv3+nmzlUTm/4XnynPBZ+AuxdX5i8/vClf+eeZbHE5c1/Au7vbQNkY1
         MLaMv04CkSDql6yVPck4mMODmqpRpXoZO/awGSte0KS81Q99UDplDhgcU6ISV1extNYh
         gAqiGUDI4ysKxIdGlpVcgI+tCdfcLLtgrBDlZo81LQAj9sH6x1RgOL+RQfdvFLJTTmMM
         BD9lDDRZlBy3dPu4lmOdCUJcdrJmF3uyW0YKUYEpjS4U0AUF06vaA9DnuMc3+w0rlW+p
         9lLFo97+VKkiqEcqFjqe5deEAZzxhh+Sps1fXU36sY0Y5BRq9cErFUhCNaUZ3i7EPWa1
         iWLg==
X-Gm-Message-State: AFuF++k0Gp0fsHC/ZWeNARImnEOXfCrvTRxFblRH9fto1Xo0pgpUII47
	44H9xuOYR/zN8tELpIwjvtuqRm74meSBDj5jLdLAnYELbs3w/EdXUkbqvKUX3mHLCyBWI/xd26C
	BCZ4+14Zp5BCHMtL/TongAUQHXEgCyY4kdDjT/KKtSXl2GfzhLXvSGY4Y24hJLXPQzmE6QPQebd
	Xw
X-Gm-Gg: AYBFou1F4wsNRIBloSKalNYcggVShjQKympczJPelS+Q8KLQWwsYd+UiZx0Sx4b6hGM
	njfIjZyxX6wm4AjLrsymQ/k2TUYcZu1G7KoSzZZxwbubFYsG4M3Q7zfZZWhiffjI52IyP1KSvSA
	pSDbYvui0qWT52NpebZXF/QjaQhLMWV6Uq1l90VGGeaeNgo4fm7yOojLJ5Tt6HN4DPmOT1HX7Pn
	5wsgOeqozHsikxop/BQFs7pi0USUgtRXpfL6FisEIx67dexB28mpkCXkjZkAIhMLSgSY9OxXN+E
	PRFuuSHYXniGdx1EJsPCxsHGfkuuGP7THE/NRirIDfhGvMUjJuHEl8A6bJbwEGurMzwQa/i69/h
	jUar6FBLvkpOruhMdiKpzDu32oCY9ysndSmZcGl8yCPCgNChg
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-39b26203f11mr24650745a91.16.1788661045455;
        Sat, 05 Sep 2026 19:17:25 -0700 (PDT)
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-39b26203f11mr24650672a91.16.1788661045013;
        Sat, 05 Sep 2026 19:17:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 4/7] hexagon: read the thread-info register with a volatile asm
Date: Sat,  5 Sep 2026 19:17:09 -0700
Message-Id: <20260906021712.2498266-5-brian.cain@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1_KxXT0pJh0F23uNhKH27V4N1zNtp4Cg
X-Proofpoint-ORIG-GUID: 1_KxXT0pJh0F23uNhKH27V4N1zNtp4Cg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX6mJRPuwy+IJY
 WqAFpk3gwwG/KGD7p0Koq7xKGdIokRRC9NhN0TJrUhOs2L1mE4KNJYTpjDW3lOOQLLo8NQzA3ym
 5Rbg3uBeEHDDdqURbd05V7kQKNIbQ9U=
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a9ccd36 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=QFdjFJDKsErBmVjQFIoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX+3k0hOBnhvbp
 0XWQzU2dZPr4GDCcD3XugDcEkOnLNe1xCo/Fu4Mk9PTkVuoVDegebx+J+zT/e9+GBpaSByL5MTn
 olQQ8K4XbG2MhbQ7mGJALMe48KXZRyz/LbVYR5GF60uxAsKFolbLCrfKoc6WuVNdwk07V5b5Z8L
 EzH9CO6jTw5SCP5nMdXF52Glr7dJCHWvQAuLsHr8mkZzkIfEn4/1x4Qg8T/gHK8EOngbGhsN4cO
 P6yw50zOKCSILdhcaWFhU3DvNtbBgh8rclThA1jze1mQ0A5G82HiefKhTJbFFgrxT/YNKhlInHK
 zeOo/G3ZLGOADWw6qzPp6+hLa5q0jcseOHDjuETjiuDWvZZFNmZQ+9w63g0uNLFbH/I2yL7XCGV
 oSVnYQsmfNRLpPXil+wlpObcxzOlwdUw6FPJcks8SonGatHb6SJFPUVWAiyqEj9cUcuOgPFEaB0
 B+eTCR1c1GL5RD01aNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060022

current_thread_info() was a global register variable.  Replace it with an
explicit read of the same register, marked volatile: the register changes
under us at every context switch, so the read must not be treated as a
pure expression the compiler is free to hoist out of a loop or reuse
across a call to switch_to().

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/include/asm/thread_info.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index e90f280b9ce3..3d4a40091a5a 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -70,8 +70,14 @@ struct thread_info {
 #define qstr(s) #s
 #define QUOTED_THREADINFO_REG qqstr(THREADINFO_REG)
 
-register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
-#define current_thread_info()  __current_thread_info
+static inline struct thread_info *current_thread_info(void)
+{
+	struct thread_info *ti;
+
+	asm volatile("%0 = " QUOTED_THREADINFO_REG : "=r"(ti));
+
+	return ti;
+}
 
 #endif /* __ASSEMBLY__ */
 
-- 
2.34.1

