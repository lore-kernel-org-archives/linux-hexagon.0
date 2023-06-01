From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Date: Thu, 1 Jun 2023 12:36:23 +0800
Message-ID: <CAJF2gTSEguewbRMD8w3u3tfSPt-Opy+i=jm_8W2+NtAP1OYSsA@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com> <20230531213032.25338-23-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685594197;
        bh=QZIVYOfQMQfDIruN7rSg689YIbiJbkkfE8AKRfy2n5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XjX+qO5TgZej3fh2HJQIqiOR5PxyL4koYuTQx2qeUwz0mw2WS7S8765bRMbrDCQVG
         whIGCjOlXBTjeWiN2+LrCx+Or8mSlhjQdHY5MFaYnqKspwUjKhBsJekNkwwwC3A2tK
         RRJ+PYWLTNVwk2Tc4E1sjjLY66LER3hFT6QIRdlz0YEtfE5QnejkEMpgjlFtCb1L5b
         jav2+jHQW0E6lB/EBDYRssonNB4dhirDM2pvI3kpcWJ0B9czAKVTkvmbZ2ylsgGsMq
         x3kGCiBqFY0IqxyFq7Pvs4DJbAWcMeNsAFCqYa1UhLYAOwr6LlCcKM6JbTbj+s1hsP
         DnX5huppMSCjQ==
In-Reply-To: <20230531213032.25338-23-vishal.moola@gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Jun 1, 2023 at 5:34=E2=80=AFAM Vishal Moola (Oracle)
<vishal.moola@gmail.com> wrote:
>
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/csky/include/asm/pgalloc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgal=
loc.h
> index 7d57e5da0914..9c84c9012e53 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>
>  #define __pte_free_tlb(tlb, pte, address)              \
>  do {                                                   \
> -       pgtable_pte_page_dtor(pte);                     \
> -       tlb_remove_page(tlb, pte);                      \
> +       pagetable_pte_dtor(page_ptdesc(pte));           \
> +       tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
>  } while (0)
>
>  extern void pagetable_init(void);
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren
