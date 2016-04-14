From: zengzhaoxiu@163.com
Subject: [PATCH V3 02/29] Include generic parity.h in some architectures'
 bitops.h
Date: Thu, 14 Apr 2016 11:04:31 +0800
Message-ID: <1460603098-4466-1-git-send-email-zengzhaoxiu@163.com>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=5brpFEkLxt9yHqclC/
 r3T7u/DTpNexvyYUpPhiKr7c0=; b=A6847GYtGFOaAURxa+Iubuql7fGn0eYt5h
 luMcT4ECRCWRuKes2PIN6alZBIOFLAmchd0XODx2naduAbd0x5YJwaQllLDWvgZk
 bJXr7Ff2JgIWXjqmkQTBEZ0qQ/9KfsxU+v0PwevDTm+NtX8FxcN6QB7UBiHeS7Zb
 v9C8qxvq8=
In-Reply-To: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, linux@lists.openrisc.net, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com, Russell King <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, linux-snps-arc@lists.infradead.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/arc/include/asm/bitops.h      | 1 +
 arch/arm/include/asm/bitops.h      | 1 +
 arch/arm64/include/asm/bitops.h    | 1 +
 arch/avr32/include/asm/bitops.h    | 1 +
 arch/c6x/include/asm/bitops.h      | 1 +
 arch/cris/include/asm/bitops.h     | 1 +
 arch/frv/include/asm/bitops.h      | 1 +
 arch/h8300/include/asm/bitops.h    | 1 +
 arch/hexagon/include/asm/bitops.h  | 1 +
 arch/m32r/include/asm/bitops.h     | 1 +
 arch/m68k/include/asm/bitops.h     | 1 +
 arch/metag/include/asm/bitops.h    | 1 +
 arch/mn10300/include/asm/bitops.h  | 1 +
 arch/openrisc/include/asm/bitops.h | 1 +
 arch/parisc/include/asm/bitops.h   | 1 +
 arch/s390/include/asm/bitops.h     | 1 +
 arch/sh/include/asm/bitops.h       | 1 +
 arch/xtensa/include/asm/bitops.h   | 1 +
 18 files changed, 18 insertions(+)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 0352fb8..7967e47 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -370,6 +370,7 @@ static inline __attribute__ ((const)) int __ffs(unsigned long x)
 #define ffz(x)	__ffs(~(x))
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/lock.h>
diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
index e943e6c..99f28a6 100644
--- a/arch/arm/include/asm/bitops.h
+++ b/arch/arm/include/asm/bitops.h
@@ -313,6 +313,7 @@ static inline unsigned long __ffs(unsigned long x)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #ifdef __ARMEB__
diff --git a/arch/arm64/include/asm/bitops.h b/arch/arm64/include/asm/bitops.h
index 9c19594..eac4965 100644
--- a/arch/arm64/include/asm/bitops.h
+++ b/arch/arm64/include/asm/bitops.h
@@ -44,6 +44,7 @@ extern int test_and_change_bit(int nr, volatile unsigned long *p);
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/non-atomic.h>
diff --git a/arch/avr32/include/asm/bitops.h b/arch/avr32/include/asm/bitops.h
index 910d537..9f4a2ce 100644
--- a/arch/avr32/include/asm/bitops.h
+++ b/arch/avr32/include/asm/bitops.h
@@ -298,6 +298,7 @@ static inline int ffs(unsigned long word)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 extern unsigned long find_next_zero_bit_le(const void *addr,
diff --git a/arch/c6x/include/asm/bitops.h b/arch/c6x/include/asm/bitops.h
index f0ab012..94eb0d1 100644
--- a/arch/c6x/include/asm/bitops.h
+++ b/arch/c6x/include/asm/bitops.h
@@ -87,6 +87,7 @@ static inline int ffs(int x)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/atomic.h>
diff --git a/arch/cris/include/asm/bitops.h b/arch/cris/include/asm/bitops.h
index 8062cb5..06bc246 100644
--- a/arch/cris/include/asm/bitops.h
+++ b/arch/cris/include/asm/bitops.h
@@ -36,6 +36,7 @@
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/lock.h>
 
diff --git a/arch/frv/include/asm/bitops.h b/arch/frv/include/asm/bitops.h
index 0df8e95..f2a7ee8 100644
--- a/arch/frv/include/asm/bitops.h
+++ b/arch/frv/include/asm/bitops.h
@@ -314,6 +314,7 @@ int __ilog2_u64(u64 n)
 
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/le.h>
diff --git a/arch/h8300/include/asm/bitops.h b/arch/h8300/include/asm/bitops.h
index 05999ab..e392db2 100644
--- a/arch/h8300/include/asm/bitops.h
+++ b/arch/h8300/include/asm/bitops.h
@@ -172,6 +172,7 @@ static inline unsigned long __ffs(unsigned long word)
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 5e4a59b..2df614e 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -290,6 +290,7 @@ static inline unsigned long __fls(unsigned long word)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic.h>
diff --git a/arch/m32r/include/asm/bitops.h b/arch/m32r/include/asm/bitops.h
index 86ba2b4..e3cf46b 100644
--- a/arch/m32r/include/asm/bitops.h
+++ b/arch/m32r/include/asm/bitops.h
@@ -259,6 +259,7 @@ static __inline__ int test_and_change_bit(int nr, volatile void * addr)
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index b4a9b0d..fd673ea 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -519,6 +519,7 @@ static inline int __fls(int x)
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
diff --git a/arch/metag/include/asm/bitops.h b/arch/metag/include/asm/bitops.h
index 2671134..ad13087 100644
--- a/arch/metag/include/asm/bitops.h
+++ b/arch/metag/include/asm/bitops.h
@@ -118,6 +118,7 @@ static inline int test_and_change_bit(unsigned int bit,
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/mn10300/include/asm/bitops.h b/arch/mn10300/include/asm/bitops.h
index fe6f8e2..60761b7 100644
--- a/arch/mn10300/include/asm/bitops.h
+++ b/arch/mn10300/include/asm/bitops.h
@@ -225,6 +225,7 @@ int ffs(int x)
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 #include <asm-generic/bitops/le.h>
 
diff --git a/arch/openrisc/include/asm/bitops.h b/arch/openrisc/include/asm/bitops.h
index 3003cda..8c97642 100644
--- a/arch/openrisc/include/asm/bitops.h
+++ b/arch/openrisc/include/asm/bitops.h
@@ -43,6 +43,7 @@
 #include <asm-generic/bitops/sched.h>
 #include <asm/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 
 #include <asm-generic/bitops/atomic.h>
diff --git a/arch/parisc/include/asm/bitops.h b/arch/parisc/include/asm/bitops.h
index 3f9406d..867ba10 100644
--- a/arch/parisc/include/asm/bitops.h
+++ b/arch/parisc/include/asm/bitops.h
@@ -211,6 +211,7 @@ static __inline__ int fls(int x)
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 8043f10..198eead 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -460,6 +460,7 @@ static inline int fls(int word)
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index fc8e652..4bf0c35 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -86,6 +86,7 @@ static inline unsigned long ffz(unsigned long word)
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/ffs.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
index 3f44fa2..981fa83 100644
--- a/arch/xtensa/include/asm/bitops.h
+++ b/arch/xtensa/include/asm/bitops.h
@@ -229,6 +229,7 @@ test_and_change_bit(unsigned int bit, volatile unsigned long *p)
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
 
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/sched.h>
 
-- 
2.5.0
