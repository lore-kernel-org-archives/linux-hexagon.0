From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Subject: [PATCH 4/7] hexagon: asm/io.h: Expect immutable pointer in
 virt_to_phys prototype
Date: Sat, 15 Apr 2023 04:17:42 -0700
Message-ID: <168155746272.13678.16103862954212080276.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8806821C33E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617335;
        bh=sj6LPYNvymIeZEc3MyNCG2Y2lTHGTHDS4BHT1bAwr3Y=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=Z63G6khxN1OPq0ZG7hjZeqCgnQ5dGb2R4fM1LshMq7Ib3jI0XzV9Hjp1g+/hL2TBe
         1B3HjnIiQHcC967R9SnMk6mY1Jtmh8zcJ2gIhGAwmINGBN2VpJODCf0+HD1hue4DwR
         NMtoUFf36vlRNMFGNZ1dUod0jepQDsbhlr+RbQ2o=
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
List-ID: <linux-hexagon.vger.kernel.org>
To: 
Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>, Brian Cain <bcain@quicinc.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

These helper function - virt_to_phys - doesn't need the address pointer to
be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Brian Cain <bcain@quicinc.com>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Mark Brown <broonie@kernel.org>
CC: linux-hexagon@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/hexagon/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 46a099de85b7..facbd7467dd3 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -46,7 +46,7 @@ extern void __raw_writesl(void __iomem *addr, const void *data, int wordlen);
  * virt_to_phys - map virtual address to physical
  * @address:  address to map
  */
-static inline unsigned long virt_to_phys(volatile void *address)
+static inline unsigned long virt_to_phys(const volatile void *address)
 {
 	return __pa(address);
 }


