From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH 2/4] hexagon: select ARCH_WANT_FRAME_POINTERS instead of defining FRAME_POINTER
Date: Mon,  9 Nov 2015 11:21:16 -0800
Message-ID: <1447096878-13519-3-git-send-email-yang.shi@linaro.org>
References: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro_org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gjO+LxlLUoFXv9zohMlSYJzudM1CFMIjjm1iYPsJSJA=;
        b=KeckGm8H2Bj6hrP5gglEYBxO3/WjQG9TiqzQLWMCNZCpp3rpB06uRSrcsIWwfmnU6V
         /zyW8bqudZ1kZMElBWRzsjWe9JwXwOuU1J7JCnDUtCer8o0jfkTd6tIEby1YOC9JSEG+
         4EyK8mng6bQNubwQ/VygVCFdPNBNjK2IbAGkGlFfA6icNoCtF7mDi6+NnCzH09+y7eV0
         Bn7+0KF+RUmuy8u/vyQL6AjTK1R+NbcDAl2Bwi2EFdpt8c+EnqmDd0EhCpQC+51u9ne+
         2yFtjFvfAme1sRbkSDgW/krdyhVr/Z+PjUxR3mq8Q/bESvybyaF2nZaXKns0ktupXKXB
         MeyQ==
In-Reply-To: <1447096878-13519-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp, ysato@users.sourceforge.jp, hskinnemoen@gmail.com, egtvedt@samfundet.no, linux-hexagon@vger.kernel.org, rkuo@codeaurora.org, mingo@redhat.com, yang.shi@linaro.org

FRAME_POINTER is set by default if ARCH_WANT_FRAME_POINTERS is selcted,
this is the standard way to include FRAME_POINTER used by all of other
architectures.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/hexagon/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 4dc89d1..87d6dc6 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,7 @@ config HEXAGON
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select HAVE_DMA_ATTRS
+	select ARCH_WANT_FRAME_POINTERS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
@@ -37,9 +38,6 @@ config HEXAGON_PHYS_OFFSET
 	---help---
 	  Platforms that don't load the kernel at zero set this.
 
-config FRAME_POINTER
-	def_bool y
-
 config LOCKDEP_SUPPORT
 	def_bool y
 
-- 
2.0.2
