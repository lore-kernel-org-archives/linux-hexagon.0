From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND 1/2] hexagon: configs: Remove useless UEVENT_HELPER_PATH
Date: Tue, 10 Sep 2019 20:47:10 +0200
Message-ID: <20190910184711.22153-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568141238;
        bh=DtA1ZIJa0KT7HzP2wl8Z4/P/Ia1Bv1IRlb/FPekwQn4=;
        h=From:To:Subject:Date:From;
        b=wUC/GACTC0iPw/SDrWBq6bZSbqO3VxntVr5gffzzRoqfe1ZbXQpTc8HzlIGPc1r8O
         ODDOB3qHnSJSWzI116i0dob6pzIuRPyrgzGnw7zz9nAbQTN2zRCtB5SKY/rYIVIO4Z
         ZAB3TdHP1R8y+YXq7B1yOD7h+qC4To87AUHXA+pE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

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
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
2.17.1

