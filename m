Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D83B19DE
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661053; cv=none; b=P4hfuE9gFzOQ7K2OxF1bCJoSI5NxXwq98k+Ho3xumOsDpd+i+8VtBkPTznQkOGPX38UXh1stIbKacFNJoAOMY4Dj98zpCPMc+thL0N25l0i0oFQ9tyOec/FpGSLyftRNmdR13IhpdITeLKNPGPzPxmsiWvrJE91C69oDbX3WcKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661053; c=relaxed/simple;
	bh=ShWRs87tZuckWRTJohUubWb92G0ZSNE2GS0QcMvqzl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7t6rGY5RN2aWeOTlblag3YUdjI+b4ZvpkczGeuuoYKxD40Lf03qQZsuO/meEYYxDIXCcP7VW2RoSIEvif+MoEz/xRLo6cQfNgLRHbK5fMaeO6DeiqDPWKZwD0pHUMDFLpz/+Qu18VMedhN+SJ1Z1oKnZqwgZ9FjitM0wRiJ3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZUsnhEc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aHXbG+84; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZUsnhEc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aHXbG+84"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685NxZa83739306
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jXl14u+UndsqNffpU5G2smJzjKpJjLjI1lXDplwZhbQ=; b=OZUsnhEcZ6AEusI6
	/k/KhXVJtp28JNmkXXC/b5XXXmqY5YHVmYS0ZXhmAUTag/GoB/R01IQXJuxT/Usc
	cJNPDruobh+AiTiMBiO96qYh9rGQeQ7yr0aNw/5IzDu4VfJQgwC0TxLsRh4usGxW
	+4d35HbnbGLKBatI1nunDVXqmZGKMFYat3+HBMQdFASTZ0b09EAonJAdk+U1UkpS
	wDGcssWsZMlNDqej0ceRlMek0HrxY20l3W7F/74jeoA5U197uU8DXFt87YT+Dav7
	RBRcIbjgIqIVZ4dz36xvXDDPGEZrVuWRXZFBXtJHWqc8A3F4Bvb6Vn7KjAJCWwgW
	4eqx2A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg8eq35b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso3515145a12.0
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661050; x=1789265850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jXl14u+UndsqNffpU5G2smJzjKpJjLjI1lXDplwZhbQ=;
        b=aHXbG+84SOgCUFRZGLoFXU7nEOlejt2bEjQQnqU4FNUpvxv9w29fvjwW14h2l0puOB
         h1TWMj/7nsVzNeiCZ4hFF5sc+arhVH0YJVKJ8+0C/YzLErkrZGitnHMaFKzntiEEaUYr
         NU2NIrPcrOOm4JZDUH9/FR7PMSN9Qb48gik66SXFWFA6Yw38UdU0A80ftfOLoHeZnNr3
         1dLZ8VdeczcGxvrYvaPTn03wa+byZPalQt/n+KTJ5i5aJqGtj4WLIpMdOggQ0iHVSZGz
         JwVE0f4g31T8eT1bzwj3P9sPWW5nyb36fiWonB5gaODhXQDYx2cKlPvMmUfbuxi9e1My
         JUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661050; x=1789265850;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jXl14u+UndsqNffpU5G2smJzjKpJjLjI1lXDplwZhbQ=;
        b=VtEzL/5Ed1R//i5dSmaxx+xHVPJw792+6aDaB+GZzkl3H+Q4470wYS9G7KOqeyTIYV
         IK7M6uJizRRxpvBTLEuVXu7lFeVvikjuOeBv3HNp6WA5dLRdHAwzY8bIytKGbxMRbAmq
         GnuSqCt8VpXiironW5XyAtjlYMrzxuO3FtqfBM6t9N1Y3ihZ7fSZjHnyutUYJ0EueA+S
         yKoLBb82gAYMXRKP6+6LNDmDf9uhITg9479+cXQNGrCWoABTHsa93EK8CgeDAaGz4HSV
         4XIjMRTOIe4roeypYfXEZDZJXSTaIJIFFA7GH5VssffcRZC7d1Cwjbr6avnvufMKORmo
         FaUg==
X-Gm-Message-State: AFuF++lavFtpUVuw32CTw72EoP75MPDMnbmL+emxjpOI6etM4N76BG2W
	lHrrP6/Z6nXK9uVhpQ3lsoVu/xG2GuYdZJrpO0grfche0Xti7U3B54KLOyn0Ifkiz55R5qX7Rk0
	e1Co08ibehCixove9SZT2RcWPzCsfNEXDTI3Mt8OO+cLh+Jsw3kelu7G+OffmpiDpUdpjB1U6tD
	AO
X-Gm-Gg: AYBFou0qAOvEdDc8KyqJnvFC/q84fIcIx27IvmBYL5KYikNwslXwDak6FMQ53tjjz3B
	KrnBuQhd2BYGkpcERvv7Zzwt6CBg2MVuahpraLB0TlBtpFSmVUYikEAhzsCzzMkg9UhUMcxl11+
	kuRAMqXU21P+bdaLXnFpCWePJo9QM3ypjEQ7R55hgQlpo6loLJ8+ZbrKXkbFYnXEBI4JzvS9IWl
	zxAeytbcmvxiqXCZwerSdvD35puEHECdPsW7W9eIkEknAUrRLichkQaS4NZEBfgew2mZjgEYYb4
	H46Qur6YJX9HwSRg9gPYGR12AqVM0H+29aBo6T08sbWUL4JrDMs+1U4GJYW2MJe7fn40rvDTkOj
	s37OD2Q3krOj1Iwl6135sbhk6zUX95JrIYWkcPwumatpu3CML
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr21297239637.1.1788661049729;
        Sat, 05 Sep 2026 19:17:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr21297212637.1.1788661049285;
        Sat, 05 Sep 2026 19:17:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 7/7] hexagon: return -ENOSYS for unimplemented syscalls
Date: Sat,  5 Sep 2026 19:17:12 -0700
Message-Id: <20260906021712.2498266-8-brian.cain@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=F61nsKhN c=1 sm=1 tr=0 ts=6a9ccd3a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=guS2OBbcRPLawzQnP5AA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX91rPqfxHrsOU
 LrAs1Ei2AqnYCV4hDWBzPscXBJRYY8N30UZYMI8Sje8x9q6tpCsYmIXANcyS8cdAVoOl65prTWY
 0rgdm3x3i6sGOGCVYM9Tjl0777QbiXY=
X-Proofpoint-ORIG-GUID: AVyrIuWBtbo0KlCi-9nHg86vSnvKxJLF
X-Proofpoint-GUID: AVyrIuWBtbo0KlCi-9nHg86vSnvKxJLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfXwClubkljcv6+
 JnHE/9Rk3a1kOQaKulGIOWxvnx0xOzmVhqrhJ32gpexikVnMjoYw6L5LFQfzqKqtZmrgcs4/PAg
 wkPlMf5MlYMDsIh0YljW6vAAPnyT2wDrmiQr7ONtdONkXtv4KnlcKJA8p0JnVvcX4vmMhG181xu
 EHjvqiAnzgVU8q1SvafSB81pzr3zeHzkh0mni8eaFZvqSSplHFk8GU/rZ+4vlAZXcoMmQuLcF6I
 Y1cgfS5nXd8mlFgRvbbh7RJQVTCzU8+UHRiv4CNAgvREmXbx/3Cub1Pd/KZU7R1opG/uVJba94J
 NRe13g52PWtVyH5TxeAmizHjk2mEdie46khX8jnANNCHvEjiFyBEfhFdL1lrnwSelZas7x2a/G8
 c5JHuvdeL6sHDfP91vEo7oELLxsORfg+8Y7MdEYy4Xrh6UNwrMglwrL5I3Xc83ESLrrNcLN9sg0
 34gm+fhcXSQGEUSJd+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060022

An out-of-range syscall number returned -1 (-EPERM) and a NULL entry in
the table was called anyway, crashing the kernel.  Return -ENOSYS for
both.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/kernel/traps.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6fe0c1b62c1b..5cafd194fa48 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -372,13 +372,18 @@ void do_trap0(struct pt_regs *regs)
 		regs->restart_r0 = regs->r00;
 
 		if ((unsigned long) regs->syscall_nr >= __NR_syscalls) {
-			regs->r00 = -1;
+			regs->r00 = -ENOSYS;
 		} else {
 			syscall = (syscall_fn)
 				  (sys_call_table[regs->syscall_nr]);
-			regs->r00 = syscall(regs->r00, regs->r01,
-				   regs->r02, regs->r03,
-				   regs->r04, regs->r05);
+
+			if (!syscall) {
+				regs->r00 = -ENOSYS;
+			} else {
+				regs->r00 = syscall(regs->r00, regs->r01,
+						    regs->r02, regs->r03,
+						    regs->r04, regs->r05);
+			}
 		}
 
 		/* allow strace to get the syscall return state  */
-- 
2.34.1

