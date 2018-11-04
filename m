From: William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH -next 0/3] Add support for fast mremap
Date: Sun, 4 Nov 2018 00:56:48 -0600
Message-ID: <D6FB3C15-A8C1-4694-A434-A7489F590E05@oracle.com>
References: <20181103040041.7085-1-joelaf@google.com>
 <6886607.O3ZT5bM3Cy@blindfold>
 <e1d039a5-9c83-b9b9-98b5-d39bc48f04e0@kot-begemot.co.uk>
 <20181103183208.GA56850@google.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5/3mBHDPg8fhydIQno7tY6osmD3isn+ISyOo4hepzG8=; b=B52SGC7cj//SI2
	CPFaPzgoTdPfuY2CMDr7ilJ8nOcOxTDcDQxPGKlugMeZ7sdMIf3W4fY0wWPyRNbXeeoLCGZ8ROI5B
	WeH0mAmt1wk9p9zbF8ZCae1R1fkvHTV6ZjB5Csar27Mnz1Exrghb6sCFLq643uWFcmFdn9gIdKIF6
	RPo+ftLu5kDNiUpSqC9zw0pw2a503lwKfftWFbsZXFIWKXbaGLwWkwMMzVNZu/5+L2Lm46mMmDcjV
	7DdU5XxoBTTzeJ/nP1SfVzL5n358+k3VQ1H9MFneBTPRKyHqvBbTPWfgLJjFKBe+eRHjFtCX25K2J
	x+C2LtvNq/cELbg1oI8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Dv2JIDyr6hj+SI1f67+zM2v2M4uA+R2C7fKFV5CQ+kE=;
 b=Js7Nh27vbqOyY2gZ0UpqFfC92w4EMKr/VwCtgb/4hz0cpD+muu4dt9mHR/RIg7LXLRKM
 KSdQlyKUBJ0Wepu8UCnGYCRdHpxOUY3LSEVv1pS+k+mLUIjCdfn6slguWQuKOfCVqlp8
 L9lqOMCdjJaGmZq1nHUWfgmmHv1CnRaeRXXjaAPM2Xi2w1DSFM+8xUpoxcjRF6GwcHR2
 Q8VGkhI55EFSCNDiU2BqFcJrF9NDtefdCtLLfW7nm+lXI8yZIprvLVxRVTeAfWiOYVVD
 vSRxnGitTcbrLliDWcoiH4FzDASOny4srW6qN47aUOBPO6AznnIha2Je6/kcXA9kalmP rQ== 
In-Reply-To: <20181103183208.GA56850@google.com>
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
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, linux-ia64@vge.kvack.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, r.kernel.org@lithops.sigma-star.at, hughd@google.com, "James E.J. Bottomley" <jejb@paris>



> On Nov 3, 2018, at 12:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> Looks like more architectures don't define set_pmd_at. I am thinking the
> easiest way forward is to just do the following, instead of defining
> set_pmd_at for every architecture that doesn't care about it. Thoughts?
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 7cf6b0943090..31ad64dcdae6 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -281,7 +281,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> 			split_huge_pmd(vma, old_pmd, old_addr);
> 			if (pmd_trans_unstable(old_pmd))
> 				continue;
> -		} else if (extent == PMD_SIZE && IS_ENABLED(CONFIG_HAVE_MOVE_PMD)) {
> +		} else if (extent == PMD_SIZE) {
> +#ifdef CONFIG_HAVE_MOVE_PMD
> 			/*
> 			 * If the extent is PMD-sized, try to speed the move by
> 			 * moving at the PMD level if possible.
> @@ -296,6 +297,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> 				drop_rmap_locks(vma);
> 			if (moved)
> 				continue;
> +#endif
> 		}
> 
> 		if (pte_alloc(new_vma->vm_mm, new_pmd))
> 

That seems reasonable as there are going to be a lot of architectures that never have
mappings at the PMD level.

Have you thought about what might be needed to extend this paradigm to be able to
perform remaps at the PUD level, given many architectures already support PUD-mapped
pages?

    William Kucharski
