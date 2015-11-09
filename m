From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH 3/4] avr32: select ARCH_WANT_FRAME_POINTERS and set DEBUG_KERNEL in defconfigs
Date: Mon,  9 Nov 2015 11:21:17 -0800
Message-ID: <1447096878-13519-4-git-send-email-yang.shi@linaro.org>
References: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro_org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o0NK1lb1H+K5GIORMuqgJKXoehDJ3NrmC4uowe2jMY4=;
        b=AyJiZ6iOA4nhljusSGPqmfhD0y76Rtq+/+jJV+hvpwwdPD9v4QsUCv82chJgOOTaJv
         i+L6uuJR5Z93kXDnm4opBIeEoSxe0zfH5FKgx2tdBQHF7upj7AVuIcIo1H4wQe7CrdYI
         aMefMQ8RF5gh+VdC8y8rfOo/zxODZAqpOcYcxIfa+Y1b25ujH2PWKR3nluJPDVoQvj/6
         fjSs+fzCI7RJja/jvolcVf0c2lIn6el/21hJauGUo9BJqaFOaDa6l0GJ1jkF8wfQInZs
         vyj2CFXUeAEqhNYzP19+kdcETM9oc7VClf6p/+156eSokbW0j1Xt/h0epV+AXHJrVQEM
         +Bcg==
In-Reply-To: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, egtvedt@samfundet.no, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com, yang.shi@linaro.org

FRAME_POINTER is set by default if ARCH_WANT_FRAME_POINTERS and DEBUG_KERNEL
are  selcted, this is the standard way to include FRAME_POINTER used by all
of other architectures.

And, set DEBUG_KERNEL=y in defconfigs otherwise FRAME_POINTER won't be enabled
at all.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/avr32/Kconfig                                  | 1 +
 arch/avr32/configs/atngw100_defconfig               | 1 +
 arch/avr32/configs/atngw100_evklcd100_defconfig     | 1 +
 arch/avr32/configs/atngw100_evklcd101_defconfig     | 1 +
 arch/avr32/configs/atngw100_mrmt_defconfig          | 1 +
 arch/avr32/configs/atngw100mkii_defconfig           | 1 +
 arch/avr32/configs/atngw100mkii_evklcd100_defconfig | 1 +
 arch/avr32/configs/atngw100mkii_evklcd101_defconfig | 1 +
 arch/avr32/configs/atstk1002_defconfig              | 1 +
 arch/avr32/configs/atstk1003_defconfig              | 1 +
 arch/avr32/configs/atstk1004_defconfig              | 1 +
 arch/avr32/configs/atstk1006_defconfig              | 1 +
 arch/avr32/configs/favr-32_defconfig                | 1 +
 arch/avr32/configs/hammerhead_defconfig             | 1 +
 arch/avr32/configs/mimc200_defconfig                | 1 +
 15 files changed, 15 insertions(+)

diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index b6878eb..bc0c0c0 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -17,6 +17,7 @@ config AVR32
 	select GENERIC_CLOCKEVENTS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
+	select ARCH_WANT_FRAME_POINTERS
 	help
 	  AVR32 is a high-performance 32-bit RISC microprocessor core,
 	  designed for cost-sensitive embedded applications, with particular
diff --git a/arch/avr32/configs/atngw100_defconfig b/arch/avr32/configs/atngw100_defconfig
index ce00300..2825f43 100644
--- a/arch/avr32/configs/atngw100_defconfig
+++ b/arch/avr32/configs/atngw100_defconfig
@@ -137,6 +137,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100_evklcd100_defconfig b/arch/avr32/configs/atngw100_evklcd100_defconfig
index 01ff632..b14f39e 100644
--- a/arch/avr32/configs/atngw100_evklcd100_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd100_defconfig
@@ -153,6 +153,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100_evklcd101_defconfig b/arch/avr32/configs/atngw100_evklcd101_defconfig
index c4021df..ca431f8 100644
--- a/arch/avr32/configs/atngw100_evklcd101_defconfig
+++ b/arch/avr32/configs/atngw100_evklcd101_defconfig
@@ -152,6 +152,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100_mrmt_defconfig b/arch/avr32/configs/atngw100_mrmt_defconfig
index ffcc28d..97148ac 100644
--- a/arch/avr32/configs/atngw100_mrmt_defconfig
+++ b/arch/avr32/configs/atngw100_mrmt_defconfig
@@ -130,6 +130,7 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100mkii_defconfig b/arch/avr32/configs/atngw100mkii_defconfig
index 0496264..451cde9 100644
--- a/arch/avr32/configs/atngw100mkii_defconfig
+++ b/arch/avr32/configs/atngw100mkii_defconfig
@@ -139,6 +139,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig b/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
index 89c2cda..6741552 100644
--- a/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
+++ b/arch/avr32/configs/atngw100mkii_evklcd100_defconfig
@@ -156,6 +156,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig b/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
index 1b4d4a8..fa4282f 100644
--- a/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
+++ b/arch/avr32/configs/atngw100mkii_evklcd101_defconfig
@@ -155,6 +155,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index 9b8b52e..5a197d7 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -152,6 +152,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atstk1003_defconfig b/arch/avr32/configs/atstk1003_defconfig
index ccce1a0..80f6ccb 100644
--- a/arch/avr32/configs/atstk1003_defconfig
+++ b/arch/avr32/configs/atstk1003_defconfig
@@ -132,6 +132,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atstk1004_defconfig b/arch/avr32/configs/atstk1004_defconfig
index e64288f..c979c8f 100644
--- a/arch/avr32/configs/atstk1004_defconfig
+++ b/arch/avr32/configs/atstk1004_defconfig
@@ -130,6 +130,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/atstk1006_defconfig b/arch/avr32/configs/atstk1006_defconfig
index 7d669f7..01fd110 100644
--- a/arch/avr32/configs/atstk1006_defconfig
+++ b/arch/avr32/configs/atstk1006_defconfig
@@ -155,6 +155,7 @@ CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/avr32/configs/favr-32_defconfig b/arch/avr32/configs/favr-32_defconfig
index 560c52f..65cf511 100644
--- a/arch/avr32/configs/favr-32_defconfig
+++ b/arch/avr32/configs/favr-32_defconfig
@@ -138,6 +138,7 @@ CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/avr32/configs/hammerhead_defconfig b/arch/avr32/configs/hammerhead_defconfig
index d57fadb..2f257d7 100644
--- a/arch/avr32/configs/hammerhead_defconfig
+++ b/arch/avr32/configs/hammerhead_defconfig
@@ -134,6 +134,7 @@ CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_850=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_ECB=m
diff --git a/arch/avr32/configs/mimc200_defconfig b/arch/avr32/configs/mimc200_defconfig
index 49c7e89..59a838a 100644
--- a/arch/avr32/configs/mimc200_defconfig
+++ b/arch/avr32/configs/mimc200_defconfig
@@ -106,6 +106,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_POINTER=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_ECB=y
-- 
2.0.2
