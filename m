From: rkuo <rkuo@codeaurora.org>
Subject: Re: hexagon: CONFIG_PAGE_SIZE_1MB?
Date: Tue, 20 May 2014 19:25:24 -0500
Message-ID: <20140521002524.GF12698@codeaurora.org>
References: <1400326363.13824.8.camel@x220>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400326363.13824.8.camel@x220>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-hexagon@vger.kernel.org

On Sat, May 17, 2014 at 01:32:43PM +0200, Paul Bolle wrote:
> Richard,
> 
> 0) There are two checks for CONFIG_PAGE_SIZE_1MB in Linux' hexagon code.
> But there's no Kconfig symbol PAGE_SIZE_1MB.
> 
> 1) There are two trivial solutions to this issue:
>     diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
>     index 0fd6138f6203..fe3c235930a5 100644
>     --- a/arch/hexagon/Kconfig
>     +++ b/arch/hexagon/Kconfig
>     @@ -148,6 +148,9 @@ config PAGE_SIZE_64KB
>      config PAGE_SIZE_256KB
>             bool "256KB"
>     
>     +config PAGE_SIZE_1MB
>     +       bool "1MB"
>     +
>      endchoice
>  
>      source "mm/Kconfig"
> 
> and
>     diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
>     index 93f5669b4aa1..7bcec3c0447c 100644
>     --- a/arch/hexagon/include/asm/page.h
>     +++ b/arch/hexagon/include/asm/page.h
>     @@ -45,11 +45,6 @@
>      #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_256KB
>      #endif
>      
>     -#ifdef CONFIG_PAGE_SIZE_1MB
>     -#define PAGE_SHIFT 20
>     -#define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
>     -#endif
>     -
>      /*
>       *  These should be defined in hugetlb.h, but apparently not.
>       *  "Huge" for us should be 4MB or 16MB, which are both represented
>     diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
>     index d8bd54fa431e..861a993afb7e 100644
>     --- a/arch/hexagon/include/asm/pgtable.h
>     +++ b/arch/hexagon/include/asm/pgtable.h
>     @@ -111,10 +111,6 @@ extern unsigned long zero_page_mask;
>      #define PTRS_PER_PTE 16
>      #endif
>      
>     -#ifdef CONFIG_PAGE_SIZE_1MB
>     -#define PTRS_PER_PTE 4
>     -#endif
>     -
>      /*  Any bigger and the PTE disappears.  */
>      #define pgd_ERROR(e) \
>             printk(KERN_ERR "%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__,\
> 
> 
> 2) Which trivial solution would you prefer?

I'd go with just removing it from pgtable.h.  The last time we
tried anything that large, there were...  adverse side effects, like
overrunning one of the object counters in the slab allocator.


Thanks,
Richard Kuo



-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
