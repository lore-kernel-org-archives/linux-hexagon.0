From: Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] hexagon fix for v4.12-rc5
Date: Sat, 10 Jun 2017 19:24:41 -0700
Message-ID: <1497147881-1921-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gTRGx9HwB0u/cfRHd1kSvARaK72bTn+2Xl/GUuKVOA8=; b=hx7r9B0BlMRqJs7HtqAr/e3tiO
        1RI18zCIvjx5gTrzV6k8WVJ/fds3pG+aXNy1/Bp81tRgFI5H4ReYIdwJihec4lmeSlD49tCbtefmX
        zjmDYRJe0yUQAPx4OEYuiLp8IInxGH6GgYb+HQsoLN5Z5smE6oj658kOfnyMOq0ZxCE839SLoATzw
        9c0IRVNN/jh5HDXxAkZbWOnC9IthM32ZNK1HoFtvMNF+iE5mS9FOH4md6j070fhRm3DL6J2qkKNbZ
        l/omXK174s4gBNhEgdgKzrwtHvbiIM2xngB/xlT0sRfb+8JO57r99rMPJIPDspgrpuNq+Il09VKJs
        brYk9Q 
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling a hexagon fix for Linux v4.12-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hexagon-for-linus-v4.12-rc5

This patch fixes a build error seen when building hexagon images.
Richard sent me an Ack, but didn't reply when asked if he wants me
to send the patch to you directly, so I figured I'd just do it.

Thanks,
Guenter
------

The following changes since commit 5faab9e0f03c4eef97886b45436015e107f79f5f:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2017-06-10 11:09:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hexagon-for-linus-v4.12-rc5

for you to fetch changes up to 4d801cca0bb7011699c2d29f0139902dcfb3482d:

  hexagon: Use raw_copy_to_user (2017-06-10 19:10:31 -0700)

----------------------------------------------------------------
Fix hexagon build error

----------------------------------------------------------------
Guenter Roeck (1):
      hexagon: Use raw_copy_to_user

 arch/hexagon/mm/uaccess.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
