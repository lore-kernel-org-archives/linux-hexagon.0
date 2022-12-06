From: David Hildenbrand <david@redhat.com>
Subject: [PATCH mm-unstable RFC 09/26] m68k/mm: remove dummy __swp definitions for nommu
Date: Tue,  6 Dec 2022 15:47:13 +0100
Message-ID: <20221206144730.163732-10-david@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gp7J1aj46K+Jiodg/5tOgmeBM9jveIu5Jwx68YS0wlE=;
        b=IxhXbRw40bxfY+M3YDwCBifRxsRBMNhhTmcHUHwzoH/qc27LI0Lspl31+bEHRcKUCex5PN
        CQf8xdP6M8+vidAIdGqrBn3Zmgj/GWiH8IALN4JJgfRao3drx0UTraf6+pU9+iAJLU3Y0+
        YK7jyGJjHp6y0E05MpMMtsD+0I4aJHI=
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux

The definitions are not required, let's remove them.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/m68k/include/asm/pgtable_no.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fed58da3a6b6..fc044df52b96 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -31,12 +31,6 @@
 extern void paging_init(void);
 #define swapper_pg_dir ((pgd_t *) 0)
 
-#define __swp_type(x)		(0)
-#define __swp_offset(x)		(0)
-#define __swp_entry(typ,off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
-
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
-- 
2.38.1

