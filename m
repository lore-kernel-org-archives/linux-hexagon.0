From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 3/4] mips: drop definition of pfn_valid() for DISCONTIGMEM
Date: Sun, 29 Jan 2023 14:42:34 +0200
Message-ID: <20230129124235.209895-4-rppt@kernel.org>
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
	List-Owner; bh=Nc9KURSSHbg8Q+mRJzQEufbH2bm0X4tTjBplT1Uyvrc=; b=E0cqc631dZ/DRg
	owxiuj620luR/1IEUbYAvK8QKQAF5dAsv21lXDZwt6eHddkoBoC9kKWqcA78zxP/1+pLn0haBRbbx
	3U+Np92Wi1kyCwLFx6YNxNBE9Sa2IGoSENzlGzEuQGSuJJktZxqojOwbRkRQ05DkHi9Kv/PAxj0ab
	jka80CRAzL+Itlru4SSvrU4sejvgNwSr4SxxCfJVTy/cPVVxX/Rh6wNrckx4+KnCTceZMxcQSnlbg
	sUjIqkrfrBLeGUhBtmciTiUUcuUOmy5F7s/ghawL7KwPcx62WN2b4XjK9Fx+j1tyXwY+fGl4QeSLB
	TxeXWepQ08JZdsLltsHA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674996210;
	bh=TNKTwe+UR0ceH94DVHkVlPLs1JCpp400iKAUs+FXrEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHOqK+fkBQfue2/LgvXT5/OFdAT2H2FDvjblZicbNXbJBXdpPk6eRh5KAzlpLxCYr
	 +ZshLmihJgfk3B+zAwo730+puTcbIc8k+mnQeD2+zmdUjKYXlyfsgcn6GYvHDuUc19
	 AOHGXLEYgfNJeOc530SeCns3uW1t7x0orjihKEYEIIT5GQHR6IqYB/gEFrjidz/2dv
	 f0dKfcsUeo0xUm2dYF+qX8c/XDVdQtMrsNcKx4lXhoiKAIFdyDDeO7DFDI10MnLJsj
	 Zihs3LV7jZdAazuy4Qto4ScBNLLuXUWDyHAfB37wPKFgGicdZknfE+MkdxncDSrEh9
	 WkpxoaJlG/GPw==
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

There is stale definition of pfn_valid() for DISCONTINGMEM memory model
guarded !FLATMEM && !SPARSEMEM && NUMA ifdefery.

Remove everything but definition of pfn_valid() for FLATMEM.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/mips/include/asm/page.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 96bc798c1ec1..9286f11ff6ad 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -235,21 +235,6 @@ static inline int pfn_valid(unsigned long pfn)
 	return pfn >= pfn_offset && pfn < max_mapnr;
 }
 
-#elif defined(CONFIG_SPARSEMEM)
-
-/* pfn_valid is defined in linux/mmzone.h */
-
-#elif defined(CONFIG_NUMA)
-
-#define pfn_valid(pfn)							\
-({									\
-	unsigned long __pfn = (pfn);					\
-	int __n = pfn_to_nid(__pfn);					\
-	((__n >= 0) ? (__pfn < NODE_DATA(__n)->node_start_pfn +		\
-			       NODE_DATA(__n)->node_spanned_pages)	\
-		    : 0);						\
-})
-
 #endif
 
 #define virt_to_pfn(kaddr)   	PFN_DOWN(virt_to_phys((void *)(kaddr)))
-- 
2.35.1
