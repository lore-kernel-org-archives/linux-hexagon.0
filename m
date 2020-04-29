From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 16/20] mm: remove early_pfn_in_nid() and
 CONFIG_NODES_SPAN_OTHER_NODES
Date: Wed, 29 Apr 2020 07:17:06 -0700
Message-ID: <20200429141706.GA25142@infradead.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-17-rppt@kernel.org>
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
	List-Owner; bh=21m/t7HJQGMC3vgtA6hO5Xt0fbKtdsHbZN0Why9IqYY=; b=fXah6Zb7TeiWNv
	2Yk6TutMvZvP0Dv2YfqyJy6j8P50/6zJ8GdvMOtJLGfStstTzHCBEJIDrWuDPyzQYh5G+gaIycIJH
	Ll47xnbEseXidfMuHJe+6oy4ZImdTQOuktD5HBXdxzKnUaRo1jbAVmpvquQQ9rlrTpqyoNWzAg8XE
	colWeu7C0hHfSMRflVFvLcUSnPVaYKht/H2wr5TnvbIlTMkWGr43bUPGKZxA3vUISmSA/N1CZiNe3
	D0hsTCFKs5389+gum2Y3H1+1TWOchXedRIPwdqm39GX4OFIxDcabLUTwtwWvO3SXImPx9xpNysU8f
	wXMT+B1hyXYD0OaQ4NrA==;
Content-Disposition: inline
In-Reply-To: <20200429121126.17989-17-rppt@kernel.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Ley Foon Tan <ley.foon.tan@intel.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hoan Tran <Hoan>

On Wed, Apr 29, 2020 at 03:11:22PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions
> rather that check each PFN") made early_pfn_in_nid() obsolete and since
> CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
> implementation of early_pfn_in_nid() it is also not needed anymore.

I don't think you can quote a commit id for something that hasn't been
commited to mainline yet.  Then again I would have just merged this
patch into the one that obsoleted early_pfn_in_nid anyway.
