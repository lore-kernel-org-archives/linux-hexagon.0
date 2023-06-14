From: Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 14 Jun 2023 16:23:10 -0500
Message-ID: <5729b45b-6a19-2aa8-8722-c50e6a1fceea@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-28-vishal.moola@gmail.com>
 <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
 <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686777794;
        bh=sfZlQC0KRiU3VFMaS6H5djLiaDuaR3UyKKAHotXoEC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JSy2cjQ3EfZqDH+GRmJ+mjVAAcseGIvPUq3lquiQxXqEjjGqwU+HemD7F3wiC1btN
         oSofDjGtfqLFUZE6+eF26LaNmlZ0XJSVLI8h3M4XLmim/HM29Na3QWm9DVPo2aVCXI
         K79BAGLxK+0MfFwKGWozB9O2gr9yZd3Cu5CIDwhRjdpR3tn5b309NHjtR2IQGAy5FI
         ii48Ct/zrPJGlO6GMB0nxU3tTn8XzvIvT2D58R4sk2Mn4rxTjXdkRPrgiKhp+20BR7
         UEwrTSQZ099UBshJbATcCyWw+lXzjKCSDECSlkjbQFiwFpFsJU9nBH5UIC1JXPi4An
         txkWeQKuOaEyQ==
Content-Language: en-US
In-Reply-To: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>



On 6/14/23 04:30, Geert Uytterhoeven wrote:
> Hi Dinh,
>=20
> On Wed, Jun 14, 2023 at 12:17=E2=80=AFAM Dinh Nguyen <dinguyen@kernel.org=
> wrote:
>> On 6/12/23 16:04, Vishal Moola (Oracle) wrote:
>>> Part of the conversions to replace pgtable constructor/destructors with
>>> ptdesc equivalents.
>>>
>>> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>>> ---
>>>    arch/nios2/include/asm/pgalloc.h | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/=
pgalloc.h
>>> index ecd1657bb2ce..ce6bb8e74271 100644
>>> --- a/arch/nios2/include/asm/pgalloc.h
>>> +++ b/arch/nios2/include/asm/pgalloc.h
>>> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *m=
m, pmd_t *pmd,
>>>
>>>    extern pgd_t *pgd_alloc(struct mm_struct *mm);
>>>
>>> -#define __pte_free_tlb(tlb, pte, addr)                               \
>>> -     do {                                                    \
>>> -             pgtable_pte_page_dtor(pte);                     \
>>> -             tlb_remove_page((tlb), (pte));                  \
>>> +#define __pte_free_tlb(tlb, pte, addr)                                =
       \
>>> +     do {                                                            \
>>> +             pagetable_pte_dtor(page_ptdesc(pte));                   \
>>> +             tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));      \
>>>        } while (0)
>>>
>>>    #endif /* _ASM_NIOS2_PGALLOC_H */
>>
>> Applied!
>=20
> I don't think you can just apply this patch, as the new functions
> were only introduced in [PATCH v4 05/34] of this series.
>=20

Ah, thanks for the pointer!

Dinh
