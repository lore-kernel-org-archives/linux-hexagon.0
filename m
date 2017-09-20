From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] hexagon: get rid of #include <generated/compile.h>
Date: Thu, 21 Sep 2017 00:17:50 +0900
Message-ID: <1505920670-8290-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com v8KFI2cq007260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1505920683;
        bh=sTQU/jjElO/jGM2/Z3BfivLFgh42KULjEqdS92ErDpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=1KKTyVoJpx14vS+tNC3r1sRitzB6V/ZkUe6VDTF2++2/m2AI3bdjpUE8cZjsnj5FO
         R3zI/WxWvAr48RaltUhEMl1uNOQhg54PaXz2Od9m62ddt30D0mRWNoNF6vqe3sFSjG
         +Acp1RpJ+75siu6L+llqXkPVsrGGaIbdHKg/3vATRbUWSnqW2zZtiookLxaIMzs2Ge
         sQ0g5LqMWFLVY3qYEmBDsL8UMq8asUjqhIPHd0GXHo2PtGJ2KCe7QxbORNA+M2hZAV
         xmC8YY0z4b5OjVQmnjES6iXgJh5x3bptLsSA657GXwxVlA/HBhLMJGI6fjYUE2+f2E
         J5jYCy+PRaxFw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org

<generated/compile.h> is created (or updated) when Kbuild descends
into the init/ directory.  In parallel building from a pristine
source tree, there is no guarantee <generated/compile.h> exists when
arch/hexagon/kernel/ptrace.c is compiled.

For hexagon architecture, we know UTS_MACHINE is a fixed string
"hexagon", so let's hard-code it, like many architectures do.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/hexagon/kernel/ptrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index ecd75e2..fa76493 100644
--- a/arch/hexagon/kernel/ptrace.c
+++ b/arch/hexagon/kernel/ptrace.c
@@ -18,8 +18,6 @@
  * 02110-1301, USA.
  */
 
-#include <generated/compile.h>
-
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -180,7 +178,7 @@ static const struct user_regset hexagon_regsets[] = {
 };
 
 static const struct user_regset_view hexagon_user_view = {
-	.name = UTS_MACHINE,
+	.name = "hexagon",
 	.e_machine = ELF_ARCH,
 	.ei_osabi = ELF_OSABI,
 	.regsets = hexagon_regsets,
-- 
2.7.4

