Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718641A8F
	for <linux-hexagon@vger.kernel.org>; Mon,  7 Sep 2026 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788739677; cv=none; b=u5tQxz0SVIVFdkP2LrVZmLS4AL1Cu4lFtUC2X909RQrzJn1UZ/p+4Sx9GpoEE7GzhQTdCUGlN4jbgdPYHDhy5xL4k5pvnsXTsIvLUMh/Xm/7jm4t5J/lgmeDUMxAdpOd6yRCoE+j7qe5r7edCJjAR2tdSKTRNkt8okAH/5f9l28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788739677; c=relaxed/simple;
	bh=ad2YXmLt+Q8UXngZdys2T9kLcqItPD3lvSyL3RSsssI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EmSAKvye++33IVggc4g575Q6nAMKOX6Vbhy1oqCtVOuRZ/1s3F2d86PbI+ynm6lAaZ9t15hCGyGXjjv6vjyjr605SWXVpRIi/lwvvToQE5phpVuJqrUMWkcUCv/nhoE1a/g+VE0FPVTk/eHveZb2I+IIsre0gzcjBexiNeNKNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTwNGl4l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G1TPMQ7Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTwNGl4l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G1TPMQ7Z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 686L9Xnm1574116
	for <linux-hexagon@vger.kernel.org>; Mon, 7 Sep 2026 00:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vg2op0LaHVLMQqaNOGefd4
	tKXyfWqA1Sng97pcjmySo=; b=WTwNGl4l/xWv8S/hLbMcuaTB6piDTmUKTK3sCz
	QVbg/52cW2IdqKdCGi5RPhxbSrpavRVUiYhUgqWyhYIe07F+OLUrIVWHBgPqe2TW
	eWrDfCx3MEjSYssfb5aGgdWpY/GrcGPeHUllE1tQy7Ir1AajZD0woWcszkkvPUt9
	k6335UVgFUhGl/J4tNwLbnejJBUGQodMsam+PkSLTM7bHuQ0xjg05FzKzkKJEIGS
	7rnTVZ4vFjL5jXC4+7SHKj7FPbUBNOlnqMrEeV9HVsyiI1dLn9/ssqU97MJLZsxD
	COUSpqjsb+E166tISGIWS5M05c1zTFjttNKiuoT6JG4SZJKw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuemdj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hexagon@vger.kernel.org>; Mon, 07 Sep 2026 00:07:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso755492a12.1
        for <linux-hexagon@vger.kernel.org>; Sun, 06 Sep 2026 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788739674; x=1789344474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vg2op0LaHVLMQqaNOGefd4tKXyfWqA1Sng97pcjmySo=;
        b=G1TPMQ7Z0wlddFp/cWH8sX/olZQ+4CAxJWvLQOMpq1sCqPLXzEfaYACzGmIkEN817u
         ueGHbBmOgM1c1LKMUqtGfjVl020OvO/VX/2lv+xUSNXGqMUhgmhzPbTkWF+IsaaDrs8Q
         DBfY+W//e3WWfryAxWYaN56qyC+58QgQPjuhBj4AuBcp8qZB2DDRl9z+CEBcj9ZUit3t
         v9ipY1Y2zTOrM03JNkHnH5hmC0zCCu15UbuUUWEnbPquGxxFyy3ZwN+T6Qzf9Fn0LrO/
         zsMgSDKXWK2PFNEUlBI+rRI+4DG+9mhRNoa0YLTecFcE8wz0YrfoH9DU/bpP0f7dI7lx
         snzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788739674; x=1789344474;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vg2op0LaHVLMQqaNOGefd4tKXyfWqA1Sng97pcjmySo=;
        b=FTd6DADH+TfbOrb/0uPzV5Qyvcsxu0BHRQzsYapDGn8oGq1WKStObQoi+W+3PfsE5q
         JJxFeeIdHy56GkV7dBELZ55YFgP1V5n7yhFN4ho9W1DWTGr5hUoZE22OP6mFwO+0MGVe
         KhD3FhtGNqJvmoBPcrPPsCAnq0ppSOfUOMpm32KOs23jVeL7VD7zB9lIiF6v7HmF1XKM
         SO2gbyIgSqzqfiZj28b/xqkGR2QvDosnuCG8NO04JOtLcv1NcFMhnvATocruDPc01WKb
         pcsxqr17WmifGlk8XncDEOleHne/hlwU/8Pz4zJafPguL7I1x4/o/qCbK9Aeznl3IZOU
         mc0Q==
X-Gm-Message-State: AFuF++ldSbhmagIAqT76r/pjk4dLw20GrhkopTBxbI2WPxj3mndFfHRX
	8zzN8IBT35BdktbTD0OAwzRMohJhGF7AU7n1CKvOA5XoSXqUoM2yDcsiEnlgLSCfNIz7wS1x37P
	KWvdNfPSIsjE4IOZGxeb/fP7WCLuL1CttPMQ7t6kPXv0qN4pzAo3/WdUd7eLclx0NFwim5Ycepg
	JT
X-Gm-Gg: AYBFou1tDXdhN9SxHjK99tLoeQo9V+t/Iv5IxkR98IGhNET8/20qg6MlO4oa0bXVV1i
	Qnrupkg7Av+hfC2n3zs4VGbmMurE1RsxpcGvqbe3736cHf+ugEGXzhEtQGJhHPHr6T9Uuniv2ua
	MUAOlfkRVeeKNAu964HpB/CP+2UJCdBmV7sz35CPydy06qE4Ip94sE2UKH9k0FDDj8BdL5MRMuX
	XB3e1lvSFfdaBsSESi/4gqHeiu1GTamLXPgi9dSPWDJnOApsXlQflYEa5yAWCic4BWO+6eaktXi
	mDC5N3oCMXHa991LweZ4Ds3G6eSnMQ/LxaWbyq2/pLb1E3fpzqYx7oDed3qWzVOv+AClWLMQexL
	W6a6dItbtt9cck7tan9jt6H9xxlGk8UE861RV8qBamx+lCCRn
X-Received: by 2002:a05:6300:6710:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3da3a15bfc3mr30744636637.23.1788739673929;
        Sun, 06 Sep 2026 17:07:53 -0700 (PDT)
X-Received: by 2002:a05:6300:6710:b0:3d8:1f68:59ac with SMTP id adf61e73a8af0-3da3a15bfc3mr30744571637.23.1788739673345;
        Sun, 06 Sep 2026 17:07:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm35547649eec.15.2026.09.06.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 17:07:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: linux-hexagon@vger.kernel.org
Cc: sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
        pierrick.bouvier@oss.qualcomm.com,
        Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] hexagon: add hwcap
Date: Sun,  6 Sep 2026 17:07:51 -0700
Message-Id: <20260907000751.3832954-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI3MCBTYWx0ZWRfXwLmmDJ3B0xN7
 uadj+tok388khqdcv7UHEEqmlAz7DJLGCZmi9WGKT9h9P2RB64elWwbXkUE+FtnvkEJGf1C0+NT
 /J2Z0i5WeqKDir+t/tgR5Yd07GljZqwidAcyHz6CIy+VYVsKuNEejSaWCSFL5iLk/hXXTDy0FOz
 OD0cMNdpcxgDDnRJiCtZ8YozQUEZDPRPGwyhbJ734XYkvT5dvQhUeGuzvl062gDssr8pEJV+LYG
 1+NMPDpea0H8Q6mJaGPWheoLChBj/8lxK21YlDB7nvi2fodM699jXl2odbdt4RlkHNWXR3Zm3Zy
 G6ZfCgPwByya+fmI32OFTK2upDEsq7mamiGYNubILY76xOXfsJoPbs9UL4v4UkgwcoIhvtuZl0Q
 8HuXFpvQ0hctqXrbHCeMGryR5XtoQCSU3bMEUwogLzx5gZZ6dQFgnNDiAjadYNATi3ju91ggRNh
 kycPCrHi0oFhjf2B0bg==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e005a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8nY-vm3X6A2xFGslIQUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 99tGxq9Tk6SMdfBkveJATxqRs4O1lYz_
X-Proofpoint-ORIG-GUID: 99tGxq9Tk6SMdfBkveJATxqRs4O1lYz_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI3MCBTYWx0ZWRfX1KphlYDErK/S
 35d/2mQ8tpycdogZhmIN1S4hkP3q/75ehq28P8FhlANBj0Ho+yvmHImB/Ee/DdB7qVde0GEDCmI
 dYZcZH5Y0GF5uosDYtvEQJB/Oumo0as=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609060270

Provide hwcap interface for userspace programs to discover the Hexagon CPU
capabilities.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 arch/hexagon/include/asm/elf.h        |   3 +-
 arch/hexagon/include/asm/hexagon_vm.h |  58 +++++++++++++++
 arch/hexagon/include/asm/hwcap.h      |  25 +++++++
 arch/hexagon/include/uapi/asm/hwcap.h |  58 +++++++++++++++
 arch/hexagon/kernel/setup.c           | 100 ++++++++++++++++++++++++++
 arch/hexagon/kernel/vm_ops.S          |   4 ++
 6 files changed, 247 insertions(+), 1 deletion(-)
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
index 9aa2493fe786..185f50618040 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -38,6 +38,7 @@
 #define HVM_TRAP1_VMSETREGS		21
 #define HVM_TRAP1_VMGETREGS		22
 #define HVM_TRAP1_VMTIMEROP		24
+#define HVM_TRAP1_VMGETINFO		26
 
 #ifndef __ASSEMBLY__
 
@@ -65,6 +66,62 @@ enum VM_INT_OPS {
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
@@ -82,6 +139,7 @@ void __vmstop(void);
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
index 000000000000..60963257bc6f
--- /dev/null
+++ b/arch/hexagon/include/uapi/asm/hwcap.h
@@ -0,0 +1,58 @@
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
+#define HWCAP_HEXAGON_ISA_V79	15	/* Hexagon V79 */
+#define HWCAP_HEXAGON_ISA_V81	16	/* Hexagon V81 */
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
index 621674e86232..99ff43bc895f 100644
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
@@ -31,6 +36,100 @@ void calibrate_delay(void)
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
+	if (boot_flags.have_hmx)
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
@@ -55,6 +154,7 @@ void __init setup_arch(char **cmdline_p)
 
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

