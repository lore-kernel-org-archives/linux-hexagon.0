Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11D25F7A9
	for <linux-hexagon@vger.kernel.org>; Thu, 10 Sep 2026 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000433; cv=none; b=nvnsKp8qK+nyDwufK0hDZWrMa8Mzkd9miu39PMrnUmJJKC2qRdw9V4hdSACODWUlFw51VyW30g31gaNWXxnTjxy17j90WqcZRBkgbJjTqTNNw1D+L+TJ8nefp36QCFOd2+Pkw1Lb5cvi+j/MT0liXyihzxe3GZq4z/wtvD/JgqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000433; c=relaxed/simple;
	bh=dqaP76TQSigAl+EYYJuDGAiIJ64UlY4+39rap1vKMYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tpuMdF93vI5zD0N0LmP8GFQCdvepi58V1hjOrftX6V7qEq1OkeR04WoI8mY/3wYXSHLS7BmaKsRQAKyxSmEzYUn7FY39uXA8emHlXP5dbl1jUHmCLFJy3Thx24RGLHS3SLF/ZrP9qIN9U4SBd8UDrdVls7abXlcfmvERjb1n+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AbyfyXVm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gd+Y3YTE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AbyfyXVm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gd+Y3YTE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689M9UYn3584763
	for <linux-hexagon@vger.kernel.org>; Thu, 10 Sep 2026 00:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hgiHbv0B59GccMDRxpidMw
	NIL5xJAvchHzzhgNBo5Qw=; b=AbyfyXVmO8UyrJAoxaHSFDlHIZLjsd7Z89QOia
	Nx7IDHOfP5xWp3a3cYBPXdQUSWIZJ0ph4EaxYIbA8eh5gWjWMSANFAwwTZzDaiZr
	mJ8cGYBQq5oEMMCbKiUaV9FqSKp9/K3yk9PufNhn/mGFJYk6vMjwvWwn5AM8KeVs
	7qaMTUGTZMBjJZPJdkTgGQii8tEivEvasOuYO7te46rB1+XVNgrjYuQRkLhoqKmG
	1eaJe/NidJawv1eXOj3qpYS4zfAcj5WnZsAyq6Jyky/HfQUTK/ezi6xG4z87bQTv
	N2sLueoAreIY5pCdsqq3GsIdnShDtzcYMCN+6sXgSVNZvUMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg17se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Thu, 10 Sep 2026 00:33:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396638f9a18so6470180a91.2
        for <linux-hexagon@vger.kernel.org>; Wed, 09 Sep 2026 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789000429; x=1789605229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgiHbv0B59GccMDRxpidMwNIL5xJAvchHzzhgNBo5Qw=;
        b=Gd+Y3YTEKN3/sUEUmcvT0c9jxF/HRosl7pXup+Tn2I9G/D1E8HKPVBs5JsCYtEFUkQ
         sWmqb2iFohLiEt6eYdTn4twqdP/ef90IqSzqcrJpAh3u0V0lf4rlX2BIHCTI7S9HY7Hc
         TaTeUBr9vymz4frEMISKZzlhlKhJmAWEeI3RYXwvIEum/Fs6PobvRq/gChkBjr0URIDs
         P8AS9uozox+lR4WCoBsMaDA932wQ6Vj/tyWaQ02QbZas4lhIqYRtPrRtfNlx/baN4sGs
         njaNIhVEXCGLHSvCZXE8VLfgMe7YTMCa//kdSVf1XsVbxnBYZU+btTurqn1LuIAEIe4G
         Z8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789000429; x=1789605229;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgiHbv0B59GccMDRxpidMwNIL5xJAvchHzzhgNBo5Qw=;
        b=DrelBy7DSwna26aJVSR7bXv5Qre59/6eeOTpP/HIyy1UlML2lgsjnPy1VBtnrY6f75
         mVj5d1wjX22R/E92B3Oami/eTfH1veIVIex3Q39DU9UvJhOgOfxriwDLegEIVE7SeRES
         p2ETwbocBJf7OfkojabqfToP6FyyRqXUMNVx+5wBSDiwHpJuBOuXHu3CdUVfzILoQEWf
         eFhSPkhyk3TlXWbBxLh51G8oCPi7Euo09wz2whbGF4yNrDS9qHSwdC3tgHhDXAq0abl/
         SZMxWdaqq7fCDvz5X6BJq0nVVuE5glRHq85OOxD8MkQSaZE2yOs0BgZW4EJLnqyoxhfE
         baug==
X-Gm-Message-State: AFuF++mZBGlC2MRtC9HuNUoqplHrf+nEhe6lgL11V9dlOCgLSRj15dvZ
	4pDsk8Lui7vaIoFoNL7ClmaXIBMMkUOQYPqg+9pbnVd3+jgH+IPxLT5h40rGO2NM4dfY7hLiU8Z
	r3ludmLbQuRHqZSyFlrUwE8UKa3EI4LfeELYy5liW6693PJ1shVq8+CxJoibAY9NtnMtJuSBVoU
	2c
X-Gm-Gg: AYBFou0Sw62KnaodBkFVWZ9t0q9/fOaoDXpvOlMalPapnqmdKeEtbPY6qQeRm9FpMia
	O65u4St9fGsshBAEsGczO8cgNEt2LjH7J7ypjo1iBpVoT3DuVkz2TsVLwFyi6V/5CHFpV5ivsui
	U97RHNg8O7evMH996WvORw05BxxE8pXfbjhOHJ5jVnqNadIYwWJs3dRxbDft/hg6TVF6ZCQutzw
	2nsMZcAAtZFYBfvKa2uIBKqXv/dFjprQqYt6WoN3yWAOh7R425fun9eKdtPrOOGiEVxMXadSW2h
	QEL5/z6moLRgX8OEZgGMH0XMP1zQSUPgFXjgP6PZTzSMknsqnPhCCXO3Ozj28ouvspespabSPkB
	rhas3Ie4R4QtunPhgYeJdV1bW7F4QsaZrfVqV4Thq7AtAEVby
X-Received: by 2002:a17:90b:538c:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-39b26204a3emr59754138a91.13.1789000429112;
        Wed, 09 Sep 2026 17:33:49 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-39b26204a3emr59754085a91.13.1789000428594;
        Wed, 09 Sep 2026 17:33:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm63368172c88.2.2026.09.09.17.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 17:33:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: marco.liebel@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
        sid.manning@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2] hexagon: add hwcap
Date: Wed,  9 Sep 2026 17:33:46 -0700
Message-Id: <20260910003346.596593-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa1faee cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BWZwQctB77_qaonzoxcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX/e8gSzwjT5z+
 1AqM93GPP/I2dBFhFc2m5i/hA6biK/6ldJS7HSuWXCZH8D1Vwk7yhHKTgwXQf9dT0F6oHW25D2e
 mS/lvG4Cg2T9At4o/WqEPcO3mYJusaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDAwNSBTYWx0ZWRfX9PMQ82mtJ9C8
 fg8DyTtOUYOt38gsqThYrZhF2FOeTi4fyYEZ/omOmO7YF/wl6CAjTnG9WrGBZfx2mMlMsfugSxE
 QC7Pr3OM3SQkgOSmxE/Jyk3xPEibLq2wswrZOpMprKBC3B5OYL23oQOVFnpXi40dfDFGLzHXy0w
 EP+U45Oy8ZT8s+WEBtCOocHYz+rDfatXZ2kx84VupCsFMDF2bnxEHu5HSTcasbBR1yW/ur7r+Gt
 0xN21A056+6p8OMGFx8hCETPGRLKktKzyanR7a4zxWDJbrZN/1yZD8HtpekYOTsyb0E9kuPkXUc
 2dgpogxOe5rJ9vmwpRZm86cycb7GolbRaTZgJrFBdICSdgaxeHk+fajupXoz8+10F0wHmiUvmEm
 ts3jkylzucUHWjXCDZsyrbUdK/Z5R97uX1yG32jT+OCpr1m7Eo4tFx/+r3BM6JGYSd+ikgcF8+I
 Dd5JUhpOWPjkVBBcH/A==
X-Proofpoint-GUID: 4EYRBJaELS13q1ZzS60xA8jPT5R8WPAp
X-Proofpoint-ORIG-GUID: 4EYRBJaELS13q1ZzS60xA8jPT5R8WPAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-09_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100005

Provide hwcap interface for userspace programs to discover the Hexagon CPU
capabilities.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/include/asm/elf.h        |   3 +-
 arch/hexagon/include/asm/hexagon_vm.h |  59 ++++++++++++++
 arch/hexagon/include/asm/hwcap.h      |  25 ++++++
 arch/hexagon/include/uapi/asm/hwcap.h |  60 ++++++++++++++
 arch/hexagon/kernel/setup.c           | 109 ++++++++++++++++++++++++++
 arch/hexagon/kernel/vm_ops.S          |   4 +
 6 files changed, 259 insertions(+), 1 deletion(-)
 create mode 100644 arch/hexagon/include/asm/hwcap.h
 create mode 100644 arch/hexagon/include/uapi/asm/hwcap.h

diff --git a/arch/hexagon/include/asm/elf.h b/arch/hexagon/include/asm/elf.h
index 5bfdd9b147fd..127e750613bd 100644
--- a/arch/hexagon/include/asm/elf.h
+++ b/arch/hexagon/include/asm/elf.h
@@ -11,6 +11,7 @@
 #include <asm/ptrace.h>
 #include <asm/user.h>
 #include <linux/elf-em.h>
+#include <asm/hwcap.h>
 
 struct elf32_hdr;
 
@@ -198,7 +199,7 @@ do {					\
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
-#define ELF_HWCAP	(0)
+#define ELF_HWCAP	(elf_hwcap)
 
 /*
  * This yields a string that ld.so will use to load implementation
diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 9aa2493fe786..f9cae71ad82f 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -38,6 +38,7 @@
 #define HVM_TRAP1_VMSETREGS		21
 #define HVM_TRAP1_VMGETREGS		22
 #define HVM_TRAP1_VMTIMEROP		24
+#define HVM_TRAP1_VMGETINFO		26
 
 #ifndef __ASSEMBLY__
 
@@ -65,6 +66,63 @@ enum VM_INT_OPS {
 	hvmi_clear
 };
 
+enum VM_INFO_TYPE {
+	vm_info_build_id,
+	vm_info_boot_flags,
+	vm_info_stlb,
+	vm_info_syscfg,
+	vm_info_livelock,
+	vm_info_rev,
+	vm_info_ssbase,
+	vm_info_tlb_free,
+	vm_info_tlb_size,
+	vm_info_physaddr,
+	vm_info_tcm_base,
+	vm_info_l2mem_size,
+	vm_info_tcm_size,
+	vm_info_h2k_pgsize,
+	vm_info_h2k_npages,
+	vm_info_l2vic_base,
+	vm_info_timer_base,
+	vm_info_timer_int,
+	vm_info_error,
+	vm_info_hthreads,
+	vm_info_l2tag_size,
+	vm_info_l2cfg_base,
+	vm_info_clade_base,
+	vm_info_cfgbase,
+	vm_info_hvx_vlength,
+	vm_info_hmx_instances = 34,
+};
+
+struct vm_rev {
+	union {
+		unsigned long raw;
+		struct {
+			unsigned long isa:8;
+			unsigned long l2tags:4;
+			unsigned long l2size:4;
+			unsigned long layer:4;
+			unsigned long unused:4;
+			unsigned long metal:8;
+		};
+	};
+};
+
+struct vm_boot_flags {
+	union {
+		unsigned long raw;
+		struct {
+			unsigned long use_tcm:1;
+			unsigned long have_hvx:1;
+			unsigned long have_sample:1;
+			unsigned long ext_ok:1;
+			unsigned long have_dma:1;
+			unsigned long have_hmx:1;
+		};
+	};
+};
+
 extern void _K_VM_event_vector(void);
 
 void __vmrte(void);
@@ -82,6 +140,7 @@ void __vmstop(void);
 long __vmwait(void);
 void __vmyield(void);
 long __vmvpid(void);
+unsigned long __vmgetinfo(unsigned long);
 
 static inline long __vmcache_ickill(void)
 {
diff --git a/arch/hexagon/include/asm/hwcap.h b/arch/hexagon/include/asm/hwcap.h
new file mode 100644
index 000000000000..6bfbcec66d31
--- /dev/null
+++ b/arch/hexagon/include/asm/hwcap.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Hexagon hardware capability definitions
+ *
+ * Copyright Qualcomm Technologies, Inc. and its subsidiaries
+ */
+
+#ifndef __ASM_HEXAGON_HWCAP_H
+#define __ASM_HEXAGON_HWCAP_H
+
+#include <uapi/asm/hwcap.h>
+
+/* Kernel-internal definitions: ISA versions are used directly from UAPI */
+
+#ifndef __ASSEMBLER__
+/*
+ * This yields a mask that user programs can use to figure out what
+ * instruction set this cpu supports.
+ */
+#define ELF_HWCAP		(elf_hwcap)
+
+extern unsigned long elf_hwcap;
+#endif
+
+#endif /* __ASM_HEXAGON_HWCAP_H */
diff --git a/arch/hexagon/include/uapi/asm/hwcap.h b/arch/hexagon/include/uapi/asm/hwcap.h
new file mode 100644
index 000000000000..a58b9593169b
--- /dev/null
+++ b/arch/hexagon/include/uapi/asm/hwcap.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Hexagon hardware capability definitions - User API
+ *
+ * Copyright Qualcomm Technologies, Inc. and its subsidiaries
+ */
+
+#ifndef _UAPI__ASM_HEXAGON_HWCAP_H
+#define _UAPI__ASM_HEXAGON_HWCAP_H
+
+/*
+ * HWCAP flags - for AT_HWCAP
+ *
+ * ISA Version Encoding:
+ * Bits 0-6 encode the ISA version as enumeration values
+ */
+
+/* ISA version encoding */
+#define HWCAP_HEXAGON_ISA_MASK	0x7F	/* ISA version mask */
+
+/* ISA version enumeration values */
+#define HWCAP_HEXAGON_ISA_V2	1	/* Hexagon V2 */
+#define HWCAP_HEXAGON_ISA_V3	2	/* Hexagon V3 */
+#define HWCAP_HEXAGON_ISA_V4	3	/* Hexagon V4 */
+#define HWCAP_HEXAGON_ISA_V5	4	/* Hexagon V5 */
+#define HWCAP_HEXAGON_ISA_V55	5	/* Hexagon V55 */
+#define HWCAP_HEXAGON_ISA_V60	6	/* Hexagon V60 */
+#define HWCAP_HEXAGON_ISA_V62	7	/* Hexagon V62 */
+#define HWCAP_HEXAGON_ISA_V65	8	/* Hexagon V65 */
+#define HWCAP_HEXAGON_ISA_V66	9	/* Hexagon V66 */
+#define HWCAP_HEXAGON_ISA_V67	10	/* Hexagon V67 */
+#define HWCAP_HEXAGON_ISA_V68	11	/* Hexagon V68 */
+#define HWCAP_HEXAGON_ISA_V69	12	/* Hexagon V69 */
+#define HWCAP_HEXAGON_ISA_V71	13	/* Hexagon V71 */
+#define HWCAP_HEXAGON_ISA_V73	14	/* Hexagon V73 */
+#define HWCAP_HEXAGON_ISA_V75	15	/* Hexagon V75 */
+#define HWCAP_HEXAGON_ISA_V77	16	/* Hexagon V77 */
+#define HWCAP_HEXAGON_ISA_V79	17	/* Hexagon V79 */
+#define HWCAP_HEXAGON_ISA_V81	18	/* Hexagon V81 */
+
+/* Essential feature flags */
+#define HWCAP_HEXAGON_HVX		(1 << 7)	/* HVX (Hexagon Vector eXtensions) */
+#define HWCAP_HEXAGON_CABAC		(1 << 8)	/* CABAC acceleration */
+#define HWCAP_HEXAGON_HVX_LENGTH_128B	(1 << 9)	/* HVX 128-byte vector length */
+#define HWCAP_HEXAGON_HVX_IEEE_FP	(1 << 10)	/* HVX IEEE floating point */
+#define HWCAP_HEXAGON_AUDIO		(1 << 11)	/* Audio ISA extensions */
+#define HWCAP_HEXAGON_HMX		(1 << 12)	/* HMX matrix extensions */
+
+/* Bits 13-31 reserved for future use */
+
+/* Utility macros for userspace applications */
+#define HWCAP_HEXAGON_GET_ISA(hwcap)		((hwcap) & HWCAP_HEXAGON_ISA_MASK)
+#define HWCAP_HEXAGON_IS_ISA(hwcap, version)	(HWCAP_HEXAGON_GET_ISA(hwcap) == (version))
+#define HWCAP_HEXAGON_HAS_ISA(hwcap, version)	(HWCAP_HEXAGON_GET_ISA(hwcap) >= (version))
+
+/*
+ * HWCAP2 is not currently used by Hexagon.
+ */
+
+#endif /* _UAPI__ASM_HEXAGON_HWCAP_H */
diff --git a/arch/hexagon/kernel/setup.c b/arch/hexagon/kernel/setup.c
index 621674e86232..a0f51f247a9c 100644
--- a/arch/hexagon/kernel/setup.c
+++ b/arch/hexagon/kernel/setup.c
@@ -20,6 +20,11 @@
 #include <asm/hexagon_vm.h>
 #include <asm/vm_mmu.h>
 #include <asm/time.h>
+#include <asm/hwcap.h>
+
+unsigned long elf_hwcap __read_mostly;
+
+EXPORT_SYMBOL_GPL(elf_hwcap);
 
 char cmd_line[COMMAND_LINE_SIZE];
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
@@ -31,6 +36,109 @@ void calibrate_delay(void)
 	loops_per_jiffy = thread_freq_mhz * 1000000 / HZ;
 }
 
+/*
+ * populate hardware capabilities using vmgetinfo
+ */
+static void __init setup_hwcap(void)
+{
+	struct vm_rev rev;
+	struct vm_boot_flags boot_flags;
+	unsigned long hvx_vlength;
+	unsigned long hmx_instances;
+	unsigned int isa;
+
+	elf_hwcap = 0;
+
+	/* Get revision information for ISA version */
+	rev.raw = __vmgetinfo(vm_info_rev);
+	boot_flags.raw = __vmgetinfo(vm_info_boot_flags);
+
+	isa = ((rev.isa >> 4) & 0xf) * 10 + (rev.isa & 0xf);
+
+	switch (isa) {
+	case 81:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V81;
+		break;
+	case 79:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V79;
+		break;
+	case 77:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V77;
+		break;
+	case 75:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V75;
+		break;
+	case 73:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V73;
+		break;
+	case 71:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V71;
+		break;
+	case 69:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V69;
+		break;
+	case 68:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V68;
+		break;
+	case 67:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V67;
+		break;
+	case 66:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V66;
+		break;
+	case 65:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V65;
+		break;
+	case 62:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V62;
+		break;
+	case 60:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V60;
+		break;
+	case 55:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V55;
+		break;
+	case 5:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V5;
+		break;
+	case 4:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V4;
+		break;
+	case 3:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V3;
+		break;
+	case 2:
+		elf_hwcap |= HWCAP_HEXAGON_ISA_V2;
+		break;
+	default:
+		/* Unknown ISA version - leave ISA field as 0 */
+		break;
+	}
+
+	/* Check for HVX support */
+	hvx_vlength = __vmgetinfo(vm_info_hvx_vlength);
+	if (hvx_vlength) {
+		elf_hwcap |= HWCAP_HEXAGON_HVX;
+
+		if (hvx_vlength >= 128)
+			elf_hwcap |= HWCAP_HEXAGON_HVX_LENGTH_128B;
+	}
+
+	hmx_instances = __vmgetinfo(vm_info_hmx_instances);
+	if (boot_flags.have_hmx && hmx_instances && hmx_instances != ~0UL)
+		elf_hwcap |= HWCAP_HEXAGON_HMX;
+
+	printk(KERN_INFO "Hexagon hwcap: 0x%08lx (v%u%s%s%s%s%s%s)\n",
+		elf_hwcap,
+		isa,
+		(elf_hwcap & HWCAP_HEXAGON_HVX) ? ", HVX" : "",
+		(elf_hwcap & HWCAP_HEXAGON_HVX_LENGTH_128B) ? ", HVX-128B" : "",
+		(elf_hwcap & HWCAP_HEXAGON_HVX_IEEE_FP) ? ", HVX-IEEE-FP" : "",
+		(elf_hwcap & HWCAP_HEXAGON_AUDIO) ? ", Audio" : "",
+		(elf_hwcap & HWCAP_HEXAGON_CABAC) ? ", CABAC" : "",
+		(elf_hwcap & HWCAP_HEXAGON_HMX) ? ", HMX" : "");
+}
+
 /*
  * setup_arch -  high level architectural setup routine
  * @cmdline_p: pointer to pointer to command-line arguments
@@ -55,6 +163,7 @@ void __init setup_arch(char **cmdline_p)
 
 	printk(KERN_INFO "PHYS_OFFSET=0x%08lx\n", PHYS_OFFSET);
 
+	setup_hwcap();
 	/*
 	 * Simulator has a few differences from the hardware.
 	 * For now, check uninitialized-but-mapped memory
diff --git a/arch/hexagon/kernel/vm_ops.S b/arch/hexagon/kernel/vm_ops.S
index f61c04d485f6..7bf32c55e050 100644
--- a/arch/hexagon/kernel/vm_ops.S
+++ b/arch/hexagon/kernel/vm_ops.S
@@ -25,6 +25,10 @@ ENTRY(__vmsetvec)
 	trap1(#HVM_TRAP1_VMSETVEC);
 	jumpr	R31;
 
+ENTRY(__vmgetinfo)
+	trap1(#HVM_TRAP1_VMGETINFO);
+	jumpr	R31;
+
 ENTRY(__vmsetie)
 	trap1(#HVM_TRAP1_VMSETIE);
 	jumpr	R31;
-- 
2.34.1

