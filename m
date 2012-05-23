From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon:  misc cleanup
Date: Tue, 22 May 2012 19:40:50 -0500
Message-ID: <20120523004049.GA4269@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Linus,

Please pull the following changes for the Hexagon architecture from: 

  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

These are mostly cleanups and feedback remaining from the original
upstreaming.


Thanks,
Richard Kuo



------------------>
Jesper Juhl (1):
      Remove unneeded include of version.h from arch/hexagon/include/asm/spinlock_types.h

Julia Lawall (1):
      arch/hexagon/kernel/dma.c: make function static

Kautuk Consul (1):
      hexagon/mm/vm_fault.c: Port OOM changes to do_page_fault

Richard Kuo (1):
      various Kconfig cleanup and old platform build code removal

Thomas Meyer (1):
      Hexagon: Use resource_size function

 arch/hexagon/Kconfig                      |   21 ++++-----------------
 arch/hexagon/Makefile                     |    5 -----
 arch/hexagon/include/asm/spinlock_types.h |    2 --
 arch/hexagon/kernel/dma.c                 |    2 +-
 arch/hexagon/kernel/time.c                |    6 ++----
 arch/hexagon/mm/vm_fault.c                |   22 +++++++++++++++++-----
 6 files changed, 24 insertions(+), 34 deletions(-)


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
