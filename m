From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 17:34:42 +0100
Message-ID: <20220214163452.1568807-5-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
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
	List-Owner; bh=G8seF8X3L+34oBVZXUMPWJoP4lxIXHLQycsRUrsC2rs=; b=isQOXiy79XGU38
	8wuutQcrTOGEQkqHP4MNqHkfR9bx67ZKm7nzzQQ+EOVo5yoD1ur8PtYPrgbsWKXp+kqq8UuqfUpLO
	XzzDnEtT4ECjY4alHb4IAUfWxjEt6ugO8C0ASNXYH+wh/EvHr/j7IzmGUP/0WtrPjTz1u5lfCwpEO
	PCZhHBg1Mi/9cDXIFRFhHeBR9kJqcpIyNmOAPPOCI4Xxv5NJ6S3j8FP1w1upHD6YBOkuhks8mxU34
	4WZjvOCzL6Qst2Fhb3RKz4yVGLSPRrspxm/KYqUW+MTGozwUj+b4BxQHUZcLPq1iTALxvqL9b13n7
	lx0Jqhnup/3mfYl36eFw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644856592;
 bh=/86KMr0jNBuJ/zqhHefOXTiqAWO1yELIA3z6g/367IQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ju2iGesCRW+FUxlTNWTSRCgy2RFCuZmRYFpVLrljojp/Ih1OBpPciIhZmM3Mzx76Y
 pq5UVjX55O0F8EXS8TaAkyYpSzYdo5XnN3HUDTfqVZjd5Sxm+EgqhUJfUY0qFQsOiM
 WPe43LcxQCw3FNNhUfT3JoeBojFKSdpgkUg8J9I/dv80iMXlTOJQyVuvr1Ic44t/BW
 sshZLtCicnOONQZDNhIZJ2ShtALDJCGKaAWUcBcXH8Jbk1posHGnpQW7HLIfAPf8T5
 5TP+rCS3n73O88MVkDoM2JLsZFfmsE0haaOo3bUAhntO+4hI+BH5xYhaxIiM5tV/MT
 +qH72eefIpddw==
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux

From: Arnd Bergmann <arnd@arndb.de>

The way that access_ok() is defined on x86 is slightly different from
most other architectures, and a bit more complex.

The generic version tends to result in the best output on all
architectures, as it results in single comparison against a constant
limit for calls with a known size.

There are a few callers of __range_not_ok(), all of which use TASK_SIZE
as the limit rather than TASK_SIZE_MAX, but I could not see any reason
for picking this. Changing these to call __access_ok() instead uses the
default limit, but keeps the behavior otherwise.

x86 is the only architecture with a WARN_ON_IN_IRQ() checking
access_ok(), but it's probably best to leave that in place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/uaccess.h | 38 +++++++++++-----------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..6956a63291b6 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -16,30 +16,13 @@
  * Test whether a block of memory is a valid user space address.
  * Returns 0 if the range is valid, nonzero otherwise.
  */
-static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
+static inline bool __access_ok(void __user *ptr, unsigned long size)
 {
-	/*
-	 * If we have used "sizeof()" for the size,
-	 * we know it won't overflow the limit (but
-	 * it might overflow the 'addr', so it's
-	 * important to subtract the size from the
-	 * limit, not add it to the address).
-	 */
-	if (__builtin_constant_p(size))
-		return unlikely(addr > limit - size);
-
-	/* Arbitrary sizes? Be careful about overflow */
-	addr += size;
-	if (unlikely(addr < size))
-		return true;
-	return unlikely(addr > limit);
-}
+	unsigned long limit = TASK_SIZE_MAX;
+	unsigned long addr = ptr;
 
-#define __range_not_ok(addr, size, limit)				\
-({									\
-	__chk_user_ptr(addr);						\
-	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
-})
+	return (size <= limit) && (addr <= (limit - size));
+}
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
@@ -66,12 +49,15 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
-#define access_ok(addr, size)					\
-({									\
-	WARN_ON_IN_IRQ();						\
-	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
+#define access_ok(addr, size)		\
+({					\
+	WARN_ON_IN_IRQ();		\
+	likely(__access_ok(addr, size));\
 })
 
+#define __range_not_ok(addr, size, limit)	(!__access_ok(addr, size))
+#define __chk_range_not_ok(addr, size, limit)	(!__access_ok((void __user *)addr, size))
+
 extern int __get_user_1(void);
 extern int __get_user_2(void);
 extern int __get_user_4(void);
-- 
2.29.2
