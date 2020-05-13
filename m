From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 08/12] mm: pgtable: add shortcuts for accessing kernel
 PMD and PTE
Date: Wed, 13 May 2020 08:23:20 +0300
Message-ID: <20200513052320.GO14260@kernel.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-9-rppt@kernel.org>
 <20200512192441.GZ16070@bombadil.infradead.org>
Mime-Version: 1.0
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hd5UK9tJpTtmUZrhPONmMMoochKvyyAg5ulZUyWSvbM=; b=QqbgA5zmmyMyLztfsj+/yZnbQ
	MQJ19BNo3cJPqnuPcTWxQFErAEiAWWfwFFrEkMd3NgMGt66l2UDJZ5PDxQi9QUBWmlqvw21aO4Uz2
	bzwVyjZ7qVJzWJQBkVXvOOswJC+o1P0WqZKB3zri+v6XLCXgI+ODLpqJDcp9fr9Da+x2U1lGtNMdp
	T8NTUtEifvB7SenbQFh7F2lY/yq5ZyuN+BFLBcUPhotFx+Mdf24xd/DAhVGINkW1aNpZEkWSTUrtc
	GEN8TEdjJc1LffAaax5nNqnOwHTC2/1RUPwiadiw2a0oCR0TRibDxC9RGGECG81LYmVz+39rtv2zP
	c38Mq0ZwQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589347416;
 bh=cxEex4OkOul1zYfcItsUOuWynzE/Lgl9iPMNnRJoKtg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NKwZ606uMnq7vGufmQSQi8UghGfD03KoKi3771z9DBsw1+Wo1JjxsFFWhM7dLfYtQ
 POagNMJcXXS2Tb5YBLano+IOZdgbrMfiYhEi9ZEWLAfmXk4sFuNrYSWiaABLsyC1eI
 WXhJfNJ0uBeiHMn5Sjkqw15bRWEojOP2A2FeEJvw=
Content-Disposition: inline
In-Reply-To: <20200512192441.GZ16070@bombadil.infradead.org>
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, lin

On Tue, May 12, 2020 at 12:24:41PM -0700, Matthew Wilcox wrote:
> On Tue, May 12, 2020 at 09:44:18PM +0300, Mike Rapoport wrote:
> > +++ b/include/linux/pgtable.h
> > @@ -28,6 +28,24 @@
> >  #define USER_PGTABLES_CEILING	0UL
> >  #endif
> >  
> > +/* FIXME: */
> 
> Fix you what?  Add documentation?

Ouch, indeed :)

> > +static inline pmd_t *pmd_off(struct mm_struct *mm, unsigned long va)
> > +{
> > +	return pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, va), va), va), va);
> > +}

-- 
Sincerely yours,
Mike.

