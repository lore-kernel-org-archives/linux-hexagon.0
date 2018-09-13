From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon cleanups
Date: Thu, 13 Sep 2018 18:46:01 -0500
Message-ID: <20180913234600.GA2406@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536882363;
        bh=BhPfPuGFeGC1Db/tUUz4YSA2Mivq7EX9ugphwtvIB94=;
        h=Date:From:To:Subject:From;
        b=W7QnsZTi1nI+i8/X7gnTCBgCjtIjYRQ+yCrmtLJDJgtrmb3Xf5wQc25eqZIp08W7J
         WMRZ/PsbMB3A+bLzTpZ7yKdxi4JsamMYjSHKYNG/VJVcKiaZrPi8D/T/R/RuMq1yls
         16CZl63gkKMHd+5opw3/v+qri7GsDlBCSs2WddfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536882362;
        bh=BhPfPuGFeGC1Db/tUUz4YSA2Mivq7EX9ugphwtvIB94=;
        h=Date:From:To:Subject:From;
        b=Ou3VPljmb/Bh80L7tbDoLmeZvOFhTxJ/oIkro0fAbTZ9wp7Tvxl6Ajy3vkBm++dzi
         Ek6sCRZ+MjwLO7O0wfg9caI5m1T9+a84+zWN94wThf6OAxL0IRHTpa7ffohCZGKgX6
         vUeO5GNjfgh3AJxUxAUDndVdWerahwIgXeW2aKVY=
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Linus,

Please pull the following changes for Hexagon; they contain some fixes for compile
warnings.


Thanks,
Richard Kuo



The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 5c41aaad409c097cf1ef74f2c649fed994744ef5:

  hexagon: modify ffs() and fls() to return int (2018-09-10 19:42:15 -0500)

----------------------------------------------------------------
Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

 arch/hexagon/include/asm/bitops.h | 4 ++--
 arch/hexagon/kernel/dma.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
