From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0146/1529] Fix typo
Date: Sat, 21 May 2016 13:55:29 +0200
Message-ID: <20160521115529.7104-1-andrea.gelmini@gelma.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=a9sjUWpmh9Z6kXRIH8ahJ/Lbp+wpzpmrt/wR81JooBk=;
        b=pTp/VjOtj947Bf/9u4V67RRpX8VeaiCI4tbOtx05qv7oHsLwOXZLaFCpqkotYv1Mop
         2rtfsuJ+RISs2sTZi8a2/Wtij9iVePPqjvFLrKuPtPbH0OjkyKzDq8x8HIvsZae56rgV
         x4KP820QqHVaFNc6noEKYM5/ExEfw6SpbRuGdGoBXUSl0cBobWF6EHQnh/XwTcVFm2p7
         kgmFB/m7eRzz4OrXG8Byq3Xwj3DDcVVdTiXmNO24pCPgxXwq3zKGj95xdWbGMpkK0eB2
         N1MC/mRK7q0sOJqXAkJR4eYhMo9pGAYUnUrLJAx3fwZv28Zgu7HeHi+wBhjJzjXmnOG7
         f92Q==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/hexagon/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/kernel/module.c b/arch/hexagon/kernel/module.c
index 477d07a..d7aa9d0 100644
--- a/arch/hexagon/kernel/module.c
+++ b/arch/hexagon/kernel/module.c
@@ -56,7 +56,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			found = i+1;
 	}
 
-	/* At this time, we don't support modules comiled with -shared */
+	/* At this time, we don't support modules compiled with -shared */
 	if (found) {
 		printk(KERN_WARNING
 			"Module '%s' contains unexpected .plt/.got sections.\n",
-- 
2.8.2.534.g1f66975
