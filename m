From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4 28/34] openrisc: Convert __pte_free_tlb() to use
 ptdescs
Date: Wed, 14 Jun 2023 18:17:26 +0300
Message-ID: <20230614151726.GA52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-29-vishal.moola@gmail.com>
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
	List-Owner; bh=gL3IwUqH7Vo0EG835WTBW4zbceyQ9uzYijsv/mg01+c=; b=gm1aRquEfgPKeR
	vm0G4IwjfWAlCfuH4ux9Je/hBtkRUT4Vk5bdWKTyN4Dr4w9BcaKk02HBsUG5xfX0r7dC2s/alAea3
	UBcmRs884jnh1xy2Z0BtB6HSov7NXlDRMP9e12hVTQCxPc/zQge3YSF3XxjTpWbMcxwtw1lBonll7
	8G4n0ew1rjtZSdAjn+WtsMiYFzTems5QDq6PQ0cG+7L2SA0R78OpbYxoC9b25RY4ffpnatk6m3gpy
	zz4Z+5BnjIS6hw5zR0fN94v5iuMjwL7o99hbLL4Foh2BPXWey170uIGhplTDHLf6EbAxDK9RGIfvl
	Xti78nxzzgnyHnLy+99A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686755883;
	bh=law0Zw5GwZ4vUNNNJfg9xYUAxoAT1vEtTRSmu8uyTiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB937Fc379p2H6sidrtQvcyE7SjhSVDiQ8fsfmvBYud73st4wP2Qr6CFo6WX9/s01
	 JYMAIyN+HTRUEnFbhSLa+5Bn06wSCkvLo2zbfe78NcaE+yN0m1csBgyzH+54BdgaWi
	 hkj4tSqaMdn2dDgxx8M+SxKDaATfhmPSw7zNp6q69zKYgpuwrRcJK0OU5fI0Lc5b7j
	 +QW7NONIzYePXcwPMPgPxV4DoA23QefODa2dgADcpUJVKL052M5kYJPDNeYMVnlftS
	 C4Vh7z6LpoOu9Cg6NCMdB+LohoR3p8kQll2UeaT5KBeo1s+c1aEFnsfa9r1LjcJVdi
	 JIaKu8RQMiB8g==
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-29-vishal.moola@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Jonas Bonn <jonas@southpole.se>

On Mon, Jun 12, 2023 at 02:04:17PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/openrisc/include/asm/pgalloc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
> index b7b2b8d16fad..c6a73772a546 100644
> --- a/arch/openrisc/include/asm/pgalloc.h
> +++ b/arch/openrisc/include/asm/pgalloc.h
> @@ -66,10 +66,10 @@ extern inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
> -#define __pte_free_tlb(tlb, pte, addr)	\
> -do {					\
> -	pgtable_pte_page_dtor(pte);	\
> -	tlb_remove_page((tlb), (pte));	\
> +#define __pte_free_tlb(tlb, pte, addr)				\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #endif
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
