From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] arch: hexagon: kernel: add export symbol function __delay()
Date: Tue, 19 Nov 2013 11:10:43 +0800
Message-ID: <528AD6B3.1060507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=QDoM4imtRZjxp6oHJaUmp+pYolf62VffO2Sv4VRJ6fs=;
        b=rgWvc5L4dUlxzNRCdw6NcVfUAaI/263wZo5iK2gZQZJpw5nGT9x09tAN/NGy7xGAzg
         1jsD0cF0afroR6scIBzXNtLgeNnaExNgW47UTHk+f2tQDYr+ceqIO7mznqiVEVl9AoG7
         zhNyurUWkhhYQQOTjGwshTuFrYTjaE/pUdNeeSknNogWI6GnBYfvT6lj+Tu7DHOIEoJD
         KmV1RvYo2OStky+QClxDFyFOLoim5OX+HhdISUBp0mFIglt51im9Swg2QwrJcPur5Bd+
         uAjPdPhaQFjhKJIVd6pPsWgYYdIv5aqz0cziM2z/gaNFKBX7kcV/eHR2jaNBXanHN4We
         9AJQ==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Need add __delay() implementation, or can not pass allmodconfig in
next-20131118 tree.

The related error:

    CC      kernel/locking/spinlock_debug.o
  kernel/locking/spinlock_debug.c: In function '__spin_lock_debug':
  kernel/locking/spinlock_debug.c:114:3: error: implicit declaration of function '__delay' [-Werror=implicit-function-declaration]


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/delay.h |    1 +
 arch/hexagon/kernel/time.c       |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/hexagon/include/asm/delay.h b/arch/hexagon/include/asm/delay.h
index 5307971..8933b9b1 100644
--- a/arch/hexagon/include/asm/delay.h
+++ b/arch/hexagon/include/asm/delay.h
@@ -21,6 +21,7 @@
 
 #include <asm/param.h>
 
+extern void __delay(unsigned long cycles);
 extern void __udelay(unsigned long usecs);
 
 #define udelay(usecs) __udelay((usecs))
diff --git a/arch/hexagon/kernel/time.c b/arch/hexagon/kernel/time.c
index d0c4f5a..17fbf45 100644
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -229,6 +229,15 @@ void __init time_init(void)
 	late_time_init = time_init_deferred;
 }
 
+void __delay(unsigned long cycles)
+{
+	unsigned long long start = __vmgettime();
+
+	while ((__vmgettime() - start) < cycles)
+		cpu_relax();
+}
+EXPORT_SYMBOL(__delay);
+
 /*
  * This could become parametric or perhaps even computed at run-time,
  * but for now we take the observed simulator jitter.
-- 
1.7.7.6
