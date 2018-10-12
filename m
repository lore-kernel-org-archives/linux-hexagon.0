From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Date: Fri, 12 Oct 2018 14:36:45 +0300
Message-ID: <20181012113644.meqy5yb3xrxyh6lh@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
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
	List-Owner; bh=Dks/rym0tfhS4WaWZE/Pe5AXrXAIRVZxa2FDYIUcEqI=; b=Z0cCzxcgsmNV0N
	9y+ibDYAcatiCUfWTxG6bESgayL8BUik8hownD2ztWHsk/do6Fr/+MKnkxssuuZynhU5g75M0afBV
	yRvamCV2Nhzs8ndOcUzNGwhZsN9JknV/dWtlle6W+Qx7BMEi8XufH53v3lCZJSbWGwkAyiH4UkR/J
	cUggoi0EotDQUVcdOEXRpo80802E93PK7qaGtk8jCUdxl8Kz4gAbusQNG+O0i3r+TGyGkjY4a1F3m
	vkfJwfGQgjgut4cnH4r0ZXKf+0o5Qwsee54M57u+fm66bbqQj38g0/pgqTR+4pcGlL7Vl0v2cuMf+
	UGf31v79IQwbeAyUt89g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RUBKeYPll4jMLSN3Gb+udTJXKfzopX9w+dug7aYTr/k=;
 b=sLllf+hmYeVdtEKLgpvUk4uo/R65gqQ2L7zDPqofo15O4TD2lqqZ48BnJii3zNLrzj
 NyrHzrmlo5M8BFAgDiAnDSzFkH/4pCMx41PDkn9KakXzyWFHzbatjJl7tG6M3QlRWbCb
 PxniswSJvBlL+/pLj7KZtuZCCp2I33/xGPiDrmpqGjXDRkvRlkWGmyBycB9Rzb7E6Zs2
 L7OGkByZKFBctGsWJmvbk2lLkFhYwnI954eYYA9mDD2xDlJKx5AIfd14wPbV5Zu/imuW
 2GvR+0yYrS49d3VwMQPPTufF89rOzatfQb3FsyMC/zTNqHmMQ6U+r5c6uWOkB0vCTRFN
 mXmw==
Content-Disposition: inline
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
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
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu, Ingo Molnar <mingo@redhat.com>, Geert

On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  			split_huge_pmd(vma, old_pmd, old_addr);
> >  			if (pmd_trans_unstable(old_pmd))
> >  				continue;
> > +		} else if (extent == PMD_SIZE) {
> 
> Hm. What guarantees that new_addr is PMD_SIZE-aligned?
> It's not obvious to me.

Ignore this :)

-- 
 Kirill A. Shutemov
