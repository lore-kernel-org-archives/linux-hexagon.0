From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] hexagon: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue,  4 Jun 2019 09:55:42 +0200
Message-ID: <1559634942-20369-1-git-send-email-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559634947;
        bh=NZG+kgsujmO3Jg394X+zVaDLzGta+dFs9SolrOcNGaA=;
        h=From:To:Cc:Subject:Date:From;
        b=IdAxSeq+8r9Y0+WaaICWoVtKQ5e99WB+5azOWgbQG0l2WiSdXhZJubd8jzvPwsXF5
         Ln4tAGzRI3jw9CIcCXxU7fOv4AcbooAcEwQhZNB3E0fuFShhUpirKdSbX+MufUpvf3
         YZ4kORtmMNG9HOMFJAmPMPy4DTRQuD/oiEa+UKfk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/hexagon/configs/comet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..d4320ebdb4b9 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -18,7 +18,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=y
-- 
2.7.4

