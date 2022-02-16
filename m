From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 07/18] nios2: drop access_ok() check from __put_user()
Date: Wed, 16 Feb 2022 14:13:21 +0100
Message-ID: <20220216131332.1489939-8-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ejCfU7PLslrrHWxRGlCBrA7/V0HkQob20cYL3Po7eLE=; b=Tfx+83rEg/z8cx
	pI4odKRK/x2d/WFJxFuAkN9VsFtSx1lx+ABQHT9LDqaY1SQ2KifvFUKZDkD/eudZEq5344+h+7bbo
	41XDT4VnPmKCw2c+n8oGJ/jcmUc8mC+Za99jKA+EyjtEqt4BIzR7SGO9Yy1sy2XcqJiVkt8HseKFr
	TTTpQy9IhHcAnzpONaBwhaU38AqzlUBukvt+TQuas+xsIEz/+ajeoIixeEE3fTT6JHBo/NIStShUo
	Q+Lo1dPwNCFdrn5ROelGFk+CtroX+TYh82tpaLw8SQBKH5H7AY0hW2hVKyJAE5z1ULXHGEeyJYNVx
	qCmuXyic84ur+Cr9Frqw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645017413;
 bh=+iR2qnnFcrsCPQoMglxV/90U3LFjDlY0u/606L67UPs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FvFA19KgOFHw//5AD53hF0IwW2eLEb8iC830WFN6MdVoW4fyh5i/2kJHpxFd7pdlD
 7UX6fEewGCq+cZvaT2PObS6XOZnZypDPzvRcYa/W0nzWewDgb+0xXamh2omZfLYFmr
 8N4H7mpvMOTDqe2QPH8s/NhnVxUv6/h988kxIKpvMvfqvjGNNvINW6t4henTJIKwJt
 jzLnL5Fc+Su69zkh5g1Nf3EInYTi+sp1khBbBbK8Lt97/7IVApa2FzdwQAvU7AyEeL
 nEYQi1fYgk8k2uZixKdw/j3+QwXzCx+3pjcEKGsjL9tNOzijYs/MTwOK3SPeQjakHj
 3w2JGHUIm9rGg==
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc: linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.k

From: Arnd Bergmann <arnd@arndb.de>

Unlike other architectures, the nios2 version of __put_user() has an
extra check for access_ok(), preventing it from being used to implement
__put_kernel_nofault().

Split up put_user() along the same lines as __get_user()/get_user()

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nios2/include/asm/uaccess.h | 56 +++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index ca9285a915ef..a5cbe07cf0da 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -167,34 +167,44 @@ do {									\
 	: "r" (val), "r" (ptr), "i" (-EFAULT));				\
 }
 
-#define put_user(x, ptr)						\
+#define __put_user_common(__pu_val, __pu_ptr)				\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) __user *__pu_ptr = (ptr);			\
-	__typeof__(*(ptr)) __pu_val = (__typeof(*ptr))(x);		\
-	if (access_ok(__pu_ptr, sizeof(*__pu_ptr))) {	\
-		switch (sizeof(*__pu_ptr)) {				\
-		case 1:							\
-			__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err); \
-			break;						\
-		case 2:							\
-			__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err); \
-			break;						\
-		case 4:							\
-			__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err); \
-			break;						\
-		default:						\
-			/* XXX: This looks wrong... */			\
-			__pu_err = 0;					\
-			if (copy_to_user(__pu_ptr, &(__pu_val),		\
-				sizeof(*__pu_ptr)))			\
-				__pu_err = -EFAULT;			\
-			break;						\
-		}							\
+	switch (sizeof(*__pu_ptr)) {					\
+	case 1:								\
+		__put_user_asm(__pu_val, "stb", __pu_ptr, __pu_err);	\
+		break;							\
+	case 2:								\
+		__put_user_asm(__pu_val, "sth", __pu_ptr, __pu_err);	\
+		break;							\
+	case 4:								\
+		__put_user_asm(__pu_val, "stw", __pu_ptr, __pu_err);	\
+		break;							\
+	default:							\
+		/* XXX: This looks wrong... */				\
+		__pu_err = 0;						\
+		if (__copy_to_user(__pu_ptr, &(__pu_val),		\
+			sizeof(*__pu_ptr)))				\
+			__pu_err = -EFAULT;				\
+		break;							\
 	}								\
 	__pu_err;							\
 })
 
-#define __put_user(x, ptr) put_user(x, ptr)
+#define __put_user(x, ptr)						\
+({									\
+	__auto_type __pu_ptr = (ptr);					\
+	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	__put_user_common(__pu_val, __pu_ptr);				\
+})
+
+#define put_user(x, ptr)						\
+({									\
+	__auto_type __pu_ptr = (ptr);					\
+	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
+		__put_user_common(__pu_val, __pu_ptr) :			\
+		-EFAULT;						\
+})
 
 #endif /* _ASM_NIOS2_UACCESS_H */
-- 
2.29.2
