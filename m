From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0144/1529] Fix typo
Date: Sat, 21 May 2016 13:55:14 +0200
Message-ID: <20160521115514.6991-1-andrea.gelmini@gelma.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Rgw7tJfYMCtuq6j/zLbatMFTUPiPJdHRac8gFbjL3us=;
        b=OH0pmzWYXz07jefo3n7xbDDYklTgEPgZATBxI8wOsKWp4A/TWJgF3ZncHq4nQ8qQsY
         EUMPl/pODeeB20aq57Xy4jDsKldCKTXXotIOQgAgXrK90lQ/r34XOFx7yK+2RffQjhRg
         D0Ej02yt8hoArM26nw07PmUhAZ9fBgwaKji8zsERd+4tNJD9bF5vb2eYfYrBg+R9X5QH
         +U+UyBEaamTos6IuPah+B4UJoES9Dg4QfWHOwA8c71qDutxpQYIBkQqC1pfENYWrz7jq
         UlvmeuKxQLHVVPMKJwQ3KEh2Uw6yhLmfxARKNbT5hg/BtIgg9HHf417WJ5A+2Kd16yix
         fqXw==
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/hexagon/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 207711a0..71bc857 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -25,7 +25,7 @@ KBUILD_AFLAGS += $(aflags-y)
 #  no KBUILD_LDFLAGS?
 LDFLAGS += $(ldflags-y)
 
-# Thread-info register will be r19.  This value is not configureable;
+# Thread-info register will be r19.  This value is not configurable;
 # it is hard-coded in several files.
 TIR_NAME := r19
 KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
-- 
2.8.2.534.g1f66975
