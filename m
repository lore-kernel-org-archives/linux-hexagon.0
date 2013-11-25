From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH 1/2] arch: hexagon: include: asm: add prefix "vm_" for all
 enum members in "hexagon_vm.h"
Date: Mon, 25 Nov 2013 10:40:32 +0800
Message-ID: <5292B8A0.7020409@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <5292B845.3010404@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hugxU1RdFo/TScVTRurmYvB+mRBzA3VK9y/1KsBQi/E=;
        b=bhF0dCAAyEo3ua4XhFYTupykmv0n/0+af8q+kfxlVumja7XTILAgCg1f8lmNwqNJVj
         shOUVEl8lLDOP7ErmXFFzMK/2dsC5zzfZpSPrRc7NWA0zJS5lwIX9TCJwOwYYabqUm7K
         g6lKvWhzpnYyyZ2cdKCOrYwGL0rFsVQKCwEtOIB+OwJINyMzMQerZNdPx9OwtwdD/ls2
         Ub8W1THBnY80Bh+BZKKPu6tK2+PWOPZC6Jd33+pKxftr7FUp0aYFz67L8j9kkwTz9uJJ
         ej6B4wBj/BHwh+WZ+Ir1+tXrXaoo+ATnAP8Mwjt9Bg0uXQ1Xk+fSKsk+nj1CXD5BZFwR
         h6pg==
In-Reply-To: <5292B845.3010404@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Append "vm_" to all enum members (which are too common to make conflict
with another sub-systems). The related error with allmodconfig:

    CC [M]  drivers/md/raid1.o
  drivers/md/raid1.c:1440:13: error: 'status' redeclared as different kind of symbol
  arch/hexagon/include/asm/hexagon_vm.h:76:2: note: previous definition of 'status' was here


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h |   70 ++++++++++++++++----------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 67bb6d6..e1e0470 100644
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
+	vm_ickill,
+	vm_dckill,
+	vm_l2kill,
+	vm_dccleaninva,
+	vm_icinva,
+	vm_idsync,
+	vm_fetch_cfg
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
+	vm_nop,
+	vm_globen,
+	vm_globdis,
+	vm_locen,
+	vm_locdis,
+	vm_affinity,
+	vm_get,
+	vm_peek,
+	vm_status,
+	vm_post,
+	vm_clear
 };
 
 extern void _K_VM_event_vector(void);
@@ -98,65 +98,65 @@ long __vmvpid(void);
 
 static inline long __vmcache_ickill(void)
 {
-	return __vmcache(ickill, 0, 0);
+	return __vmcache(vm_ickill, 0, 0);
 }
 
 static inline long __vmcache_dckill(void)
 {
-	return __vmcache(dckill, 0, 0);
+	return __vmcache(vm_dckill, 0, 0);
 }
 
 static inline long __vmcache_l2kill(void)
 {
-	return __vmcache(l2kill, 0, 0);
+	return __vmcache(vm_l2kill, 0, 0);
 }
 
 static inline long __vmcache_dccleaninva(unsigned long addr, unsigned long len)
 {
-	return __vmcache(dccleaninva, addr, len);
+	return __vmcache(vm_dccleaninva, addr, len);
 }
 
 static inline long __vmcache_icinva(unsigned long addr, unsigned long len)
 {
-	return __vmcache(icinva, addr, len);
+	return __vmcache(vm_icinva, addr, len);
 }
 
 static inline long __vmcache_idsync(unsigned long addr,
 					   unsigned long len)
 {
-	return __vmcache(idsync, addr, len);
+	return __vmcache(vm_idsync, addr, len);
 }
 
 static inline long __vmcache_fetch_cfg(unsigned long val)
 {
-	return __vmcache(fetch_cfg, val, 0);
+	return __vmcache(vm_fetch_cfg, val, 0);
 }
 
 /* interrupt operations  */
 
 static inline long __vmintop_nop(void)
 {
-	return __vmintop(nop, 0, 0, 0, 0);
+	return __vmintop(vm_nop, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_globen(long i)
 {
-	return __vmintop(globen, i, 0, 0, 0);
+	return __vmintop(vm_globen, i, 0, 0, 0);
 }
 
 static inline long __vmintop_globdis(long i)
 {
-	return __vmintop(globdis, i, 0, 0, 0);
+	return __vmintop(vm_globdis, i, 0, 0, 0);
 }
 
 static inline long __vmintop_locen(long i)
 {
-	return __vmintop(locen, i, 0, 0, 0);
+	return __vmintop(vm_locen, i, 0, 0, 0);
 }
 
 static inline long __vmintop_locdis(long i)
 {
-	return __vmintop(locdis, i, 0, 0, 0);
+	return __vmintop(vm_locdis, i, 0, 0, 0);
 }
 
 static inline long __vmintop_affinity(long i, long cpu)
@@ -166,27 +166,27 @@ static inline long __vmintop_affinity(long i, long cpu)
 
 static inline long __vmintop_get(void)
 {
-	return __vmintop(get, 0, 0, 0, 0);
+	return __vmintop(vm_get, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_peek(void)
 {
-	return __vmintop(peek, 0, 0, 0, 0);
+	return __vmintop(vm_peek, 0, 0, 0, 0);
 }
 
 static inline long __vmintop_status(long i)
 {
-	return __vmintop(status, i, 0, 0, 0);
+	return __vmintop(vm_status, i, 0, 0, 0);
 }
 
 static inline long __vmintop_post(long i)
 {
-	return __vmintop(post, i, 0, 0, 0);
+	return __vmintop(vm_post, i, 0, 0, 0);
 }
 
 static inline long __vmintop_clear(long i)
 {
-	return __vmintop(clear, i, 0, 0, 0);
+	return __vmintop(vm_clear, i, 0, 0, 0);
 }
 
 #else /* Only assembly code should reference these */
-- 
1.7.7.6
