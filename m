From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Date: Wed, 24 Oct 2018 19:13:50 -0700
Message-ID: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
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
	List-Owner; bh=jB8RpTc7IAIoNhq2EERqIuaS843hm/hgSbs5gYFYvOc=; b=qyy95DWskV8RS+
	ixreCwCcs7yWnY/gW5ur8iJCy4kPhreIfFNEMoaP/0RnD4FonlQmlAZ8umpbCCy/MIEDL+fj1Bcg9
	EjwyeLC/e8+mALe6mi4TGSTvI5JXT8LEkZMZwYK5XtAQxbLuab9Esn0STYtZJ1IHs+XDTA/IB96FM
	pl1n7M77ED7EXxeKoOQWNXFZvQ//ymkjGXOlY3OMdVSTokxCwiiP39yGbOaijmjxodcarDGKdo2Zw
	ZPunvzWEiUcsIkXHmqY5R7jDALgyAfu6fVqdAtbLTn1GrMYyAAY4QWdLmfI9v9xxuomBFJxNWEc4M
	y8D9Kci7BWwohw747Tcg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5CbWcmgaWhK69oh2DEOguVgA2uKl1YpKoqaGwtGwge8=;
 b=q/q3QTdACzUlPpDQMN1kjcezMfcsn0Yv6fXB6ODPHDCxjW91L/KWd7ad+HnYMhVDLK
 4w8FEyzAp+rB09Si8JZs7MJE9NTlxjm6PO3Hk2MpIdxGl6P2KagjiLkUB/ExO2oGujpm
 CSZTqm0K2zOVm+Foil/VJrYg2JhZozpJsR9l8=
Content-Disposition: inline
In-Reply-To: <20181024115733.GN8537@350D>
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
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, Ingo Molnar <mingo@redhat.com>, Geert

On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
[...]
> > > +		pmd_t pmd;
> > > +
> > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> 
> 
> Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> the code applies, why not just reuse as much as possible? The same comments
> w.r.t mmap_sem helping protect against lock order issues applies as well.

I thought about this and when I looked into it, it seemed there are subtle
differences that make such sharing not worth it (or not possible).

 - Joel
