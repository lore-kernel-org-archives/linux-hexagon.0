From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] hexagon: add memset_io() helper
Date: Fri,  6 Apr 2018 16:28:22 +0200
Message-ID: <20180406142832.2243021-2-arnd@arndb.de>
References: <20180406142832.2243021-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

We already have memcpy_toio(), but not memset_io(), so let's
add the obvious version to allow building an allmodconfig kernel
without errors like

drivers/gpu/drm/ttm/ttm_bo_util.c: In function 'ttm_bo_move_memcpy':
drivers/gpu/drm/ttm/ttm_bo_util.c:390:3: error: implicit declaration of function 'memset_io' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/include/asm/io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 9e8621d94ee9..e17262ad125e 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -216,6 +216,12 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 	memcpy((void *) dst, src, count);
 }
 
+static inline void memset_io(volatile void __iomem *addr, int value,
+			     size_t size)
+{
+	memset((void __force *)addr, value, size);
+}
+
 #define PCI_IO_ADDR	(volatile void __iomem *)
 
 /*
-- 
2.9.0

