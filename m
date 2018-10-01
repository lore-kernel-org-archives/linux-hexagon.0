From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 08/13] hexagon: modify ffs() and fls() to return
 int
Date: Mon, 1 Oct 2018 00:41:48 +0000
Message-ID: <20181001004139.147341-8-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7+0pRY0svB9FNfCSgP/f3OrEDCvM73X5Tp09FHOWKg=;
 b=SmKPfg0zdkNLY0UvwMipeId/qjLwhj3GHRvDbNq/dgf0TlH8LU+AZAKDmwCip30Zs6E10UBohwrZ4d6uAzCbAqz7oUktnLWIsOZAy3VL158fc5J2hPV0CMB3xKoYBUiPk80xrVCmERvZ/NdEV8ypVmj6Wt23iBeIgOngASaV6tM=
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Kuo <rkuo@codeaurora.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Sasha Levin <Alexander.Levin@microsoft.com>

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
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argum=
ent of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]

There are no ffs() or fls() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Patch-mainline: linux-kernel @ 07/22/2018, 16:03
Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/hexagon/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/b=
itops.h
index 5e4a59b3ec1b..2691a1857d20 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) =3D 0, fls(1) =3D 1, fls(0x80000000) =3D 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
=20
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
=20
--=20
2.17.1
