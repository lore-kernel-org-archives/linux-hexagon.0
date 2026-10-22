Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691107;
	b=p8gwhMj+5174Lwyn1nBHma9xIOY82UD/hcK3CwG0/05uNkEBHqE+iOxPeehjJfzOwGm9
	 zyJNsiC3Jh4XyrSC6k/TXJYqDc4w9r8x1RcKoazQWL4K3gHgfQdGln4wwAWa5nkXY4FWn
	 7jNeS2Ma6F5fT3fRe9WdRTn2CqO2oajaD1KQel6dv06jwI7rU8q/VacRvoxizKdhKxTrd
	 bg5hPsp0qCblB1c2aY5ffS2vJmiKb9xfW0Wr/3bKErkoGunJRl9ewyOY2eDhbTh4abBGH
	 rNdeVQ6GhXwwe/Q06uOvwMpuKYsGDZOZmhpDPMvvLtJrx9LR50tZthR/apvz63bg+xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691107;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=APqBfV9LNU4GND6HkjG0xUfHrFEtSU5GaPvdAgxKciE=;
	b=snBLOrjTHaEReQin3de+/vFKiQ0g6OPVk57C6HxPUYvqRba+6v1oPjWb4bcw/4vJi44D
	 DF7Fkxssc8HzQTa/Fthv/92iUIJEsGba1Ho8HhxwDo3gh6rsxtkf1KRIw/Euf7hTFtVIP
	 02v6vW2uCpIhjwteeUJMfOyBkDVgbJ50LY0O/dZlLAJsFNhtsWv5BiHyj2iunwVpjeXSW
	 zf4Aixt+hs1XhwxJGEZBxYsILTT26Wb2dUaWKVv0+U3S80d6BKp0NfiAPqt+BwdSYiwgz
	 JtCEx1vz7XF7rbYQSHP4sPAb48bT/MVEcm1t+qtNEwT62bbIoT4xn2IzW6nheglxTTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+iMAcz3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jk79UCuz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC8606A31B
	for <linux-hexagon@vger.kernel.org>; Thu, 22 Oct 2026 17:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34EC8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+iMAcz3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jk79UCuz
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MHcuCI898201
	for <linux-hexagon@vger.kernel.org>; Thu, 22 Oct 2026 17:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	APqBfV9LNU4GND6HkjG0xUfHrFEtSU5GaPvdAgxKciE=; b=d+iMAcz39hOSyw8e
	lO809x1rfULubAanZUBN1GGosNK+9eD2eI6K2OB6pj3JtL4b94dmqATALkZpg60L
	QQTWFDci669n03oW/do+N7H0bHsZgLj9eZUWaXf+l9Qi5QdY3lmH7Z9GE83KaADL
	vTvFavi+hmwCx0RcoTakBbKghoA/hYKF1keM8rDXnjdveMQ1kMVqY3ZJOrVmt8ZG
	0amMxr2hOSqWKw+UzJ1PRA2P7Iv5YnFLqwnSEwBiZt/s4Zg1W2lffSvuRyCD+YKJ
	COUgIawwLVGta8mDohl8ny83sJ9CYwtGaUhSnZ+qUD3Lx4NFCtCM0gTE549x5MMV
	Zk5kww==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ccypd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 22 Oct 2026 17:45:05 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b09ee23de2so1978067b3.0
        for <linux-hexagon@vger.kernel.org>; Thu, 22 Oct 2026 10:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691105; cv=none;
        d=google.com; s=arc-20260327;
        b=MJUPBOE8ZbikF8ad+wTgPeCHtSEiNdN/kp3zECxG1Km9Oyyq+72c8VzdIfqtNhLfmh
         e03BOfR3hoBIJ8oSCiUSbqnwkfBrwMrxM+K/o8ZvhSik+V0dNwhF+5I+a6O1gIEcMnYX
         REswfYl3R8mxzZ4dKRPIYz6tkLw+Fz7KaQOxibKSoxcpcO+S3NLQjS7EGmsUxmDw2a6B
         W27GKCfxsHrv+Wm1mvtpZ3BmZsxffWoHQrPjI5Hu1D+7jvTM4dhA6iEovkwL7vsqPpRQ
         9G27TEJk937Gfr041p1Zf3zkZ+wtQe1Qcj2nsl2D97oEObA7+hbBmNglUItvtWjP+XMR
         zT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=APqBfV9LNU4GND6HkjG0xUfHrFEtSU5GaPvdAgxKciE=;
        fh=x42xa2ddfODkJ22lYvVD23HHJL6HjH+GL9vofmPupds=;
        b=ebVPXKjA97BZTWN+cfLvG7VnK0KWvEXr5TkAPEZh+7HqbcEbopha7k+Edlb9nohrZt
         D72N8UYwRBbrlPiJWYe3S+ddIOjxSHFUM5viSqfjQahi6bs9Di8nwv0nEdH9mlZ4QQny
         861dggrx6Un8SMxLdvrGFV59Xc1GdF9nTTUm++HXmI3lICitQuBWPuxzu2hCIGRzYxks
         WRqf7QtCRs5QTt0aSsCuJ9gYRhYG1RQedUnTabR0iMf7myfBtvxG4Xle5A3/3CJP0FAN
         BunEAODpTgRl0zWGP5vExXO/LbldokwMYEshrwoMuyk8AJTwu2vzhcYbyftxZQ0bTdH0
         OEBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792691105; x=1793295905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=APqBfV9LNU4GND6HkjG0xUfHrFEtSU5GaPvdAgxKciE=;
        b=Jk79UCuzD7gVBLcGTWKKQLgDDt+IVmaI1fYJ0ITsgrl9NJRF6iNar5dyt1oE6vz3iw
         qkbD3pW5D6aQfjrAx8XfWgC5tKKcDi42gxz6PnMtFxqVShjulqNUqU3Pfl1Wvn0CIiOq
         r1de1lI7n05LRxOX3xQUE4Wo96VcvkCnPsIKAT59SeAjmIq3G1jubQC3ZYqsr1LTaBs0
         Zu/6ppMCr8OEd3Zx7p6m+RQvK4Ho3QNDh/nBTZMoy9Z9R2ai8OfgxffPZEITdLmMgmbe
         YHnA1M61BAudotDadFJx8ZiwfxxXSuswwLXaxP7kbeW/M5DwfvPb9kLSrOV1jAYQfSN5
         WzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691105; x=1793295905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=APqBfV9LNU4GND6HkjG0xUfHrFEtSU5GaPvdAgxKciE=;
        b=lxOv2wg8MI03/vwZZ1ydKqAoN/di68SXgwn+4k8dcYdOEb/OuxcepaEnUxEIpZYk07
         30LDoBV+UVz94UHwMg+S+KDJtJB9yQkg82TSmQqgWDcdqr9XvfrvRYNMvfHXaWm9skJt
         xyvMel7iBmFl0fAQNnF5qfgMptjyKttGdgngozItutdHJY7Yb16i7ehxQ5eN0a9gDiAM
         pm1Mikc4wnZ9E+pD+j6vBpaBHDuR7RqUofop0OeGE0ohWyYGK2SgzoYMnfHqniooVcaK
         KnfPtzUcdIrXLHuOXf0iiv5KEYvU7FeTp0wblVKic7DDPhSS97/9DyeWzwGAYqygryCE
         rXqA==
X-Gm-Message-State: AFq9FYKLXU2vHinxxXAQ8zDkT2BSmb4IFCDQRkb1fIW53YbtY+5mv658
	NAkeaMkNespf+a5AsfLBa6/hovqlxHFV+8UjrBnJHVWlRmtfhEp0geFQ7yK40idC212GeRvdnBq
	xR+V9opqXUAA2IYWjWQGulwkW3YzBZMc99eQ1QqqsihFEvWaSFirTJ2hp61ncRYd8/Ld5PWQqKS
	arbeOcRIjHIpk2NokAhz/2KbJYsWc41C8clggSnTsjwis=
X-Gm-Gg: AYBFou1r9X866jOi+tYQHM6tDCHcjOKq4xeGSbsDY1BmcFpY9InWp/kCCjoa7xH689x
	xWMgCNGDz2KOFJyvd6nLkoT+AIIN7TBeB/84huL4QA4FW4whlkJMIN6sTxhGLX5zLuGWGEseeG3
	CHR1h45I5SiqahNpLkPH/QgKOKBU2uv4Tn6/zUqIOWKaAwJQQoqO8dtKmXfrc=
X-Received: by 2002:a05:690c:389:b0:8b0:e13c:284d with SMTP id 00721157ae682-8b133fbd7cemr32998967b3.49.1792691105261;
        Thu, 22 Oct 2026 10:45:05 -0700 (PDT)
X-Received: by 2002:a05:690c:389:b0:8b0:e13c:284d with SMTP id
 00721157ae682-8b133fbd7cemr32998797b3.49.1792691104754; Thu, 22 Oct 2026
 10:45:04 -0700 (PDT)
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Post: <mailto:linux-hexagon@vger.kernel.org>
List-Help: <mailto:linux-hexagon+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hexagon+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910003346.596593-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910003346.596593-1-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 12:44:27 -0500
X-Gm-Features: AclHuK_UTxDCfEh0T4SayHP0515y1fgb7-1zLmE3mF18BtMVwq9TnJmGuV3V4Dc
Message-ID: <CAJpW4SW9ZBbFzvhSdkvZVK7r5_ffwT8+EOXRL+c3H8c0fgnPRQ@mail.gmail.com>
Subject: Re: [PATCH v2] hexagon: add hwcap
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-hexagon@vger.kernel.org, marco.liebel@oss.qualcomm.com,
        pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX3J9B8t+p1ulO
 wJzlITCZpQmjESlMELmFVISlhm5qVsCnwuJKM1CX3rn5Vz+5LTylu9VERrFK2XfZMxZl+l4HrJP
 OHv8qUnQYrdLyB4lV3HAKaLEBT2U9ko=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada4ba1 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=QcnPQdyAuGesMr4gUY0A:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: Q0XL9xB8eXMH25mjs4A9sScTSgYpQG9y
X-Proofpoint-ORIG-GUID: Q0XL9xB8eXMH25mjs4A9sScTSgYpQG9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MCBTYWx0ZWRfX6mfNjwOVor7M
 rcG/jwHVPIJhzYBMI55lAy23H5is9v0N5OfTkDVHWPwh43sNax8ki8cyAdzwzk7RepSp+jmxA0s
 J2bz5CeRjcSzfW8aDsTT2Jg5hnx+aB1IlMEPvB6kJNTMuEJUjo+aU46ZFFdo/sN4a2EwukiS5j9
 LMdKICov1x8yaBjlcmzw1Ee4bCpPLWIjp//HyyH5i02wu8TLQFU8IUoGU+n9achpSshTcN7bbcP
 qubaxB8R1PpnzCzdnTUZDCK5nSIaKbPp0uv8MCoxFiwT9E/mc3f6+2+b0zcCpsmNu6HFzeW0jQr
 nKigJ3P3b0vK3cAYdy9+WqfgMjvufA8yDpkW0+A9O3N3uJkI0RYVLc7ZcLE2Ak3euHAAOEktP22
 lI8OqSviIdHHZ2xTk2E8EzF0BSw/u9s3sA5WN+yYIBgI0rW3sTvaOU2lYi9Y1odW4w44dybscDM
 F/0tHeGRgaPAUy9oweA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220070

LGTM


On Wed, Sep 9, 2026 at 7:33=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> Provide hwcap interface for userspace programs to discover the Hexagon CP=
U
> capabilities.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  arch/hexagon/include/asm/elf.h        |   3 +-
>  arch/hexagon/include/asm/hexagon_vm.h |  59 ++++++++++++++
>  arch/hexagon/include/asm/hwcap.h      |  25 ++++++
>  arch/hexagon/include/uapi/asm/hwcap.h |  60 ++++++++++++++
>  arch/hexagon/kernel/setup.c           | 109 ++++++++++++++++++++++++++
>  arch/hexagon/kernel/vm_ops.S          |   4 +
>  6 files changed, 259 insertions(+), 1 deletion(-)
>  create mode 100644 arch/hexagon/include/asm/hwcap.h
>  create mode 100644 arch/hexagon/include/uapi/asm/hwcap.h
>
> diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/el=
f.h
> index 5bfdd9b147fd..127e750613bd 100644
> --- a/arch/hexagon/include/asm/elf.h
> +++ b/arch/hexagon/include/asm/elf.h
> @@ -11,6 +11,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/user.h>
>  #include <linux/elf-em.h>
> +#include <asm/hwcap.h>
>
>  struct elf32_hdr;
>
> @@ -198,7 +199,7 @@ do {                                        \
>   * This yields a mask that user programs can use to figure out what
>   * instruction set this cpu supports.
>   */
> -#define ELF_HWCAP      (0)
> +#define ELF_HWCAP      (elf_hwcap)
>
>  /*
>   * This yields a string that ld.so will use to load implementation
> diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include=
/asm/hexagon_vm.h
> index 9aa2493fe786..f9cae71ad82f 100644
> --- a/arch/hexagon/include/asm/hexagon_vm.h
> +++ b/arch/hexagon/include/asm/hexagon_vm.h
> @@ -38,6 +38,7 @@
>  #define HVM_TRAP1_VMSETREGS            21
>  #define HVM_TRAP1_VMGETREGS            22
>  #define HVM_TRAP1_VMTIMEROP            24
> +#define HVM_TRAP1_VMGETINFO            26
>
>  #ifndef __ASSEMBLY__
>
> @@ -65,6 +66,63 @@ enum VM_INT_OPS {
>         hvmi_clear
>  };
>
> +enum VM_INFO_TYPE {
> +       vm_info_build_id,
> +       vm_info_boot_flags,
> +       vm_info_stlb,
> +       vm_info_syscfg,
> +       vm_info_livelock,
> +       vm_info_rev,
> +       vm_info_ssbase,
> +       vm_info_tlb_free,
> +       vm_info_tlb_size,
> +       vm_info_physaddr,
> +       vm_info_tcm_base,
> +       vm_info_l2mem_size,
> +       vm_info_tcm_size,
> +       vm_info_h2k_pgsize,
> +       vm_info_h2k_npages,
> +       vm_info_l2vic_base,
> +       vm_info_timer_base,
> +       vm_info_timer_int,
> +       vm_info_error,
> +       vm_info_hthreads,
> +       vm_info_l2tag_size,
> +       vm_info_l2cfg_base,
> +       vm_info_clade_base,
> +       vm_info_cfgbase,
> +       vm_info_hvx_vlength,
> +       vm_info_hmx_instances =3D 34,
> +};
> +
> +struct vm_rev {
> +       union {
> +               unsigned long raw;
> +               struct {
> +                       unsigned long isa:8;
> +                       unsigned long l2tags:4;
> +                       unsigned long l2size:4;
> +                       unsigned long layer:4;
> +                       unsigned long unused:4;
> +                       unsigned long metal:8;
> +               };
> +       };
> +};
> +
> +struct vm_boot_flags {
> +       union {
> +               unsigned long raw;
> +               struct {
> +                       unsigned long use_tcm:1;
> +                       unsigned long have_hvx:1;
> +                       unsigned long have_sample:1;
> +                       unsigned long ext_ok:1;
> +                       unsigned long have_dma:1;
> +                       unsigned long have_hmx:1;
> +               };
> +       };
> +};
> +
>  extern void _K_VM_event_vector(void);
>
>  void __vmrte(void);
> @@ -82,6 +140,7 @@ void __vmstop(void);
>  long __vmwait(void);
>  void __vmyield(void);
>  long __vmvpid(void);
> +unsigned long __vmgetinfo(unsigned long);
>
>  static inline long __vmcache_ickill(void)
>  {
> diff --git a/arch/hexagon/include/asm/hwcap.h b/arch/hexagon/include/asm/=
hwcap.h
> new file mode 100644
> index 000000000000..6bfbcec66d31
> --- /dev/null
> +++ b/arch/hexagon/include/asm/hwcap.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Hexagon hardware capability definitions
> + *
> + * Copyright Qualcomm Technologies, Inc. and its subsidiaries
> + */
> +
> +#ifndef __ASM_HEXAGON_HWCAP_H
> +#define __ASM_HEXAGON_HWCAP_H
> +
> +#include <uapi/asm/hwcap.h>
> +
> +/* Kernel-internal definitions: ISA versions are used directly from UAPI=
 */
> +
> +#ifndef __ASSEMBLER__
> +/*
> + * This yields a mask that user programs can use to figure out what
> + * instruction set this cpu supports.
> + */
> +#define ELF_HWCAP              (elf_hwcap)
> +
> +extern unsigned long elf_hwcap;
> +#endif
> +
> +#endif /* __ASM_HEXAGON_HWCAP_H */
> diff --git a/arch/hexagon/include/uapi/asm/hwcap.h b/arch/hexagon/include=
/uapi/asm/hwcap.h
> new file mode 100644
> index 000000000000..a58b9593169b
> --- /dev/null
> +++ b/arch/hexagon/include/uapi/asm/hwcap.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Hexagon hardware capability definitions - User API
> + *
> + * Copyright Qualcomm Technologies, Inc. and its subsidiaries
> + */
> +
> +#ifndef _UAPI__ASM_HEXAGON_HWCAP_H
> +#define _UAPI__ASM_HEXAGON_HWCAP_H
> +
> +/*
> + * HWCAP flags - for AT_HWCAP
> + *
> + * ISA Version Encoding:
> + * Bits 0-6 encode the ISA version as enumeration values
> + */
> +
> +/* ISA version encoding */
> +#define HWCAP_HEXAGON_ISA_MASK 0x7F    /* ISA version mask */
> +
> +/* ISA version enumeration values */
> +#define HWCAP_HEXAGON_ISA_V2   1       /* Hexagon V2 */
> +#define HWCAP_HEXAGON_ISA_V3   2       /* Hexagon V3 */
> +#define HWCAP_HEXAGON_ISA_V4   3       /* Hexagon V4 */
> +#define HWCAP_HEXAGON_ISA_V5   4       /* Hexagon V5 */
> +#define HWCAP_HEXAGON_ISA_V55  5       /* Hexagon V55 */
> +#define HWCAP_HEXAGON_ISA_V60  6       /* Hexagon V60 */
> +#define HWCAP_HEXAGON_ISA_V62  7       /* Hexagon V62 */
> +#define HWCAP_HEXAGON_ISA_V65  8       /* Hexagon V65 */
> +#define HWCAP_HEXAGON_ISA_V66  9       /* Hexagon V66 */
> +#define HWCAP_HEXAGON_ISA_V67  10      /* Hexagon V67 */
> +#define HWCAP_HEXAGON_ISA_V68  11      /* Hexagon V68 */
> +#define HWCAP_HEXAGON_ISA_V69  12      /* Hexagon V69 */
> +#define HWCAP_HEXAGON_ISA_V71  13      /* Hexagon V71 */
> +#define HWCAP_HEXAGON_ISA_V73  14      /* Hexagon V73 */
> +#define HWCAP_HEXAGON_ISA_V75  15      /* Hexagon V75 */
> +#define HWCAP_HEXAGON_ISA_V77  16      /* Hexagon V77 */
> +#define HWCAP_HEXAGON_ISA_V79  17      /* Hexagon V79 */
> +#define HWCAP_HEXAGON_ISA_V81  18      /* Hexagon V81 */
> +
> +/* Essential feature flags */
> +#define HWCAP_HEXAGON_HVX              (1 << 7)        /* HVX (Hexagon V=
ector eXtensions) */
> +#define HWCAP_HEXAGON_CABAC            (1 << 8)        /* CABAC accelera=
tion */
> +#define HWCAP_HEXAGON_HVX_LENGTH_128B  (1 << 9)        /* HVX 128-byte v=
ector length */
> +#define HWCAP_HEXAGON_HVX_IEEE_FP      (1 << 10)       /* HVX IEEE float=
ing point */
> +#define HWCAP_HEXAGON_AUDIO            (1 << 11)       /* Audio ISA exte=
nsions */
> +#define HWCAP_HEXAGON_HMX              (1 << 12)       /* HMX matrix ext=
ensions */
> +
> +/* Bits 13-31 reserved for future use */
> +
> +/* Utility macros for userspace applications */
> +#define HWCAP_HEXAGON_GET_ISA(hwcap)           ((hwcap) & HWCAP_HEXAGON_=
ISA_MASK)
> +#define HWCAP_HEXAGON_IS_ISA(hwcap, version)   (HWCAP_HEXAGON_GET_ISA(hw=
cap) =3D=3D (version))
> +#define HWCAP_HEXAGON_HAS_ISA(hwcap, version)  (HWCAP_HEXAGON_GET_ISA(hw=
cap) >=3D (version))
> +
> +/*
> + * HWCAP2 is not currently used by Hexagon.
> + */
> +
> +#endif /* _UAPI__ASM_HEXAGON_HWCAP_H */
> diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
> index 621674e86232..a0f51f247a9c 100644
> --- a/arch/hexagon/kernel/setup.c
> +++ b/arch/hexagon/kernel/setup.c
> @@ -20,6 +20,11 @@
>  #include <asm/hexagon_vm.h>
>  #include <asm/vm_mmu.h>
>  #include <asm/time.h>
> +#include <asm/hwcap.h>
> +
> +unsigned long elf_hwcap __read_mostly;
> +
> +EXPORT_SYMBOL_GPL(elf_hwcap);
>
>  char cmd_line[COMMAND_LINE_SIZE];
>  static char default_command_line[COMMAND_LINE_SIZE] __initdata =3D CONFI=
G_CMDLINE;
> @@ -31,6 +36,109 @@ void calibrate_delay(void)
>         loops_per_jiffy =3D thread_freq_mhz * 1000000 / HZ;
>  }
>
> +/*
> + * populate hardware capabilities using vmgetinfo
> + */
> +static void __init setup_hwcap(void)
> +{
> +       struct vm_rev rev;
> +       struct vm_boot_flags boot_flags;
> +       unsigned long hvx_vlength;
> +       unsigned long hmx_instances;
> +       unsigned int isa;
> +
> +       elf_hwcap =3D 0;
> +
> +       /* Get revision information for ISA version */
> +       rev.raw =3D __vmgetinfo(vm_info_rev);
> +       boot_flags.raw =3D __vmgetinfo(vm_info_boot_flags);
> +
> +       isa =3D ((rev.isa >> 4) & 0xf) * 10 + (rev.isa & 0xf);
> +
> +       switch (isa) {
> +       case 81:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V81;
> +               break;
> +       case 79:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V79;
> +               break;
> +       case 77:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V77;
> +               break;
> +       case 75:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V75;
> +               break;
> +       case 73:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V73;
> +               break;
> +       case 71:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V71;
> +               break;
> +       case 69:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V69;
> +               break;
> +       case 68:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V68;
> +               break;
> +       case 67:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V67;
> +               break;
> +       case 66:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V66;
> +               break;
> +       case 65:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V65;
> +               break;
> +       case 62:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V62;
> +               break;
> +       case 60:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V60;
> +               break;
> +       case 55:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V55;
> +               break;
> +       case 5:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V5;
> +               break;
> +       case 4:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V4;
> +               break;
> +       case 3:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V3;
> +               break;
> +       case 2:
> +               elf_hwcap |=3D HWCAP_HEXAGON_ISA_V2;
> +               break;
> +       default:
> +               /* Unknown ISA version - leave ISA field as 0 */
> +               break;
> +       }
> +
> +       /* Check for HVX support */
> +       hvx_vlength =3D __vmgetinfo(vm_info_hvx_vlength);
> +       if (hvx_vlength) {
> +               elf_hwcap |=3D HWCAP_HEXAGON_HVX;
> +
> +               if (hvx_vlength >=3D 128)
> +                       elf_hwcap |=3D HWCAP_HEXAGON_HVX_LENGTH_128B;
> +       }
> +
> +       hmx_instances =3D __vmgetinfo(vm_info_hmx_instances);
> +       if (boot_flags.have_hmx && hmx_instances && hmx_instances !=3D ~0=
UL)
> +               elf_hwcap |=3D HWCAP_HEXAGON_HMX;
> +
> +       printk(KERN_INFO "Hexagon hwcap: 0x%08lx (v%u%s%s%s%s%s%s)\n",
> +               elf_hwcap,
> +               isa,
> +               (elf_hwcap & HWCAP_HEXAGON_HVX) ? ", HVX" : "",
> +               (elf_hwcap & HWCAP_HEXAGON_HVX_LENGTH_128B) ? ", HVX-128B=
" : "",
> +               (elf_hwcap & HWCAP_HEXAGON_HVX_IEEE_FP) ? ", HVX-IEEE-FP"=
 : "",
> +               (elf_hwcap & HWCAP_HEXAGON_AUDIO) ? ", Audio" : "",
> +               (elf_hwcap & HWCAP_HEXAGON_CABAC) ? ", CABAC" : "",
> +               (elf_hwcap & HWCAP_HEXAGON_HMX) ? ", HMX" : "");
> +}
> +
>  /*
>   * setup_arch -  high level architectural setup routine
>   * @cmdline_p: pointer to pointer to command-line arguments
> @@ -55,6 +163,7 @@ void __init setup_arch(char **cmdline_p)
>
>         printk(KERN_INFO "PHYS_OFFSET=3D0x%08lx\n", PHYS_OFFSET);
>
> +       setup_hwcap();
>         /*
>          * Simulator has a few differences from the hardware.
>          * For now, check uninitialized-but-mapped memory
> diff --git a/arch/hexagon/kernel/vm_ops.S b/arch/hexagon/kernel/vm_ops.S
> index f61c04d485f6..7bf32c55e050 100644
> --- a/arch/hexagon/kernel/vm_ops.S
> +++ b/arch/hexagon/kernel/vm_ops.S
> @@ -25,6 +25,10 @@ ENTRY(__vmsetvec)
>         trap1(#HVM_TRAP1_VMSETVEC);
>         jumpr   R31;
>
> +ENTRY(__vmgetinfo)
> +       trap1(#HVM_TRAP1_VMGETINFO);
> +       jumpr   R31;
> +
>  ENTRY(__vmsetie)
>         trap1(#HVM_TRAP1_VMSETIE);
>         jumpr   R31;
> --
> 2.34.1
>
