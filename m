From: Jeffrey Merkey <jeffmerkey@gmail.com>
Subject: [PATCH 26/31] Add debugger entry points for HEXAGON
Date: Thu, 28 Jan 2016 12:47:34 -0700
Message-ID: <1454010454-29483-1-git-send-email-jeffmerkey@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ckhTUnr4jBPdMZ6Vxtosmrr303Xfph3d0ECtAIkI5cU=;
        b=TcWoRWanEK9xNancSfilKDzP65t3N+sWiTo/KBsJNouPaC6RH6FrE8napR26WE0Ej2
         U1XJJQs9hZPiXh/Li/A4/rC9h5yeEapb4fnAEl+Kg8lfQlQBlYWjUFGSGz+kiGXKfrZu
         Ta7q036y6xxvo/UMaReoYgEszkC/pa9cGyGwB9uHa2t1ncjlCuvf6K8zLxRZMmPqSapa
         x7pM10JfIMvumJti1p40zkFItolLOE/I7kTi05ANebTyq/P0zFQd3G5peSnFiUq11R1P
         OZ8UXEaIcdJX+kJUgYqFmh8CITewbrm63+bk++bjqr3guzG3ne0ckIoE6KBu48l+Pni0
         C9qg==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: rkuo@codeaurora.org, linux.mdb@gmail.com, linux-hexagon@vger.kernel.org

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/hexagon/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 arch/hexagon/include/asm/kdebug.h

diff --git a/arch/hexagon/include/asm/kdebug.h b/arch/hexagon/include/asm/kdebug.h
new file mode 100644
index 0000000..2014f33
--- /dev/null
+++ b/arch/hexagon/include/asm/kdebug.h
@@ -0,0 +1,5 @@
+
+static inline void arch_breakpoint(void)
+{
+	asm("trap0(#0xDB)");
+}
-- 
1.8.3.1
