From: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 17/19] arch/xtensa: rename internal name __xchg
 to __arch_xchg
Date: Thu, 22 Dec 2022 12:46:33 +0100
Message-ID: <20221222114635.1251934-18-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709747; x=1703245747;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xrva1eFk6Np1Bm1YmRwegqhZeY1WwhPNk9Drl9WzrJI=;
 b=UE2Sdfb7RyduJZnLoGxcxngQLIBvNWa1aUvZzaNx7oB/iJgazljtCVZC
 Niwzasj3Xl1B9X3YT0pu9FXODrlzsjTHL5ip52BKO9hB6WH/atFEy3iMg
 veQmlImqTVCt0a13265jEgTD5hIAhb8XM8d1c60bC2vXnkO7tjeRBk4iW
 uzC9V4lANf7tSqh6dx1JmSQnbafYs1fRKt87+ylyF+JqLgp+12O9eUDBn
 rGQSjWN0BwsbgD9REma45qP/XXtQB2l62E6YvbgaNmYyC9Mu5bo2V2YNq
 voQ3sYTFRrtyGCbCIooinFnE6K5EZGgbYbUfPyn2b/mAONFyHXekFC6dT w==;
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
 arch/xtensa/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index eb87810357ad88..675a11ea8de76b 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -170,7 +170,7 @@ static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 }
 
 #define arch_xchg(ptr,x) \
-	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+	((__typeof__(*(ptr)))__arch_xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
 static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
 {
@@ -203,7 +203,7 @@ static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
 extern void __xchg_called_with_bad_pointer(void);
 
 static __inline__ unsigned long
-__xchg(unsigned long x, volatile void * ptr, int size)
+__arch_xchg(unsigned long x, volatile void * ptr, int size)
 {
 	switch (size) {
 	case 1:
-- 
2.34.1

