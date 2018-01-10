From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/33] hexagon: remove unused flush_write_buffers definition
Date: Wed, 10 Jan 2018 08:59:56 +0100
Message-ID: <20180110080027.13879-3-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0JuEE1unvevJ5PXqHKEqQaNX4Nl1WkCrydQ4fDGvEz4=; b=UAC+8ksEkuDEi73It5/kWVF/Y
        Y6BUVIwbddZyn5Xo3ac9Udve4li1qA31zzIobX3tgk39lJlXYUipNZo3PMytVWfxHOovvzvU55T2H
        UJAZiGDBnlZzpkeVDlWigyl5u3iPd2V80d7L8O9thN9Kcffj/adkXUyNTHzhIW0mz5TU8MA58jMzH
        GV7LGBlKaalHhg0+3hDO4GiRS4oR1bvjE3wAziaZ7tS8cmOss6IN2RjFQVM3weiRZ3iMe0zXDRoRD
        1FICzN08X3Y0G4K4kqP8qSrzfaKiDZ0cp84RmJUyd6TBlFL4C15PCJGdsPMr7X+26RK7NGDJtd3Au
    
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 66f5e9a61efc..9e8621d94ee9 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -330,8 +330,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
 	}
 }
 
-#define flush_write_buffers() do { } while (0)
-
 #endif /* __KERNEL__ */
 
 #endif
-- 
2.14.2
