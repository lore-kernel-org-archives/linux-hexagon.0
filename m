From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon arch maintainer change
Date: Thu, 19 Sep 2019 21:04:27 -0500
Message-ID: <20190920020427.GA7719@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568945071;
        bh=7VRyQrCrEIg2B5dbxsKJsZB0FNxfrVA48YSIi9y+2Os=;
        h=Date:From:To:Cc:Subject:From;
        b=FShJKSPW0XfZJeo5I3gGmXH9lqzOX8YyBeciOR4R2NCet5ripR+7Sx4zbJCQQtCh+
         /kkkS3txf3eqf755Owz4k33d56jKQurmFiGl2quw4cE0qWW5GZS/xsbFYNo5TSVoBe
         2JHJeQYUp1ruSspcgibSieRUr/RUtEwxsICKUwnM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568945071;
        bh=7VRyQrCrEIg2B5dbxsKJsZB0FNxfrVA48YSIi9y+2Os=;
        h=Date:From:To:Cc:Subject:From;
        b=FShJKSPW0XfZJeo5I3gGmXH9lqzOX8YyBeciOR4R2NCet5ripR+7Sx4zbJCQQtCh+
         /kkkS3txf3eqf755Owz4k33d56jKQurmFiGl2quw4cE0qWW5GZS/xsbFYNo5TSVoBe
         2JHJeQYUp1ruSspcgibSieRUr/RUtEwxsICKUwnM=
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org
Cc: bcain@codeaurora.org

Hi Linus,

Please pull the following changes.  I am leaving QuIC, and Brian Cain will be
taking over maintainership of the Hexagon port.


Thanks,
Richard Kuo


The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 18dd1793a340f8216e22c9295c0c7b95cdae1783:

  Hexagon: change maintainer to Brian Cain (2019-09-19 14:58:15 -0500)

----------------------------------------------------------------
Brian Cain (1):
      Hexagon: change maintainer to Brian Cain

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
