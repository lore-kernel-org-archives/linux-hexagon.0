From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon: compile fixes and CPU hotplug
Date: Mon, 23 Apr 2012 16:18:23 -0500
Message-ID: <20120423211823.GB3221@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Hello Linus,

Please pull the following changes for the Hexagon architecture.
It's mostly compile fixes and the Hexagon portion of a CPU hotplug
patch set.


Thanks,
Richard Kuo


The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

Richard Kuo (3):
      Hexagon: misc compile warning/error cleanup due to missing headers
      hexagon:  use renamed tick_nohz_idle_* functions
      hexagon: add missing cpu.h include

Srivatsa S. Bhat (1):
      hexagon/CPU hotplug: Add missing call to notify_cpu_starting()

 arch/hexagon/kernel/dma.c     |    1 +
 arch/hexagon/kernel/process.c |    6 +++---
 arch/hexagon/kernel/ptrace.c  |    1 +
 arch/hexagon/kernel/smp.c     |    8 +++++++-
 arch/hexagon/kernel/time.c    |    1 +
 arch/hexagon/kernel/vdso.c    |    1 +
 6 files changed, 14 insertions(+), 4 deletions(-)


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
