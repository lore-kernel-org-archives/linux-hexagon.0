From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 16/26] riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Date: Thu, 23 Jun 2022 22:10:59 -0700
Message-ID: <YrVHYwb3z0Wv+vZx@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-17-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oy8Qzv7ZwesdQ7gZcxE/IliyoXQVuCtp5qw3DJ66UmU=; b=tYEY6TDJRXfImJFb/TegSvBB52
        c9s1q6arcG99qLu14ih4wheulphZK3pt+18fSMiLmXsL2oDuB7dPvXw7yuFMgzGpHbHvusQBMskHB
        MEDDM/XjG+R7Lzh/3+bIAU/402+xsYAByeCBVOA0I8WhpORdaOiymIQlPUyq4X9KtlBx1l3ssAZWz
        5kVdXI840LT9CyXBPW9XnEObiktYQInNMEYJCgmlVRdPEgXlKUePxM+/UFR7JkbhiRuzBlDVzuO7q
        97wrFo+nfpajUACMGdBzXCRcH0frNcML2+64mW5MNr8axsa789mj7G6nXr8zjaYQMjHBPDkFr6VGZ
        mk0T0xhA==;
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-17-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>

On Fri, Jun 24, 2022 at 10:13:29AM +0530, Anshuman Khandual wrote:
index d466ec670e1f..f976580500b1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -288,6 +288,26 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
>  #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
>  #endif /* CONFIG_XIP_KERNEL */
>  
> +static pgprot_t protection_map[16] __ro_after_init = {

Can't this be marked const now?

