From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
Date: Mon, 27 Mar 2023 14:13:05 +0200
Message-ID: <20230327121317.4081816-10-arnd@kernel.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
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
	List-Owner; bh=sjt+Ra3k6GeBw6s1pr+WWzzMceXT8uYQqSqyJkW2H78=; b=eTale3KEcUDE2k
	JgDxaARPmNWZHzmnEgr7nJCpsdqtFipTeg4pkOQ1YQUqmXxB1enZeuWSXeBe8dSj8TE86aP90WecX
	LJj9pBIkraWmIZcZlrUCd1Pwgit0LV1U2/SeC2ceE7rw8kmca4kX9h5vNU7i9u2scBG0DiwAxWWWS
	Z4NbHGy7UKJvD9C0dMjtvcneLn278y3iIsH1bPG/qrhQgiOIBfkoJrq7ZtG22LhTUI2mvQSXbAjwA
	sirurecFvH9IxXSiJ67AT3Ey+dPzqlkafyUuUoDe8V/bgYgO/eKPfuxgy7cprplUtBlHyupUmU+pl
	wKpI74YvRcYN+lboILLA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919315;
	bh=gK+eQNvNHVtgIlRiu3kF6HYH3yBsX0klGJL13i4k/aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMy3k5gM2XS604J4ArMuSWvMXzgs2AlKyYx4fCZS7J/lWvOZ2Yw/Z/jrtMa5gIHU9
	 FjlooO1xQTngsA6hbEvqN4tEnshVSie7B+AEJaU1Cy1oTWuJpEfFFlaRXS3tq+GwRJ
	 er3cljYGerTP/ivX+B9p913oVNSRI6mJdCnknZw/+Go9C3u3Axj27xDUpsuC4nBj8r
	 bgnEtVHNKaiAki6GHJ1OFvO5x00a1gCx3DhHWTCMKP7Wv9fwGxJu8GpPhhiTKRkk1x
	 zZRoP0hNRHHFBO8EoUedx3N9IqVzTMyc60Fp/OWdtgr6CAuRCyXfSdikQcmkzRIL2M
	 hyE6lbMlfVtJQ==
In-Reply-To: <20230327121317.4081816-1-arnd@kernel.org>
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
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.>

From: Arnd Bergmann <arnd@arndb.de>

For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
first to let the device see data written by the CPU, and invalidated
after the transfer to let the CPU see data written by the device.

riscv also invalidates the caches before the transfer, which does
not appear to serve any purpose.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index 640f4c496d26..69c80b2155a1 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
-- 
2.39.2
