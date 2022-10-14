From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 04/13] hexagon: ptrace: user_regset_copyin_ignore() always returns 0
Date: Sat, 15 Oct 2022 00:22:26 +0300
Message-ID: <20221014212235.10770-5-s.shtylyov@omp.ru>
References: <20221014212235.10770-1-s.shtylyov@omp.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20221014212235.10770-1-s.shtylyov@omp.ru>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Oleg Nesterov <oleg@redhat.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

user_regset_copyin_ignore() always returns 0, so checking its result seems
pointless -- don't do this anymore...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 arch/hexagon/kernel/ptrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/hexagon/kernel/ptrace.c b/arch/hexagon/kernel/ptrace.c
index 8975f9b4cedf..125f19995b76 100644
--- a/arch/hexagon/kernel/ptrace.c
+++ b/arch/hexagon/kernel/ptrace.c
@@ -115,10 +115,9 @@ static int genregs_set(struct task_struct *target,
 
 	/* Ignore the rest, if needed */
 	if (!ret)
-		ret = user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					offsetof(struct user_regs_struct, pad1), -1);
-
-	if (ret)
+		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
+			offsetof(struct user_regs_struct, pad1), -1);
+	else
 		return ret;
 
 	/*
-- 
2.26.3

