From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH v2] arch: hexagon: include: asm: add prefix "hvm[ci]_" for
 all enum members in "hexagon_vm.h"
Date: Thu, 28 Nov 2013 16:51:45 +0800
Message-ID: <52970421.3030104@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <5292B845.3010404@gmail.com> <5292B8A0.7020409@gmail.com> <5292B8D1.5050407@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kXxPBQD7Z5sKIDOPUCumQkI4hqzmowSgkahmc6qc8AE=;
        b=aDax02ynnrPikNc19hXvYl/byVYB2n3Z+7IA7748ENUAH6sZ9g310uIZxuRdLso1sL
         BbW3li8VWDz1/IsjCJq2dEIRcfjWBvBItC485EyEjgPICrI+wm2tWn92SVHkuBI6JctD
         lXofmAtKHiUSTjAcojyQJ7Pp5eNFW7XBwhwDEuO2Ocovfkaw8mQre2OWavuVnKvJw6+/
         a9hMIWZwlz522WgxjUcOL2OCTT8Zm5juXTKnGukRLb+OF48LHFkt8iEU9bdo5Ko51WQd
         CFAaBqr+BfrkiKq1yAIUmva49vR+vBrcrMqbHhFCD71plOwv3uf/sEte1MFnOHX80yFD
         G/ig==
In-Reply-To: <5292B8D1.5050407@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Append "hvmc_" or "hvmi_" to all related enum members (which are too
common to make conflict with another sub-systems). The related error
with allmodconfig:

    CC [M]  drivers/md/raid1.o
  drivers/md/raid1.c:1440:13: error: 'status' redeclared as different kind of symbol
  arch/hexagon/include/asm/hexagon_vm.h:76:2: note: previous definition of 'status' was here

Also use 'affinity' instead of 'locdis' for __vmintop_affinity().


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h |   72 ++++++++++++++++----------------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 67bb6d6..1f6918b 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -55,27 +55,27 @@
 #ifndef __ASSEMBLY__
 
 enum VM_CACHE_OPS {
-	ickill,
-	dckill,
-	l2kill,
-	dccleaninva,
-	icinva,
-	idsync,
-	fetch_cfg
+	hvmc_ickill,
+	hvmc_dckill,
+	hvmc_l2kill,
+	hvmc_dccleaninva,
+	hvmc_icinva,
+	hvmc_idsync,
+	hvmc_fetch_cfg
 };
 
 enum VM_INT_OPS {
-	nop,
-	globen,
-	globdis,
-	locen,
-	locdis,
-	affinity,
-	get,
-	peek,
-	status,
-	post,
-	clear
+	hvmi_nop,
+	hvmi_globen,
+	hvmi_globdis,
+	hvmi_locen,
+	hvmi_locdis,
+	hvmi_affinity,
+	hvmi_get,
+	hvmi_peek,
+	hvmi_status,
+	hvmi_post,
+	hvmi_clear
 };
 
 extern void _K_VM_event_vector(void);
@@ -98,95 +98,95 @@ long __vmvpid(void);
 
 static inline long __vmcache_ickill(void)
 {
-	return __vmcache(ickill, 0, 0);
+	return __vmcache(hvmc_ickill, 0, 0);
 }
 
 static inline long __vmcache_dckill(void)
 {
-	return __vmcache(dckill, 0, 0);
+	return __vmcache(hvmc_dckill, 0, 0);
 }
 
 static inline long __vmcache_l2kill(void)
 {
-	return __vmcache(l2kill, 0, 0);
+	return __vmcache(hvmc_l2kill, 0, 0);
 }
 
 static inline long __vmcache_dccleaninva(unsigned long addr, unsigned long len)
 {
-	return __vmcache(dccleaninva, addr, len);
+	return __vmcache(hvmc_dccleaninva, addr, len);
 }
 
 static inline long __vmcache_icinva(unsigned long addr, unsigned long len)
 {
-	return __vmcache(icinva, addr, len);
+	return __vmcache(hvmc_icinva, addr, len);
 }
 
 static inline long __vmcache_idsync(unsigned long addr,
 					   unsigned long len)
 {
-	return __vmcache(idsync, addr, len);
+	return __vmcache(hvmc_idsync, addr, len);
 }
 
 static inline long __vmcache_fetch_cfg(unsigned long val)
 {
-	return __vmcache(fetch_cfg, val, 0);
+	return __vmcache(hvmc_fetch_cfg, val, 0);
 }
 
 /* interrupt operations  */
 
 static inline long __vmintop_nop(void)
 {
-	return __vmintop(nop, 0, 0, 0, 0);
+	return __vmintop(hvmi_nop, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_globen(long i)
 {
-	return __vmintop(globen, i, 0, 0, 0);
+	return __vmintop(hvmi_globen, i, 0, 0, 0);
 }
 
 static inline long __vmintop_globdis(long i)
 {
-	return __vmintop(globdis, i, 0, 0, 0);
+	return __vmintop(hvmi_globdis, i, 0, 0, 0);
 }
 
 static inline long __vmintop_locen(long i)
 {
-	return __vmintop(locen, i, 0, 0, 0);
+	return __vmintop(hvmi_locen, i, 0, 0, 0);
 }
 
 static inline long __vmintop_locdis(long i)
 {
-	return __vmintop(locdis, i, 0, 0, 0);
+	return __vmintop(hvmi_locdis, i, 0, 0, 0);
 }
 
 static inline long __vmintop_affinity(long i, long cpu)
 {
-	return __vmintop(locdis, i, cpu, 0, 0);
+	return __vmintop(hvmi_affinity, i, cpu, 0, 0);
 }
 
 static inline long __vmintop_get(void)
 {
-	return __vmintop(get, 0, 0, 0, 0);
+	return __vmintop(hvmi_get, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_peek(void)
 {
-	return __vmintop(peek, 0, 0, 0, 0);
+	return __vmintop(hvmi_peek, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_status(long i)
 {
-	return __vmintop(status, i, 0, 0, 0);
+	return __vmintop(hvmi_status, i, 0, 0, 0);
 }
 
 static inline long __vmintop_post(long i)
 {
-	return __vmintop(post, i, 0, 0, 0);
+	return __vmintop(hvmi_post, i, 0, 0, 0);
 }
 
 static inline long __vmintop_clear(long i)
 {
-	return __vmintop(clear, i, 0, 0, 0);
+	return __vmintop(hvmi_clear, i, 0, 0, 0);
 }
 
 #else /* Only assembly code should reference these */
-- 
1.7.7.6
