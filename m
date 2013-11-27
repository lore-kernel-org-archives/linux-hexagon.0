From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: include: uapi: asm: setup.h add swith macro
 __KERNEL__
Date: Wed, 27 Nov 2013 13:28:36 +0800
Message-ID: <52958304.4050707@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org> <5292B845.3010404@gmail.com> <5292B8A0.7020409@gmail.com> <5294255E.7040105@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BHrvZornhP4VJhNOh3R2BJLVM0D6gD13MHG3no+/eVw=;
        b=esiZrH/n8prED1Q6+vepGTh8MmQG3f8+C5jSfyekzUZB51zFH090p7RUJcu2JngkJe
         OyGvKWnWCigBJ3NLCRyMWo1LTtHY8nsNug1Cqjb4FIZlz12D8eOs37jsOiNTNFnNTgwH
         Ak0NBa1uf3T9UibOv8Cdvb8M2dVFnpaBdwSjx9EbzCSzcVEswOGclPP72DOzUFryDlzY
         Z2iEyh/08C2RX3u5gKgZ/OKHEwgp/2l7MVKGHZ35GnZPXq4OU8Hw9oo+kYFPUrOfr/cD
         n/1ktxi/wrKk4f8G9eczTf+1MWWoficU+9JH9fXrGoK6WS/eR4gl2JwsMLHftuQvhgab
         y4CQ==
In-Reply-To: <5294255E.7040105@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Define dummy '__init' instead of include "linux/init.h" if !__KERNEL__,
or can not pass checking. The related error (with allmodconfig under
hexagon):

    CHECK   include/asm (34 files)
  usr/include/asm/setup.h:22: included file 'linux/init.h' is not exported


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/uapi/asm/setup.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/include/uapi/asm/setup.h b/arch/hexagon/include/uapi/asm/setup.h
index e48285e4a..7e3952d 100644
--- a/arch/hexagon/include/uapi/asm/setup.h
+++ b/arch/hexagon/include/uapi/asm/setup.h
@@ -19,7 +19,12 @@
 #ifndef _ASM_SETUP_H
 #define _ASM_SETUP_H
 
+#ifdef __KERNEL__
 #include <linux/init.h>
+#else
+#define __init
+#endif
+
 #include <asm-generic/setup.h>
 
 extern char external_cmdline_buffer;
-- 
1.7.7.6
