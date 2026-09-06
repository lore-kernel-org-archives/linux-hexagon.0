Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6063AFCF4
	for <linux-hexagon@vger.kernel.org>; Sun,  6 Sep 2026 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788661040; cv=none; b=GjNdwAnMvxHVE+8S6xfsEBkYrcTnxJd6pkDbck/3HIoIRiDxPaW56H5Pe54pq4aC7M+IJjHYUT45jDfUgAeBKVoddlGi/7fx7iGPdlUZmH23f4QsEjkxDQXW5jC5Ww6Vkjy3FpwNM8XbLsYZtfvc+UljpoVjMuZqZivu3jPJnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788661040; c=relaxed/simple;
	bh=qiw4DYppmmZbwg73t5rzNjVDsK8kkiX1zBh1SZSsLUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RdPOvL0TERt5tC2uXGPSMwkB8tW8N7jROFyv35JVpaq5+/7ZKx0eNTyk0wYnQIFXaysIOwhzZ9mmQAVOQ0ww5O9ira0jY13mm1hs85oymnwSAZWsPlV3vXzCx/xxX7/dFC9zNEWX4FZKPwR4mBQMPxzJg28J38wvi+qXVQugktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+tUnyYA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XBGQ4a/N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+tUnyYA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBGQ4a/N"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686004YN346234
	for <linux-hexagon@vger.kernel.org>; Sun, 6 Sep 2026 02:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+peTpHFjkfCr8QmxsyMzYI
	dLFlsAcygtnL9KOarpK+A=; b=V+tUnyYAPTtV7fv5Si+nHHtLdw2Xz2HMMBgUQW
	Gsw13wcJ6P8/Et+kx+x2I+NIziodnHvkOaY8lwCJH3k5qyA5Nc7F9Woe5Bk4fUO8
	145pfadIkuUlSVQ0yLijLlXEjws+mddVGdpMRRWg/XJ8o7mtqgMGBNlAqX4tD66K
	D6YX/dIsanyGgDhUFkN9drSnDH3nN55GFWNwX2HohSXommE98Mhvj9scuiaQkolX
	7hSafIkKElvk/dA88UpLKafeCmVfnfXQaQtgUirx+R0puTZuLRc/W8nDro5Aaw3P
	CnqXJUvmRHISJLnnVj71Wh9iUQI6IQX7WnH/KQv8bHTfkMHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s2tkp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 02:17:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so4166176a91.0
        for <linux-hexagon@vger.kernel.org>; Sat, 05 Sep 2026 19:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788661037; x=1789265837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+peTpHFjkfCr8QmxsyMzYIdLFlsAcygtnL9KOarpK+A=;
        b=XBGQ4a/N+jGbT41bxyZa7P79wk9k/vVsqEoxWGDMgul9I9KzjYC5FAw0/tS3ikwKHF
         CoDXGIoOAUBSEoVID+lresHHahXAHSCmYiCSZF1cfyxAFCQJDGrAjX+6U4sehPc1Xrny
         QUjQzqvK6zDdCjRG8wwp1ozInVG/m/EW4EVLzETEwCeXaBWtGz6Y9tpMHs+Zqn1CRNur
         9gDjulBpteuI9FEY0CzgD73rkZZhqEZtJFiG4VPzCNyI4Esmo5VVF8VmBXaGO34hwm8o
         JusUCYhGmhvN9QX9h4unLu3K9MpokROEoOGP5LEljPQAJ6qelthlmiGf0e7kkVb1XUpd
         +eUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788661037; x=1789265837;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+peTpHFjkfCr8QmxsyMzYIdLFlsAcygtnL9KOarpK+A=;
        b=p+Zw833OzT3YumRIDdUWqNRq+kCe9oJ6KkbCOt6t7D9XccSmsdhLQde6sQ8JEnjzjt
         RJwLHWZtiX4F5koQtWkii+KTggNG9vn5AgDe2JUKkSpoieN/1iouvJc2ojv/wXdLMhKL
         6Iv+2hV8YJS835AcRJxZj9luTCtvtn/wOYqGJREgRX9lW1d4I9hdZn8mZQoNet+p4rF0
         S97YDjzsb7V2oaEjrQ5xFEd8GePVipF4F6hkN54Ela1B32YL4tFaK9QOlDv6d16l7Nad
         TfmoZGjyBR5+WZs7pGlmTPkDzJ3/GyIlS6wwJxA1VAKkBZ5JoYbWq/UEzCsUzAqrIFk8
         l1Xw==
X-Gm-Message-State: AFuF++mb0I1rjXRkdHWmG0LHJUGBW8QrP7FDoLeuXdhZcwUC/ZgkJXOC
	YIaluDqVLljfuIwRXfn0GTRg005vmyOZM9ODtfFIv9qLiB3VA5TYU87JVbaiHxjNZEBenDWrbun
	rkhwixhKyPNJrbJjObq2jg3L5aoTkYxxofqTwj5rlw75YX8v8O6+sl4qyErE8itK+pPMd12wKxQ
	Zx
X-Gm-Gg: AYBFou04/7uMgUJZ5ek1jPEx+tSrhiEvuPNXJSO5zeg0vE9faQ7qjKa5pv5TSNT30VA
	4uaji6FExQ6CI0DTl0yGXMQW6ACDkpYaWxpjUcGUAcS9ngGItdZ9WK3eOyQM0KvVzdL9OshLA+o
	X0H3qdUfJQxBZQ3/6JM/uZFBoaeVdNAcJnSgmyp7k1lcd7cu9h0WlacAoCtDaDFuOB04tuBWrrl
	qXtnls7DUEPh3189rCEOJZ2ZLQPE++Ag+LbjqB5ejTK4gtSJyM/3wu0dpFCq315eNahS8//TFns
	tbJ+t72G+NQJEW0+qrkBVtgN+rOfbfthn2SpeI2DN6D3ReEAFGawJ0/416S4ay2y4ke6+YhQSZ8
	XYReSlG0GDlqRYqn23ry0jJ1I3Fcf8vAvrnB1KQ0Nffyecqke
X-Received: by 2002:a17:90b:2ccd:b0:398:b88c:2b7b with SMTP id 98e67ed59e1d1-39b260d7297mr27485837a91.8.1788661034814;
        Sat, 05 Sep 2026 19:17:14 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccd:b0:398:b88c:2b7b with SMTP id 98e67ed59e1d1-39b260d7297mr27485772a91.8.1788661034184;
        Sat, 05 Sep 2026 19:17:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm15547054c88.14.2026.09.05.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 19:17:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/7] Hexagon build/syscall/etc fixes
Date: Sat,  5 Sep 2026 19:17:05 -0700
Message-Id: <20260906021712.2498266-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9ccd2e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=FRLJcpEBjdMWidUa_hUA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX2HKZfoU/nXJ6
 wZx4vrqx46FnNO6nRrCtdFxbkOpwnB042IBiy/VMdEdswfBn1764yXrhIbnj0am33lEeEgQoPvA
 lLCAMdgHcWlOHewIEo38TsOAJeWG1WE=
X-Proofpoint-GUID: LmIJwUIm5vERRq7iUiuEXo1FMA7_pp-9
X-Proofpoint-ORIG-GUID: LmIJwUIm5vERRq7iUiuEXo1FMA7_pp-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDAyMiBTYWx0ZWRfX/robQwkBmpx0
 1UPn2ifjGJDWNAcNHIZHjJEtK7+3/XsIMHxbuWQxdttIpIM6UNI64qBR8BuQ2fOcY8KVLec3XPu
 mOCZrZhtDSJHBGr+6MxwcRO9dNGrnXl9QtR1eLUOsoriJDIItpeLmhgZc+YAueFLD1HufJk9/4b
 p+rEBf464NU7RlCKdaELN8e0/w+l3vPWNOuBBpYpRYLTCwbtSNh+TzGTBHj6IDjbVaQ1fDVyN0h
 hDhSkOUJACAz2Nxh93cOjRYa4EYfrKc83wRiRoGJLV4WchUZyDy7Zn0xtXUIDHc24Llix+e28Sb
 +mlAwnkXH3P01r2dFPWfkiEVdG6bOtykF0P4pLWDbZv3Y6zNPWNauzh+tXQJQebg6szP91wgiuQ
 +M1U/x3L1s8U8aCnrlxo3kTpm03gKlTWYuRIyENikHUZq+qGjXBowIS63uvEPhHCU6+F3aEaWJi
 nDeyC7vLpYThfSeqWrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_08,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060022

While working on the qemu boot configuration, several issues were uncovered,
this series contains fixes for the bugs that were found.

Brian Cain (7):
  hexagon: disable the LLVM packetizer
  hexagon: define ELF_CORE_EFLAGS for V4-and-later architectures
  hexagon: stop passing -mv${CONFIG_HEXAGON_ARCH_VERSION} to the linker
  hexagon: read the thread-info register with a volatile asm
  hexagon: let do_work_pending return without pending work
  hexagon: set the user stack pointer in start_thread
  hexagon: return -ENOSYS for unimplemented syscalls

 arch/hexagon/Makefile                  |  7 +++++--
 arch/hexagon/include/asm/elf.h         |  2 +-
 arch/hexagon/include/asm/thread_info.h | 12 +++++++++---
 arch/hexagon/kernel/process.c          | 10 +++-------
 arch/hexagon/kernel/traps.c            | 13 +++++++++----
 5 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.34.1

