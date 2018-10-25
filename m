From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Date: Wed, 24 Oct 2018 19:09:07 -0700
Message-ID: <20181025020907.GA13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rzUvdW2MB+PzMlbbuqpZ+UubxQx/LyT45D1T3uqRkgk=; b=gUpu+sYr7h/cSk
	G9J3x8zxLIzUZBEYdmUQcitwhnqmFGR409QgLFdoi37b3jjeF/2NMSs681CJbodXigF9T9QMCKlqY
	eIPCiiyv0llzxTosVTq2aBefkfeiQefMMFkn9Mol80M8QCLnMz4wrevbqwDaU+rhPSe4Wek2cpT0m
	f8r5PvzVqA5hWRT1hQlZUwMPXuNW/Eet/NVdP9PKOBQzHUKrw8y1RPhm3qZA1yn+P5Uag18gwZ/Bv
	U/YEWAI+3HW3pw9lHz0WmN7z5FcVqz5wu22djcleuT+OcADr5DWB2+ACZSig7epQJUTAxah/koYT5
	qLyNqNvelFMomAnsNzZA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G78I9uM4gXdiLalpqQZcUQ0k8S9gAvq6zBmyUxhGe0M=;
 b=LAnJhDOqLDe5rJ8W4SiC2EjUQZvQu/r5ZibVfgxKfT2epX8iHZwYQmEjB6a8btC1dW
 r6dDSvdCvkPgsk5m3K0hxUEc1ohpdLPr/504o7kJ7XSyqWkNXqLU77+seSO2HzOgNvQs
 hVyNi6MDrJlz77EflnU3vSDe0xbeuTe8cghrE=
Content-Disposition: inline
In-Reply-To: <20181024125724.yf6frdimjulf35do@kshutemo-mobl1>
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Balbir Singh <bsingharora@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, I

On Wed, Oct 24, 2018 at 03:57:24PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> > On Wed, Oct 24, 2018 at 01:12:56PM +0300, Kirill A. Shutemov wrote:
> > > On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> > > > diff --git a/mm/mremap.c b/mm/mremap.c
> > > > index 9e68a02a52b1..2fd163cff406 100644
> > > > --- a/mm/mremap.c
> > > > +++ b/mm/mremap.c
> > > > @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> > > >  		drop_rmap_locks(vma);
> > > >  }
> > > >  
> > > > +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> > > > +		  unsigned long new_addr, unsigned long old_end,
> > > > +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> > > > +{
> > > > +	spinlock_t *old_ptl, *new_ptl;
> > > > +	struct mm_struct *mm = vma->vm_mm;
> > > > +
> > > > +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> > > > +	    || old_end - old_addr < PMD_SIZE)
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * The destination pmd shouldn't be established, free_pgtables()
> > > > +	 * should have release it.
> > > > +	 */
> > > > +	if (WARN_ON(!pmd_none(*new_pmd)))
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * We don't have to worry about the ordering of src and dst
> > > > +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> > > > +	 */
> > > > +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> > > > +	if (old_ptl) {
> > > 
> > > How can it ever be false?

Kirill,
It cannot, you are right. I'll remove the test.

By the way, there are new changes upstream by Linus which flush the TLB
before releasing the ptlock instead of after. I'm guessing that patch came
about because of reviews of this patch and someone spotted an issue in the
existing code :)

Anyway the patch in concern is:
eb66ae030829 ("mremap: properly flush TLB before releasing the page")

I need to rebase on top of that with appropriate modifications, but I worry
that this patch will slow down performance since we have to flush at every
PMD/PTE move before releasing the ptlock. Where as with my patch, the
intention is to flush only at once in the end of move_page_tables. When I
tried to flush TLB on every PMD move, it was quite slow on my arm64 device [2].

Further observation [1] is, it seems like the move_huge_pmds and move_ptes code
is a bit sub optimal in the sense, we are acquiring and releasing the same
ptlock for a bunch of PMDs if the said PMDs are on the same page-table page
right? Instead we can do better by acquiring and release the ptlock less
often.

I think this observation [1] and the frequent TLB flush issue [2] can be solved
by acquiring the ptlock once for a bunch of PMDs, move them all, then flush
the tlb and then release the ptlock, and then proceed to doing the same thing
for the PMDs in the next page-table page. What do you think?

- Joel
