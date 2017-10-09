From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH 3/3] hexagon/kbuild: replace CFLAGS_MODULE with KBUILD_CFLAGS_MODULE
Date: Mon, 9 Oct 2017 15:11:47 +0800
Message-ID: <1507533107-2069-3-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1507533107-2069-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507533107-2069-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

As kbuild document & commit 6588169d51 says: KBUILD_CFLAGS_MODULE is
used to add arch-specific options for $(CC). From commandline,
CFLAGS_MODULE shall be used.
Doesn't have any functional change, but just follow kbuild rules.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
CC: Richard Kuo <rkuo@codeaurora.org>
CC: linux-hexagon@vger.kernel.org
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
2.1.0



