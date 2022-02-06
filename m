From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] mm: Remove mmu_gathers storage from remaining
 architectures
Date: Sun, 6 Feb 2022 12:19:43 +0900
Message-ID: <Yf8+T8Ow7n+38w2H@antec>
References: <20220205141956.3315419-1-shorne@gmail.com>
 <Yf6UthQtASGNgW8Q@kernel.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGk+V+tevAHKhW+yEMe4I8KgmYjwftpUv9T2QF06uWE=;
        b=J4rbAUwx4FzXDA6I/18kBT29+TTryshYioLti4InX/RjYUY/r/dl4EprlBmuuRtfAY
         6tqo3jCfjC3jASzc5pEp7aKLlaBFMBN7+FVbXNwDu5V5HNsoVlxqYfIOUVG+0A6/Bpul
         Jzuh9hENgnNkS5le4n0/ILY4m7blOqy9qxQRLMGATcg0H+TAoOg2fax9/B5yTXuj4d4j
         1FgnTr4Nm87JQfu+hMBH9NqoYFcpW+CaZ2zMMKNmaMTT6GpgcsFhYstOfD/dW3VMogIA
         6NBNdwwZKobUpi3Nr+BYYxnAUReEDzEcHtYg7N2SHMT22kjxcsBT7W2U831Hqc3sxrFt
         PMDg==
Content-Disposition: inline
In-Reply-To: <Yf6UthQtASGNgW8Q@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-hexagon@vger.kernel.org, openrisc@lists.librecores.org

On Sat, Feb 05, 2022 at 05:16:06PM +0200, Mike Rapoport wrote:
> On Sat, Feb 05, 2022 at 11:19:53PM +0900, Stafford Horne wrote:
> > Originally the mmu_gathers were removed in commit 1c3951769621 ("mm: now
> > that all old mmu_gather code is gone, remove the storage").  However,
> > the openrisc and hexagon architecture were merged around the same time
> > and mmu_gathers was not removed.
> > 
> > This patch removes them from openrisc, hexagon and nds32:
> > 
> > Noticed while cleaning this warning:
> > 
> >     arch/openrisc/mm/init.c:41:1: warning: symbol 'mmu_gathers' was not declared. Should it be static?
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

Thank you,

BTW For now my plan is to queue this on my openrisc branch unless someone else
wants to pick this up.

-Stafford

> > ---
> >  arch/hexagon/mm/init.c  | 2 --
> >  arch/nds32/mm/init.c    | 1 -
> >  arch/openrisc/mm/init.c | 2 --
> >  3 files changed, 5 deletions(-)
> > 
> > diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
> > index f01e91e10d95..3167a3b5c97b 100644
> > --- a/arch/hexagon/mm/init.c
> > +++ b/arch/hexagon/mm/init.c
> > @@ -29,8 +29,6 @@ int max_kernel_seg = 0x303;
> >  /*  indicate pfn's of high memory  */
> >  unsigned long highstart_pfn, highend_pfn;
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> > -
> >  /* Default cache attribute for newly created page tables */
> >  unsigned long _dflt_cache_att = CACHEDEF;
> >  
> > diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
> > index f63f839738c4..825c85cab1a1 100644
> > --- a/arch/nds32/mm/init.c
> > +++ b/arch/nds32/mm/init.c
> > @@ -18,7 +18,6 @@
> >  #include <asm/tlb.h>
> >  #include <asm/page.h>
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> >  DEFINE_SPINLOCK(anon_alias_lock);
> >  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> >  
> > diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> > index 97305bde1b16..3a021ab6f1ae 100644
> > --- a/arch/openrisc/mm/init.c
> > +++ b/arch/openrisc/mm/init.c
> > @@ -38,8 +38,6 @@
> >  
> >  int mem_init_done;
> >  
> > -DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
> > -
> >  static void __init zone_sizes_init(void)
> >  {
> >  	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.
