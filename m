From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] hexagon: configs: Cleanup CONFIG_CROSS_COMPILE
Date: Mon, 17 Feb 2020 17:50:34 +0100
Message-ID: <20200217165034.4649-1-krzk@kernel.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581958240;
        bh=JjNDVJm+v6HWDhnhInttXBEV3fn14//iNMHEewyjbmU=;
        h=From:To:Subject:Date:From;
        b=10Ach5BGGNWH6/e4qlfWlP9MDZ88BG00bJAdYes1Ymu8vf1eQl7nDdeMe2xWKk++e
         UxSWIDCS59WGX8T5uM1ThwhrnL5QmxIXUwhefnLgp+l3xJgUv2G33NrfEXqbhRmqXF
         +s0wuNL4mS7vyaVq1pb080O7QVZV8tA1Kcy13U3E=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/hexagon/configs/comet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..9e0da536c0c6 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -2,7 +2,6 @@ CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
 CONFIG_EXPERIMENTAL=y
-CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
-- 
2.17.1

