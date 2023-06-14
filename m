From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 26/34] mips: Convert various functions to use ptdescs
Date: Wed, 14 Jun 2023 18:16:19 +0300
Message-ID: <20230614151619.GY52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-27-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k5oxPr4kB1rc0NXAvq6zGF5t8O7C1+8I8aSquIxbHbM=; b=h6vuhdIPGzKjAE
	JTF89sLnlHgPApXYLf7MATL7C9Nzj7kzXNq4Bfbo+XH/Ub6tY51x070FYV4qHGY3eFQj74NWjOLAP
	P41T24m4Lu+u4zNhF8JdXRfl58rt4sb3HiIjUzXdRqnVJDkC30AJxBlWnINS2hDUDXxxh+GxYhtqQ
	pWfjpii4sad0HR3pHw1zOjsqJwd/7icFieF3r+Ze1eWLfs2mlzLzZLPHkHk259ZsEB6X6xcGMqjPi
	Uv4/cCAcEm/9fA83isUBeOm11Y5BPsiynO2vFf4qYxiHlccJQ0KuQ1roPScJOueafMUahWLUsOf5j
	SdNHhfJNB6SXQ7lvJzWg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686755817;
	bh=YWehRl3xWKEbQP9tq7ePmQYYbNy3P9MQRqza8pSXoQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5HfETjkviYZmB3yycxaStNQCcDjQ92r6U1dHXLCQYNXXuG0AAUSq7jKrB+2l21WE
	 GypEoOApF1rLNsDZqptGPcxmCr0wOSIRfpVC7vWwoWHblSH2+PhDM7ZW5oWZFVA9ML
	 0FHsMp89h7dErkEWSqM9r5MLgxZuAZm5NLE0GbwBvKGpFqgzoxM2AhuVGiRnrVxHpJ
	 +MEb2WN6DRbMDDPEuOzeya9BK86TjWF0eG9IOlempn4j36CfKy0Jiz99cVNmFKgRnt
	 JUCMMz1gmGbQUt/P8bZ99XYy/Rxm4p9/4bFRzL62I+G/NVscu1YUh+MWxgzqPj29/v
	 2pSk7JFRzXlsw==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-27-vishal.moola@gmail.com>
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
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>

On Mon, Jun 12, 2023 at 02:04:15PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/mips/include/asm/pgalloc.h | 31 +++++++++++++++++--------------
>  arch/mips/mm/pgtable.c          |  7 ++++---
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index f72e737dda21..6940e5536664 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -51,13 +51,13 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> -	free_pages((unsigned long)pgd, PGD_TABLE_ORDER);
> +	pagetable_free(virt_to_ptdesc(pgd));
>  }
>  
> -#define __pte_free_tlb(tlb,pte,address)			\
> -do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page((tlb), pte);			\
> +#define __pte_free_tlb(tlb, pte, address)			\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
>  } while (0)
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> @@ -65,18 +65,18 @@ do {							\
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	pmd_t *pmd;
> -	struct page *pg;
> +	struct ptdesc *ptdesc;
>  
> -	pg = alloc_pages(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
> -	if (!pg)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
> +	if (!ptdesc)
>  		return NULL;
>  
> -	if (!pgtable_pmd_page_ctor(pg)) {
> -		__free_pages(pg, PMD_TABLE_ORDER);
> +	if (!pagetable_pmd_ctor(ptdesc)) {
> +		pagetable_free(ptdesc);
>  		return NULL;
>  	}
>  
> -	pmd = (pmd_t *)page_address(pg);
> +	pmd = ptdesc_address(ptdesc);
>  	pmd_init(pmd);
>  	return pmd;
>  }
> @@ -90,10 +90,13 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	pud_t *pud;
> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, PUD_TABLE_ORDER);
>  
> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_TABLE_ORDER);
> -	if (pud)
> -		pud_init(pud);
> +	if (!ptdesc)
> +		return NULL;
> +	pud = ptdesc_address(ptdesc);
> +
> +	pud_init(pud);
>  	return pud;
>  }
>  
> diff --git a/arch/mips/mm/pgtable.c b/arch/mips/mm/pgtable.c
> index b13314be5d0e..729258ff4e3b 100644
> --- a/arch/mips/mm/pgtable.c
> +++ b/arch/mips/mm/pgtable.c
> @@ -10,10 +10,11 @@
>  
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> -	pgd_t *ret, *init;
> +	pgd_t *init, *ret = NULL;
> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, PGD_TABLE_ORDER);
>  
> -	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_TABLE_ORDER);
> -	if (ret) {
> +	if (ptdesc) {
> +		ret = ptdesc_address(ptdesc);
>  		init = pgd_offset(&init_mm, 0UL);
>  		pgd_init(ret);
>  		memcpy(ret + USER_PTRS_PER_PGD, init + USER_PTRS_PER_PGD,
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
