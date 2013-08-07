From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] hexagon: fix return type of ffs()
Date: Wed,  7 Aug 2013 22:42:38 +0900
Message-ID: <1375882959-26853-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6Be05+ULKlhuRHx1tKNiXMiVN5XodosSDIQfIGWd0h0=;
        b=a78cJ8FaMjqtRUFGh/p16RpPSVApZYGQo5t5YA/SjksqrRjU6wdKjx/kk5fBdZF+4+
         9AdzeX8SlWVBEOUPklI/u9J2kJ4c3cMTx3pblxvZ3V94DlLTp9nShVeokoWefj04Nt4P
         CHExpsWb/Bv2OX1yMQKSjbIF0Fb/10N72o68lRkKjnYHUAEHIgMGTeswwI6iXupxnUWf
         yDuXoMturE+2KUnHHSkg3FWOPf8Z9BSCcdmfe/6J4nU+ZsUeAQnTgZsYS6Mh+vmw1l/x
         35RssuNTRhbOvhwExKwjZqhLdEBjBDBpddWtTVN47xQrHV4E0kms6UytGXBCdu1e5E9u
         JDYw==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org

The return type of ffs() is 'int' on all architectures except cris and
hexagon.  This unifies the return type to 'int'.

The problem I'm seeing is that the following line generates a warning
on cris and hexagon because of the mismatch between format '%u' and
return type of ffs().

	printk("bits in OOB size: %u\n",	ffs(ns->geom.oobsz) - 1);

But removing this warning by casting to 'int' looks odd, so I suggest
unifying the return type of ffs() on all architectures.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
This patch is not compile tested yet, because I couldn't find cross
compiler for hexagon.

 arch/hexagon/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 9b1e4af..80e34a6 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -234,7 +234,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
 
-- 
1.8.3.1
