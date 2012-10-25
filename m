From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH RFT] hexagon: dma-mapping: support debug_dma_mapping_error
Date: Thu, 25 Oct 2012 17:12:11 -0600
Message-ID: <1351206731.6851.10.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo@codeaurora.org, arnd@arndb.de, linas@codeaurora.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com
Cc: linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/hexagon/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 85e9935..1957c4c 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -65,6 +65,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
+	debug_dma_mapping_error(dev, dma_addr);
 	if (dma_ops->mapping_error)
 		return dma_ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5


