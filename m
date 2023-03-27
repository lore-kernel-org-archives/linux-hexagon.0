From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 08/21] riscv: dma-mapping: only invalidate after DMA, not flush
Date: Mon, 27 Mar 2023 14:13:04 +0200
Message-ID: <20230327121317.4081816-9-arnd@kernel.org>
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
	List-Owner; bh=V6hBBmTUb/14a+F7Ok//C2wtII3J+8SfYsLhIka9szo=; b=IZQYML0HGy9Zlt
	cucFH8WqdX8rh0HHOJTGu3CDVCmswa7wxRmdsNLwapef1tGfe/3AGR+vbxCGV821dZ0NgcCe5p9GC
	7GaxtQM7y91dRWqmfEnovtod9cgfIOZM9dy0yLYU2lHeypdoa0m3+gZYrSepah4vnxSJL0iOAla4i
	KyV+9VJwA23uS3pn6OepREDvF7yeSpaCDh2f8MNnQhfWq9puZbXM/CSyRskHDVUeQ6q2LlViFy8Ss
	wVlRVF8tu48Hlf30xaWFrVKhGKLf8dGOUxMQZPo8qQRjOcS2itHjKT7Q8VuVYmW/tNJsFVlSiEDdM
	BHs3AOPCutGmey6x5ZjA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679919307;
	bh=p+eG9OtxIwlFEHuBl1BynARl6RQHBxG84PbOJSDaMSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7yTj16MC4QC0lUkI+OlRgN70GEfUAXZsHUm34awwsfDq+uuBVpGn8XzMpAYzrKep
	 rzfZf9IvuTrt/evwGGuCXfuT5QwwzcXZODB9YgjYpxv0iZgT9rwRfHG1vVFKHMnR80
	 WkjKXapkPoQqpX0z8bvvlpG0YOBt+p7Spw/IdU0XpPUFOYiASiKd39EeZPyxyEYUJn
	 9ZY055tF4c7BVKMQhNCmNKfo+NgnV/grwYyrPuAwvgV7tJNlhsepLbNs91InZGtrtI
	 0UOObEmqhXtHeujJTAybyrsno6jtIGCIZbfee+GXSUa8z2HvG7G/GO5AeAihPvul14
	 jCOgl+Q3LDa9w==
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

No other architecture intentionally writes back dirty cache lines into
a buffer that a device has just finished writing into. If the cache is
clean, this has no effect at all, but if a cacheline in the buffer has
actually been written by the CPU,  there is a drive bug that is likely
made worse by overwriting that buffer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/mm/dma-noncoherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index d919efab6eba..640f4c496d26 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 		break;
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
 		break;
 	default:
 		break;
-- 
2.39.2
