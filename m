From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 27/29] binfmt_flat: use flush_icache_user_range
Date: Fri, 15 May 2020 16:36:44 +0200
Message-ID: <20200515143646.3857579-28-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2Xdr7If4G7tlq1M/OLagjELexqLovtR85HrbwT8o5D0=; b=aKuM/IuZGNMxQJ+txtJ5ChLiO9
        jgRu5IvQBhmQvsyQ6/tX1AwBW4qI7pc/hLSkgNnaYqK3tZnN4jXJuYrKMFwXINCILvmITyTkWBGyq
        jFRKUUwH6dq7lYNFmx2GLqJw+EL+4rvVlaBjqiFFNolUMbA/eRnz/YCKnBetEYTEB1zu9d/ibFFsd
        s+6anIu4IhN8wAgtQxueZd0zvcXv9o4iooxCT6SP5C3NG9PKmnNCmKTBZkl79s/wInEl3upE2O1HU
        uNBV437kfWy7Ap5NeVKUwXWpl3ukGmCINI/nM4NHP1YXOI2mHuEgdsF7zSZNYCiKrqFVqaiJ93UnM
        YkoHC6JA==;
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>

load_flat_file works on user addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 831a2b25ba79f..6f0aca5379da2 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -854,7 +854,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 #endif /* CONFIG_BINFMT_FLAT_OLD */
 	}
 
-	flush_icache_range(start_code, end_code);
+	flush_icache_user_range(start_code, end_code);
 
 	/* zero the BSS,  BRK and stack areas */
 	if (clear_user((void __user *)(datapos + data_len), bss_len +
-- 
2.26.2

