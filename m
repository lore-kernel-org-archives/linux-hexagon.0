From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 29/31] binfmt_flat: use flush_icache_user_range
Date: Sun, 10 May 2020 09:55:08 +0200
Message-ID: <20200510075510.987823-30-hch@lst.de>
References: <20200510075510.987823-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=HRyhkH18LFCbkgCXbt9/+HszHvh8kjMmfVRTGKbbIGQ=; b=tgn4T8jqYxuFS/VlRTlED2h30H
        OLRzqiBTZ7HascfUuszhx2OsXTQOvS+NpGco2CJjFdJLeP9V5jyBlX1aCF5nEErg+2CQucIbH5JyH
        BNjHHnQsT68AG805N8id3Yca4jtzH5/6JYU5eCQ6ifezmPiNhcdYdz8ysTYetT1ARCMBfFdIx3Fxs
        u6bw9rOX07UfOvdMyNW9+wKXyrIWTX2ih6TSKxCh9m4RMuDsERrz/olZmo1/00c4+7zLOQWazHC5Q
        gVjkkOY3VBzq0fdFx9uKPs6aglI8dSNNA0aqmQNEcfziY69zsLBeXjS82110t8mCYhLfEPkP/qth5
        2lXoJoUg==;
In-Reply-To: <20200510075510.987823-1-hch@lst.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>
Cc: Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org

load_flat_file works on user addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

