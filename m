From: Andrzej Hajda <andrzej.hajda@intel.com>
Subject: [PATCH 11/19] arch/parisc: rename internal name __xchg
 to __arch_xchg
Date: Thu, 22 Dec 2022 12:46:27 +0100
Message-ID: <20221222114635.1251934-12-andrzej.hajda@intel.com>
References: <20221222114635.1251934-1-andrzej.hajda@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671709711; x=1703245711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ShuBR0Z5S7GcOYzeMdcvtC9TNipnvNb2IL9/zmSpmSE=;
 b=PYGsCY2GO6JtbO2ykcyYwRQarTNmzIM1sCfvaLg66v4m0uYLObV65Qrd
 h0yQWOrnFykgdRB5dFiRIPz3gQX8AhfDj/EKQzKzeTZcQvpsgWdLuYtQ9
 A/quGqvV8LBu+qpA6ukyKQZ3Y6PGH7ewbKg2GGZUo/iq7KQWNuYqyic9i
 0lOSaFsuE8G6AlbQYcmL7DmH512zSFydvRfOG8XL56ve+vQE6s8Yqc54O
 VQAvWOOzccGYqj62d+JnZfm0uMu6BTgbd8twYBdMCEIsTchBeNLLnoXq0
 s2kImY4FJshkB51R33UwEPnVX4EDLE+ewhGmCMI7oEsliUNh87rbQlVL/ g==;
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
 arch/parisc/include/asm/cmpxchg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 5f274be105671e..c1d776bb16b4ed 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -22,7 +22,7 @@ extern unsigned long __xchg64(unsigned long, volatile unsigned long *);
 
 /* optimizer better get rid of switch since size is a constant */
 static inline unsigned long
-__xchg(unsigned long x, volatile void *ptr, int size)
+__arch_xchg(unsigned long x, volatile void *ptr, int size)
 {
 	switch (size) {
 #ifdef CONFIG_64BIT
@@ -49,7 +49,7 @@ __xchg(unsigned long x, volatile void *ptr, int size)
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	__ret = (__typeof__(*(ptr)))					\
-		__xchg((unsigned long)_x_, (ptr), sizeof(*(ptr)));	\
+		__arch_xchg((unsigned long)_x_, (ptr), sizeof(*(ptr)));	\
 	__ret;								\
 })
 
-- 
2.34.1

