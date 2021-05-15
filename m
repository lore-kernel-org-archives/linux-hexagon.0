From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 4/6] [v2] arc: use generic strncpy/strnlen from_user
Date: Sat, 15 May 2021 12:18:01 +0200
Message-ID: <20210515101803.924427-5-arnd@kernel.org>
References: <20210515101803.924427-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+ZTnrtv2xvdwi91A3pbmrpOaIfScV6wlu//Y5Skjs7w=; b=IGH/NNeF9VVy6IVZtU+NCOGS7
	MqsXAmfBVncMLG9mrAmz9Meq3Id7+kkBT6YNN/eaESkNey26cuxAU9n6b43RGqKNxzPXJEf0E9q1G
	OGRstXDUJJSP0+6sWPdwCq17tbEYS9VnACdTUtQXoxlTuPjXp7Wb03u5WEtN4MHZQqag3P5JeXo8L
	Y2p1HXzr09oDh0R1TxiA25rn8eGVpcP2X+7nS+PA9LQ+lFTSjk1YKqannvPzE91GQepGmWIJfVkY7
	m5w9rrTUfXQ9q+8SLArjuXLurDK2P7TnVNYI47pQbkOvD0cqJEX+y8XRhmqN9rGtSQt7OXnyMl/e/
	Jpr7w4uQg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=NaqXJV908V1jIAVejU+NdX55MLC7FA58Fe0o+EeCqG4=; b=wU1JLmm9mUirjVwBwAwpxvJZFm
 IFkiBwBTuzZDHbvrNtERcmMRFyFM/3q+coQnjklMDuLOczJ7PAxaIjIyA68MPwhTey+hgGdTITSnZ
 /66pSSNIHhdlLKK1C+/E3lARU9Rn58BObZUnT6D5ON/YyUdkVAnCQa0qLvMcjcorp7FuseduM8iDP
 u8fw5DtqWXtGuDNcHtmEpz9DeuJ2TPBjvdKfPSOHIHLz14GS0x0wOUljMN8S2eU/01XJbRdUoCyBq
 OF3PXEXwOL0m/fJ1EtKHw2DQRWYPBDb+kJikvPAb/OjgT8yvH3vB8OBu8R5irLDIb8ETkrkCRQcrU
 sbSbrxWQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621073958;
 bh=5EiV6+uSoRXpKB9TPWxNu5WmBqsPjct5G2z66NyP0fw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bjky3cSuDqZIES1KbepcV5Oby6RvxvISRH0AGI4mDxg/BM6uDnjAapszFc+ptgQNt
 J0tcmi3xigYXX6LJOuynlQSBPrO9WxPj+DHGujJh2g321TLT2yXZIWKChiUclVzNT4
 e58Rf8vzaJI19p63w017oebZKBmnLE1JxFJ1EqoB+mcwLFkW7KFxUSpVniv3oWMjB/
 AbImTti61Fc9PLzwUugONY6MJ21I7VRetVRK7MGExtcfjVaYKiPP3HYU+Cv6SlyudR
 o0/Wn48mXsLWAkQpjkkDV0eSXkAeuZeYrNAIMxNEqrbMd6pJyq6LaoRglM9p2zd//o
 ggJFHQ3qZVlvw==
In-Reply-To: <20210515101803.924427-1-arnd@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Sid Manning <sidneym@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-um@lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

Most per-architecture versions of these functions are broken
in some form, and they are almost certainly slower than the
generic code as well.

This version is fairly slow because it always does byte accesses
even for aligned data, and its checks for user_addr_max() differ
from the generic code.

Remove the ones for arc and instead use the generic version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/Kconfig               |  2 +
 arch/arc/include/asm/uaccess.h | 83 ++--------------------------------
 arch/arc/mm/extable.c          | 12 -----
 3 files changed, 7 insertions(+), 90 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2d98501c0897..a38f403a8811 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -27,6 +27,8 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 3476348f361e..754a23f26736 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -655,96 +655,23 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-static inline long
-__arc_strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	long res = 0;
-	char val;
-
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
-	if (count == 0)
-		return 0;
-
-	__asm__ __volatile__(
-	"	mov	lp_count, %5		\n"
-	"	lp	3f			\n"
-	"1:	ldb.ab  %3, [%2, 1]		\n"
-	"	breq.d	%3, 0, 3f               \n"
-	"	stb.ab  %3, [%1, 1]		\n"
-	"	add	%0, %0, 1	# Num of NON NULL bytes copied	\n"
-	"3:								\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, %4		# sets @res as -EFAULT	\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word   1b, 4b			\n"
-	"	.previous			\n"
-	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
-	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "memory");
-
-	return res;
-}
-
-static inline long __arc_strnlen_user(const char __user *s, long n)
-{
-	long res, tmp1, cnt;
-	char val;
-
-	if (!access_ok(s, 1))
-		return 0;
-
-	__asm__ __volatile__(
-	"	mov %2, %1			\n"
-	"1:	ldb.ab  %3, [%0, 1]		\n"
-	"	breq.d  %3, 0, 2f		\n"
-	"	sub.f   %2, %2, 1		\n"
-	"	bnz 1b				\n"
-	"	sub %2, %2, 1			\n"
-	"2:	sub %0, %1, %2			\n"
-	"3:	;nop				\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, 0			\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word 1b, 4b			\n"
-	"	.previous			\n"
-	: "=r"(res), "=r"(tmp1), "=r"(cnt), "=r"(val)
-	: "0"(s), "1"(n)
-	: "memory");
-
-	return res;
-}
-
 #ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
 #define __clear_user(d, n)		__arc_clear_user(d, n)
-#define strncpy_from_user(d, s, n)	__arc_strncpy_from_user(d, s, n)
-#define strnlen_user(s, n)		__arc_strnlen_user(s, n)
 #else
 extern unsigned long arc_clear_user_noinline(void __user *to,
 		unsigned long n);
-extern long arc_strncpy_from_user_noinline (char *dst, const char __user *src,
-		long count);
-extern long arc_strnlen_user_noinline(const char __user *src, long n);
-
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
-#define strncpy_from_user(d, s, n)	arc_strncpy_from_user_noinline(d, s, n)
-#define strnlen_user(s, n)		arc_strnlen_user_noinline(s, n)
-
 #endif
 
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
+#define strncpy_from_user(d, s, n)	strncpy_from_user(d, s, n)
+extern long strnlen_user(const char __user *src, long n);
+#define strnlen_user(s, n)		strnlen_user(s, n)
+
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index b06b09ddf924..4e14c4244ea2 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -32,16 +32,4 @@ unsigned long arc_clear_user_noinline(void __user *to,
 }
 EXPORT_SYMBOL(arc_clear_user_noinline);
 
-long arc_strncpy_from_user_noinline(char *dst, const char __user *src,
-		long count)
-{
-	return __arc_strncpy_from_user(dst, src, count);
-}
-EXPORT_SYMBOL(arc_strncpy_from_user_noinline);
-
-long arc_strnlen_user_noinline(const char __user *src, long n)
-{
-	return __arc_strnlen_user(src, n);
-}
-EXPORT_SYMBOL(arc_strnlen_user_noinline);
 #endif
-- 
2.29.2
