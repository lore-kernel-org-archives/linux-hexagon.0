From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Date: Mon, 12 Jun 2023 14:04:22 -0700
Message-ID: <20230612210423.18611-34-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jngaPSPjtuDXG6LmIfYg6TDMtME6T0zA852zieMR+lc=; b=gA02YI6XZ+fYex
	X3PUuFvVAtwLLEbZLg/mvZmHuPqenus/RfYT32vM0gZhEZu9qZsPKxe8LA1EwR2wAMqyNBUnPvH0G
	Zy3xXsA8eCCWD0k4MtbOMzEZ7eW7ITj4EHPztmNZ4KRiostOZ1cTxrq2SCuJVgD24qCIGmyjX5yL4
	7sBUoyXi7GYiZUpfqwI5j7GfTVWvosFWJghOHAlT3d0fLF5DIvbXul7ZNHt9+fQ/AEjNixxklE6ti
	CveGk7qYTufgq9nz89Pd0z1zxgxiaO29OUGRQMU7tV00WXyud+p2Jjbj8poPjWHsDMYY64rBnXHfi
	sLP05yhtxCqG4AvTzr/w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=; b=WDcxvj4JBQ3yWt92tkTHp0Zk1C
	7HMkzLXUTcdqgtIFQYYm6NibATJ8ZQrKayzhIAkI3yH2tTZA7kjMNSdSVZzav0Zn7JETM5krZ3FWg
	JrxsFKBDj0yWly0Tl4/wggODP1sTLo9YDreQSsWShoTxuZHVASZNRFm/zM6n7heUhFJ0xjiMlLVUY
	j9MkvxlBu858zPoHwaKF9Q8kiNvwShcwloz4BaLSlQDxDUmwL/Rs/rFl6biNfttl6m/QJgDfPaay3
	ZEfbyON+ym20WFId37/myRIVdmPDXwhWpdeCC6ub8hObU3jn6zsMaJ5oN2YXC6K9H13VPRsK9DOn4
	YLpUnVMg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603953; x=1689195953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQ/uV998f7GBK3U8fEwXlOSI96PW+5wzkUNMHiphdSU=;
        b=Tn4mHghr2z50QboRcFFwBXnQDC7dmOVTmd7q6odwa9ofCDQNfilhaBNviFDHX8SrYA
         fagx19tWV5xnG2unDu30AzBD8hFIWArocnuzCUa1K7AMS5VYUgKKhDVTLptGD0WPUw8/
         ZX9JliY6gx8+hXM3OztwRe71m1A+kx2eLC7qxtJVOpdoP5HVloTMtr0/abQT4yyYQOzs
         IVhZgoGgAdf28rfS5OorktySibfeqB5FLW0b+HoIsUsy+Q3Hv3TNg2zjbv2EGrbvSAhn
         +UJqDlCblQUHBUCUqLriRDZ3qurN8WXPOHGnwhy4vkGIt3E2YX1KhqR56pPwBtbb673W
         dPyQ==
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Richard Weinberger <richard@nod.at>

Part of the conversions to replace pgtable constructor/destructors with
ptdesc equivalents. Also cleans up some spacing issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/um/include/asm/pgalloc.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index 8ec7cd46dd96..de5e31c64793 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -25,19 +25,19 @@
  */
 extern pgd_t *pgd_alloc(struct mm_struct *);
 
-#define __pte_free_tlb(tlb,pte, address)		\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb),(pte));			\
+#define __pte_free_tlb(tlb, pte, address)			\
+do {								\
+	pagetable_pte_dtor(page_ptdesc(pte));			\
+	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
 } while (0)
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 
-#define __pmd_free_tlb(tlb, pmd, address)		\
-do {							\
-	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
-	tlb_remove_page((tlb),virt_to_page(pmd));	\
-} while (0)						\
+#define __pmd_free_tlb(tlb, pmd, address)			\
+do {								\
+	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
+	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+} while (0)
 
 #endif
 
-- 
2.40.1
