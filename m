From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 14:09:06 +0300
Message-ID: <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ljdtykZTpGPKpHYDunRR4vVQMqB/nCpn3mQXIGAdvbs=; b=mW6g2LThnMBKSz
	7k6M5EuTBmDfUhpFyqsE/n0wbpieG/KKeV2X4i6ek9AHSRiXlYMBsFT/0M2yii7/68e+xDrJKq5nZ
	t4Pu3jfT55nel/mCzv18OTbTGt5haHYC+U/BdWuXxr205RRCtzPvklX43hfPTlfyoZeVlKlsapRTC
	zh4heKXLhBGYMMMlQLle17PPVDXPnP4TyQmnWm4AAMNE5c1Lc3Nr9ZvVj2Fh8nAsAKzmAPU1Sg0FF
	EcDVrK7OAea5+aV7zzy02HDyKvrEWnNX7ytrJSgPjAFQvYbjZtIPHC/PK7JlKjSgyR2niSlyFnriD
	CPFpFZuzklVJw8RgL/1A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RX5FjI3wwkptc5sfX4+NkcctA+fCkcVF8HC/oTZQueA=;
 b=qeudmJU6+nqktNq8hagWevdDYJTTFMn+WENyVU02czllfS+fQup8X2aAcQtu2Lo0Fp
 dhBWK+IUAJCVJxMgLR2Q+5FdwzcoZDri19DNWDDMDN459vxsWd4gd90pvEzqmj7i/Fk+
 4GmiBbPPBQxYkEOU63G/QIHHt6iTrlm7BZWRGLnI42WPtnHHGUwiFQgxxz6a5lmwlVkh
 RLNcciTpu4deyuzzSogUrxoQpB41XxnBfDW3RTICetpaoKpeC37wL/mNktpm48Nj7dgI
 Xa/aCwwYycAOdNSNZVdcW5B/PKAoIddEyh93084VotBhdiNKJBPYH3SrKS+IeMKOkimb
 sY+A==
Content-Disposition: inline
In-Reply-To: <20181012013756.11285-1-joel@joelfernandes.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>

On Thu, Oct 11, 2018 at 06:37:55PM -0700, Joel Fernandes (Google) wrote:
> diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> index 12fe700632f4..4399d712f6db 100644
> --- a/arch/m68k/include/asm/mcf_pgalloc.h
> +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  extern const char bad_pmd_string[];
>  
> -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> -	unsigned long address)
> +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  {
>  	unsigned long page = __get_free_page(GFP_DMA);
>  
> @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
>  #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
>  
> -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> -

I believe this was one done manually, right?
Please explicitely state everthing you did on not of sematic patch

...

> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
> index 7c89390c0c13..f4cc9ffc449e 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -108,10 +108,9 @@ static inline void free_pgd_slow(pgd_t *pgd)
>  #define pmd_alloc_one_fast(mm, address)	({ BUG(); ((pmd_t *)1); })
>  #define pmd_alloc_one(mm, address)	({ BUG(); ((pmd_t *)2); })
>  
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  
> -static inline struct page *pte_alloc_one(struct mm_struct *mm,
> -		unsigned long address)
> +static inline struct page *pte_alloc_one(struct mm_struct *mm)
>  {
>  	struct page *ptepage;
>  
> @@ -132,20 +131,6 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm,
>  	return ptepage;
>  }
>  
> -static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm,
> -		unsigned long address)
> -{
> -	unsigned long *ret;
> -
> -	ret = pte_quicklist;
> -	if (ret != NULL) {
> -		pte_quicklist = (unsigned long *)(*ret);
> -		ret[0] = 0;
> -		pgtable_cache_size--;
> -	}
> -	return (pte_t *)ret;
> -}
> -

Ditto.

-- 
 Kirill A. Shutemov
