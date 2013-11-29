From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: kernel: hexagon_ksyms.c remove useless __hexagon_*i3()
Date: Fri, 29 Nov 2013 10:29:55 +0800
Message-ID: <5297FC23.3030507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=bamIYuz42G/WWf0Niq/1IazMDYYa8GAhI2uVJ8BYDKg=;
        b=jdjHR2YRCJvf27MiHp7lh1i/I9c2hYCA9hfY5X7ub1csHv8/pFMti61iSABhdqHL6o
         UeLFrABq7ubGVf34+LIqDE7Vz03XWUpync1OPOQIWeCfqPOElWTjstrQ6DpFtDOip9G9
         QYNU6UvZ7fEMsiAS8sr1Cjrok3EJfi2wUMaISYt/uNgTXmaBgXdEc8DjuWikB1tCv+kD
         M0CxCOO6NfhNEQ43temD8XarvEaqChQWqy28DfsL3PNo917/aClRfqZx2mrZCoI6f8Bs
         IqWpSgRjrCV0OuNfEQpurR1S2CT4M4YdzwMIGV85cUVlDnOtoBjIv8IfVxNni2W8lB/H
         vYJA==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Only find "DECLARE_EXPORT(__hexagon_*i3)", no related implementations
and callers, so remove them, or will cause ld issue with allmodconfig,
the related error:

    LD      init/built-in.o
  arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_umodsi3+0x0): undefined reference to `__hexagon_umodsi3'
  arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_udivsi3+0x0): undefined reference to `__hexagon_udivsi3'
  arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_modsi3+0x0): undefined reference to `__hexagon_modsi3'
  arch/hexagon/kernel/built-in.o:(___ksymtab+__hexagon_divsi3+0x0): undefined reference to `__hexagon_divsi3'


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/kernel/hexagon_ksyms.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/kernel/hexagon_ksyms.c b/arch/hexagon/kernel/hexagon_ksyms.c
index 32b1379..1257c85 100644
--- a/arch/hexagon/kernel/hexagon_ksyms.c
+++ b/arch/hexagon/kernel/hexagon_ksyms.c
@@ -33,8 +33,3 @@ EXPORT_SYMBOL(memset);
 
 /* Symbols found in libgcc that assorted kernel modules need */
 DECLARE_EXPORT(__hexagon_memcpy_likely_aligned_min32bytes_mult8bytes);
-
-DECLARE_EXPORT(__hexagon_divsi3);
-DECLARE_EXPORT(__hexagon_modsi3);
-DECLARE_EXPORT(__hexagon_udivsi3);
-DECLARE_EXPORT(__hexagon_umodsi3);
-- 
1.7.7.6
