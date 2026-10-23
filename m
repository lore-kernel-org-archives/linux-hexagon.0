Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764871;
	b=xlei4QupimndqVMHN/2s7W5xGCmWuY+n/1iwpA6afs+Vi1bCg0gGz8BJA3qYsJGVo1qm
	 aq6J78FGe0sU/yjVQ4cqLELsLQY4+NBWUCoWEjvR5JdRmTpoGxHrXYErp/a9wdoWjwKun
	 Hl9fxBjDSAJoXC7/V2hwbF70kypBeWvLYsb6mO1scUgVTNtemQ3RTSeDgL8U6Q2ciuvOR
	 TtHcY4PZ5I0PVz4OSwmTxD5ax1AkFFDZrQ9xsdANOwMHxTtMm1DJoXYwk+O2cmlpmXLl8
	 xW6IdXD0jvahFrXOcd0Ewo9GxcgqSzeU4LinG9Xe4Pu0pK/Bwlv+CCnJWk6zaQo1fOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764871;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EZWdBRoJNt+TK7KYOxyc2ZJo59OCAz+KL2vb9KPYZYI=;
	b=kPU8w61WVBEEuQMbJx4fXsk4c/MCBl4y+vJZrICQiV8KliugQ/5jpy43OpPCE4r93BZq
	 fmf1kjcF1s7q4ZkYJO8rAiyZx87zDPWUbE0fUxFSARTJUL+DWZjrRxTJDIjNX3RrQz7E8
	 N2wS6Iz+qe2BE0NBCazEyzeKL6hmCnbM5KeTRiGhEnH8ZMs+F+52FQc8m+UpbmKIKPSm7
	 38b7B8CgopUu3KRCB1B9dZ3QPbYoEHvvgnc9oPaMBuxyFyk6/ldU94m1zJSk2GjU/M6C9
	 HJ33V+ugpN3ytY2rFJWnWsmMclNqcu4VIWaLAbfbNtY9tzMEqYREYhaiUv5mKnLOiQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IKhj5YIi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TAmDqB3m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F832606A31A
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F832606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IKhj5YIi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TAmDqB3m
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6riw1492226
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 14:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZWdBRoJNt+TK7KYOxyc2ZJo59OCAz+KL2vb9KPYZYI=; b=IKhj5YIiT88n6M/H
	IV0N6pBaRtm8lBiWYChnCxHvUOZPZM0iysnai6X4Ssyx6OQcir+8YK9Z0P0f8L1C
	C4Fc94pWUii+sW9A2kzawx8ZDnxk1IExt28ENRE7+wbsB219ui1s7ee+s4trNJE6
	k6fq7VZIp0JequK0sGHzYPsEe8KbzeO5Q9ddGbT7IVFyqjf2EPdBqsR5+4nkk8Mt
	7r5+UrBd4S5vcgGblI5U8VkOl+NwcIaKZipkm6S/rChnSvxBuX8/bxaxjcVPILhU
	h7wApq4EyzSVm2PuFkND84/TZ6sGqC39rS1qcyMGVmvusxmM2vr+Dvlrj38gkGo1
	32Pjhg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmaug78-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 14:14:30 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0d978e4faso15539547b3.0
        for <linux-hexagon@vger.kernel.org>; Fri, 23 Oct 2026 07:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764869; cv=none;
        d=google.com; s=arc-20260327;
        b=TWoqC9bIUna4Hkd3e1GJdLzFgLEisBzTFJK46n+zPxrQxVH2PeijJ4hrmuH2kHRhEo
         T7ZL7y25mfVxIInHbumGJSoJ0ispW5y3UlF8G6SXW2HTGjvYjAx/Tqx3QZlryIHJoyFk
         r3Z9GSYvtZadLnLU+c2NMXPPRRT3rEmg9K5f5OIBmkECFYv3PKqi52VBHum1+Om8JiA+
         8AQiBaAlROp8WpEbQO3YYEVQ5iBlHFOEiB/6q14cNr4zhUB8xSqp2rnsTlt5Mt09ci9U
         y7W6+ZZrc+u2q4R+P719L424MZUpkqFULCNK6U/WKo377gkQWaogx8XzPXRK+ZSasbkL
         /3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZWdBRoJNt+TK7KYOxyc2ZJo59OCAz+KL2vb9KPYZYI=;
        fh=x42xa2ddfODkJ22lYvVD23HHJL6HjH+GL9vofmPupds=;
        b=lODoCfDDSeI2m1lcmJ36Pf1Zz4bi84dgwzCJGvcaXra2/GSMjy8/g9oc8yTxXbHzWe
         DyibYuEm22f2Ki2Xn/8a0nPenJD7DH1NXgndpiyLw3nyDmwhTfTcCtD/s4KPx2DeOiN2
         AqegBovejzZJTIUN4x8+cX2SI0Wwel9XQFOh668UN2cAnjxgSW7p92INcpVzuTaAmN81
         J5jw4WcjrhYm2Ess7Yps8zdajfPk3mgBgtGDshF2Ih7iTjOP8VzquWwSZDWzdaz3RZiV
         kXPQ7wAfEWn+oVS5cRpsyEphloPEwAEPENQXqKLf2rQ3tdP7JvbzSgi0mSVpQzA85DxS
         CJ/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792764869; x=1793369669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZWdBRoJNt+TK7KYOxyc2ZJo59OCAz+KL2vb9KPYZYI=;
        b=TAmDqB3m2DaUn+wo2XcY8J/1ELfR57thRoNRxXf+uUQIMsSLctrMBXfcu0TZcWHtKi
         x3VtqjH8kg/Vas74WrbjUfAEI0zum65GDFhiDBGyM+nS9AinzOd/LySvRDqqATi62KTc
         SB/pvaS369hfKzKz3jIhjMPCMN+zt/giXtldV9aoRsJAiCIKSJF7Yo48DQ6dO11suHyG
         uNF5EYu0XjM4mT6oCmw0huCWd5UeJqFAPRKQcz62YtOoQp9fAfbzg+egacSRCE8rzHlM
         3vR0NKwJDRpA/iorzTxMCEXJ6EVy82sQ/j7VNk36TW4i70c/M01iNW6bxdH0if5u30Rj
         4IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764869; x=1793369669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZWdBRoJNt+TK7KYOxyc2ZJo59OCAz+KL2vb9KPYZYI=;
        b=wbhnixsSjQ6SK3WSzAblFaU1pzxKwza7W/9ARjas3/ChlUOEJo6L/SQdQDl20GsS8T
         lmfDrBRnCjAgV65UJWGBdCQQjUxwF581JiReNJpw3W6gHyJ8orQpRgEOr9S+8Fv1+BNw
         G4dM2M7dU8pi/ZastAWUWVzPlFZ137Ebrfj+usurXMEbzSNdNfN0VoWZM9KcnzRMBiHC
         oxznQrl/AthHAOYRL9RdKWkOZ3JFt0gJlH7nH0o4p+lURriH8SnbjXKNtlnS/xhfgpkd
         7g4SIkAZ4p+75TFFQhrppHUJeHt92E8Mqnd4Li67WjPZ0bS8BoaztuB2H3QEoodM17SP
         k8Lw==
X-Gm-Message-State: AFq9FYJgqd63aTtEIckwZrMXgq22KaYZ1t5IdAKchzat4wKDCgI2QIfi
	S3GY7qnTllolGwLMkCfoRX/LwpEjnw87NQ/OgSGEaJx44wrakb5mBJi8ZS3hsTnv52ZAPSOhMw3
	tQcXefz8IMwjHOWdl7/6ajBi84HIltU+FvHg9/aEMZ1vaqPK+W9M33dqG/8PjtemLsFLVEgkyql
	jtkgmQ00flvF4OuiUa8n0Euf2AxYzi0HffnKJPwNPVJ+4=
X-Gm-Gg: AYBFou3b/89T/b9e+HjxIWfOEAhUwZJZENm7Xo29mgXJS5njSiU0DYTTRcUN/nfBDyu
	vf2KirCu9sqSL/O2I0V4w1GfouYxGffSLzJIJTi7duBthVkpbsQ3rVBMk1XlZv8pYroEcQMk3js
	hHFSmbib6LtbPkpBjodqC2A9Mf3Y5IWW1lfwS3ay2LrsjPv2K9VFx/zkmZf9k=
X-Received: by 2002:a05:690c:ec9:b0:897:73ed:dd25 with SMTP id 00721157ae682-8b157d24754mr17254187b3.27.1792764869385;
        Fri, 23 Oct 2026 07:14:29 -0700 (PDT)
X-Received: by 2002:a05:690c:ec9:b0:897:73ed:dd25 with SMTP id
 00721157ae682-8b157d24754mr17253947b3.27.1792764868771; Fri, 23 Oct 2026
 07:14:28 -0700 (PDT)
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
Date: Fri, 23 Oct 2026 09:13:52 -0500
X-Gm-Features: AclHuK91FBv94ggROGjbzWTLQHV8o2CehoWAlIZBvgOall9gkytTsbRTMGhK6oQ
Message-ID: <CAJpW4SWKueOt7-czXkFa-ff=7z+q82Jea5Ks72++aS1=swf8=Q@mail.gmail.com>
Subject: Re: [PATCH v2] hexagon: add hwcap
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: linux-hexagon@vger.kernel.org, marco.liebel@oss.qualcomm.com,
        pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6adb6bc6 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=QcnPQdyAuGesMr4gUY0A:9
 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfX5JDv8f7GA6VM
 8dfPUDH5c63Glm5AE/x4MD4udd1cDcMk3ys8+2oJWb9z8lcqvLu2SSgRIps7OkiKMD2ObsUaNoY
 k1d6Zq0HAYkfM/v5xbEUcHm5LW5BxHU=
X-Proofpoint-GUID: YVPL_zUwjPVI3D4yfI6lWFlrEKqwu0-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfXwqxQgvNN7Vna
 WH5ZaWrXNHQwkQrskjUpqY93vEGVNMGY7JViAEeB4XZuYFA1QGXyskL/RMwseYIw/dBRKwVx7K+
 OoKYKI/O4QdXav71uHxKSgxUUwamKlTsoGiQ/wwM6qG20TUUsIpmX/2o8v7hZxKmhZa+pL/F1Pq
 16sSM7mvHQF9/FUXlLVjBGb0mz1fPANUljCz4No0OBrZ4HtKbO6d7W4uEKWLQloWdftzxX/RuRv
 Z5yLQ2NRjqbh8eyVF9X5RHXlkxsaP5FQsaxiEiCv8Jbt2OC8q4Ep9TFJbXyqhFD4RyFkhPpCU8o
 qN2hgGw98YiUb4sGSIdFo/2QspKKd7P5mg+4sursxw44NvQMy29rrDcrM1ZTdvmnYI34kVI0CHd
 1ZtTGby8GQKRWdCqpqH3wkCYo8pX7S5Z1212vn7tUFT82xlLh/8OmeCI/uwDeJZ/xevEf+e43gD
 G6sUwAGTnVM1zq7qMrw==
X-Proofpoint-ORIG-GUID: YVPL_zUwjPVI3D4yfI6lWFlrEKqwu0-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230055

LGTM
Reviewed-by: Sid Manning <sid.manning@oss.qualcomm.com>

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
