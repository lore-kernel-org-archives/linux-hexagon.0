From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Date: Sat, 27 Oct 2018 21:21:02 +1100
Message-ID: <20181027102102.GO8537@350D>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181024101255.it4lptrjogalxbey@kshutemo-mobl1>
 <20181024115733.GN8537@350D>
 <20181025021350.GB13560@joelaf.mtv.corp.google.com>
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
	List-Owner; bh=WOxIW/nPLy7Rt0f4i3YQkVCRVK7+S3eEt3luQqHVr8g=; b=Xi/S0xTc10L/3b
	cV2vG9fZHyqaYQVCKdzQKJ/ChAOGHXc6Hc4P8sb5ZR2pUYF+Dazwg+NoUKyfZo/OqsLY7Yn8zoMT6
	mi/IuP0OWXpP/xFy/trW39QcUJ75H8wHv9bIYHfZsomztCAXNeZNkprjxYEKUcwhM8Fa8RITdZb7h
	lnzddadVn73vuzn8vJPVV69e3AYqIOqL1znRgXF3cZJ0zKCgmBtnpXqhw2tXar8T+l0F3vz+TuysU
	5i1+82jZaOkqCdTVK76dHzkHlvUvNzBRPj8qdoVmVNmh09f25mOgUAuhkj3zc4MfPqSE0OgG12Cs4
	ZsxBoyZZU0bY1lpJzWOg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ytoc7E/E+CDN+36oMCq4ib7UWrIKwi1XigueqliThJE=;
 b=ab1knh/8i2Gpv4Vxfi+YDSBKbX/LgufE79cYPr5GJEdQUVQbI970thsDIy0ZjV1q0k
 ZSfcWvh4GTM9Brshk9p+y4tQ9MlVv9xCOgRN+Mkl3IacQhaurmJjOF4ISMav3UWSPWT0
 QDI4JUUMAIPA35q0/cXsitIc3ySa7+/5ANkq6TLz2UHPpSbIN1fzgNHsIaIbSC3XX++1
 mylMnA2ff0XDd2sL+yXZDHQHXijLBXi1MJNMHNoE52RFFgyL7H1Hr53le1mRs/9vRlLJ
 8fln4V5coK7PbseEtgyE6znLwjAsimR/DLzPXzQyaRXpcBZcO/1WMqn8CO3ILrNZhl0z
 +0sw==
Content-Disposition: inline
In-Reply-To: <20181025021350.GB13560@joelaf.mtv.corp.google.com>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, Ingo Molnar <mingo@redhat.com>, Geert

On Wed, Oct 24, 2018 at 07:13:50PM -0700, Joel Fernandes wrote:
> On Wed, Oct 24, 2018 at 10:57:33PM +1100, Balbir Singh wrote:
> [...]
> > > > +		pmd_t pmd;
> > > > +
> > > > +		new_ptl = pmd_lockptr(mm, new_pmd);
> > 
> > 
> > Looks like this is largely inspired by move_huge_pmd(), I guess a lot of
> > the code applies, why not just reuse as much as possible? The same comments
> > w.r.t mmap_sem helping protect against lock order issues applies as well.
> 
> I thought about this and when I looked into it, it seemed there are subtle
> differences that make such sharing not worth it (or not possible).
>

Could you elaborate on them?

Thanks,
Balbir Singh. 
