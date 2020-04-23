From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 16/21] mm: remove early_pfn_in_nid() and
 CONFIG_NODES_SPAN_OTHER_NODES
Date: Thu, 23 Apr 2020 09:13:12 +0800
Message-ID: <20200423011312.GY4247@MiWiFi-R3L-srv>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-17-rppt@kernel.org>
Mime-Version: 1.0
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2i5M2ycjs3rlosl36wEuRNmxANDiCG1t4SjA8z/n0gs=; b=GAKIM4WD9SM74dm6rRWCNJegG
	PzpctPNlBdnGdemMla544JEUXjgwoJliWGga0Hf1KXYKcHOXYPUIY4Sd5G/LqFae3QVuxlT0wbuD2
	UY0NIso6P4b4Gqpr5ZoqKsOevoe0pBw+JGRurRzcL7JquygPJfIheMh8lflQmSHBRJ3g3gJil65Qr
	nxvewy+l9OYKrd4EpMcNdY9dcGYGczfLnaZr7+AYA9IaMYos3G9PfHg2Rq4JYL7KCT97yelA4CljY
	LQ1rY3wMQCwX1RMpv5Roz8NDM8tMVtSbk/tY8q9JEilwqhcaKBU2u0vTHvoIvbFfHoxZyN7ffBu4r
	B9OkBS/2A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587604411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2i5M2ycjs3rlosl36wEuRNmxANDiCG1t4SjA8z/n0gs=;
 b=R6e10Uhs5Yo958u1WHMs5QxFhLnIkQrzgv/gqwubCiTzjo+qQv+3rEr6rCO/RKpd1izZEZ
 x24S3n4zFpoI/WXQ1BBxeGzzZrN5KHURQ4sKVx9C6ff9fQ8O0r6OpP0KlGd5TJQDHtOy4n
 oZO2v0B9WoclAwf1F2826RhcInHgPBY=
Content-Disposition: inline
In-Reply-To: <20200412194859.12663-17-rppt@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>

On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions

This commit id should be a temporary one, will be changed when merged
into maintainer's tree and linus's tree. Only saying last patch plus the
patch subject is OK?

> rather that check each PFN") made early_pfn_in_nid() obsolete and since
> CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
> implementation of early_pfn_in_nid() it is also not needed anymore.
> 
> Remove both early_pfn_in_nid() and the CONFIG_NODES_SPAN_OTHER_NODES.
> 
> Co-developed-by: Hoan Tran <Hoan@os.amperecomputing.com>
> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig |  9 ---------
>  arch/sparc/Kconfig   |  9 ---------
>  arch/x86/Kconfig     |  9 ---------
>  mm/page_alloc.c      | 20 --------------------
>  4 files changed, 47 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5f86b22b7d2c..74f316deeae1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -685,15 +685,6 @@ config ARCH_MEMORY_PROBE
>  	def_bool y
>  	depends on MEMORY_HOTPLUG
>  
> -# Some NUMA nodes have memory ranges that span
> -# other nodes.  Even though a pfn is valid and
> -# between a node's start and end pfns, it may not
> -# reside on that node.  See memmap_init_zone()
> -# for details.
> -config NODES_SPAN_OTHER_NODES
> -	def_bool y
> -	depends on NEED_MULTIPLE_NODES
> -
>  config STDBINUTILS
>  	bool "Using standard binutils settings"
>  	depends on 44x
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 795206b7b552..0e4f3891b904 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -286,15 +286,6 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -# Some NUMA nodes have memory ranges that span
> -# other nodes.  Even though a pfn is valid and
> -# between a node's start and end pfns, it may not
> -# reside on that node.  See memmap_init_zone()
> -# for details.
> -config NODES_SPAN_OTHER_NODES
> -	def_bool y
> -	depends on NEED_MULTIPLE_NODES
> -
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool y if SPARC64
>  	select SPARSEMEM_VMEMMAP_ENABLE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9d3e95b4fb85..37dac095659e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1581,15 +1581,6 @@ config X86_64_ACPI_NUMA
>  	---help---
>  	  Enable ACPI SRAT based node topology detection.
>  
> -# Some NUMA nodes have memory ranges that span
> -# other nodes.  Even though a pfn is valid and
> -# between a node's start and end pfns, it may not
> -# reside on that node.  See memmap_init_zone()
> -# for details.
> -config NODES_SPAN_OTHER_NODES
> -	def_bool y
> -	depends on X86_64_ACPI_NUMA
> -
>  config NUMA_EMU
>  	bool "NUMA emulation"
>  	depends on NUMA
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c43ce8709457..343d87b8697d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1541,26 +1541,6 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
>  }
>  #endif /* CONFIG_NEED_MULTIPLE_NODES */
>  
> -#ifdef CONFIG_NODES_SPAN_OTHER_NODES
> -/* Only safe to use early in boot when initialisation is single-threaded */
> -static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> -{
> -	int nid;
> -
> -	nid = __early_pfn_to_nid(pfn, &early_pfnnid_cache);
> -	if (nid >= 0 && nid != node)
> -		return false;
> -	return true;
> -}
> -
> -#else
> -static inline bool __meminit early_pfn_in_nid(unsigned long pfn, int node)
> -{
> -	return true;
> -}
> -#endif

And macro early_pfn_valid() is not needed either, we may need remove it
too. 

Otherwise, removing NODES_SPAN_OTHER_NODES in this patch looks good.

Reviewed-by: Baoquan He <bhe@redhat.com>

> -
> -
>  void __init memblock_free_pages(struct page *page, unsigned long pfn,
>  							unsigned int order)
>  {
> -- 
> 2.25.1
> 


