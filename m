From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 31/34] sparc64: Convert various functions to use
 ptdescs
Date: Wed, 14 Jun 2023 18:20:05 +0300
Message-ID: <20230614152005.GD52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-32-vishal.moola@gmail.com>
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
	List-Owner; bh=FDkf1Sg7D4jZgxm5I8d4AS+L7juQau5TTRHhVJLYSgc=; b=yS7J0WWVo7jBE6
	CxCh+OsGRZVdSQLVacjTj19SfEWgvY76kbjo2sd/BNVhTAkl23JAplWQG2ke9zxdLaXVOK6GIHFgU
	EE8PbwiI1pl49lw9FKhBHbNuzim4i3DIESGTCFJ9o6LH3siL/xi+zkC/oCu2KQqYxs2xlAmz8sWlO
	tm/Q2T0E9I6oVgCgtTb2TagIwOqyxNyOAatXugmZ1TL72Ifc1KTQjE/GFresJQeJ71vHHesriHN6b
	6+HYQ/T/2ABkWHm313CDOKKfQKvVIiAOdNEyXU5XAs8Mdep/0NtNLYNX/f8D2EUjsOi9Kzc9f2pqW
	KW860hAgL2VVt5o7LhDA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686756043;
	bh=96hB/Dutg7+YAlKNWDoQ2GAzZAZD6BC/gRuTrx6fMnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFKiOvSreJTfh5Xtv6ubZJTR9fklehqu0ZAN5wgMUW/sLqZjohhJPxRlmW70y9tfb
	 MJLE0xzsHXtV1/gKV+4z7tPzVs1ZREMtj8U0/znRVOW0O8y6uNIHnGpjzdr49RBrYC
	 xBb5NI93jS0qUzMwboMr7y3y4ocYh19ocFZmLT8j7b8qsMYlxYS9jlizQt+L95Bpg7
	 ZJLiQdwmzorCuBbqjkmB8vgbIliB9r128kkEi0yENbNqrP9+TzrpqoRpFbndP1I//x
	 MAHASOLZvbHnJOfb7hXUM8MLSqBbEToS6swaIXlfv1V66JK3DzG4OV417sT6SCG7QR
	 ESRbrUE0cTyFQ==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-32-vishal.moola@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 12, 2023 at 02:04:20PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/mm/init_64.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 04f9db0c3111..105915cd2eee 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  
>  pgtable_t pte_alloc_one(struct mm_struct *mm)
>  {
> -	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> -	if (!page)
> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
> +
> +	if (!ptdesc)
>  		return NULL;
> -	if (!pgtable_pte_page_ctor(page)) {
> -		__free_page(page);
> +	if (!pagetable_pte_ctor(ptdesc)) {
> +		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> -	return (pte_t *) page_address(page);
> +	return ptdesc_address(ptdesc);
>  }
>  
>  void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> @@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  static void __pte_free(pgtable_t pte)
>  {
> -	struct page *page = virt_to_page(pte);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
>  
> -	pgtable_pte_page_dtor(page);
> -	__free_page(page);
> +	pagetable_pte_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  
>  void pte_free(struct mm_struct *mm, pgtable_t pte)
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.
