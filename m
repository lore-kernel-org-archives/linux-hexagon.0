From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 18/21] mm: rename free_area_init_node() to
 free_area_init_memoryless_node()
Date: Thu, 23 Apr 2020 11:14:54 +0800
Message-ID: <20200423031454.GB4247@MiWiFi-R3L-srv>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-19-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XfxZqpHaSoGhE9cxk5ZYpDaKgkriOWkEUTjyuT/ZkRw=; b=p8BmYr6ImMwCfp
	bJoZDrOyfHglCqTfzv3YRaflsEgp3RzynsMXIfFRoOG6LVHg3UKNd9Y6GNH0a30YXsPJZODNbhvl3
	ktUnLV5Kz+53sORkIxh0BqiC8/eswyE2kUsx2uSd0bkNRbEHhZ9Fsd3sCI356sh+u7GMfC1KnonpB
	5MzyaYCPQbINDW7lYet5XAnngOaYaKtNRgZlwjzUJqhcAe+LEEhkm8TzQP798M+7u3TYyDUUk3Pu4
	JtcX1Idpov4rxTvkfOYdRu9EgiSZEIBNG5IVpCYmZQQtDKq09Rn4CWSBXE34juJxJqJOxkBTMpaiv
	nWpOZxftS6YxzgB5WQEQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587611710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fUgyxTdqEN6SINdaIWtc3kKJE7aXkFDNuKscYDglBVE=;
 b=fbSWHJCCIvuuzV1NwtAhStDr/8Yo3K7FzO6B0H87qbAGX/6eudb59E6ecVe7Lz9MZkJgRX
 wuN9HEiQEJa9IYbWGLWP+xpndvqFdB55tkfBLgRZOlM8RBOb/YvuSNy/11C4KthVD8oNtk
 2XJ+iJZYI+sm0F7D7BUju1JM+kVTjkg=
Content-Disposition: inline
In-Reply-To: <20200412194859.12663-19-rppt@kernel.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>

On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The free_area_init_node() is only used by x86 to initialize a memory-less
> nodes.
> Make its name reflect this and drop all the function parameters except node
> ID as they are anyway zero.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/mm/numa.c | 5 +----
>  include/linux/mm.h | 9 +++------
>  mm/page_alloc.c    | 7 ++-----
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index fe024b2ac796..8ee952038c80 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -737,12 +737,9 @@ void __init x86_numa_init(void)
>  
>  static void __init init_memory_less_node(int nid)
>  {
> -	unsigned long zones_size[MAX_NR_ZONES] = {0};
> -	unsigned long zholes_size[MAX_NR_ZONES] = {0};
> -
>  	/* Allocate and initialize node data. Memory-less node is now online.*/
>  	alloc_node_data(nid);
> -	free_area_init_node(nid, zones_size, 0, zholes_size);
> +	free_area_init_memoryless_node(nid);
>  
>  	/*
>  	 * All zonelists will be built later in start_kernel() after per cpu
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1c2ecb42e043..27660f6cf26e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2272,8 +2272,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  }
>  
>  extern void __init pagecache_init(void);
> -extern void __init free_area_init_node(int nid, unsigned long * zones_size,
> -		unsigned long zone_start_pfn, unsigned long *zholes_size);
> +extern void __init free_area_init_memoryless_node(int nid);
>  extern void free_initmem(void);
>  
>  /*
> @@ -2345,10 +2344,8 @@ static inline unsigned long get_num_physpages(void)
>  
>  /*
>   * Using memblock node mappings, an architecture may initialise its
> - * zones, allocate the backing mem_map and account for memory holes in a more
> - * architecture independent manner. This is a substitute for creating the
> - * zone_sizes[] and zholes_size[] arrays and passing them to
> - * free_area_init_node()
> + * zones, allocate the backing mem_map and account for memory holes in an
> + * architecture independent manner.
>   *
>   * An architecture is expected to register range of page frames backed by
>   * physical memory with memblock_add[_node]() before calling
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 376434c7a78b..e46232ec4849 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6979,12 +6979,9 @@ static void __init __free_area_init_node(int nid, unsigned long *zones_size,
>  	free_area_init_core(pgdat);
>  }
>  
> -void __init free_area_init_node(int nid, unsigned long *zones_size,
> -				unsigned long node_start_pfn,
> -				unsigned long *zholes_size)
> +void __init free_area_init_memoryless_node(int nid)
>  {
> -	__free_area_init_node(nid, zones_size, node_start_pfn, zholes_size,
> -			      true);
> +	__free_area_init_node(nid, NULL, 0, NULL, false);

Can we move free_area_init_memoryless_node() definition into 
arch/x86/mm/numa.c since there's only one caller there?

And I am also wondering if adding a wrapper
free_area_init_memoryless_node() is necessary if it's only called the
function free_area_init_node().

>  }
>  
>  #if !defined(CONFIG_FLAT_NODE_MEM_MAP)
> -- 
> 2.25.1
> 
