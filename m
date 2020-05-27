From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] hexagon: defconfig: Cleanup from old Kconfig options
Date: Wed, 27 May 2020 20:55:31 +0200
Message-ID: <20200527185531.13599-1-krzk@kernel.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590605743;
        bh=aNFtU8zIfSmNdMSRneS41YVkmW+XR+pqe4/iN3ZpWfM=;
        h=From:To:Subject:Date:From;
        b=S2XjffAjtQYNsfxNnzbudEs+bMcog8JnlhGy6R1O94bNV4Tv2gHeP7pC4tgatX7kA
         6R2NZAndtxOotI65VCPlkSXc5OH+C5WSB2AKjwLL/2eBNu/9oiq8qv3w+5CzV4cNZF
         lE7lpT6tGql6F0ID1BSNz6aOg6NmCpyU9cTADWx4=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Cain <bcain@codeaurora.org>, Krzysztof Kozlowski <krzk@kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - NETDEV_1000 and NETDEV_10000: commit f860b0522f65 ("drivers/net:
   Kconfig and Makefile cleanup"); NET_ETHERNET should be replaced with
   just ETHERNET but that is separate change;
 - HID_SUPPORT: commit 1f41a6a99476 ("HID: Fix the generic Kconfig
   options");
 - INET_LRO: commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library");

Remove also the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Richard Kuo <rkuo@codeaurora.org>

---

Changes since v1:
1. Add Richard's Ack,
2. Squash cleanup of old defconfigs with UEVENT_HELPER_PATH removal.
---
 arch/hexagon/configs/comet_defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index e324f65f41e7..6b9397aacdf9 100644
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
@@ -18,7 +17,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_STANDALONE is not set
 CONFIG_CONNECTOR=y
 CONFIG_BLK_DEV_LOOP=y
@@ -27,8 +25,6 @@ CONFIG_NETDEVICES=y
 CONFIG_MII=y
 CONFIG_PHYLIB=y
 CONFIG_NET_ETHERNET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -42,7 +38,6 @@ CONFIG_SPI_DEBUG=y
 CONFIG_SPI_BITBANG=y
 # CONFIG_HWMON is not set
 # CONFIG_VGA_CONSOLE is not set
-# CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
@@ -68,7 +63,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
-- 
2.17.1

