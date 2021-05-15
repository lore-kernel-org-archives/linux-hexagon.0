From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 6/6] [v2] asm-generic: remove extra strn{cpy_from,
 len}_user declarations
Date: Sat, 15 May 2021 12:18:03 +0200
Message-ID: <20210515101803.924427-7-arnd@kernel.org>
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
	 bh=DgVytqFjBuVcwQKGFL4Kyasoz451RwvwlrvkCBSqVBs=; b=kgckZxfcAqazHGB9BBA/kyMfB
	VpL/6yuF86w9Zfcks0zpn2W5OaJ3fzVBYhZoS3Nao+2idXieTy7v9FUanrKVii9R4Kb+DglQQjU56
	1b9ytKZYNLqDIdlQYa+QyCfojUfL2yQdaKJby3/q1aAQjcnQpoP8kkT4P8VqhmafFFDRjh0feb3ZM
	wdvz4K1cQUkUX9AEvDxFBodOMYE+x6j90KJi7OkLnUHv6oFU2Zj5ZlT5sm0dyAKUPWSO7r6qB43fr
	YuMld+/uJiDLiTXmdo1oS7K4ynlpSO/xv++fhb4mFG2Fd1MstOK+Iyc8wFeCTMOZ7iwkm5DLta5zh
	WfzhRys0w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=9Fw1IFvYq/KjZTRKKWVzQNRcjazScUqC2uvuOnLwQW0=; b=Y+uvjse+1MvjzSJhMngSlDQ4KV
 kWrh2ud6kQ7RCMGXTCRDj6porqRUfY3+v0uf0csvvqMOEBDEpQ/gJT1cSolZMPj7wOrTK9ktKejbE
 PuxXHEj+Q/w2ZAH+gPLp/UMm0zeyDaXzYL1UjadCHfJBAmAAwNTDZYOr27Sq12KsE0ELXyHIfOcox
 pr0/xC/mZ1hLZ9Qo8O+4EpQK4ohZ0U+OdlccRLI2tHCBaNQ77FmIj7TuPUTc/O3MNYhRSQ0rPr6Lt
 2ZZDrjRqGleoDY5F8X62SMgVE2xWwsfrkKNv0nJdgv7NjUo6YjT1My3bDYKzS2gS+8XG7yhach++3
 hyKfDKWw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621073967;
 bh=Lb/DGS9E/FUSMtSHAOCH5rcc8a7ucnqACx5B/SB9r64=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lp+IzcRjKvLR7R++grQxnLp5gtXP/qgN/cg/jcb91yHCafo9eiUfkQxObCDBCGovC
 TFKLGUohWA3fQwZPvPi3so4qDwe/nQwdVB/Zpg89Ei6NLVc98yHvm8h8zpxNkOXOzJ
 HqlnbG+AOzcfs7TiPxwHgCjBWg/sp1i9Mx+5NkeL/2X5g4YE7j9kLgiy41okPcWaDK
 GZ3hLjqev+EZ0yJmEGmLgCdC9w79agdGf9FvOnZDObtON4etwgfiPcWKWiAgelyks0
 Gtn4EtMiZohOg//Wb49qpe1Brp+XFagahm8puDaxQjJ1NEBFDVrRK656cJmTzk6wAb
 0ws3B/3Ao+LfA==
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

As these are now in asm-generic, it's no longer necessary to
declare them in the architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/uaccess.h     | 5 -----
 arch/hexagon/include/asm/uaccess.h | 6 ------
 arch/um/include/asm/uaccess.h      | 5 +----
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index 754a23f26736..783bfdb3bfa3 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -667,11 +667,6 @@ extern unsigned long arc_clear_user_noinline(void __user *to,
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
 #endif
 
-extern long strncpy_from_user(char *dst, const char __user *src, long count);
-#define strncpy_from_user(d, s, n)	strncpy_from_user(d, s, n)
-extern long strnlen_user(const char __user *src, long n);
-#define strnlen_user(s, n)		strnlen_user(s, n)
-
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index d950df12d8c5..ef5bfef8d490 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -57,12 +57,6 @@ unsigned long raw_copy_to_user(void __user *to, const void *from,
 __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count);
 #define __clear_user(a, s) __clear_user_hexagon((a), (s))
 
-extern long strnlen_user(const char __user *src, long n);
-#define strnlen_user strnlen_user
-
-extern long strncpy_from_user(char *dst, const char __user *src, long n)
-#define strncpy_from_user strncpy_from_user
-
 #include <asm-generic/uaccess.h>
 
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3bf209f683f8..191ef36dd543 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -23,16 +23,13 @@
 
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
-extern long strncpy_from_user(char *dst, const char __user *src, long count);
-extern long strnlen_user(const void __user *str, long len);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
 static inline int __access_ok(unsigned long addr, unsigned long size);
 
 /* Teach asm-generic/uaccess.h that we have C functions for these. */
 #define __access_ok __access_ok
 #define __clear_user __clear_user
-#define strnlen_user strnlen_user
-#define strncpy_from_user strncpy_from_user
+
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-- 
2.29.2
