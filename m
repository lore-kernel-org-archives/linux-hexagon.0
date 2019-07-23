From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] hexagon: remove asm/bitsperlong.h
Date: Tue, 23 Jul 2019 19:27:45 +0900
Message-ID: <20190723102745.13165-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x6NAS1IM019895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563877681;
        bh=RM09kFBEe9BZQtN3E3JSIzmta5teq7cqqcqSj788ATE=;
        h=From:To:Cc:Subject:Date:From;
        b=LtHWgw9ndkNfnBP7+YBATh8JEff8HQSoUgI+WJNB1zSu6ClaDf+Tdbvfm83I4xZW9
         3UJJcrnIEmgTUE+gXCPk+JsGj87bFyKEnBw2UyIiLNNAf6ZKXpwRAE62MW8MlcGnW/
         Y0dBS46D+74X/sg5bgcbaV2m1YLM0mqFe6okudhwuv8/6151Va/7pBT7Q0rmVpeZ70
         OQaxqeiWoqvGHl0pJa+4rOJ2BYHAaTdLH9x6uDlLxSraWx+/QxlW4GYsQxdXgSPjjO
         xMUJlwIdE3Ah84r00uQD8LaVNSdgE1JpmiD9W6m6fNN3LE/O6EDGgQwdYC42fS2N9U
         qH7yqHNbA801Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Remove hexagon-specific bitsperlong.h so that it falls back to
include/uapi/asm-generic/bitsperlong.h

Kbuild will automatically create a wrapper of it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/hexagon/include/uapi/asm/bitsperlong.h | 27 ---------------------
 1 file changed, 27 deletions(-)
 delete mode 100644 arch/hexagon/include/uapi/asm/bitsperlong.h

diff --git a/arch/hexagon/include/uapi/asm/bitsperlong.h b/arch/hexagon/include/uapi/asm/bitsperlong.h
deleted file mode 100644
index 5adca0d26913..000000000000
--- a/arch/hexagon/include/uapi/asm/bitsperlong.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-
-#ifndef __ASM_HEXAGON_BITSPERLONG_H
-#define __ASM_HEXAGON_BITSPERLONG_H
-
-#define __BITS_PER_LONG 32
-
-#include <asm-generic/bitsperlong.h>
-
-#endif
-- 
2.17.1

