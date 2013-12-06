From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: [PATCH] hexagon: correct type on pgd copy
Date: Thu,  5 Dec 2013 21:13:25 -0500
Message-ID: <1386296005-2346-1-git-send-email-imirkin@alum.mit.edu>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=eELR5oTxnZc+CfxsAOpPv+yhm6UnJsWPlfiAS1IboBs=;
        b=tQaIXUCUWs/uqivJos0O5Ql3f0HMD8QsRix3DAUnns6xHfTsJj0PtIADcyjJe2jG2I
         JvSwOTqWY6Q569bHVuywBsBrIn82CA/ZXfFCbnTwC2ifz/4yPFQyqkE3NKoF1QJLJrzE
         MHA4gf8Zq8EX6VAbUATCsob6vNDkiMaAbpJwBrBsm+ysGdcFDsD3WIxTcCm1LtdeK1dc
         k0C9yGJ3QS8/6PruZKd0ZMtIKwdIPZIS6kzo9VW4EifU/mBrlzV4uIr3Jaya8AGgrVTs
         0hV1FbmONZAZLEllQYVyInykIztdhSUZeylD7zPqCsgUHxBBQtb/q43GF4oU4do5aXhv
         RUnw==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>

swapper_pg_dir is an array of pgd_t, not pgd_t*. This has no actual
effect since sizeof(pgd_t) == sizeof(pgd_t*), but unconfuses tools that
check types.

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
---

Looks like I wrote this ~2 years ago, when I was playing around with spatch,
but forgot to send it out (along with a few other patches which no longer
applied). This still seems valid though.

 arch/hexagon/include/asm/pgalloc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 4c9d382..77da3b0 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -45,7 +45,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	 * map with a copy of the kernel's persistent map.
 	 */
 
-	memcpy(pgd, swapper_pg_dir, PTRS_PER_PGD*sizeof(pgd_t *));
+	memcpy(pgd, swapper_pg_dir, PTRS_PER_PGD*sizeof(pgd_t));
 	mm->context.generation = kmap_generation;
 
 	/* Physical version is what is passed to virtual machine on switch */
-- 
1.8.3.2
