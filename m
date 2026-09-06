Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B53B4417
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661050; cv=none; b=CNBgCNxmCxBEZohRBMmqr5WwESsTpIVdx4YXOXGwp8x6r4MD4TtVrAml2nXZ4mj289QfJtEaH5JiuCJfBO9pHejsRbjwVIlWik7ihgv2liZDwN6sIYv5nsPltAz8StnM0sRM2XUmVfWQ7XY734c8s48KAq/Ynkn873cvhDjHYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661050; c=relaxed/simple;
	bh=cWRl0lKb3R1ysr7EQPL6M5jYBKnQB/Ccz/tuJSqMydk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOqEu7GPYyvgAcRLJ4zEwi6qPy+TYcY4YHhE764d9oPNX4dRzAxpO6aaxXe65A7EMd0CQrO2iE6LGftoqNDl3xGwUd81FaiaVHPPXSy0MdJ+/D3XToA9Ds5TLTfRTQCnxcOmjGBR8GfGEhbf0fTl1TonWsBiLRLe1oEp5BmM8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cmZvRzWR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CfC7YDMn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cmZvRzWR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CfC7YDMn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68601TPA3658752
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	muaLhDCkuJOctC1SZ5f5J3L4t6BdiSYNx/Dgk3t2hzI=; b=cmZvRzWR6fRxyM2N
	q9ciAhbV+VkXHwaM2Mz7RdKjy9wbg3iVfZ1AHpxs2gawVu9SHInBn7ytoFh0IIMd
	QNUU8i8qLVaicYbDK/5dvxAgJCDeJUpWGNUvf/ynahm9Lv8yWyeIsvb34GiLqV+9
	xzGTiIC5eG2QLC7P1X5sVsXBaln7qwp51s1qnj9+k30LXOe14Quv6SelZgsuNcog
	/Sk5XzkT/dGgIqdleWALURYVC4LHD0vrJROS0L243Dx9wJhCThu2ZReysiboygDp
	pZZslJnUyPZPhg7AyX08wn19DUpdRNmaCUzqgv1J38RySvbz4hDwtZBLCoI5pBQI
	hdXulA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggadhjnay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2875479a91.1
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661047; x=1789265847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=muaLhDCkuJOctC1SZ5f5J3L4t6BdiSYNx/Dgk3t2hzI=;
        b=CfC7YDMnHkNEWCUCkw7cFQCD3C9o8Fbmih9SC8fvODnzzI91iMThIB9TaemOvBnNRR
         ppzn9Ho2fUaI8zT8AKMvaOrDqIXjRzMZD3+OX/8ET/7pc8GRXTkrBKJi8rz68rleftjy
         OyQ094vqJzdzEnr3/XgKGhWUZAEev9wn0Xmpjq4U+RCEDn2Jp7YPdUukFpUg/n27Avfj
         OSFCnGmgvZAb7aKjm0ORBmmW6u72Z8fuHAHfbGF5Seyt4iDvLwIAdzkMA3jqPW754HFT
         CEgPLHbEzj0vx73KwarD89BwVYJaJJgQLFJtQVLG3fFUAWglD8zY2xsKQOWR4CuxqCO3
         pi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661047; x=1789265847;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=muaLhDCkuJOctC1SZ5f5J3L4t6BdiSYNx/Dgk3t2hzI=;
        b=hUPWIHvTmUMGGqT8XJOTXMn6txeo8ofo9bDM6U0TgMYZEVig/c/3D2NBuKzaT6KIx4
         S/ZnBlTNO8eY0qWvh8RZ1mTTZh19BoXuJbhL4y1ZANOzWSTcZHtDWzXdBxprpqyn1cF5
         4/aaH8bGCNBk8RA8YGZISCGyekeLo2ErWqNXBTaHIxk/J4rfxxqSZtJNR9vfQEvdjuyH
         ddGa5hDHVaLwOxtMbZ8G4KqIoBvmn3J/qI15t5/nQlcgAD7AqITUiP4EA5NNXxaCcnJu
         D0c8jvgkc800Cp9oZ5xirsd6z2eUc0/IGOQVINw6yBZwrrhfFoe9Bv9G8yQIa31brfoS
         73cQ==
X-Gm-Message-State: AFuF++nJotXH7HpMATAjeeBknnpPF9RR1Mq+ESwqfdsnICWARZOxXMhX
	gm+FKWyt4ChaVBJNwBNAmVWGcAhVI6/Yt1vvkOHyDN02V4Rc+9yuab03xGTAxA+ERnr9ZbU1O0H
	IKnESVldzbNiXUvy6IhFDklNd1bAStC27kOQn4T0mRIRrW+FhDBrHPLe+jQIvV72hQHaqfJj8P9
	0S
X-Gm-Gg: AYBFou2mXVIPKdAspRie9Vev61nIIZbRLIW+0huEkENqw1XBWcPzFUjK9GKOmT+PX5O
	BTZRL1Qy6eKAlSMULe7gE33sv5I3kbb9B1XkJjq0YW5mAeVGRmpU93wQYDlFOa0xe6kwX/A8sib
	JXUrJLKko0wDmPpRmhueyeFmR7EDdAvi2Hc2Ycw1NTWHkMrp3ltwKFI8YC3ff+NaG0pzu8eSN5H
	/3hnoiF27mEH6prdyBkDtuwXy/ncOEb6csCBcDTJz4RpZoAmPLt4jLAEhHpySNpP3tdMAvIktgQ
	Bbs05Bknt7jHfrJAR/uBkWXxlG67xrZcrVz/DlTuxj1MeNxa4PG8TtaDm97fMyuHLCHChicxSwM
	eyQANl3SRzndDtmoZ6Wrh2Xz33aMDNsQmhm2QByn/HR7/3W6Z
X-Received: by 2002:a17:90a:51e6:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39b4877aeb8mr5482243a91.22.1788661046795;
        Sat, 05 Sep 2026 19:17:26 -0700 (PDT)
X-Received: by 2002:a17:90a:51e6:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39b4877aeb8mr5482205a91.22.1788661046316;
        Sat, 05 Sep 2026 19:17:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 5/7] hexagon: let do_work_pending return without pending work
Date: Sat,  5 Sep 2026 19:17:10 -0700
Message-Id: <20260906021712.2498266-6-brian.cain@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 8mJA0Xpit5G_J9hmA4A4ksCWF4xhkuoI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfXw2joz9dIY7Lw
 fa026UEjL59Yun8DQfBFQ++adz66yC19zBY+fLHDIGdRd4Qt99iUA0XDwTHMBvfW/7HxfVfhnuN
 7Z5I8SR3X5mBYRKw4efkir9CX0ombRSH1QyTByoDbDCNrEls43umSeIPDNzgnMPlEPurBUmaPzZ
 uZPYKDlo4mP/qCwWSWCY/WG5SbE4lEyP/eRQJyjPP7oK0E98MhiRyOkJwwbZjTUeqtsbwpBmIvh
 OfSRjgLlcxXN8cp8wOgk0V2e6RzO5/Bp+l4WDUTV8NXMGoTnVGckNFnvH6Ha6QwBV9KP4vx37jm
 Z4y8UFcveYNFLKLUBF1vtAA5fLrdP3Lhcnn8i6GSZpX++JM+1gdgRzJH9sLubO44LXQsHLeCzT4
 WJS7/VIrXcSYjorhw9Hf2Of+ptOOJiypBsf+qby+dp9zfvgrDu/fuuTn8YPkyv6Rtoik0IO/w1r
 Wf1MqE+iCaNqnGcV97w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX4A1+KVLOVR/G
 gGk/HMEhEKZG41ttKlkJN8eM4c+QzZOtMfMpTR9Phe0KS20XMJbsDMDkh1sA/kLyYsNW9Z43515
 z+wPRUBaYjuyhIIUzqyMYrNITagTUT4=
X-Authority-Analysis: v=2.4 cv=OceoyBTY c=1 sm=1 tr=0 ts=6a9ccd37 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1z1AmJp96zu41nyL7QQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 8mJA0Xpit5G_J9hmA4A4ksCWF4xhkuoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060022

do_work_pending() panicked if it was entered with no work bit set, but
the event exit path re-checks flags after enabling interrupts, so a
signal that has since been handled legitimately leaves nothing to do.
Return zero instead, and stop treating single-step as pending work.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/include/asm/thread_info.h | 2 +-
 arch/hexagon/kernel/process.c          | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index 3d4a40091a5a..d4a005d43e31 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -107,7 +107,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 
 /* work to do on interrupt/exception return - All but TIF_SYSCALL_TRACE */
-#define _TIF_WORK_MASK          (0x0000FFFF & ~_TIF_SYSCALL_TRACE)
+#define _TIF_WORK_MASK          (0x0000FFFF & ~_TIF_SYSCALL_TRACE & ~_TIF_SINGLESTEP)
 
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK       0x0000FFFF
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index 15b4992bfa29..f5e9934c36e3 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -156,10 +156,6 @@ unsigned long __get_wchan(struct task_struct *p)
 int do_work_pending(struct pt_regs *regs, u32 thread_info_flags);
 int do_work_pending(struct pt_regs *regs, u32 thread_info_flags)
 {
-	if (!(thread_info_flags & _TIF_WORK_MASK)) {
-		return 0;
-	}  /* shortcut -- no work to be done */
-
 	local_irq_enable();
 
 	if (thread_info_flags & _TIF_NEED_RESCHED) {
@@ -177,7 +173,5 @@ int do_work_pending(struct pt_regs *regs, u32 thread_info_flags)
 		return 1;
 	}
 
-	/* Should not even reach here */
-	panic("%s: bad thread_info flags 0x%08x\n", __func__,
-		thread_info_flags);
+	return 0;
 }
-- 
2.34.1

