From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/34] alpha: mark jensen as broken
Date: Fri, 12 Jan 2018 09:41:59 +0100
Message-ID: <20180112084232.2857-2-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fc+yufmsekcunyWNZ4Si3kNXZUA9/EcLDknX/xtVMxA=; b=o3gWIkbwwLEX+NKNzTiu8H8ZMS
	/OIUE5qwprjnU6OCP2Apc/d6fOAXmhJb+cF6say8o7n2GPlFmLXm9NRo82v383+eCxCPtnnZax/B9
	K3Hf/bl1N8T0TqB2BP1OlMk2P9O3X2EL7TcMA4r2tcjMqcu5ED7Xft/wC66c3GzuVOPT7aJ35youz
	MimaNmkP37OYreJeaDcsh5GdNcnI4nxjeaw7vchGC9qvWJNNkD/dTYrUqlxNiu2R3dZLAARkW+W8N
	DZRFRHW+5oylPtmOIyHMpINMK746Yx2hM2YhXp0I8TZ652N2TQzPUD4wNFMxMtE8nDj5lKBCPWn2v
	nMUKfOEg==;
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

CONFIG_ALPHA_JENSEN has failed to compile since commit 6aca0503
("alpha/dma: use common noop dma ops"), so mark it as broken.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b31b974a03cb..e96adcbcab41 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -209,6 +209,7 @@ config ALPHA_EIGER
 
 config ALPHA_JENSEN
 	bool "Jensen"
+	depends on BROKEN
 	help
 	  DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
 	  of the first-generation Alpha systems. A number of these systems
-- 
2.14.2
