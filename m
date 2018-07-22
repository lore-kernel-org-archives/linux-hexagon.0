From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] hexagon: modify ffs() and fls() to return int
Date: Sun, 22 Jul 2018 16:03:58 -0700
Message-ID: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JxqFiJdr/t+pjO9xAB6kGCMldCcA3PpmAXCTmdxlT/4=; b=sYU5NY639LpH8beZlL3MTuW+J
        0A77tUNqzyRwLJ54IMt9YbnhuYnzy3I3lFBG9u4UZz1/4L33kKl8j8o+zzfxcALqC15+zo9AktR5h
        9/P087Bhu/2ng8dWCMUKH73f70Kc25rtRHFxgOzQgGIBf83DTwvoPJPEJOd+wE9KtQddpS27hKLsa
        Ghsyi6/Kd1ELK46rdQo67b0LNp+3Diduaw/Pv+eQtC7lI5btLcYjrFpspZqXPKiGWJIn3sVOud/os
        el/35pm5DTvfkFOaBttWxqN1fRWKUw4yiSJJLaVYAQIGIy2W4tXbm8Pbhgbzra/aZyfysAFs8lODl
    
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

From: Randy Dunlap <rdunlap@infradead.org>

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffs() and
fls() functions to return int instead of long.  The variables that
they return are already int instead of long.  This return type
matches the return type in <asm-generic/bitops/>.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]

There are no ffs() or fls() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
add hexagon contacts, drop erroneous sh contacts; [thanks, Geert]
only change return type for ffs() and fls() [thanks, Geert]
  [drop the changes for ffz(), __ffs(), and __fls()]

 arch/hexagon/include/asm/bitops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
+++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
 
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
 

