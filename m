From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 13/21] arc: dma-mapping: skip invalidating before bidirectional DMA
Date: Mon, 27 Mar 2023 14:13:09 +0200
Message-ID: <20230327121317.4081816-14-arnd@kernel.org>
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
	List-Owner; bh=oYKtyKPvfHO6nbHstspibRqhUuI4p3c+4d/U7ISLUF4=; b=fbhaQjtU4XDXKz
	n9ZgmxQEV4SvmkzDFB5lxM1ph0LGq2GnCToEjHF/MrJo+HzTkFUNPAIEjV9k8F/W/SRg9ktcHSjdi
	DAlhPWjAZJIRUXjjZYVFE8Ps7pE5stNJBna7lOK0NNev1xT941TLcdhaWmKiaFMug/aENLC+cUyR4
	IjTXp65tGvn0tZAK00DUF/zJ0Tb2k9gPY6C0lPVHarLk2cI+LUmyvtUFA42tbVWQPhgVCMRqN0UT8
	fFE+r7Dhy6cE+i2k2b0J3BXjUvpMj1Rx817XbzGZloLvy3dZbEGYwprRH8afivxedeAuboser7+Bv
	2bLneZtCPXzq1ltiLOxw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919350;
	bh=WcyJUuclgspkZHSwVclV5Jksx+zy3hY89ahpztaj0hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gF/2rqKM1LHnyfHfzF1g693XZNfrbHBqd2oKlgoQ2jGFc8xTOws4qsH2njENSW1Si
	 OGeqBCL1Lt3BSCm5fmGZhO1H6HKEoKzetUEYMk3Soh/1yhM8nZtCol16EHntqcT8Er
	 pM+o9uzAgZL1iYBAWUy3z6yGzIeoUU0K+TXymgHYz7EqbCIvcrn8MMo6RRjBuEtKTx
	 6l+8vcM3FOZ1WkoHQ1Wlf6+gyjrHJP0Ci4xI/sPZptxVi/W3OXZggPcMTH3OeaOXte
	 UVzqZh+or7dDyFm/ogv6Vz88DYJfSiZ34SmQ2duChP+VAO1veqEJjztWBBm3dd9c41
	 y9Yt0CcmM/sAw==
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

Some architectures that need to invalidate buffers after bidirectional
DMA because of speculative prefetching only do a simpler writeback
before that DMA, while architectures that don't need to do the second
invalidate tend to have a combined writeback+invalidate before the
DMA.

arc is one of the architectures that does both, which seems unnecessary.

Change it to behave like arm/arm64/xtensa instead, and use just a
writeback before the DMA when we do the invalidate afterwards.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/mm/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 2a7fbbb83b70..ddb96786f765 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -40,7 +40,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
  *          |----------------------------------------------------------------
  * TO_DEV   |   writeback        writeback      |   none          none
  * FROM_DEV |   invalidate       invalidate     |   invalidate*   invalidate*
- * BIDIR    |   writeback+inv    writeback+inv  |   invalidate    invalidate
+ * BIDIR    |   writeback        writeback      |   invalidate    invalidate
  *
  *     [*] needed for CPU speculative prefetches
  *
@@ -61,7 +61,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 		break;
 
 	case DMA_BIDIRECTIONAL:
-		dma_cache_wback_inv(paddr, size);
+		dma_cache_wback(paddr, size);
 		break;
 
 	default:
-- 
2.39.2
