From: Pranith Kumar <bobby.prani@gmail.com>
Subject: [PATCH 4/6] update reference, kerneltrap.org no longer works
Date: Mon,  9 Jun 2014 11:55:24 -0400
Message-ID: <1402329327-6766-4-git-send-email-bobby.prani@gmail.com>
References: <1402329327-6766-1-git-send-email-bobby.prani@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Zde7GaRhKc+qo8pBe/6lwaGMEplysi1LtWuXs+nTDBI=;
        b=HcDe6tVzuA41ftVthX7R6XYRvKpmo/ef9Y37WI6W+VAc+utX9aDzGkxhZstPNMGUeT
         Q2wUsxakiT6BivqRc9auFx7o4wUzyB5+WdgC8URSlpDw1fBSMoeiJJQJLleyuXYP8bW8
         MvI3tsdccX1DBcmQyw2mmIaU/8umksmf9DfogPVzXigjwTYp/6fOxBrj1gFrmcPxXRUK
         nbZ8GuY1TAWu7rKHTnEvNhTtjuNsD35bvrULQSSgALDTeBgWa53OSYix9UtoBNJDs4fo
         MbXgvO22BEbPCEfGr8svQNXh5lUlxzcMGALzcG5lqhS+uXWEB02+C0iDzNTmLn2TZfdn
         uDNA==
In-Reply-To: <1402329327-6766-1-git-send-email-bobby.prani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@kernel.org, Richard Kuo <rkuo@codeaurora.org>, "GitAuthor: Pranith Kumar" <bobby.prani@gmail.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

kerneltrap.org no longer works, update to a working reference

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/hexagon/include/asm/cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/cache.h b/arch/hexagon/include/asm/cache.h
index f4ca594..2635117 100644
--- a/arch/hexagon/include/asm/cache.h
+++ b/arch/hexagon/include/asm/cache.h
@@ -28,7 +28,7 @@
 #define __cacheline_aligned	__aligned(L1_CACHE_BYTES)
 #define ____cacheline_aligned	__aligned(L1_CACHE_BYTES)
 
-/* See http://kerneltrap.org/node/15100  */
+/* See http://lwn.net/Articles/262554/ */
 #define __read_mostly
 
 #endif
-- 
1.9.1
