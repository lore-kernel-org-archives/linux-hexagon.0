From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 02/13] h8300: remove usage of __ARCH_USE_5LEVEL_HACK
Date: Sun, 16 Feb 2020 10:18:32 +0200
Message-ID: <20200216081843.28670-3-rppt@kernel.org>
References: <20200216081843.28670-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581841154;
        bh=4sQuAppJ9V8uQLBiWjuxN6eOuFTm+NWRpi38gIPMGaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrGzuxCA83oW5cfkOQW52qTCQfOb6o9wxjHpc3wOuyz4EK2kMGqIUugemS+6YI4BO
         V3FyRmzLm47eolAh1sBEeZ4pMx8QjAHnGXET3Fp7oLSet5xZdlNokN0IZY1S1YV/J/
         v4ptml2vFK1l6zTGw2jXz8ycZs4NLPGZ6CY+3Gu8=
In-Reply-To: <20200216081843.28670-1-rppt@kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <s>

From: Mike Rapoport <rppt@linux.ibm.com>

h8300 is a nommu architecture and does not require fixup for upper layers
of the page tables because it is already handled by the generic nommu
implementation.

Remove definition of __ARCH_USE_5LEVEL_HACK in
arch/h8300/include/asm/pgtable.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/h8300/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/h8300/include/asm/pgtable.h b/arch/h8300/include/asm/pgtable.h
index 4d00152fab58..f00828720dc4 100644
--- a/arch/h8300/include/asm/pgtable.h
+++ b/arch/h8300/include/asm/pgtable.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _H8300_PGTABLE_H
 #define _H8300_PGTABLE_H
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopud.h>
 #include <asm-generic/pgtable.h>
 extern void paging_init(void);
-- 
2.24.0

