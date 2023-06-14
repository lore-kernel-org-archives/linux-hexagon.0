From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date: Wed, 14 Jun 2023 16:51:12 +0300
Message-ID: <20230614135112.GE52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-7-vishal.moola@gmail.com>
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
	List-Owner; bh=/QSHULLIDSkxiAzlCmdgQTqei3bwz32cpp6WhMlPPJs=; b=1ddLa9/e2VRJtq
	Z2GlfZAi7gJ7u3ubnMhDMdeKxWZKzsm/10uH6gM60ytU6CImtPtjvYWKYEKkxNI8DRu2i2VyYmB0V
	BHk8X4DhRDiixUSMJoW7nPzJbU7j4jP74E/Uxfdhp7nqOUsUl0eFB9De+xWJSC0jbfX16Wv1xf7Yd
	ubr1JQXKHdM7gRIyAsl6Z1c63UK5oO8yrIw5LJJ0NlaqbcMLL2gOFNjVKVYG+RcpiBGDM76yqQRw1
	wTXE5+sQXpsL6VPBreywVgTQii/31v7VKsJEQ0MGVe3nn6bItoGEjJa8dZmh+ourM04LQyToaaSWK
	bXO+6vgaiq/t3hOiparw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686750710;
	bh=MAYhMoo3f8WL6wMqKE5pm7ocfhsiks+frK6iH2blioo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEIirlFbT/jXJvHUAqdydA59j1RgDZUUfgyOKgwNndXqGOEHUHhZfOzL8/NQgVHWq
	 /q8XC8zbUoWUdbEY52nA6n3QMoY+5uT3nVSo46hX3ckloa8Tsk20nvsFk+nFyI69rq
	 kqHKU2qNg4cLDxDKYqW/CF0jwV3eWOULQ1qERJP4E28CBFcj6QUn7snwpsx+9K+Qu2
	 POIbcaK1ERRHtrayBYsdhpVVMqCnIj3U/FswN9W3HiA4Vsg6KhJEbi7yWjCVgy7Bim
	 qkQ5e6uOUhmZCAZAp2Mldqm52UMAWsfOcJWE7Vw1mqKjcEoYqpl1pq42H9ff1U9Ztz
	 NxXUpOfWIJH1g==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-7-vishal.moola@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

On Mon, Jun 12, 2023 at 02:03:55PM -0700, Vishal Moola (Oracle) wrote:
> Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
> removes some direct accesses to struct page, working towards splitting
> out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f184f1eba85d..088b7664f897 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2931,15 +2931,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>  
>  #if USE_SPLIT_PMD_PTLOCKS
>  
> -static inline struct page *pmd_pgtable_page(pmd_t *pmd)
> +static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
>  {
>  	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
> -	return virt_to_page((void *)((unsigned long) pmd & mask));
> +	return virt_to_ptdesc((void *)((unsigned long) pmd & mask));
>  }
>  
>  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
> -	return ptlock_ptr(pmd_pgtable_page(pmd));
> +	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
>  }
>  
>  static inline bool pmd_ptlock_init(struct page *page)
> @@ -2958,7 +2958,7 @@ static inline void pmd_ptlock_free(struct page *page)
>  	ptlock_free(page);
>  }
>  
> -#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
> +#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
>  
>  #else
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
