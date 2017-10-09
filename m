From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] hexagon: add KBUILD_ prefix to CFLAGS_MODULE, LDFLAGS_MODULE
Date: Mon,  9 Oct 2017 23:35:14 +0900
Message-ID: <1507559715-30918-3-git-send-email-yamada.masahiro@socionext.com>
References: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com v99EZVZF018442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1507559733;
        bh=UsZH4SJbRn2VBEhLQA/xUCVRwLc1HbN7wd8EuVpqrCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0i44Cre774G5H218p40rQJsU5QO5zybOBMG4XDgjBbCTc6Km+nPA/YZHLej9lVn4z
         3uYdDsuPhGSLm6GZESWHQxtzc2xO8HizZzYMFt5/IL6MH3gT5ZGdBsyZWP59ZVxOXL
         Gx/pARwuHizn3w6OG0TfPvR7IqZWUWbRxfCgIMZcd5SOOcJV2dcsDi4Vq0F/DQX4Pe
         F0gehvU/stw7xTYBeqU58NDuCX5aTTgi1BbVQ7oeEwW5wR4OSkKczcFz/bhF9wfvL6
         J6NzKLsiJetY6x1no2CUPJyBFYcW/W11jpfh9ILl7cF0x+SvoB4OvdJWNFOR1f2KF1
         TMpTL+wFqrKXg==
In-Reply-To: <1507559715-30918-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

{CFLAGS,LDFLAGS}_MODULE are supposed to be set by users, not by
in-kernel makefiles.

Documentation/kbuild/makefiles.txt clearly explains the difference:

  KBUILD_CFLAGS_MODULE   Options for $(CC) when building modules

      $(KBUILD_CFLAGS_MODULE) is used to add arch-specific options that
      are used for $(CC).
      From commandline CFLAGS_MODULE shall be used (see kbuild.txt).

  KBUILD_LDFLAGS_MODULE   Options for $(LD) when linking modules

      $(KBUILD_LDFLAGS_MODULE) is used to add arch-specific options
      used when linking modules. This is often a linker script.
      From commandline LDFLAGS_MODULE shall be used (see kbuild.txt).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/hexagon/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 207711a0..4f5c84c 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -11,9 +11,9 @@ KBUILD_CFLAGS += -fno-short-enums
 
 # Modules must use either long-calls, or use pic/plt.
 # Use long-calls for now, it's easier.  And faster.
-# CFLAGS_MODULE += -fPIC
-# LDFLAGS_MODULE += -shared
-CFLAGS_MODULE += -mlong-calls
+# KBUILD_CFLAGS_MODULE += -fPIC
+# KBUILD_LDFLAGS_MODULE += -shared
+KBUILD_CFLAGS_MODULE += -mlong-calls
 
 cflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
 aflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
-- 
2.7.4

