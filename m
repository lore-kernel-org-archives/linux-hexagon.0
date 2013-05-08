From: rkuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon fix/cleanup
Date: Tue, 7 May 2013 21:34:45 -0500
Message-ID: <20130508023404.GA776@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Hello Linus,

Please pull the following changes for Hexagon; it includes a bug fix and a
Kconfig cleanup.


Thanks,
Richard Kuo



The following changes since commit 426d29ccb2a8d44c18d3167327ee82b38287e7bf:

  Hexagon: add v4 CS regs to core copyout macro (2013-04-30 19:40:29 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to de44443a45e36b7467af2518d3bf7ec6ec909549:

  HEXAGON: Remove non existent reference to GENERIC_KERNEL_EXECVE & GENERIC_KERNEL_THREAD (2013-05-07 11:38:12 -0500)

----------------------------------------------------------------
Alexander Shiyan (1):
      HEXAGON: Remove non existent reference to GENERIC_KERNEL_EXECVE & GENERIC_KERNEL_THREAD

Richard Kuo (1):
      Hexagon: fix register used to call do_work_pending

 arch/hexagon/Kconfig           |    2 --
 arch/hexagon/kernel/vm_entry.S |   12 ++++++------
 2 files changed, 6 insertions(+), 8 deletions(-)


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
