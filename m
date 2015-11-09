From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH 0/4] cleanup FRAME_POINTER kconfig option use
Date: Mon,  9 Nov 2015 11:21:14 -0800
Message-ID: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro_org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=tBHoGmCJGLAQFR6zfiqtaV/7xSxpXLG3cZp/xZfBsVE=;
        b=jIWBmFR8BzEgNF4+GzNgqLr/iRjg2mGIKsedCuWwJxIpf9bmemoitMNwVkrcZklA12
         dQAR1zIpvrDAyCKBHWBmWGVEDQCzYC1ADe3K/T5/eHr/3FXnzdu0HBFofle8I1+Y1Epm
         KiCbKq4vXiyd/7iv4qJeU9cnUOliIPa56DtugK8Whr03YpyV3OQKqa7Y7WOPdVbx+jmL
         VzKZA1ESBo1fONtNj3lRNxsn3BI7COja1WLhnPouri5i8sNigLxrK0DAH1XALDbqfu5Z
         75dET0tN2WiUg+oa/cwjo34fRtzKmR+kXDqTMlPLVp5HCXymBj5j0vdMLPIDUzksuO/u
         xuQw==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, egtvedt@samfundet.no, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com, yang.shi@linaro.org


When I cleanup FRME_POINTER use for arm64 arch, I found some other
architectures need the similar cleanup. So, I came up with the patch series
for them.

Yang Shi (4):
      m32r: remove redundant FRAME_POINTER kconfig option
      hexagon: select ARCH_WANT_FRAME_POINTERS instead of defining FRAME_POINTER
      avr32: select ARCH_WANT_FRAME_POINTERS and set DEBUG_KERNEL in defconfigs
      h8300: set DEBUG_KERNEL in defconfigs

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
 arch/h8300/configs/edosk2674_defconfig              | 1 +
 arch/h8300/configs/h8300h-sim_defconfig             | 1 +
 arch/h8300/configs/h8s-sim_defconfig                | 1 +
 arch/hexagon/Kconfig                                | 4 +---
 arch/m32r/Kconfig.debug                             | 8 --------
 20 files changed, 19 insertions(+), 11 deletions(-)
