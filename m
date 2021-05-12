From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/5] hexagon: move core-y in arch/hexagon/Makefile to arch/hexagon/Kbuild
Date: Wed, 12 May 2021 16:57:28 +0900
Message-ID: <20210512075729.60291-4-masahiroy@kernel.org>
References: <20210512075729.60291-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 14C7vbPv028192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1620806263;
        bh=XTnZp0dklxYATimLXSJ2reqvSr9cCkH20z3gSq6FZjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge9jUxdRcyf/fu5QiQH9815oSlmsyLsoDXUsismXQxLsT3T8om0VmcgfhRPqbQbON
         LdoYRF50yEdDpN07kFDp0hDl0dXOFxI8W4FW7Ax6NUR8HGh7qDVo8Gdj6bqAKbYxmv
         v/ciMhBFwKL1+ArMdSWiAfwntp8JNtzWHruQWcaE+5z7BJQBLhIE8HIB+GOukuXgIi
         FQO5xIK6R5n8O0TGJP+IBKUTj+Qx8c/x23PG4rRFqiV1Zc4Q/GaP7LtXo6UISyli7j
         MB+8jhFi4qd4iuc3MGq8UmsW/BGzM2dOW5z0AI4CD6jx4akfDdP1k7WNkPy19EuScQ
         DD+mzGJMHwEiQ==
In-Reply-To: <20210512075729.60291-1-masahiroy@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Brian Cain <bcain@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/hexagon/Kbuild   | 1 +
 arch/hexagon/Makefile | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/hexagon/Kbuild b/arch/hexagon/Kbuild
index a4e40e534e6a..d930c2f954d5 100644
--- a/arch/hexagon/Kbuild
+++ b/arch/hexagon/Kbuild
@@ -1 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj += kernel/ mm/ lib/
diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 74b644ea8a00..44312bc147d8 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -34,7 +34,3 @@ KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
 KBUILD_AFLAGS += -DTHREADINFO_REG=$(TIR_NAME)
 
 head-y := arch/hexagon/kernel/head.o
-
-core-y += arch/hexagon/kernel/ \
-	arch/hexagon/mm/ \
-	arch/hexagon/lib/
-- 
2.27.0

