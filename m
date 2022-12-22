From: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 06/19] arch/ia64: rename internal name __xchg to
 __arch_xchg
Date: Thu, 22 Dec 2022 12:46:22 +0100
Message-ID: <20221222114635.1251934-7-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709681; x=1703245681;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P1D9tmgH8/CSHAiLVPcpQPpEF0wSUpHitFyM9Wwb9a4=;
 b=ahSP5dgM3r3V2lA0FKRdtVtVlnl26SvioGH/Glhf//OSSzUGeGHal8fR
 CcnADFUuEKJ14jV+qxGZ4ucGC/uYcom9ULUDfU3+lmrRfEiQwKyR7j0rh
 p5Xn++J2m9RrJaH58A8D6c4KPbKtPYuijHIVzyIRyS+W+whTAsSomugWs
 ABnMVy//9pqFegHegnF4zXC2m8XySUwJC2vSYybpDDkuX01uBmqwPjb/K
 rtuGrHSIkfNZl5+JRg3ZTutJLhPqLqg9tGSTLu7m5EtjUS4MxIXTyiUJc
 YiEuV5MsmSWfBFcMCVEtrJUWqQfIrMhEOzkFWw7Fn2+J2F/0y0tLWJODo A==;
In-Reply-To: <20221222114635.1251934-1-andrzej.hajda@intel.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

__xchg will be used for non-atomic xchg macro.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 arch/ia64/include/asm/cmpxchg.h      | 2 +-
 arch/ia64/include/uapi/asm/cmpxchg.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/cmpxchg.h b/arch/ia64/include/asm/cmpxchg.h
index 94ef844298431a..8b2e644ef6a14e 100644
--- a/arch/ia64/include/asm/cmpxchg.h
+++ b/arch/ia64/include/asm/cmpxchg.h
@@ -5,7 +5,7 @@
 #include <uapi/asm/cmpxchg.h>
 
 #define arch_xchg(ptr, x)	\
-({(__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
+({(__typeof__(*(ptr))) __arch_xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
 
 #define arch_cmpxchg(ptr, o, n)		cmpxchg_acq((ptr), (o), (n))
 #define arch_cmpxchg64(ptr, o, n)	cmpxchg_acq((ptr), (o), (n))
diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index ca2e0268534384..3fec9b037051bb 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -27,7 +27,7 @@
  */
 extern void ia64_xchg_called_with_bad_pointer(void);
 
-#define __xchg(x, ptr, size)						\
+#define __arch_xchg(x, ptr, size)					\
 ({									\
 	unsigned long __xchg_result;					\
 									\
@@ -55,7 +55,7 @@ extern void ia64_xchg_called_with_bad_pointer(void);
 
 #ifndef __KERNEL__
 #define xchg(ptr, x)							\
-({(__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
+({(__typeof__(*(ptr))) __arch_xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
 #endif
 
 /*
-- 
2.34.1

