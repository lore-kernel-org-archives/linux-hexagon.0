From: Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] hexagon: define ioremap_uc
Date: Mon,  9 Dec 2019 14:29:55 -0800
Message-ID: <20191209222956.239798-2-ndesaulniers@google.com>
References: <20191209222956.239798-1-ndesaulniers@google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bQkMIXCQ6JhHHUfx0puV3Z6acwFjFfU42F7sTftKhD4=;
        b=N8rz3xkqm7uAha+HtqB5j32nTJonEkwcr0XJOzEadMjCIWHfCiKEvNoh98J/2Lq+gR
         Qi17CEKhCgxFtsRUXWRHclvtpbbcrY4TxbZJDRMcjWraSjLzsoSP7DrsHqGz/TudjqIj
         UP1GwdMnaHjBkXi/VGiETx5OOEb1iFHm4BlYMLlRjYvU3viRWC7pDR3Dj54tKtUqG9ZX
         h2PU1JYaxkUse4+qwLV/Ud0ihdxHkdmpiv/DQx/qoy62/RX3V+cHNtKfKTy/vRYv3qWj
         bmhvuupaMh0Jq5B3R8vXCZJATE9KwbXY7ImF4QzuY3/uXSY9TJOnloJ9Byefe1yNMUaX
         mftQ==
In-Reply-To: <20191209222956.239798-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, lee.jones@linaro.org, andriy.shevchenko@linux.intel.com, ztuowen@gmail.com, mika.westerberg@linux.intel.com, mcgrof@kernel.org, gregkh@linuxfoundation.org, alexios.zavras@intel.com, allison@lohutok.net, will@kernel.org, rfontana@redhat.com, tglx@linutronix.de, peterz@infradead.org, boqun.feng@gmail.com, mingo@redhat.com, akpm@linux-foundation.org, geert@linux-m68k.org, linux-hexagon@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>

Similar to
commit 38e45d81d14e ("sparc64: implement ioremap_uc")
define ioremap_uc for hexagon to avoid errors from
-Wimplicit-function-definition.

Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
Link: https://github.com/ClangBuiltLinux/linux/issues/797
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/hexagon/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 539e3efcf39c..b0dbc3473172 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -173,6 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 
 void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
 #define ioremap_nocache ioremap
+#define ioremap_uc(X, Y) ioremap((X), (Y))
 
 
 #define __raw_writel writel
-- 
2.24.0.393.g34dc348eaf-goog

