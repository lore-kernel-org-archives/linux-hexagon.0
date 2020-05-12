From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 08/12] mm: pgtable: add shortcuts for accessing kernel
 PMD and PTE
Date: Tue, 12 May 2020 12:24:41 -0700
Message-ID: <20200512192441.GZ16070@bombadil.infradead.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-9-rppt@kernel.org>
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
	List-Owner; bh=M5L59npbP6DAmqI8JAc2O/DvS/BF5UlxipsHdFyHNPc=; b=C3I/2h02zwe3Lk
	gdBwwkMV4qfukV9sZCpKQ7uLE64fwOyfkqXlhpRHR9nfKGJAYrlM3wk+G7HsLA2eh4NDK+RecdoPw
	OIKsrwleDBczt0pmf/JMX3M5Ti/GqkhEUBeP6++18F8ac+MPaK7ofb46yrINsJUNGWUAROYpJ46kg
	yVZX3hMG2MMD2Fh0WOtY2+IdoW94v+nQsL3rHsBV2riiGl04h+cACfikDIyFCGP/PpDsyyToRHXIl
	fXP/LG75uNLCn7mt5sPt5mZzDMGucM241406VS3hq70RdOz4wi2D2AQHdp9O5oKzrudY7R5ntgi3i
	eRK//OTDlX0AWaE35+kw==;
Content-Disposition: inline
In-Reply-To: <20200512184422.12418-9-rppt@kernel.org>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, lin

On Tue, May 12, 2020 at 09:44:18PM +0300, Mike Rapoport wrote:
> +++ b/include/linux/pgtable.h
> @@ -28,6 +28,24 @@
>  #define USER_PGTABLES_CEILING	0UL
>  #endif
>  
> +/* FIXME: */

Fix you what?  Add documentation?

> +static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long va)
> +{
> +	return pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, va), va), va), va);
> +}
