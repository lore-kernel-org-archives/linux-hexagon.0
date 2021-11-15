From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 3/3] hexagon: Ignore vmlinux.lds
Date: Mon, 15 Nov 2021 10:42:51 -0700
Message-ID: <20211115174250.1994179-4-nathan@kernel.org>
References: <20211115174250.1994179-1-nathan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636998205;
        bh=/55NZjImNU/atzvuV52ntcos8+5XyyBCHHe8S7A3r0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvgQ4xf9mcuyn2Kfu4s70FT2kuznDFJV0K4ibbNtoVZs7kZ2aBu6T3MU5cWqknj+u
         OnJVbnCcCeDrZ9f19/ojsrFPzyVR6a1pIxpjEDSMooj3WFOltiT9/Cgzd2glIm9prm
         /idsXsDQZXAkpIdYetHowMvGpCInWuwhVqE4JTmGF3znG2ujTIbv5O7pQjyqLku3ZK
         LjSguKhkhbDAWW580G+ZSiaVMm0lZHG9Qj1gL/NZGYuMMZ8hmC3ocab51OHm81+KYC
         yWtmK4pvsiJsqnjVxRnL9YmgfVdtL1Z93BaSLVhznijekPMBSQp2B43hHJtam5W4Ee
         mS9UPvwI5oU7g==
In-Reply-To: <20211115174250.1994179-1-nathan@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>

After building allmodconfig, there is an untracked vmlinux.lds file in
arch/hexagon/kernel:

$ git ls-files . --exclude-standard --others
arch/hexagon/kernel/vmlinux.lds

Ignore it as all other architectures have.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/hexagon/kernel/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/hexagon/kernel/.gitignore

diff --git a/arch/hexagon/kernel/.gitignore b/arch/hexagon/kernel/.gitignore
new file mode 100644
index 000000000000..c5f676c3c224
--- /dev/null
+++ b/arch/hexagon/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
-- 
2.34.0.rc0

