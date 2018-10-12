From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Date: Fri, 12 Oct 2018 05:50:46 -0700
Message-ID: <20181012125046.GA170912@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vv2q5RPaYPxtHiea9/6H/fBzubHa4ecZNCUi7DMg2uU=; b=WgCCUW2oUxWx7W
	ly+vx/sRnG1/et19eARJWJwvyjqTlqTpjgaDnnKR39wd6FQDSRsyEQ+ae8NqBSf59rynxKFx+Unel
	eg+TOJtkJDbiSjmoj8E8HrxvAo1RswvhIvmSA3dOfHe1rjMwZwMwfn1inrKiWR9ZOMS+3H93zN6lo
	cG5N9Dswg58F8fY0+7T2I0L0oZy5NCn/0fKnEZOOeKCeXqM71xEdm6EwaX6/XnNy67OANc/LstGaP
	9EyYB1KzojNlfjW6Wfod9Dkj6ruiYHmV7Gp67RZe52l6eXEIlML6XxO4y9FGLHzuEPjaK5stxCixy
	ajZT1YzL0RnvHELlHlJw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QKN0QLgWMdeaFShuOKgUCdS+KZEgqTytMiliL2mzgC0=;
 b=cuTpq2KxjzFREjuReJCgXoTtmsf4MapPO/GKTB1jBLxsEEu2m7M7ZkvRB6q79tS5tz
 O6mqiraSPEsjDSeGINirN/8v2zV5PUlYs/7NG0sKTsmNtz6ADZ+8u7AlqnAMULoHIM7r
 c98gGt3pHgL5ok5lR90IVL9Vuy1e12CI4gJLs=
Content-Disposition: inline
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>, Geert

On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > Android needs to mremap large regions of memory during memory management
> > related operations. The mremap system call can be really slow if THP is
> > not enabled. The bottleneck is move_page_tables, which is copying each
> > pte at a time, and can be really slow across a large map. Turning on THP
> > may not be a viable option, and is not for us. This patch speeds up the
> > performance for non-THP system by copying at the PMD level when possible.
> > 
> > The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> > completion times drops from 160-250 millesconds to 380-400 microseconds.
> > 
> > Before:
> > Total mremap time for 1GB data: 242321014 nanoseconds.
> > Total mremap time for 1GB data: 196842467 nanoseconds.
> > Total mremap time for 1GB data: 167051162 nanoseconds.
> > 
> > After:
> > Total mremap time for 1GB data: 385781 nanoseconds.
> > Total mremap time for 1GB data: 388959 nanoseconds.
> > Total mremap time for 1GB data: 402813 nanoseconds.
> > 
> > Incase THP is enabled, the optimization is skipped. I also flush the
> > tlb every time we do this optimization since I couldn't find a way to
> > determine if the low-level PTEs are dirty. It is seen that the cost of
> > doing so is not much compared the improvement, on both x86-64 and arm64.
> 
> I looked into the code more and noticed move_pte() helper called from
> move_ptes(). It changes PTE entry to suite new address.
> 
> It is only defined in non-trivial way on Sparc. I don't know much about
> Sparc and it's hard for me to say if the optimization will break anything
> there.

Sparc's move_pte seems to be flushing the D-cache to prevent aliasing. It is
not modifying the PTE itself AFAICS:

#ifdef DCACHE_ALIASING_POSSIBLE
#define __HAVE_ARCH_MOVE_PTE
#define move_pte(pte, prot, old_addr, new_addr)                         \
({                                                                      \
        pte_t newpte = (pte);                                           \
        if (tlb_type != hypervisor && pte_present(pte)) {               \
                unsigned long this_pfn = pte_pfn(pte);                  \
                                                                        \
                if (pfn_valid(this_pfn) &&                              \
                    (((old_addr) ^ (new_addr)) & (1 << 13)))            \
                        flush_dcache_page_all(current->mm,              \
                                              pfn_to_page(this_pfn));   \
        }                                                               \
        newpte;                                                         \
})
#endif

If its an issue, then how do transparent huge pages work on Sparc?  I don't
see the huge page code (move_huge_pages) during mremap doing anything special
for Sparc architecture when moving PMDs..

Also, do we not flush the caches from any path when we munmap address space?
We do call do_munmap on the old mapping from mremap after moving to the new one.

thanks,

 - Joel
