From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RESEND 2/2] hexagon: defconfig: Cleanup from old Kconfig options
Date: Tue, 10 Sep 2019 20:47:11 +0200
Message-ID: <20190910184711.22153-2-krzk@kernel.org>
References: <20190910184711.22153-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568141240;
        bh=zaKmPQ7vH0+cAyYV/z6y+X+ZB80bGLkw9eVR6IiI6M8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tPMuaLObBflJclHYQCj82OHKoALRbmnidS1oa2MZJ+syYLcMhSA/LlRPR8JYukXcc
         epxK+8VCs0pdOq5IhgyjB47ZGVyNNSbOVmuEc/U3tlqx9jQhAd6tyroCkSM85Upn7k
         0qWqzuOirsAOaGDmZTRWF7faXSMicEGOBt6YU1VE=
In-Reply-To: <20190910184711.22153-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - NETDEV_1000 and NETDEV_10000: commit f860b0522f65 ("drivers/net:
   Kconfig and Makefile cleanup"); NET_ETHERNET should be replaced with
   just ETHERNET but that is separate change;
 - HID_SUPPORT: commit 1f41a6a99476 ("HID: Fix the generic Kconfig
   options");
 - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/configs/comet_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index d4320ebdb4b9..6b9397aacdf9 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
@@ -26,8 +25,6 @@ CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_PHYLIB=y
 CONFIG_NET_ETHERNET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -41,7 +38,6 @@ CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
@@ -67,7 +63,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
-- 
2.17.1

