From: Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] hexagon: work around compiler crash
Date: Mon, 28 Oct 2019 08:57:21 -0700
Message-ID: <20191028155722.23419-1-ndesaulniers@google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vl1oAr7RM/zca7FwT/vXMjuwpEGjQxC9D0ySoZ6dSQg=;
        b=rwx1pjEeHweipdLqJFc0f5AUWZAt8f6HXKzgo85WscfDfpxJvb0YoHuhVcrwDm/Y2K
         +j9mtodjaOIEYD8wniTDB2wvsC67omtrPVrl+aass6UblAf/IrU0nPkok+Y/zg4LYLWp
         9A+UQLVPy7bHJBX8av35/sm9p+KV+5GMkLv70djWsjb00967Q9Qs1y7jyblGPK2+h3mh
         o2DYex0fmo7JSQn5aOlfvOiKm8EAOoaT6HFrbMKPssgQbz5uUOP+4IsJ3eDKyUUiwlHf
         oCkBDsYEROwNTcs5tUAd5qatUOz92rhtqKg3UAI1IVzpdOdd3w60mCa0kPsIhyzMEQOX
         4ykA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bcain@codeaurora.org
Cc: Nick Desaulniers <ndesaulniers@google.com>, Sid Manning <sidneym@quicinc.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Fontana <rfontana@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com

Clang cannot translate the string "r30" into a valid register yet.

Link: https://github.com/ClangBuiltLinux/linux/issues/755
Suggested-by: Sid Manning <sidneym@quicinc.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/hexagon/kernel/stacktrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/kernel/stacktrace.c b/arch/hexagon/kernel/stacktrace.c
index 35f29423fda8..5ed02f699479 100644
--- a/arch/hexagon/kernel/stacktrace.c
+++ b/arch/hexagon/kernel/stacktrace.c
@@ -11,8 +11,6 @@
 #include <linux/thread_info.h>
 #include <linux/module.h>
 
-register unsigned long current_frame_pointer asm("r30");
-
 struct stackframe {
 	unsigned long fp;
 	unsigned long rets;
@@ -30,7 +28,7 @@ void save_stack_trace(struct stack_trace *trace)
 
 	low = (unsigned long)task_stack_page(current);
 	high = low + THREAD_SIZE;
-	fp = current_frame_pointer;
+	fp = (unsigned long)__builtin_frame_address(0);
 
 	while (fp >= low && fp <= (high - sizeof(*frame))) {
 		frame = (struct stackframe *)fp;
-- 
2.24.0.rc0.303.g954a862665-goog

