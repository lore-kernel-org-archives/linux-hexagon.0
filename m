From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 32/34] sparc: Convert pgtable_pte_page_{ctor, dtor}()
 to ptdesc equivalents
Date: Wed, 14 Jun 2023 18:20:53 +0300
Message-ID: <20230614152053.GE52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-33-vishal.moola@gmail.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686756091;
        bh=il/HQfNL/uVoI8Ww57mtbKzYiPMAc1DKtiQkMGOtIfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVqVK3+cHzzM3I6jLTXFddZxbFNGPyRkmUP04L3rXdQHtkhROZjeS4xs716iEeHdI
         3NTDNl7d+xttJku6jL5Vp2AtMEzW22vWDWbwjll2V8vVRNY23vhOyS7i+LK0LxbXdw
         FLa/cSLNMXXmsxuzrxQhCn+drunkS9V+mQxgMLtHYqy48lWC0KA1CxMftayd+ywuMN
         LLMWJKOOtCwfpjAWz8cODynASF/ygJUUKBwEscMZxGpjyvRIOPidi0xPpAYKGa2gya
         /E5L+RC/PloG4xdfJOfUmDMA7VZBXAl85QlMPjo/CmXi01rcsEFX+MuFeeezAt7qfD
         tIubuOBxrNFBw==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-33-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, "David S. Miller" <davem@davemloft.net>

On Mon, Jun 12, 2023 at 02:04:21PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable pte constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/mm/srmmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 13f027afc875..8393faa3e596 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  		return NULL;
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
>  	spin_lock(&mm->page_table_lock);
> -	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
> +	if (page_ref_inc_return(page) == 2 &&
> +			!pagetable_pte_ctor(page_ptdesc(page))) {
>  		page_ref_dec(page);
>  		ptep = NULL;
>  	}
> @@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
>  	spin_lock(&mm->page_table_lock);
>  	if (page_ref_dec_return(page) == 1)
> -		pgtable_pte_page_dtor(page);
> +		pagetable_pte_dtor(page_ptdesc(page));
>  	spin_unlock(&mm->page_table_lock);
>  
>  	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
