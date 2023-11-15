Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4D1A707
	for <linux-hexagon@vger.kernel.org>; Wed, 15 Nov 2023 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFf3AUw6"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE14AC
	for <linux-hexagon@vger.kernel.org>; Wed, 15 Nov 2023 05:28:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507cd62472dso923930e87.0
        for <linux-hexagon@vger.kernel.org>; Wed, 15 Nov 2023 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700054898; x=1700659698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27kbaYc9o/j9wTLBAVP45tsETwTbQIy8zKNs3tAOssU=;
        b=aFf3AUw6HACU8INstTlF/4ZpPhEi2toseHhRelR0G9Kohvz1QugxFEBsainSppF+PS
         mhZjZSaHuPt4Y9HIHYbmU8vP42iu6FUPO4K4vXJphrAsSI4p5dQOc5XktMwum5ozpWHV
         4X5fAC5EGNQ2bbAUqhCAHA4ui9AB9pVXQcn3acig9ijKkSzGbnXqmqvP/r+xUsC9yN6U
         POUsAITTRqug1bdnvGtcf1WMz6pHpUCdu1Hzupzzxb/7NZvD2gAbnERgBa3UzwTZlzFJ
         JtWWDQgH2rNiC3cWkfvuYFym/fRJHLsoJXoDjoZAQv1y461T8Pr3zYCwmF/iRq0+pDF3
         ZpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054898; x=1700659698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27kbaYc9o/j9wTLBAVP45tsETwTbQIy8zKNs3tAOssU=;
        b=WcRz1h2hXPQOiXLCeKGetyao4H2w0cNcBZ11pXEnrobDZbH5QGEoy61mFfOe5hCoeS
         0C9Ik9nC4gW7CYAtmdGSC2eny2P0tOPxBqZCgnwWv2lpcLI3WJfo3OIBfXFzjs1e78BN
         lwmcCWXowR1A5IxWruNdhS1cpRjTO5Q0JcTsYS0owNoe1HmJEIkUMuC1UwGPhfiSsPje
         GaaOP+xXvj2MMqSRPLEuFe8irgx0/FxbtyJt1a+Y582J3xltwFjA1htwCkyywoN9dVbI
         TUbH8pIbGR7WCZwtWtf6s/iL1I/5jEFpTcy+p/HjNYOtfvEAsfXhGamDIfdqqEwCKImS
         T3Ig==
X-Gm-Message-State: AOJu0YxDNqPlD+6n+cOipzKyT2VJca8hQVB4mlqMjxlWc60BcXfb43y1
	OdT1a8o41d4fkL/xJzZ+AcfBhczpPY3ljX4Fic8=
X-Google-Smtp-Source: AGHT+IF1ifJjaPJepmn4jpc4ZHMqCS1sjn+6cBfSpPYvLaA1BjCWNuLVV5igC58y6bNOjVoqNakptg==
X-Received: by 2002:a05:6512:2248:b0:4fe:4896:b6ab with SMTP id i8-20020a056512224800b004fe4896b6abmr2401582lfu.15.1700054897725;
        Wed, 15 Nov 2023 05:28:17 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id l12-20020a19c20c000000b00507b1da672bsm1648705lfc.174.2023.11.15.05.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:28:17 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 15 Nov 2023 14:28:15 +0100
Subject: [PATCH 2/2] Hexagon: Make pfn accessors statics inlines
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-virt-to-phy-arch-tree-v1-2-8b61296eae73@linaro.org>
References: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
In-Reply-To: <20231115-virt-to-phy-arch-tree-v1-0-8b61296eae73@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, 
 Brian Cain <bcain@quicinc.com>
Cc: linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

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

Acked-by: Brian Cain <bcain@quicinc.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
 

-- 
2.34.1

