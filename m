From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND 1/2] config: android: Remove left-over BACKLIGHT_LCD_SUPPORT
Date: Tue,  7 Jul 2020 22:55:25 +0200
Message-ID: <20200707205526.32649-1-krzk@kernel.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594155349;
        bh=XnF1pN+IJFHwFtadwbx3LPlPCtLa6RG3KhJruPiqXfw=;
        h=From:To:Subject:Date:From;
        b=eX2Dqz90oWR/baZVInWfXYUL6AJemRPPMMWSZCcPqpvAi+OUKUbBArizOeFJfzrzj
         9EZXCwv/uVoGn4Y9BB0wfygq1okSAbWBY1HFNPfD0Chre3KVd+hgOGvgOhABjfVynI
         xaC0Z+0oCEFUp2kUafsFuKx+9/pgORTuhAn3U+OE=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>, Rob Herring <robh@kernel.org>, Richard Kuo <rkuo@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

The CONFIG_BACKLIGHT_LCD_SUPPORT was removed in commit 8c5dc8d9f19c
("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel
symbol"). Options protected by CONFIG_BACKLIGHT_LCD_SUPPORT are now
available directly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

This patchset is not an important cleanup but removes few lines which I
think everyone likes.  I posted it on the list some time ago and wasn't
applied.

Dear Andrew,
Maybe you could pick it up?

Best regards,
Krzysztof


---
 kernel/configs/android-recommended.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/configs/android-recommended.config b/kernel/configs/android-recommended.config
index 81e9af7dcec2..c51f4c221ad6 100644
--- a/kernel/configs/android-recommended.config
+++ b/kernel/configs/android-recommended.config
@@ -7,7 +7,6 @@
 # CONFIG_PM_WAKELOCKS_GC is not set
 # CONFIG_VT is not set
 CONFIG_ARM64_SW_TTBR0_PAN=y
-CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
2.17.1

