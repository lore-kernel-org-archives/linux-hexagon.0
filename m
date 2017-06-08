From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/44] drm/exynos: don't use DMA_ERROR_CODE
Date: Thu,  8 Jun 2017 15:25:29 +0200
Message-ID: <20170608132609.32662-5-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VolBZDxS9ZQrQoHzmubjiZ2v8Rk+FgSixd/DX4o9p2E=; b=gF+6aDODIb7xcHBd7xdo+sHop
        1Bh4UuYpu1Mt5Zc9LJ8djA0u+qYbfjcRYBu4PgpcovWdfLQm5pSH+ik9urNqGCEWSDi90KUEDViK7
        z8/HkDLChErmKMHxPDVsohs4XTYF4id0ezPjvvBExGPcnSTPr8igshrAvzNnY3GMfw05ZJWzzUN0N
        Z8oB7GyXuCvPufd6GNByT/f7+3sAkQ8KBbP8qdBQkNUFtl+HR7pKHBvOxNjOo+8lqAL48nU/8boOd
        LEp/A5jpWQxpGvfUxQ8l5+0KIH+cOuxOrwzQUCVTFf4DT0FgelbP3BwTQYP+o+NYV2T+uQupQN8qz
    
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

DMA_ERROR_CODE already isn't a valid API to user for drivers and will
go away soon.  exynos_drm_fb_dma_addr uses it a an error return when
the passed in index is invalid, but the callers never check for it
but instead pass the address straight to the hardware.

Add a WARN_ON instead and just return 0.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index c77a5aced81a..d48fd7c918f8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -181,8 +181,8 @@ dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index)
 {
 	struct exynos_drm_fb *exynos_fb = to_exynos_fb(fb);
 
-	if (index >= MAX_FB_BUFFER)
-		return DMA_ERROR_CODE;
+	if (WARN_ON_ONCE(index >= MAX_FB_BUFFER))
+		return 0;
 
 	return exynos_fb->dma_addr[index];
 }
-- 
2.11.0
