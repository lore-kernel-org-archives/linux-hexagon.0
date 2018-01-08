From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH] hexagon: Make THREAD_SIZE available to vmlinux.lds
Date: Mon, 08 Jan 2018 11:14:08 +0000
Message-ID: <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo@codeaurora.org
Cc: dhowells@redhat.com, linux-hexagon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Make THREAD_SIZE available to vmlinux.lds on hexagon by including
asm/thread_info.h the linker script.

This allows init_stack to be allocated in the linker script in a subsequent
patch.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Guenter Roeck <linux@roeck-us.net>
cc: Richard Kuo <rkuo@codeaurora.org>
cc: linux-hexagon@vger.kernel.org
---

 arch/hexagon/kernel/vmlinux.lds.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index ec87e67feb19..ad69d181c939 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -22,6 +22,8 @@
 #include <asm/asm-offsets.h>	/*  Most of the kernel defines are here  */
 #include <asm/mem-layout.h>	/*  except for page_offset  */
 #include <asm/cache.h>		/*  and now we're pulling cache line size  */
+#include <asm/thread_info.h>	/*  and we need THREAD_SIZE too */
+
 OUTPUT_ARCH(hexagon)
 ENTRY(stext)
 
