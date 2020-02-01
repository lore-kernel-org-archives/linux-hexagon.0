From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/hexagon: fix punctuation in SMP help text
Date: Fri, 31 Jan 2020 17:54:03 -0800
Message-ID: <09765113-6064-9be3-c1f9-19947e2afa4a@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aK5HMxJWe9BbxviT1wbx7h4LJPrrlS0wbe9GNcZNOIY=; b=YJUBvIPczp3UISQFBphrC2dVF
        9mfFWG5EIxdBnG2rkPwzBximLbAveSQe3vCEZpmMO/rTUiow39n54m5kFoL6TAUvoBbkCIISP2UJg
        UkCQMUi6LsrxGNV7oCW3kt/a2JCsytCIcmsq2tSLwpSqeg1a1hRVcCxmKSOEEtCW+oiK2p1gXjSA2
        jdu7B/ANYnPa4ZipLa/6jVbGMUzTV71LTYpGQRvk2PYnp7KHjcn9c5Hx+MOsfVEC3b1/O54o2DF6Q
        LuVw/fBmedPSDntmy4HlQqUCKv22aYOwwd0TRsActl10c0E+JONsTQfIniHuH7naYFW2dVs8aR0PE
Content-Language: en-US
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

End a sentence with a period ('.') in SMP help text.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
---
 arch/hexagon/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/hexagon/Kconfig
+++ linux-next-20200131/arch/hexagon/Kconfig
@@ -105,7 +105,7 @@ config CMDLINE
 config SMP
 	bool "Multi-Processing support"
 	---help---
-	  Enables SMP support in the kernel.  If unsure, say "Y"
+	  Enables SMP support in the kernel.  If unsure, say "Y".
 
 config NR_CPUS
 	int "Maximum number of CPUs" if SMP

