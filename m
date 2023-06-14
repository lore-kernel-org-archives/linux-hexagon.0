From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 11/34] mm: Convert pmd_ptlock_free() to use ptdescs
Date: Wed, 14 Jun 2023 16:59:11 +0300
Message-ID: <20230614135911.GJ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-12-vishal.moola@gmail.com>
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
	List-Owner; bh=QKEC7VSxD286S+d3aNR4MlqViP+PrnBi/bOdtDZEogE=; b=F5qypV7WiUHZ0S
	7wcZbROmfb89Om4nZ6RsToByCIyhGfU8j97znzkVtv1UWKe4ANBJeEhCWXKvNdXfzl6xLntaejwyb
	Uh9B205/dK++QejPOWe/jazsSwoT09LlSn3DWMz59aepfF0ZPpFg+1V2lK1czUcITsj7BekJFBlK8
	mOvHNmLqwTgZv6Edcx3y9zn92bbFnyzySovlIIuo64SToaJiyVp/qrwq1IPks2JzoDDt2N1u5/p0M
	i8HrwyIfdEP4bYjUmjYmVJ1eMm0tnPULZ2mqrh20Kt/tHZ561+9O0GFXSpl+IDN3kxXdszOpdzRKo
	0PSZMVlw0QKIdDhD6gdw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686751188;
	bh=bczNeLQKsA4Jn/cyv5Zpe2oQqQ9DoTlx1RmcfxuzAiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB5cuxD7f+pVV/2kNGOgyZm/CMnI+FrUzScbpb3WvoAusSUJT4mgiOW93EX9McJH2
	 FhTySbUNTBv9MPhFHuVa5nuJ1XZTkWt5yRSSUAhZSNmRhZbJ31odisGjIKfu1++lsZ
	 CH2YOx06YFt56y6ifO55IZUoGHHh/jigUaNtJtYKTg86qZrpU96rQcXjsvJGzQn/kn
	 YLwGgJim4snk8fpaILSaD4wUTac4kDSaDw7wbBi0N7ZYhBsLDqm0a86c4hplOXMBZK
	 gjGoFTFEI0ysZIaZZuOB0qrBTQ+cGwB5XLuAStdydY6oCdalsx3dIZVfFXIzN0yL0V
	 8u2LU4VeWNaSQ==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-12-vishal.moola@gmail.com>
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

On Mon, Jun 12, 2023 at 02:04:00PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f48e626d9c98..3b54bb4c9753 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2950,12 +2950,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
>  	return ptlock_init(ptdesc);
>  }
>  
> -static inline void pmd_ptlock_free(struct page *page)
> +static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
> +	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
>  #endif
> -	ptlock_free(page);
> +	ptlock_free(ptdesc_page(ptdesc));
>  }
>  
>  #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
> @@ -2968,7 +2968,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  }
>  
>  static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
> -static inline void pmd_ptlock_free(struct page *page) {}
> +static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
>  
>  #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
>  
> @@ -2992,7 +2992,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>  
>  static inline void pgtable_pmd_page_dtor(struct page *page)
>  {
> -	pmd_ptlock_free(page);
> +	pmd_ptlock_free(page_ptdesc(page));
>  	__ClearPageTable(page);
>  	dec_lruvec_page_state(page, NR_PAGETABLE);
>  }
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
