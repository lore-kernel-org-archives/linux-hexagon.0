From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 18:38:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1810121838180.4366@hadrien>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
 <20181012163433.GA223066@joelaf.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aq3+I5MwjwDsgqU9K4A2XpXNDW6/e5NLoaU8cWlQHbg=; b=S2JaqqInlIUxZ9
	p8jib87wtRFc2y4xuN5fcUYk8cWrnBrEzpn1WYrqI1FG9m35HrVpFvXe1wRIu2af+H5jvO+J86j/b
	WE9o+oVL0+X54oClEEsbQV2LsoR8h8gxydRxs0ZT7YzJSzuTJjIXEesJPIMGNy0AyUjH8/1JBXV6C
	4uAFilEp9ivs6zLpzLr2xjYdFoki5exyO5fpPKaOjtcOScck8O2fIM4pvFvq7pkib+aVRuSNUOTxm
	XtT2J8iHwTtjKj4Bp8w+bgbFhwV0PB6mEKODFpbhNX0wU9x/l0odHQn91eIyllu/Z04hke9Ss19Lk
	8p7sOo67sD7Ft7WW6k0w==;
In-Reply-To: <20181012163433.GA223066@joelaf.mtv.corp.google.com>
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
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, Anton Ivanov <anton.ivanov@kot-b>

> I wrote something like this as below but it failed to compile, Julia any
> suggestions on how to express this?
>
> @pte_alloc_func_proto depends on patch exists@
> type T1, T2, T3, T4;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> @@
>
> (
> - T3 fn(T1, T2);
> + T3 fn(T1);
> |
> - T3 fn(T1, T2, T4);
> + T3 fn(T1, T2);
> )

What goes wrong?  It seems fine to me.

julia
