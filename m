From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] hexagon: Select ARCH_WANT_LD_ORPHAN_WARN
Date: Thu, 20 May 2021 18:12:39 -0700
Message-ID: <20210521011239.1332345-4-nathan@kernel.org>
References: <20210521011239.1332345-1-nathan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621559608;
        bh=LM15UHAX7XIvUWWap02WPhXkiLJ5e4m0TMbCFTmBn0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ew5iaWXeIIeRGnoLEVn5ClB7+i3+YF8HAEswUqsUNIkoOWOP2biSgTWkCqo7fP51a
         xcQRBmsLEkVDroV6dNhkD1bKfGRfS4f3kOQiAY2WmARYvdXUNEvx3xEUVJmQzr46Vs
         jFcevocawDUt5vulnf7rs4MeAU0BFukkGddFQg+B0EDCmRwxNAq1GBm6CJIRQK4MEC
         w32S3fmshDmtE4CWwSzCjJmQ81Pmzf5sWgTztk5WSUdK6TibXWor/VzI52NCUe1OFP
         iSOEHkSfWXrbHY/DXN5Xk/Fm0QSaZIeuF7eIUWgBJYmuA7krghxta6PCVq8JXVx+Yb
         Vc93MSCE0NLow==
In-Reply-To: <20210521011239.1332345-1-nathan@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Brian Cain <bcain@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <nathan@kernel.org>

Now that we handle all of the sections in a Hexagon defconfig, select
ARCH_WANT_LD_ORPHAN_WARN so that unhandled sections are warned about by
default.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..e5a852080730 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,6 +30,7 @@ config HEXAGON
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select SET_FS
+	select ARCH_WANT_LD_ORPHAN_WARN
 	help
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
-- 
2.32.0.rc0

