From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] hexagon: cmpxchg: fix comment after rename of a documentation file
Date: Sun, 27 Jun 2021 20:01:22 -0700
Message-ID: <20210628030122.11180-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=i5WxxZc8tT6cAucoU1opsevqwz38zO18+wH7avWZ1ME=; b=LoTq6T4vTYCjcuEk8An7PXx+ki
        EVh7Fj0g6XxkO9VUNH7eNpn8zk5yMoXfjwGYgnljQaDCpu1eIDJsDVnYkRghwnYSa1Zhw0/WrEyeq
        NjIeBFdB8JJ1cZpyiP6u40xYkGAoC8GzQARnuGo3Q1z9d9hBGqGBCVdxeEZ9bhyd4N2r92Et4TurM
        +rUv8r/4EWLnIyBYUFnKpU17zg4rkg4ctAwhgEb9Wma9UNHte8Xtb1pJn+B60drnJap5KwjFgzgR9
        j8sJCoKj6IrzPvUvoR1pBT8vvHSJH0iXAk2uuHA/nkmivkwcRVNTc8vGGLBMcaWj/SowDAlXEPo6i
        wVDF0cQQ==;
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Fix comment text after the rename of a document file from .txt to .rst.

Fixes: 387b14684f94 ("docs: locking: convert docs to ReST and rename to *.rst")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 arch/hexagon/include/asm/cmpxchg.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210625.orig/arch/hexagon/include/asm/cmpxchg.h
+++ linux-next-20210625/arch/hexagon/include/asm/cmpxchg.h
@@ -46,7 +46,7 @@ static inline unsigned long __xchg(unsig
 	sizeof(*(ptr))))
 
 /*
- *  see rt-mutex-design.txt; cmpxchg supposedly checks if *ptr == A and swaps.
+ *  see rt-mutex-design.rst; cmpxchg supposedly checks if *ptr == A and swaps.
  *  looks just like atomic_cmpxchg on our arch currently with a bunch of
  *  variable casting.
  */
