From: Richard Kuo <rkuo@codeaurora.org>
Subject: [GIT PULL] Hexagon fixes
Date: Tue, 1 May 2018 21:08:33 -0500
Message-ID: <20180502020833.GB7239@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1525226916;
        bh=6OXrwR5P+eJId3DPkgQP3nGcpWJ7PXUfV4Gqe5TM0KU=;
        h=Date:From:To:Subject:From;
        b=fHAZPAQ1vcge17DK24WSq14OwbyZqqRYu+cHVKIasoWYf/nfA2tyrL8+0vYXgKj7D
         ZRu4Co+vlbJDnp0J1kOsvlKE9/rdqE8p7itc24iHCJePtuzLXA3WRdx0kjEzRzMwGy
         qkfDWRynbqf+G6pVEtXxdpXXXuE8SIACJin2vWXE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1525226915;
        bh=6OXrwR5P+eJId3DPkgQP3nGcpWJ7PXUfV4Gqe5TM0KU=;
        h=Date:From:To:Subject:From;
        b=nhwqOG02uA/2t0WQ2L1oG50L7xyeOzeOfZ+gyx+F+kcfCkpBkBpmubJDBkXfXddkI
         dte8gzLh9UG4ll6dL1gxxgcq2Hr2YmQuSs54Aqtt+GFNuAwKIUacfHAwU/lgzctgLP
         Td+0QjAkenAoOSC5zfmMEkmnKI/J52PvVEz2LXZU=
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

Linus,

Please pull the following changes for Hexagon; they contain some small fixes
for module compilation.


Thanks,
Richard Kuo



The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel.git for-linus

for you to fetch changes up to 330e261c35dfb969c48f996dbbc8b334b5ee8d9d:

  hexagon: export csum_partial_copy_nocheck (2018-05-01 15:49:50 -0500)

----------------------------------------------------------------
Arnd Bergmann (2):
      hexagon: add memset_io() helper
      hexagon: export csum_partial_copy_nocheck

 arch/hexagon/include/asm/io.h | 6 ++++++
 arch/hexagon/lib/checksum.c   | 1 +
 2 files changed, 7 insertions(+)


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
