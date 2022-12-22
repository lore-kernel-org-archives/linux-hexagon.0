From: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 16/19] arch/sparc: rename internal name __xchg
 to __arch_xchg
Date: Thu, 22 Dec 2022 12:46:32 +0100
Message-ID: <20221222114635.1251934-17-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709741; x=1703245741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hqPNEu1dGLHX4INM1uJ+E07/4aKzMUY3q5RTm6bJ5ag=;
 b=mpCD9SwDomHQG/rn2RJ09vMUtZSGuBAO6HTUuRZ+NZz+g3NHlZTDb9Gu
 getshSi6KRAvJhin+awQWEFURRw1J98EKLr/B9j3uNqTH+a3nVX0NXMDJ
 UlBOWj9xoZtfm9jJe0famyH0t2ii0Z2EHAK+8pSky+Owt2eWCJf86Km5X
 2cQyySabUunTbOlecSLlN/U5PbU+aKN0wN2rX+f4pVaueV9KMriJYLxVz
 9U9Y/u8JzAW6o0SOCqppRR9U3s+aSihZQ7CuS+Tm2ByY5fC6F+Hy1dpK7
 0lEtnsu86AS0m5KQ3gVgSW08nS+D2eAFkaYKVuQnsLDyKSzpw5eWj6giX Q==;
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
 arch/sparc/include/asm/cmpxchg_32.h | 4 ++--
 arch/sparc/include/asm/cmpxchg_64.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 27a57a3a7597eb..7a1339533d1d7e 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -15,7 +15,7 @@
 unsigned long __xchg_u32(volatile u32 *m, u32 new);
 void __xchg_called_with_bad_pointer(void);
 
-static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr, int size)
+static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
 {
 	switch (size) {
 	case 4:
@@ -25,7 +25,7 @@ static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr, int
 	return x;
 }
 
-#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
+#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__arch_xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 /* Emulate cmpxchg() the same way we emulate atomics,
  * by hashing the object address and indexing into an array
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 12d00a42c0a3ed..4c22fd9110c945 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -55,7 +55,7 @@ static inline unsigned long xchg64(__volatile__ unsigned long *m, unsigned long
 #define arch_xchg(ptr,x)							\
 ({	__typeof__(*(ptr)) __ret;					\
 	__ret = (__typeof__(*(ptr)))					\
-		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
+		__arch_xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
 	__ret;								\
 })
 
@@ -87,7 +87,7 @@ xchg16(__volatile__ unsigned short *m, unsigned short val)
 	return (load32 & mask) >> bit_shift;
 }
 
-static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr,
+static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr,
 				       int size)
 {
 	switch (size) {
-- 
2.34.1

