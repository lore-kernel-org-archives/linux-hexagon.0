From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3.18 089/120] hexagon: modify ffs() and fls() to return int
Date: Thu, 11 Oct 2018 17:34:30 +0200
Message-ID: <20181011152553.492490731@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272381;
        bh=Ewz1bHPZO7Zl+A3Q+ag7hv+1whRFw1/Cwj5BKQlr/RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pNOYtbhnR5p5Non/VqQ9wCGuJ9oWo0p2eQugxvcSf3UoIY8QRSmkUf/xccSVJYdfd
         8GyhaXbbBeOGOvOWGaaFUYtl0fG6NCe/Xpz5LLtr/3MBqMRVoojZ/x3CDSESh2CkDy
         ro7xrsMtrPDqWbVQ+7UdcwG6H+Ns4ph8HGtjJWPc=
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sasha Levin <alexander.levin@microsoft.com>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 5c41aaad409c097cf1ef74f2c649fed994744ef5 ]

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
Patch-mainline: linux-kernel @ 07/22/2018, 16:03
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/hexagon/include/asm/bitops.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
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
 


