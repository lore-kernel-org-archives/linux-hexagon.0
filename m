From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from page.h rather than memory.h
Date: Sun, 29 Jan 2023 14:42:32 +0200
Message-ID: <20230129124235.209895-2-rppt@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674996188;
        bh=cgWDMwNotrvgtwLOXkxr022OhYpC4uBm5qKZZMTCdc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOlDKwso6wRfZVylh618GS0Ouplr5vx0EbZPPHD3xUb+8QoPpiFEHadR57onqorCd
         YVV0X4T7n8gLAlDCcDoHkjHy+WzsJoiwhi5dfYlZ0/SJbhBTB4CLpq8O6xDe8ABdAj
         ibLF/6hCOLr13VOj/azi035hOFFfeFmuDXjRvCo9nQzUAZ1DneDknyLVqg+z3u91Hb
         JSM0yS+mjSe2REo/FRs3DbdIX7npqpWYBVELIqlPxuJWRXDIEj2eP/ud0TKhe2R7e/
         shdVeHbLA/9GwBZjKAbCX1zbNI+chUKkqGr1E/I9bnpduDb0l68n12sXR48UTQjqrn
         2HPElfopuZj9Q==
In-Reply-To: <20230129124235.209895-1-rppt@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Makes it consistent with other architectures and allows for generic
definition of pfn_valid() in asm-generic/memory_model.h with clear override
in arch/arm/include/asm/page.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/include/asm/memory.h | 2 --
 arch/arm/include/asm/page.h   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d8eef4bd8c71..62e9df024445 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -386,6 +386,4 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 
 #endif
 
-#include <asm-generic/memory_model.h>
-
 #endif
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 5fcc8a600e36..74bb5947b387 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,7 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+#define pfn_valid pfn_valid
 #endif
 
 #include <asm/memory.h>
@@ -167,5 +168,6 @@ extern int pfn_valid(unsigned long);
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif
-- 
2.35.1

