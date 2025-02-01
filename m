Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DE3EA76
	for <linux-hexagon@vger.kernel.org>; Sat,  1 Feb 2025 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738380445; cv=none; b=q5EEHq8fBUAQ2vVg1BFIa9E2XzjdNgT/u9CLjBIaGcn/MJ8N7Vufc4ezWqbuydtQtNl4dF2/wamM6XZsg6emcuji+Swxwrd3uS4PMzfV/NOuPH4Mmc/lRfCIxOL+9zAKf1ir6lcHEpr+cjMQVX0XSKu2RmSnl3CM2aiWDp6IB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738380445; c=relaxed/simple;
	bh=PF2Yl1TqoXLr0NeE8+DQsBl5UrmwjXRSIckiNT0UUh0=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=S8kYbc0izLwPkNaxowuo/G3RqMPbgK2Lp5ni4PNMOoO2AYlkCQOyXsyjlE3PjWgxeaVlB9UsFiWB5mgZDcsqlEH4V7o8JzyP7nx9f4g3GRvFgr2919flMec7HhNvYv/Gnrx4HYus3bpageAJ6+Yc6J6o3cJ2ccwGytqOlOpOVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QcNsMTxK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QcNsMTxK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5112ZQVv015884
	for <linux-hexagon@vger.kernel.org>; Sat, 1 Feb 2025 03:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ngm+J1bv5blPhxkqLYNt5X
	iWRJ/xudmR6tBXP3+PxHI=; b=QcNsMTxKGovxWyyujJ/EIGJyJ103f0Ytesa/tq
	Na9QutVf3sBfB3GACaPcwjUYLIYwB2sSYljwAysx311TtQ4QnuBQpbxNVi4bBLh8
	Po5Gl2OB9Mq+bL96AKK/AfqiW1Wc1g3PJBQW0MO2rcZCgq8ghRM2nplrxo2PBIuw
	VnqbZB+h8zQBXrvtt7N3PRggn49BTXku3DsJw8N2uXUui6yhBIa1cxU0xBJP10r0
	nlui2dvaO0eChL/0WIVc1rgmOFa2sSy3wVlWJlczj69sFq2hLmsxo6z9zcctyvAi
	eEMskDj7kbvIy3XsZWwFBtg0kfEhOjtOMorQcj3QoZxfxUkQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44haxfg1xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Sat, 01 Feb 2025 03:27:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-468f80df8caso48169271cf.2
        for <linux-hexagon@vger.kernel.org>; Fri, 31 Jan 2025 19:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738380441; x=1738985241;
        h=content-transfer-encoding:to:subject:from:cc:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngm+J1bv5blPhxkqLYNt5XiWRJ/xudmR6tBXP3+PxHI=;
        b=b8DwrwpKdoFu3DFjSLjb57wf53HFlZu32+dEAkscBNshIh3yxcpCz+w2AlIBirdAhV
         KSaysVrHgrptURa5F12VUmfIggcb+wUcp8Ea2klgkFK9OyzX4L6L2/CMFaCK8rZJGGNm
         MpG+0zL78v/i8KahoMeIwfgJAvySZlSiGOxcRm8sCJ7Jj1q2875dkyniio5uGkeuQpPq
         LFkTxwgjKBrxb/pl68NAA5naln06ZW6JnBxCfVQl+TRyvJlkghjZdpvbuu6fzOt+hG43
         V8tHn0HtR+zdtiaYc9vjLMc9tx2PDN0ZEUIT0BKIwnqQcL/hUt2vUMHTnqq0VsAocuqN
         1IQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbRk0z0jrVPXrbSlU+wY5J+c9R/Z7i4D3+3NZikXqPQ9kK/02I2SP8HPlH1EwlGXCOOYsjOYPi/+MB3yv3@vger.kernel.org
X-Gm-Message-State: AOJu0YwLG1fxE6DeuHYjNFPcrYcbljUgft1VZjiqBPJCVpLLh1i56PuV
	Ifl+h19MQ22ei+18TLBRoAUnJszpqLlEMj+D5+7n8F52sOAvyC0Vkze7OM6m3vf2UBquIWu8dYK
	BzAN0PCzsQV/lZB6Rz5O67HnxKVi4EPuTSdeSJfOEeOZWv9E0HFuPFVEqOYOHBpVI
X-Gm-Gg: ASbGncuNbfb7PoO+EzBiuO7g4o+32izYLmrVlldXCYCOFBe7Z93aehlOYgxNsitBH8z
	WeRss8DVufk55ezJd90ajM8sW8pomOVFVKM5uKNaIDORGQLzSX1kPqVlgfGEOVUM+gZDpRKNod5
	qFIzZWhgSPIQCaG3kSHanamnjWd308zFGTOe2DIKSdAsmFVJdfwrkGoBF+u4swhBCA26lrsrX8K
	3o4Ecz6VUYjDNFPRMuwo3VgJ5EsIJSEDs3cPa7H8p2tKp1XAqwXXEIcnZbPoz7nw/jpo7G3Z7WE
	GlphW9S07McTCmwYO+Tca48LCK1etYwRGUHjSlxk3LxNK45u0/WaxeuyQYgoiiMZ4u9UyFyR5Wg
	q1Zep+A==
X-Received: by 2002:a05:622a:4d88:b0:46c:716f:d76 with SMTP id d75a77b69052e-46fd0a64856mr201942741cf.12.1738380440796;
        Fri, 31 Jan 2025 19:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7nersnCv1Rs7slOFSULjuyyLKsgIxH/oH4djXhl1UKj2C2IF4Um8Ukrb2kEhT+WjO/hAF1g==
X-Received: by 2002:a05:622a:4d88:b0:46c:716f:d76 with SMTP id d75a77b69052e-46fd0a64856mr201942581cf.12.1738380440459;
        Fri, 31 Jan 2025 19:27:20 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net. [104.54.226.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a75c0sm24002221cf.9.2025.01.31.19.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 19:27:20 -0800 (PST)
Message-ID: <971d297c-cc66-4947-9bf7-33aa7fc12673@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 21:27:18 -0600
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: "sidneym@quicinc.com" <sidneym@quicinc.com>,
        Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
        "quic_mliebel@quicinc.com" <quic_mliebel@quicinc.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [GIT PULL] hexagon changes for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: btJ7BoW-h95mOTOJrKVDV9zjWKVeUSCS
X-Proofpoint-GUID: btJ7BoW-h95mOTOJrKVDV9zjWKVeUSCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=830 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502010027

Linus,

Please pull the following changes for hexagon.  Among the changes is a 
change to my email address.  The public key containing this new uid 
should be available on keys.openpgp.com and keyserver.ubuntu.com -- 
hopefully one of those is satisfactory.

Thanks,

-Brian

====

The following changes since commit cd45f362fc1f2d81fa69a19e7f8eca058db3e320:

   Merge tag 'bootconfig-fixes-v6.13' of 
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace 
(2025-01-28 10:11:33 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux 
tags/for-linus-hexagon-6.14-rc1

for you to fetch changes up to 84d78214b4f187da7e029f5dad344203511a04d7:

   MAINTAINERS: Update my email address (2025-01-30 18:55:25 -0800)

----------------------------------------------------------------
hexagon updates for 6.14-rc1

* Move kernel prototypes to internal header
* Fix to address an unbalanced spinlock
* Miscellaneous patches to fix static checks
* Update bcain@quicinc.com->brian.cain@oss.qualcomm.com

----------------------------------------------------------------
Brian Cain (1):
       MAINTAINERS: Update my email address

Hardevsinh Palaniya (1):
       hexagon: time: Remove redundant null check for resource

Lin Yujun (1):
       hexagon: Fix unbalanced spinlock in die()

Thomas Huth (1):
       hexagon: Move kernel prototypes out of uapi/asm/setup.h header

Willem de Bruijn (1):
       hexagon: fix using plain integer as NULL pointer warning in cmpxchg

Yang Li (1):
       hexagon: Fix warning comparing pointer to 0

  .mailmap                              |  2 ++
  MAINTAINERS                           |  2 +-
  arch/hexagon/include/asm/cmpxchg.h    |  2 +-
  arch/hexagon/include/asm/setup.h      | 20 ++++++++++++++++++++
  arch/hexagon/include/uapi/asm/setup.h | 14 ++------------
  arch/hexagon/kernel/time.c            |  3 +--
  arch/hexagon/kernel/traps.c           |  6 ++++--
  7 files changed, 31 insertions(+), 18 deletions(-)
  create mode 100644 arch/hexagon/include/asm/setup.h

