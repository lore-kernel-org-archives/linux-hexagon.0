From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 2/3] mips: drop definition of pfn_valid() for DISCONTIGMEM
Date: Wed, 25 Jan 2023 21:07:56 +0200
Message-ID: <20230125190757.22555-3-rppt@kernel.org>
References: <20230125190757.22555-1-rppt@kernel.org>
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
	List-Owner; bh=Nc9KURSSHbg8Q+mRJzQEufbH2bm0X4tTjBplT1Uyvrc=; b=Lg6tp7Th8z7bO+
	7PKfduuK9m9pmUslnsZ0/ku/68rQbTYxGqkermNbQkXp3fm9Y0O+Ll+fN2jHYy+c7nDqj8fGkuZS6
	bZ6qYLpdTHk7LAcPhBokdYJ2J3yLMEaqhXg0UGNiS7UWY6P43C+whOpUsxlK4gZbyr1JttS6HPWxA
	MbW49HFGTPA+f3lDVzmMHSP0Cerc7XLUKwN4HgLWn/MZOOsfofzGnKxEyVBEQyDWiIeOy6hy8B+hY
	9yOSDhhkm0G9dTePU17zQja0+WSf4R4TzcfCQHeofIEFvhUNerx8h4wz6j31zU4lglu6PH94MkvpS
	U8mzs5ce3OUxhZpHz2dw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674673721;
	bh=TNKTwe+UR0ceH94DVHkVlPLs1JCpp400iKAUs+FXrEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3jdBK0rt95oJXQpHyDSd2FKY40hm9U8H2r8cDgoJuDx7YDiY7e//KIo42MnYQDFl
	 yQmL7WKzB7s4oFY8V5/tKLgfG8mwnId3oI9LYhFcsnOt4yGJDZUdVzE2htJsGKqtsZ
	 GO6h8IdJNcv2de5AIgZKhZ4ECBZ+hzs/Tuz45qdKLCt5fmgVLmxMBeCy5EwvVg2waU
	 DDQbULZEonzqn4s3vaAdzVkwi4v8hp/Zo+nZA+yqBMSFvm72KBgBGmtfLGQSnwTPHK
	 97B7v6Sd79PnhkzX5BjiFX1uoLwgXashF9p/sPPGZHQtMupT6tRcnOuB4caGN44DCv
	 bqdV5sLP3jU5A==
In-Reply-To: <20230125190757.22555-1-rppt@kernel.org>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>, "David S. Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, Richard Weinberger <richard@nod.at>, Stafford Horne <shorne@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vineet Gupta <vgupta@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux--csky@vger.kernel.org, linux-hexagon@vger.kernel.org

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
