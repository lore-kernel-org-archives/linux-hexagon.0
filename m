From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 07/34] mm: Convert ptlock_alloc() to use ptdescs
Date: Wed, 14 Jun 2023 16:51:38 +0300
Message-ID: <20230614135138.GF52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-8-vishal.moola@gmail.com>
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
	List-Owner; bh=3FWgkUUvhRFbTULMdiSZczu91BLecz1rMosZASjMRKw=; b=BOXjwOSsFIdo7a
	ZMnPExcV7tuRxWaJ6ivyDU9of6AsBNUztzk1gRtfWfuJSmIAcaX9G7LuVfPNRrwrNN0ZTCQofEgte
	mOE2N90UsR5WyLfUzOGckTmu/Y+KofzFL2769lHTiNsBLU/U83vwCwuUEqJg16R7k2OEoykKvVCUO
	3LIrqE6DLm+c09mVWr6EL12yjyn1Q5UWkZ92WNvV1mqafW7uQiianvLAOLzOiaumdAPzu4oJfbd6J
	04wwg3g0QVgIKDC5XE2d2Gw5cPl+cpZNB5lr05T4X+UiogvCmt7Hoywq5gcZg3mEs3Q31RviDW3L0
	g9vSV+4FmwoE9LFecxPw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686750736;
	bh=VwaE4ixu2oYgT8bWCqZd/sCxt5Vr7LA6FKY2uA7+iKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pvu46WaEl54YKxvYrg17S6Us5Z+6jc6ZyxloGDXNG3sVbWCAn8khJSWsZ739VwfPP
	 KwSYnW5Cb22U/hoqAU+3FM5yWaAmL/GvAe5O+LdrEw3/pZtxxI5c7cLPpLdtEqXk8T
	 Fbh9NCB++t1sBODF7SprarK+tEpzTtUTE1tfwFFFrABefWFeIYBfx1eKkeOd7kHivF
	 njsBTw00M7iYLOdiQBjB3A+VyNpSzWxaS2T8NQnbhp/VhP28ksnHBcMgphMjijMkdr
	 wBr5rhU0/C9m5DU9+5BLMiU/dcdSlTsxTG9cV+YRjI8bVXWZYj/RDtOKkEZB/GxHIp
	 Of8H4nZJFOgvQ==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-8-vishal.moola@gmail.com>
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

On Mon, Jun 12, 2023 at 02:03:56PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 6 +++---
>  mm/memory.c        | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 088b7664f897..e6f1be2a405e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2825,7 +2825,7 @@ static inline void pagetable_clear(void *x)
>  #if USE_SPLIT_PTE_PTLOCKS
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> -extern bool ptlock_alloc(struct page *page);
> +bool ptlock_alloc(struct ptdesc *ptdesc);
>  extern void ptlock_free(struct page *page);
>  
>  static inline spinlock_t *ptlock_ptr(struct page *page)
> @@ -2837,7 +2837,7 @@ static inline void ptlock_cache_init(void)
>  {
>  }
>  
> -static inline bool ptlock_alloc(struct page *page)
> +static inline bool ptlock_alloc(struct ptdesc *ptdesc)
>  {
>  	return true;
>  }
> @@ -2867,7 +2867,7 @@ static inline bool ptlock_init(struct page *page)
>  	 * slab code uses page->slab_cache, which share storage with page->ptl.
>  	 */
>  	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
> -	if (!ptlock_alloc(page))
> +	if (!ptlock_alloc(page_ptdesc(page)))
>  		return false;
>  	spin_lock_init(ptlock_ptr(page));
>  	return true;
> diff --git a/mm/memory.c b/mm/memory.c
> index 80ce9dda2779..ba9579117686 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5934,14 +5934,14 @@ void __init ptlock_cache_init(void)
>  			SLAB_PANIC, NULL);
>  }
>  
> -bool ptlock_alloc(struct page *page)
> +bool ptlock_alloc(struct ptdesc *ptdesc)
>  {
>  	spinlock_t *ptl;
>  
>  	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
>  	if (!ptl)
>  		return false;
> -	page->ptl = ptl;
> +	ptdesc->ptl = ptl;
>  	return true;
>  }
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
