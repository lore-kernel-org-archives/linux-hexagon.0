From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH 1/4] m32r: remove redundant FRAME_POINTER kconfig option
Date: Mon,  9 Nov 2015 11:21:15 -0800
Message-ID: <1447096878-13519-2-git-send-email-yang.shi@linaro.org>
References: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro_org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7nxuWMsWrRB847JfZXQqTjEPZP91RznmEnx0tAgK+fE=;
        b=q7LLAIENQmy0586BrtMUsBZWlt1lHLHHpwoxb0LMGh6KB6+QAjre8uFC7hhy3GRbpH
         LfWQyXliycbyV/IukxXD51klCgRYIQAYIHR9fXjoNsr0FQc3dJMxPVhGYfyFqoCtvbQK
         CeBusFgesQWTPvA6kjaUAMFXZaKZZF9ccJQMFkYeBi8159PTzRCSIjivwOvvAlvwYloq
         3MHREhqM4ScRYtYx3bSzPFNPrS/VVDhbxJqcCRdAAUrZRSzhwOopDpvOoaKNcgQLkAoQ
         ZuR5wGIx2KORMoeAj6fSj3iQ5REdd0oFjENnxIvID5+cR7ukjL30q6XmhBGMAdbrW50v
         9QVA==
In-Reply-To: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, egtvedt@samfundet.no, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com, yang.shi@linaro.org

FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
it in arch/m32r/Kconfig.debug. Actually, the one defined in arch directory
is never used.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/m32r/Kconfig.debug | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/m32r/Kconfig.debug b/arch/m32r/Kconfig.debug
index 6c612b7..a991aeb2 100644
--- a/arch/m32r/Kconfig.debug
+++ b/arch/m32r/Kconfig.debug
@@ -10,12 +10,4 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
-config FRAME_POINTER
-	bool "Compile the kernel with frame pointers"
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame pointers.
-
 endmenu
-- 
2.0.2
