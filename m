From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 03/14] nds32: fix access_ok() checks in get/put_user
Date: Mon, 14 Feb 2022 17:34:41 +0100
Message-ID: <20220214163452.1568807-4-arnd@kernel.org>
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
	List-Owner; bh=cVolXD2G4ouD0cp8l+5w5jDAVgC1Kr9ZAQg5Kq4+Jf4=; b=1aqO3axKR3LBCd
	EqXP70tb71F/13YUuN8NI+WtPeBYKcSC8g4qpSfmwRao5gHyVvXjnK57MVopFUF+gjW2Ep6ftyDFd
	WamuatI4+Bm3lktembPou5OJ6WvKnYw2ZqE/IPHiJTdz1IzEOj3mKXn5+HJWa6hR7j4R9fZjufdyP
	m+jTtVXHuEESGrmyUb9CJnaFDgofoz/cT1TmKv72DX0FRYmxWHWOKhBy8nIG1iP8K/ZSlDLBl2nDh
	XPSkwmNqD4AN41dzxiCukhG6mrlhmvUZtZakGe/BQl/bJ28EwkXWz0kbwybPSIgokewoM/BHeR/xY
	01MA+HkEIv6LVswyrqYQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644856574;
 bh=FUHsy4SbKAUYNozm8BPMqbHwV1/3+i881CYSdrE+f4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Z7Q4rLaCN6ssWfRJjiohyNPNSH4AWIFoR2vjhNDxUgjfNfHH7pkAYd6WVfV+n+x9c
 +WV0/jrjDwMQSxFLAlps2jjuMnVZIOeBqY8sTLGXG3NSNoRgN4aMaQF70dC5VmKlbz
 wKgblcbV/RMf4tUWFrLCMmX3JZOR+vd5uu7VMT3O6QlAqKtfqQJRS1nxlvPcGInv/v
 XBstA4u0hl/ULtrxPbm1mmk/7pEjT2RtDdVk6Bgh4FfwDqInSeWgdh0NWTCvDXoa+m
 P2UB2k6eY0IDMT8bDgJE5JjS2hgCmG4/tcDBMzfcaf/rf+9dHCufsKlU4v2Hooyfng
 DxQ3KwkytwjMA==
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

The get_user()/put_user() functions are meant to check for
access_ok(), while the __get_user()/__put_user() functions
don't.

This broke in 4.19 for nds32, when it gained an extraneous
check in __get_user(), but lost the check it needs in
__put_user().

Fixes: 487913ab18c2 ("nds32: Extract the checking and getting pointer to a macro")
Cc: stable@vger.kernel.org @ v4.19+
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/uaccess.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index d4cbf069dc22..37a40981deb3 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -70,9 +70,7 @@ static inline void set_fs(mm_segment_t fs)
  * versions are void (ie, don't return a value as such).
  */
 
-#define get_user	__get_user					\
-
-#define __get_user(x, ptr)						\
+#define get_user(x, ptr)						\
 ({									\
 	long __gu_err = 0;						\
 	__get_user_check((x), (ptr), __gu_err);				\
@@ -85,6 +83,14 @@ static inline void set_fs(mm_segment_t fs)
 	(void)0;							\
 })
 
+#define __get_user(x, ptr)						\
+({									\
+	long __gu_err = 0;						\
+	const __typeof__(*(ptr)) __user *__p = (ptr);			\
+	__get_user_err((x), __p, (__gu_err));				\
+	__gu_err;							\
+})
+
 #define __get_user_check(x, ptr, err)					\
 ({									\
 	const __typeof__(*(ptr)) __user *__p = (ptr);			\
@@ -165,12 +171,18 @@ do {									\
 		: "r"(addr), "i"(-EFAULT)				\
 		: "cc")
 
-#define put_user	__put_user					\
+#define put_user(x, ptr)						\
+({									\
+	long __pu_err = 0;						\
+	__put_user_check((x), (ptr), __pu_err);				\
+	__pu_err;							\
+})
 
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err);				\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	__put_user_err((x), __p, __pu_err);				\
 	__pu_err;							\
 })
 
-- 
2.29.2
