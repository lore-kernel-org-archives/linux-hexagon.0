From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon arch changes for 4.3
Date: Wed, 9 Sep 2015 18:54:39 -0500
Message-ID: <20150909235439.GA20067@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Linus,

Please pull the following changes for the Hexagon architecture.  It's just two
fixes -- one for a uapi header and one for a timer interface.

Thanks,
Richard Kuo


The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:

  Linux 4.2 (2015-08-30 11:34:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 02cc2ccfe771677db3cd40a71837e1467ebc839a:

  Revert "Hexagon: fix signal.c compile error" (2015-09-09 11:27:15 -0500)

----------------------------------------------------------------
Mike Frysinger (1):
      Revert "Hexagon: fix signal.c compile error"

Viresh Kumar (1):
      hexagon/time: Migrate to new 'set-state' interface

 arch/hexagon/include/uapi/asm/signal.h |  2 --
 arch/hexagon/kernel/time.c             | 17 +----------------
 2 files changed, 1 insertion(+), 18 deletions(-)


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
