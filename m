From: Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 12/7] hexagon: Implement the new page table range API
Date: Wed, 15 Feb 2023 16:22:56 +0000
Message-ID: <SN6PR02MB4205EC14C2B3D85CCFFFF2C6B8A39@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-4-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=nq4LfOIYnP6y4Mzr5hYSqCcQe/XMKu/f/2+ilkqPWCY=;
 b=OzMzwqYC+zjggbw3CU7ofbYDf1qfZ0hBRa1uB70UVEUizQMucHiwadR+MBXS0EvHI9uj
 ZavnW6+J6+iVBsu1YUIqUtaZ39rvtys8R0zYRPyJqPaZz2eVTrgJ1bNKt4Sz3s69T3Kx
 UtVDRqUwfe9nmNamNTBClb9Fh0gmAP5+yz//BVZNV6fGGVSIPZa1evawqw7kLMh1p3uy
 LSBnk+nGrgRT51/hUqXx5ozRmbtkb7g+P9ggxZoNOZ93nDcOZFUqEN3wiw1dn871p7Y0
 1b+STNSSxMXzcpTiFecOOqdxKS8v4Swwha6C99FyYNM92aSM62DkwvYi1nj4AQaKmFq2 Mw== 
In-Reply-To: <20230215000446.1655635-4-willy@infradead.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>



> -----Original Message-----
> From: Matthew Wilcox (Oracle) <willy@infradead.org>
...
>=20
> Add set_ptes() and update_mmu_cache_range().
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/hexagon/include/asm/cacheflush.h |  7 +++++--
>  arch/hexagon/include/asm/pgtable.h    | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/hexagon/include/asm/cacheflush.h
> b/arch/hexagon/include/asm/cacheflush.h
> index 6eff0730e6ef..63ca314ede89 100644
> --- a/arch/hexagon/include/asm/cacheflush.h
> +++ b/arch/hexagon/include/asm/cacheflush.h
> @@ -58,12 +58,15 @@ extern void flush_cache_all_hexagon(void);
>   * clean the cache when the PTE is set.
>   *
>   */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -                                       unsigned long address, pte_t *pte=
p)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +               unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>         /*  generic_ptrace_pokedata doesn't wind up here, does it?  */
>  }
>=20
> +#define update_mmu_cache(vma, addr, ptep) \
> +       update_mmu_cache_range(vma, addr, ptep, 1)
> +
>  void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
>                        unsigned long vaddr, void *dst, void *src, int len=
);
>  #define copy_to_user_page copy_to_user_page
> diff --git a/arch/hexagon/include/asm/pgtable.h
> b/arch/hexagon/include/asm/pgtable.h
> index 59393613d086..f58f1d920769 100644
> --- a/arch/hexagon/include/asm/pgtable.h
> +++ b/arch/hexagon/include/asm/pgtable.h
> @@ -346,12 +346,24 @@ static inline int pte_exec(pte_t pte)
>  #define set_pmd(pmdptr, pmdval) (*(pmdptr) =3D (pmdval))
>=20
>  /*
> - * set_pte_at - update page table and do whatever magic may be
> + * set_ptes - update page table and do whatever magic may be
>   * necessary to make the underlying hardware/firmware take note.
>   *
>   * VM may require a virtual instruction to alert the MMU.
>   */
> -#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +               pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +       for (;;) {
> +               set_pte(ptep, pte);
> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               pte_val(pte) +=3D PAGE_SIZE;
> +       }
> +}
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>=20
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
> --
> 2.39.1

Acked-by: Brian Cain <bcain@quicinc.com>
