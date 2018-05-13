From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] hexagon: fix printk format warning in setup.c
Date: Sat, 12 May 2018 18:48:49 -0700
Message-ID: <adce8db5-4b01-dc10-7fbb-6a64e0787eb5@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yfxdMOBVsfpbOt27QPans5cYacEarSY4UVqg6HNnMtI=; b=qBNPMs99V10oCHhVPWVqwtHVM
        xvY05o0iDEohhRLvczRAzhwSIDO2iEXZf80Grr+s/zgmj7N2tR2xJQ0sPYhS4WklOWZhR4BdRiVWe
        /JoiF1mHj4JjjZS9eXLl9By1PBs3RuVVNWLCbxTNpy6e7ShB/EPTig7jVN5xdEtr8HGInsAXv7qrs
        F0VbgTMAYa5bEZkoErzw/QHMPy3ok85WBdtOexviMw+YrUK5hDuIV29t3OiqvKWJ+EBAml6B9iLnU
        VigJ9PvS3iGwcNPsY5DNLBWXX/e6+KtDD3DUap/mFRKWYsw504NwpcgAY0h1WruT5FolDrc+pnaLZ
    
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning in hexagon/kernel/setup.c:

../arch/hexagon/kernel/setup.c: In function 'setup_arch':
../arch/hexagon/kernel/setup.c:69:2: warning: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'long unsigned int' [-Wformat]

where:
extern unsigned long	__phys_offset;
#define PHYS_OFFSET	__phys_offset

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180510.orig/arch/hexagon/kernel/setup.c
+++ linux-next-20180510/arch/hexagon/kernel/setup.c
@@ -66,7 +66,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	__vmsetvec(_K_VM_event_vector);
 
-	printk(KERN_INFO "PHYS_OFFSET=0x%08x\n", PHYS_OFFSET);
+	printk(KERN_INFO "PHYS_OFFSET=0x%08lx\n", PHYS_OFFSET);
 
 	/*
 	 * Simulator has a few differences from the hardware.


