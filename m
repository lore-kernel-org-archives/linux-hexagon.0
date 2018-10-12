From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 09:46:44 -0700
Message-ID: <20181012164644.GC223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
 <20181012163433.GA223066@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810121838180.4366@hadrien>
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
	List-Owner; bh=5HaYAyoWv48myR0VPnGU0Gem/1qC4FfFysukIafcNzM=; b=Qdl/+I5soUqWfz
	5s1rtk/1We6UDpNEuRVej49IgK+g7d+kF83TLCkqPL3X16Qv1v6BgrQkGiWCr6a6MsyLS0cnFE3nu
	8WwVUi2BLVuqjjguHvsYsrFiSp0S9u4jY0uSNql/gU5o7yMB+hd+JZPumn24Me93ZiYmRRNXaLjwR
	oWwngsoI+TZr0G+JQ37uduyf9VzYN3qc0n6cGt3vIfjOeDObIcgyvXGqJZ4HAZ2h7eLLZfIa/N6Y0
	DJGPevcGCzC/ttb7W316AKUyuUgQ7Zd03SNrJbQwfZUODAsjoBdfGt829CsHY75+jDliSjRspvFuB
	msTmpls8i1MpuBsRAUNA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Umti8berIQqjm65Zoyf/w3JloUMrJhwZUXe+Y2BsWdc=;
 b=KQEzQQFkI6jyKow9cNxsGELIJZyLx1I8uGjB/QnyLtJkOtbntdWVJwS8u0cqFmWoK2
 Zbax90aSm2shdb707DdFjVreJBouZPwsGgrwGCldaGV6mLKNDvduyzCfqgYYC5kplbyd
 Z9GrlBVjP7KcXBEbZpZjy43C4pR8q7gp8Lu8Q=
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1810121838180.4366@hadrien>
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
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, Anton Ivanov <anton.ivanov@kot-b>

On Fri, Oct 12, 2018 at 06:38:57PM +0200, Julia Lawall wrote:
> > I wrote something like this as below but it failed to compile, Julia any
> > suggestions on how to express this?
> >
> > @pte_alloc_func_proto depends on patch exists@
> > type T1, T2, T3, T4;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > @@
> >
> > (
> > - T3 fn(T1, T2);
> > + T3 fn(T1);
> > |
> > - T3 fn(T1, T2, T4);
> > + T3 fn(T1, T2);
> > )
> 
> What goes wrong?  It seems fine to me.

Weird it seems working now. I could swear 5 minutes ago it wasn't and I did
give a unique rule name. Don't know what I missed.

Anyway, thank you for all the quick responses and the help!

- Joel
