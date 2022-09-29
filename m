From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hexagon: update config files
Date: Thu, 29 Sep 2022 12:14:37 +0200
Message-ID: <20220929101437.31902-1-lukas.bulwahn@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H/fjjauboM76AsKEJYN+l5mLtFMVtLVkrmfPN6VbpaE=;
        b=KkDI0lFljwhEBtPZ5YgOj5zul4ksZb6EPM03zfuGM0XXNNv5d4e4ZSCDs+AatqLGd5
         tT4CMHTpv28JLCvQHisqJqqAd0NdKRucuCWAJA33hnZS0OoDUeIOhWCpfWY8+oaPZwtg
         mR4vrIklX3FY0IkQOpjh+IRdKJEImtAKjLkZhmJ9lWjBUdRsIbgQqb/vJIVGLBtYMuBn
         3gUJINaH7Q1ZMElZRroQYHmltCyXjm4v193dRBJH8uVoeFE10JjIH+e/5fFKkjgvoKv0
         +VSewndZ/KaiG7p0kTc124EtAbXzmFYbYyka2hn69QSTeZ9OTCfG8EhNCBoDDkU0sAgA
         2anQ==
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Clean up config files by:
  - removing configs that were deleted in the past
  - removing configs not in tree and without recently pending patches
  - adding new configs that are replacements for old configs in the file

For some detailed information, see Link.

Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/hexagon/configs/comet_defconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index 9b2b1cc0794a..59e3a128b897 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -1,7 +1,6 @@
 CONFIG_SMP=y
 CONFIG_DEFAULT_MMAP_MIN_ADDR=0
 CONFIG_HZ_100=y
-CONFIG_CROSS_COMPILE="hexagon-"
 CONFIG_LOCALVERSION="-smp"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
@@ -25,9 +24,6 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_PHYLIB=y
-CONFIG_NET_ETHERNET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -40,14 +36,12 @@ CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_QUOTA=y
@@ -63,10 +57,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
-- 
2.17.1

