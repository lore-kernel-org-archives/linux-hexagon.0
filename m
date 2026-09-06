Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764025A655
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661055; cv=none; b=JXdjCqB3eAa52uG7DI4ByX7TOAmg74Van6yFdQn0AoophA/N7PB5kYaUYzMHdc15QTR95hSVZvcZIR1aTSJMzyMLOVjhvvFE0iBsa4r6gy/5ghUUWL17SkCXPZXueG018oDLtmzXWz0aXZN2Rsd4XgOGO737L3BeAhXHvJ0gpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661055; c=relaxed/simple;
	bh=vSqt02D/a5nYsc72GEGr6DfetSBqI7h5uVKptjw0zfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnVuX9mXSxXFPbNFNpA0iuGIAjM6GwvlNwr+pa5Yw/IVhB4YOPIZ84BSwFEyPtRwVP/zgWgVRGqotr/Mb+GkoY80Gn7YOKZoXgdOoocOteOeBcNNuld6YBtavEGK1Qw05hma0ibo7wBFRJnqh+B7T767o5aB8Ja52W4fRjwd/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Czrq579q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HxrISgQH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Czrq579q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HxrISgQH"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68611WwO3338642
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cNznb2UY/ZEv/mQfco7L32Lmo3KRkgWAfB/Zm8CdYJk=; b=Czrq579qDZFdtiJa
	p7Pf/jO3lgwmCWM8i0ugrkgz2qfoNPBrtrw2ILUb5vIb+5gJ/jYgDJTcSZAbR8h0
	us71shvIYEwLLJXomy2zVe533332Cn57Kox/wsSvNo7R8BtgFuFnpFs7JnT9Ur7Z
	nKxKtPUpYwKQ4vQzHSZTUQ5ZvwuWixPw645PRxsUlCHdU1al73RfXocbZ7A07Tvl
	626Vhsnj95avzo2f1f+eD4C5U6xYnjXSdmfg6RHj7oQ9YzjyIt1GHk3oiSAvfeua
	kUgUn6HuLKqG2bqw3k5j/U8KqBTaJRXK/3zr1ZGMULeMHvgYE6o8ZRNYYld4EzLf
	66Vtvg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuejnuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso3394539a91.2
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661052; x=1789265852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cNznb2UY/ZEv/mQfco7L32Lmo3KRkgWAfB/Zm8CdYJk=;
        b=HxrISgQH5iPIpMOJBEhb4Ilx32nJmVe6xGVDk8EPjcpt4KSqRhT421dOaOaIrmqXg2
         C+C2pTFhd55e7z+pHDHzDPF0WSfthzmjy7Ehe5jzssEq+2gYHNS9aqloWgdLsuwFHNJT
         7beVkIwgJlrHh+IuqpTJVMqT7QhNv+X5h1nC+b0paKZtfXaRcZDfcflG2FTd8gMjySqI
         HuRr0vTsbDc57H2ZEPhDpvW1FnJZGjH0xmDYfHJKvA4JYzBIpsBwqW3iiUz+06tGq+Zh
         9nanZstpzxUBhjVb9vFLrOBwZ8gC/abRyshQ36uCl1+rH7+80F3NY9IHpgUK3crQOTDP
         soHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661052; x=1789265852;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNznb2UY/ZEv/mQfco7L32Lmo3KRkgWAfB/Zm8CdYJk=;
        b=CuXDS99/Ikb9L2TW2gZOOPWmwtZVUQLSP6Yjq8Wj4LQ3sTftVuOis43SofmaMKL/ZW
         VnkvxN2k0kenv+rCrWZO/LdKxxHsSYPEVKQrVhEIPwePgXvYxT+N9Y5f+F/XUS0W7LaJ
         HdniEqlFNlX9v4ZaYole3NhS2d9yX8KPLF3VPFbI3zj5ioyJ0mO+1dsUK+4cKE7nt4EF
         QY8mhX9JknSr47tOSq6RDWqufS95OLSSUDocpHT929+pANhuizOrwRKZLQV1maMjvGLx
         KMpPkl2l2Mg/m+FRQq2iyg4q/5Rux6/uNzqN7leJFJ4wDSVNa0mNM5ICdi//lkryCmZ9
         D7xA==
X-Gm-Message-State: AFuF++l4MHotzuAmo/yyTiuWHxztdmPMQ54+nbyhAljtuRb9mnxXuYD4
	GWc+8nWrQ6z34fwAT34I8+IBXsJIOJyVSkXyu6bm3zl7l7WUkS48Rzz9v3mq4U7NQ8NEamkwS4p
	3ZZEgaucoTDfEBy5ZbFwy3Vlv/IEaaKG5yEKZg8cTSe2VyO7CQ4k5q+0MGG8h/OfErPaaBfMxTl
	j7
X-Gm-Gg: AYBFou2KChCOCKgGakLM5BmSK8lOdk1U5xMi//yrDw/n+WKynApGRM9caAjOqzpIsEp
	dpclS670ghnMeM08YQq+1WbTqUwp2W4Uz9MpTqzBUKLH4OUrs8xbVzGcRUXeuEkg4wKAOC2FxQY
	Z65R4iiqSMBONnB7kBg3AqaW5DqVb3GNSxV1Oly+TrtEF3zDiNUW++RhXmCrs0rmNkWhLbvtORd
	URI8QQyYtPLauIIsc6uEX9b0ez7r3ihuPaGa/y3QeQuI29mC3MnCok7Lr0IU15vlIRzonP8kBJT
	hDwBJZvwX9f2Vfm6ZGi1KiPtGYX3lj7pV6M0mAHxlImXkJAsj1FPUgmxeWM4cToEipfieY7Tfmz
	KDs+m6sahpj3cngkd48rjmieh3FZSySq+opeLx75nFgKGGSec
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr24450880a91.15.1788661052607;
        Sat, 05 Sep 2026 19:17:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39b261d0d8emr24450427a91.15.1788661048328;
        Sat, 05 Sep 2026 19:17:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 6/7] hexagon: set the user stack pointer in start_thread
Date: Sat,  5 Sep 2026 19:17:11 -0700
Message-Id: <20260906021712.2498266-7-brian.cain@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX03bf3feTSSIP
 qgGTdF+u8MXYdlOfCzq4kj4m/AxMULAt1KvP7hYpctu0+JfBy82q/tHbab8WpN5hwev1z3Tr9T9
 C5q6myA81iA3NqEJXKJx82FDsQPnB190GL5t0WDGl3yhxlVbZ+P/qzkwCUncYCvP1bCwavd5cRo
 x5ylTJN8U7bnmPnd6uYkKGLXvlvJaxD3jTfJrnLFTbOjhMU1HV4GcomZ6RB3y58N5+nuIrg+pst
 zjTVrDAoIOXakGOvOx26Tn2mpGAXPycsidDGi0QWVlEU3WCIvGPQ+pyiI+owwybDL6n9e/gmP3O
 kZDveX//rl5jNPpYRt+4B0hg+E0OEDpCkcbqKjv16AmH7ptguNgi29Xpy/SMYiUwRyJabt7osP2
 m6ucK06Gy5btVxRD9COce5yNoYm96wROGL421VCgw6iVwOlW909xxHDckRlFufsT0ecv5OfsNJw
 utYCW7tfahaRKA2WeNQ==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9ccd3d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UWIXS7BK_bYSEFTQNYEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: PB6ufEApWIYL4hS4YhHtukgCjMK3tO5X
X-Proofpoint-ORIG-GUID: PB6ufEApWIYL4hS4YhHtukgCjMK3tO5X
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX0uSiToRvnSEg
 Ad/vDZ6afh/oFLOxT/VpracPfPupRhhbp0OLUXkGI2wE5Twn8DCiKfN5xOrzGeeo2y0jMsimtog
 wYGzGaT4vAksjzRoK4yoJ6tAJRuK+Pk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060022

start_thread() set only the stack pointer that vmrte restores on the way
back to user mode, leaving the copy in pt_regs holding whatever the
previous thread had.  A ptrace stop between execve() and the first return
to user mode therefore reported a stale r29.  Set both.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/kernel/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index f5e9934c36e3..6953c4b1fd5c 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -16,6 +16,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 #include <linux/resume_user_mode.h>
+#include <asm/hexagon_vm.h>
 
 /*
  * Program thread launch.  Often defined as a macro in processor.h,
@@ -33,6 +34,7 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long sp)
 	/* We might want to also zero all Processor registers here */
 	pt_set_usermode(regs);
 	pt_set_elr(regs, pc);
+	regs->r29 = sp;
 	pt_set_rte_sp(regs, sp);
 }
 
-- 
2.34.1

