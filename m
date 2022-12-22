From: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 02/19] arch/arc: rename internal name __xchg to
 __arch_xchg
Date: Thu, 22 Dec 2022 12:46:18 +0100
Message-ID: <20221222114635.1251934-3-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709670; x=1703245670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/UDTi8Vls0g/+nnPnB+HCzMyNgpTxrVUoGQF5kbhC34=;
 b=RM+cLECTApjcbeEPy2Y02ig+ua3YBZn6pmQwfduf8vnVuJhSa7Rw5gWl
 Dxr2yQqdFoCiDeY1aA59pW3O2Y56zXrY7jkA2ZeYh5mToatywOfvEymnt
 vc9kg+YXFxLOYcijmF8uA7sLRblHvA81hWEyHNMevNv6u2pOFd87IVk/e
 VUSQ/H5JclvDzIRxJxcsg/wOjppY9lk9gJBiBKM64Bw7dBJYNVngkMmEY
 iKYA3ojpjAFvWTv+Rc4MKE/FDk+6dR7rEfbKWHKaYmM8AsS5BGW6uUv6J
 DgEbbJcsS6MsK7vfOJoM0MOO9eYI+vmWZpVoUxN2jPi7GkcqfHe3TJ2SJ g==;
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
 arch/arc/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index c5b544a5fe8106..e138fde067dea5 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -85,7 +85,7 @@
  */
 #ifdef CONFIG_ARC_HAS_LLSC
 
-#define __xchg(ptr, val)						\
+#define __arch_xchg(ptr, val)						\
 ({									\
 	__asm__ __volatile__(						\
 	"	ex  %0, [%1]	\n"	/* set new value */	        \
@@ -102,7 +102,7 @@
 									\
 	switch(sizeof(*(_p_))) {					\
 	case 4:								\
-		_val_ = __xchg(_p_, _val_);				\
+		_val_ = __arch_xchg(_p_, _val_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
-- 
2.34.1

