From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU and !MMU
Date: Sun, 29 Jan 2023 14:42:33 +0200
Message-ID: <20230129124235.209895-3-rppt@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
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
	List-Owner; bh=Xb8wzyVWANZbRWMKEkTdNH6HdlGzjCKxRyF5qvBrVss=; b=zdnXvgTHyoSsZg
	HxBz1jyYuhE8FwRXsgj9C9V6fA9JV6KtGZuOMCVCcCU3d2zrAlinlSjnx+nrHkBXEV+v8OVkvnhwA
	i6/6fGawC/tNorNhurclXjU3pe4tcOh3j68ufj4tVHegnWArPUyVfFoe22vjLFhQx2sTOofruid8a
	ZErP0RJXyPPjW4cSdwRzHplUI+gBZRbdenOlj7psZlJ87O5Hu3vOWhgy35i8E/6xM/JQXGWsy/xvk
	nyycN9PN3SwQEy/X9JQyzMaw5N8c5LlX3uR+feCEj4sQpn5v4aDdlTCEUt6yksXefMIqtS5ntfcEo
	MUb4X+CZHwwFhHcrT55w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674996199;
	bh=LN+b67L2GuYmW7NwwfmoYPOQn6/pUneVShVCsQXwAMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0nQr0pB/ARk6wpI1wApVcVwgzvL3nJvZL0d1rEEnUQjWCN8tFtMC8RLAoPrMcWp2
	 RDTPNMDGCtYLZKrFtqYc+unayS8BpfmpBREVaITviVkY9SQqoa9DIPak7ZMaylUoNU
	 XkEUMVMunXKWmZPR9BcpXjNlA5vQUkeeuQZo5bDTV+GIseFI+xGOGnl6U0jF878itf
	 mh/e6H0Y33/zTuC21r/0CJPhnc1+7P3/Qqea7El3CYfWpYJrYLN7QObiWb+sV322Md
	 3wRUSA/Myj0DO5A4pbRCW2jOQFtmwI9nGJsN3Q1ij2VEBYnaXPWn8lukuSf+C48vvu
	 mJ0VjB6iJLE0w==
In-Reply-To: <20230129124235.209895-1-rppt@kernel.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@list

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The MMU variant uses generic definitions of page_to_pfn() and
pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
good reason.

Include asm-generic/memory_model.h in the common include/asm/page.h and
drop redundant definitions.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/page.h    | 6 +-----
 arch/m68k/include/asm/page_mm.h | 1 -
 arch/m68k/include/asm/page_no.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 2f1c54e4725d..a5993ad83ed8 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,11 +62,7 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
-#ifndef CONFIG_MMU
-#define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
-#define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
-#endif
-
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif /* _M68K_PAGE_H */
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index a5b459bcb7d8..3903db2e8da7 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -134,7 +134,6 @@ extern int m68k_virt_to_node_shift;
 })
 
 #define ARCH_PFN_OFFSET (m68k_memory[0].addr >> PAGE_SHIFT)
-#include <asm-generic/memory_model.h>
 
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index c9d0d84158a4..0a8ccef777fd 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -26,8 +26,6 @@ extern unsigned long memory_end;
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define page_to_virt(page)	__va(((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))
 
-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
 #define pfn_valid(pfn)	        ((pfn) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
-- 
2.35.1
