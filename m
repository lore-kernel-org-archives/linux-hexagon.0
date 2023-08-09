From: Atul Raut <rauji.raut@gmail.com>
Subject: hexagon: fix warning comparing pointer to 0
Date: Wed,  9 Aug 2023 11:51:48 -0700
Message-ID: <20230809185147.98262-1-rauji.raut@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691607320; x=1692212120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml4dfY3mLq3SCYyf0vfwwEcWzqsDXJO/lar+p7qztwU=;
        b=CKnfz7HzOaVI1c8Xxr/EcY6QKMHJqQ7cpVvPcskHfjmo+1EB//ZE6mSGoOgQzRL0dm
         Qv3t33bzM31KbPHqwnZdkvyMtbGA7wUTrtHLiU7mkItOoAnl5Y/DaEmES9Wdy6CYGmHO
         GbdAtlOU69nBqzLiIHS08lp6pndIZCacZz+27Tpyn94Yon5/nTvm0M48Apo31BYEFDAw
         58wDsx2Ev1OQLkhzyElbGU/FAo9XNJz+F0vZrkIzNRDw50pLLbetVSmTTuPhcQ0g9SWu
         aV8dUrZj3SNr9ICs03jULfBLMdCfxBVuE4hrEE2XWTscQ55RS4cN3FOmfJieEW/8nrdR
         A8Bg==
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@quicinc.com
Cc: linux-hexagon@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org

Fix the following coccicheck warning:
./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 arch/hexagon/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 6447763ce5a9..78486eea77d7 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -80,7 +80,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 	int kstack_depth_to_print = 24;
 	unsigned long offset, size;
 	const char *name = NULL;
-	unsigned long *newfp;
+	unsigned long *newfp = NULL;
 	unsigned long low, high;
 	char tmpstr[128];
 	char *modname;
@@ -135,7 +135,7 @@ static void do_show_stack(struct task_struct *task, unsigned long *fp,
 		}
 
 		/* Attempt to continue past exception. */
-		if (0 == newfp) {
+		if (!newfp) {
 			struct pt_regs *regs = (struct pt_regs *) (((void *)fp)
 						+ 8);
 
-- 
2.34.1

