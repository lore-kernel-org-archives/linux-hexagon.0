From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/67] hexagon: remove unused flush_write_buffers definition
Date: Fri, 29 Dec 2017 09:18:10 +0100
Message-ID: <20171229081911.2802-7-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Return-path: <sparclinux-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0JuEE1unvevJ5PXqHKEqQaNX4Nl1WkCrydQ4fDGvEz4=; b=MWDluzQz7YabNI2B/3OQy+A2n
        opgvgPhMANbomhkv05tmdnwvwoYYcIkum22hVekDO6tvNuxxrscsvUCo3RN5skSj3vah6qr8Fj8YB
        2x8IpyZZe5zsFp1TcTSA7p822IoxVIb2da/jnAonsTDtgPGHHGC8PbVAs3VFwV47mkmy071OVYGuQ
        XvaJjo53I8NipSsRXEo9MR4dTK8zVI1cKFNJXvoIgaNf8jycE6MIeeOW9IbnsNm8om68g4IpFDbfd
        LgE7FAqk7e/UwOCAcgjhyzRRHJ4SOJABBVrn1T4IfH10lBvFUH7A6/+LJEyO2RhqTzpte/aTxzk5c
    
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
Sender: sparclinux-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

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

