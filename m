From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 04/26] mips: remove ioremap_cachable
Date: Mon, 19 Aug 2019 20:57:30 +0000
Message-ID: <20190819205722.4eir2edy6qgtgarl@pburton-laptop>
References: <20190817073253.27819-1-hch@lst.de>
 <20190817073253.27819-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jp7hHF1AqvthBKQciVk4gG80JHpcz6ImFFEBzf+csWY=; b=KYTNfKrcnvbzBJ
	X58Pfq+BEqxIULkUYy4Tch6ggKFp6jXx2kP4udyINIxIQ8CCZKuVHsiRFt35t2XSiS8xaZSGRl6hc
	jF4q7c9KSl3hz5rThZSNv37DXGr8sGFdqSPe8O/bolRucAkIwb2BnN64K5g9eqf8ADZkug3FrINXa
	zFCKBpkU/NqR5T9xVpjw+VbYVkb+ZTnWozW9xivwGLjDPxT2p0fx24f2qPt9lZYiqgpNGEa5cbbZm
	BINP1RSSkNv43+ELTD45m088S7TeYD+sCuSri5e630RWNU4nrDlqDW3u+rwJbMsbBFJk//A9fjvpk
	wFvAOAuVOaZ9F2HHkIxg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQlemvDaibl3TmaUoytPX70nix/LzsjtaZ1/LsbuUDQ=;
 b=vQ/3pUFl5pl4EUYYaAjWg0jq9iLtomWR7q2NzSLd8KleB3fGL4Kf68+gNkERCR82HHTgHcJ3jmVtdMwBtxwKYn3CRheLwhUqHgXa2RA7zB/l6Vqrg1soikbidi4Hc0Eqd6Q3wYn9MPQsHUlsA7C2DQENfza+mdqBZZVqVoiJd3o=
In-Reply-To: <20190817073253.27819-5-hch@lst.de>
Content-Language: en-US
Content-ID: <F7A01E6E65132543B693A9F6442F8662@namprd22.prod.outlook.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Guo Ren <guoren@kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Vincent Chen <deanbo422@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, Greentime Hu <green.hu@gmail.com>, linux-mtd@list

Hi Christoph,

On Sat, Aug 17, 2019 at 09:32:31AM +0200, Christoph Hellwig wrote:
> Just define ioremap_cache directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/io.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 97a280640daf..c02db986ddf5 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -262,11 +262,11 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
>  #define ioremap_uc ioremap_nocache
>  
>  /*
> - * ioremap_cachable -	map bus memory into CPU space
> + * ioremap_cache -	map bus memory into CPU space
>   * @offset:	    bus address of the memory
>   * @size:	    size of the resource to map
>   *
> - * ioremap_nocache performs a platform specific sequence of operations to
> + * ioremap_cache performs a platform specific sequence of operations to
>   * make bus memory CPU accessible via the readb/readw/readl/writeb/
>   * writew/writel functions and the other mmio helpers. The returned
>   * address is not guaranteed to be usable directly as a virtual
> @@ -276,9 +276,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset,
>   * the CPU.  Also enables full write-combining.	 Useful for some
>   * memory-like regions on I/O busses.
>   */
> -#define ioremap_cachable(offset, size)					\
> +#define ioremap_cache(offset, size)					\
>  	__ioremap_mode((offset), (size), _page_cachable_default)
> -#define ioremap_cache ioremap_cachable
>  
>  /*
>   * ioremap_wc     -   map bus memory into CPU space
> -- 
> 2.20.1
> 
