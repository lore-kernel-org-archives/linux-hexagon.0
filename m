From: WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH] mm: remove kern_addr_valid() completely
Date: Tue, 18 Oct 2022 17:20:19 +0800
Message-ID: <27ffa400-b947-7c83-0e79-c8eb9f96e12e@xen0n.name>
References: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1666084821; bh=N48MFgDUmr1tfKHznoAthvRtR1Wpy0hSpJqTj7oKYC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cHV6qrCjD47k3jGPjUQF3lwihop1RDaw3yjdG73m7BjSD1b/7jyWqLqeN+Uyk642T
         VvEcixZUqLhrENpMZkopSZmIH+3rzqlov7m3aEUZuBieiNorHcibY7orD6PjU5mrAB
         wuldpVWm+HQ77bl4gfDeA0Z+scSMeI8G3x4eFq+M=
Content-Language: en-US
In-Reply-To: <20221018074014.185687-1-wangkefeng.wang@huawei.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>

On 2022/10/18 15:40, Kefeng Wang wrote:
> Most architectures(except arm64/x86/sparc) simply return 1 for

one space before the opening parens

> kern_addr_valid(), which is only used in read_kcore(), and it
> calls copy_from_kernel_nofault() which could check whether the
> address is a valid kernel address, so no need kern_addr_valid(),

minor grammatical nit:

"... which already checks whether the address is a valid kernel address. 
So kern_addr_valid is unnecessary, let's remove it."

> let's remove unneeded kern_addr_valid() completely.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/alpha/include/asm/pgtable.h          |  2 -
>   arch/arc/include/asm/pgtable-bits-arcv2.h |  2 -
>   arch/arm/include/asm/pgtable-nommu.h      |  2 -
>   arch/arm/include/asm/pgtable.h            |  4 --
>   arch/arm64/include/asm/pgtable.h          |  2 -
>   arch/arm64/mm/mmu.c                       | 47 -----------------------
>   arch/arm64/mm/pageattr.c                  |  3 +-
>   arch/csky/include/asm/pgtable.h           |  3 --
>   arch/hexagon/include/asm/page.h           |  7 ----
>   arch/ia64/include/asm/pgtable.h           | 16 --------
>   arch/loongarch/include/asm/pgtable.h      |  2 -
>   arch/m68k/include/asm/pgtable_mm.h        |  2 -
>   arch/m68k/include/asm/pgtable_no.h        |  1 -
>   arch/microblaze/include/asm/pgtable.h     |  3 --
>   arch/mips/include/asm/pgtable.h           |  2 -
>   arch/nios2/include/asm/pgtable.h          |  2 -
>   arch/openrisc/include/asm/pgtable.h       |  2 -
>   arch/parisc/include/asm/pgtable.h         | 15 --------
>   arch/powerpc/include/asm/pgtable.h        |  7 ----
>   arch/riscv/include/asm/pgtable.h          |  2 -
>   arch/s390/include/asm/pgtable.h           |  2 -
>   arch/sh/include/asm/pgtable.h             |  2 -
>   arch/sparc/include/asm/pgtable_32.h       |  6 ---
>   arch/sparc/mm/init_32.c                   |  3 +-
>   arch/sparc/mm/init_64.c                   |  1 -
>   arch/um/include/asm/pgtable.h             |  2 -
>   arch/x86/include/asm/pgtable_32.h         |  9 -----
>   arch/x86/include/asm/pgtable_64.h         |  1 -
>   arch/x86/mm/init_64.c                     | 41 --------------------
>   arch/xtensa/include/asm/pgtable.h         |  2 -
>   fs/proc/kcore.c                           | 26 +++++--------
>   31 files changed, 11 insertions(+), 210 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index 946704bee599..fc70b7041b76 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -421,8 +421,6 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>   	__update_tlb(vma, address, (pte_t *)pmdp);
>   }
>   
> -#define kern_addr_valid(addr)	(1)
> -
>   static inline unsigned long pmd_pfn(pmd_t pmd)
>   {
>   	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;

Acked-by: WANG Xuerui <git@xen0n.name> # loongarch

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

