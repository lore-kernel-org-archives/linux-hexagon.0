From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 10/21] csky: dma-mapping: skip invalidating before DMA from device
Date: Mon, 27 Mar 2023 14:13:06 +0200
Message-ID: <20230327121317.4081816-11-arnd@kernel.org>
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
	List-Owner; bh=wYy2Rl/7bteIYTFyUEN+i4oYLxwAdkdnYcoGIQSjl+c=; b=AetWSBPw4PU/Sv
	EYWriC6vVBw8NgCoDe1KmI9jmBsSSKrpFACOOXCrsXN2GimJK+JZyxIQilGNcSwaPMVfZyszZFSuy
	6kQSSClRbko6YJ/G4EGJ8YRaxf/0QvPAW9Rge8u6YlVE4NeVPX6/QIfN8JNyfHqWKWz03bozLyNkb
	kQZkYlQM6K2ejbE1gjwWe8iWEEkU2O0N1/g/LbZx1Qi9d8gSj5XfyYKrdZy5owTOwBZZ3o8qpYZ32
	RA5OO+jU7yx0Qyg9PAciufTZJ1jgJUjPHWJKk1ByoR0WXR8lkLNyJ5P+TkcqFD/EIVnAFH7QKcr3+
	+RtL6hsyPSx0G/r0xAkw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919324;
	bh=X7ixDT/eME8zr2M/ikt5bC5rQoS3uASy2IlC1ftIdSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2ffntjZwCcvJ7ZjcddqfIzivLJJTiZqbCBMhicCNOoftlZSKr8SZk1bt+v6QBdJ3
	 AqWhwmcTeaS96y4RUjpqI9FGKTqNfAOz/7RBt+ymuWQLCwljPJr+H8JgdNwFdqMXwE
	 J72tIuLXAnxcA7lDtjwg32UTtKQ0DkssHKQnBWYb3L+gXkApRayP0Mte6XTqD4QU75
	 zUBFdzaO9TiPGVooVFe2U07En2yoiRB9h1tj51608yH2BmWke6vfUVRIXO9jhZyAf0
	 Nifety/7HWh8t+jBWCaVsZT7PH2v1d96plBTbAk5HzBMivkiokDHTCIu3jr6mGkPTw
	 a3+V9R9fKm3ag==
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

csky is the only architecture that does a full flush for the
dma_sync_*_for_device(..., DMA_FROM_DEVICE) operation. The requirement
is only make sure there are no dirty cache lines for the buffer,
which can be either done through an invalidate operation (as on most
architectures including arm32, mips and arc), or a writeback (as on
arm64 and riscv). The cache also has to be invalidated eventually but
csky already does that after the transfer.

Use a 'clean' operation here for consistency with arm64 and riscv.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/mm/dma-mapping.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 82447029feb4..c90f912e2822 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -60,11 +60,9 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		cache_op(paddr, size, dma_wb_range);
-		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		cache_op(paddr, size, dma_wbinv_range);
+		cache_op(paddr, size, dma_wb_range);
 		break;
 	default:
 		BUG();
-- 
2.39.2
