From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 2/3] Remove useless wrappers of asm-generic/ipc.h
Date: Thu, 21 Jun 2012 21:21:06 +0200
Message-ID: <1340306466.1773.60.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org

mn10300 has a header (in its include/asm directory) that is a thin
wrapper around asm-generic/ipc.h. This wrapper is useless, since that
header doesn't exist. It is also unused (no file includes asm/ipc.h).

hexagon and tile generate similar headers at build time (using a
generic-y entry in include/asm/Kbuild). These generated headers are
useless and unused too.

Remove this header and these generic-y entries.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 arch/hexagon/include/asm/Kbuild |    1 -
 arch/mn10300/include/asm/ipc.h  |    1 -
 arch/tile/include/asm/Kbuild    |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)
 delete mode 100644 arch/mn10300/include/asm/ipc.h

diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 8ecd202..0690642 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -22,7 +22,6 @@ generic-y += ioctl.h
 generic-y += ioctls.h
 generic-y += iomap.h
 generic-y += ipcbuf.h
-generic-y += ipc.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
diff --git a/arch/mn10300/include/asm/ipc.h b/arch/mn10300/include/asm/ipc.h
deleted file mode 100644
index a46e3d9..0000000
--- a/arch/mn10300/include/asm/ipc.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipc.h>
diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 143473e..ab7640a 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += fb.h
 generic-y += fcntl.h
 generic-y += ioctl.h
 generic-y += ioctls.h
-generic-y += ipc.h
 generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
-- 
1.7.7.6
