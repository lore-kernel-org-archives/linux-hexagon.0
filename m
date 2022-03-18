From: Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] Hexagon: fix typos in comments
Date: Fri, 18 Mar 2022 11:36:57 +0100
Message-ID: <20220318103729.157574-2-Julia.Lawall@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JVYTpZ2S+jPM8aku+6zMmH5pu/hPftoGDQ9F+um17w=;
  b=En+N9Hx9lTWX+XtGUc70HCD0z0A6SiL1rF7KDG3bHgmUzIW1Z9yDsYrH
   gxCJECVTQw6u4uiyXkJ4GewzRWchuv4FE1khmMtEiEzaVBuXj/9opALdK
   99nZ1QcJVYqeGL6lw9T6BbPKPxTqntmnL/KNPm9zeFwOLz2S1veWvG1Jk
   M=;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@codeaurora.org>
Cc: kernel-janitors@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/hexagon/kernel/module.c |    2 +-
 arch/hexagon/mm/vm_tlb.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/module.c b/arch/hexagon/kernel/module.c
index cb3bf19b0640..62ab39027360 100644
--- a/arch/hexagon/kernel/module.c
+++ b/arch/hexagon/kernel/module.c
@@ -43,7 +43,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			found = i+1;
 	}
 
-	/* At this time, we don't support modules comiled with -shared */
+	/* At this time, we don't support modules compiled with -shared */
 	if (found) {
 		printk(KERN_WARNING
 			"Module '%s' contains unexpected .plt/.got sections.\n",
diff --git a/arch/hexagon/mm/vm_tlb.c b/arch/hexagon/mm/vm_tlb.c
index 53482f2a9ff9..5b6673353120 100644
--- a/arch/hexagon/mm/vm_tlb.c
+++ b/arch/hexagon/mm/vm_tlb.c
@@ -46,7 +46,7 @@ void flush_tlb_one(unsigned long vaddr)
  */
 void tlb_flush_all(void)
 {
-	/*  should probably use that fixaddr end or whateve label  */
+	/*  should probably use that fixaddr end or whatever label  */
 	__vmclrmap(0, 0xffff0000);
 }
 

