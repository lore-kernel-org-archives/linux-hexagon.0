From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] Hexagon: Make pfn accessors statics inlines
Date: Thu, 10 Aug 2023 09:41:47 +0200
Message-ID: <20230810-hexagon-virt-to-pfn-v2-1-ec8b4152f9fe@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653308; x=1692258108;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9JjIvfMur6gn/jWCq4DFu7qCLyJ7WcwWmX8GtDsRIk=;
        b=mVOiEl7ELLi0lMnbWmVoEtSc+/Nc8urH4vO/fjVk5P5kluFBUqfORnQ6tNomAN6xPf
         1uOeQ45UZoVz7xEMCnf6xpKxHW857zRgpAAGF8fUU4cegvRl02KAXC7fnYAxXs+8QKv7
         uekN53HY7boQLgm6PxHtYeOVgXnsuDCpaE7yw2cmwHXq1lRgvgLlcu/4rhURpkX98eZs
         GWll0RG+j3cs/BZ6B83RoT9nqZkFZwSQ/buuGPzqGWbxf9xhEzCPUlE9apu7ASYaOTuW
         9/8m+rf/5+AmQ3sS8JIwlJXTP4gGVFxnykGyLhkRswah9TVMywT4/DGigZI0scxdOOIv
         KXfg==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@quicinc.com>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry do the same with pfn_to_virt().

For compiletime resolution of __pa() we need PAGE_OFFSET which
was not available to __pa() and resolved by the preprocessor
wherever __pa() was used. Fix this by explicitly including
<asm/mem-layout.h> where required, following the pattern of the
architectures page.h file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Use more elaborate casting back to unsigned long before shifting
  in pfn_to_virt and back to void * after that.
- Link to v1: https://lore.kernel.org/r/20230808-hexagon-virt-to-pfn-v1-1-68d07c221f17@linaro.org
---
 arch/hexagon/include/asm/page.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 9c03b9965f07..10f1bc07423c 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -78,6 +78,9 @@ typedef struct page *pgtable_t;
 #define __pgd(x)       ((pgd_t) { (x) })
 #define __pgprot(x)    ((pgprot_t) { (x) })
 
+/* Needed for PAGE_OFFSET used in the macro right below */
+#include <asm/mem-layout.h>
+
 /*
  * We need a __pa and a __va routine for kernel space.
  * MIPS says they're only used during mem_init.
@@ -125,8 +128,16 @@ static inline void clear_page(void *page)
  */
 #define page_to_phys(page)      (page_to_pfn(page) << PAGE_SHIFT)
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void *pfn_to_virt(unsigned long pfn)
+{
+	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
+
 
 #define page_to_virt(page)	__va(page_to_phys(page))
 

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-hexagon-virt-to-pfn-457bd51a5744

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

