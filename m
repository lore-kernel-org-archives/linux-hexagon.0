From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH mm-unstable v8 04/31] mm: Convert pmd_pgtable_page() callers to use pmd_ptdesc()
Date: Mon, 31 Jul 2023 10:03:05 -0700
Message-ID: <20230731170332.69404-5-vishal.moola@gmail.com>
References: <20230731170332.69404-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690823026; x=1691427826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUMUqbW/uAIHfn0G4toP3JCuPKsaNgXF+JjYaBSaBaw=;
        b=LO7IgtMfV7D/5pieeNhzhX7jbefImFR1TuQgjSMNALZjO7jWhqLJ0NYlGohhp9vNEp
         P7qjRmM9tu3EiZV8IpnwyOsR5oR0G2xN8+6lkb99Xp3Pq2LKGQ1pnDBT3xTub9FDUFeD
         NiuludkMelWGqpPq5Si9scPBohunGQ7wjCbjn1MG6IHkoKqu0G6KIfhUmk1zbCODarzf
         JF+LluYmZmW6+nXXKHPD8kZWEQzzXdWA4gTgt31gpJPirIvHnT+QXlpNT9xuTR/Ob7I2
         6KYVvpK8cyw965ouTwB0qJzxRQ+l2kkvuwks4w7hfsZgPcLfFUXNyqFPQAdsNQn7UH4p
         LAXA==
In-Reply-To: <20230731170332.69404-1-vishal.moola@gmail.com>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Mike Rapoport <rppt@kernel.org>

Converts internal pmd_pgtable_page() callers to use pmd_ptdesc(). This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3fda0ad41cf2..bf552a106e4a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2971,7 +2971,7 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2990,7 +2990,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1


