From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
Date: Fri,  6 Apr 2018 16:28:23 +0200
Message-ID: <20180406142832.2243021-3-arnd@arndb.de>
References: <20180406142832.2243021-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180406142832.2243021-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

This is needed to link ipv6 as a loadable module, which in turn happens
in allmodconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/hexagon/lib/checksum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
index 617506d1a559..7cd0a2259269 100644
--- a/arch/hexagon/lib/checksum.c
+++ b/arch/hexagon/lib/checksum.c
@@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 	memcpy(dst, src, len);
 	return csum_partial(dst, len, sum);
 }
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
-- 
2.9.0

