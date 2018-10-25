From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Date: Thu, 25 Oct 2018 13:47:03 +0300
Message-ID: <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
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
	List-Owner; bh=yAb9ELWxbqMMsSw0dIjYDXN+cmh3Lcp3EblPfokbLyI=; b=ay5ZQDlW4ZNI2P
	39eYQlwWuLhhzIsvpSvnCyeZEDpzdYFrLXx7zSM68yrMch1pqwAcVwowKcT+HpGxVKKRrcGVBNYrd
	OxBPQy8A9qt4VDNuLSVhkuv9ZqMP9fkRJNRG3YKgxImzBLjQrr7WtKNxoNEKprYHWi6ulKkjgiIHP
	2lC5HO4H/8HPK6woiXjYfYi0I8tWBpzmmW0pJrEtDLlpY9nxezyYMop9AUBv8c+88Zm5aeIRL7Nsk
	bfXQo56f0u0iLjL7yvpEdhKRe299K4aLC757CphZ1Uc6Gi1EYgR4SBHd+h62Y/bt8NWGs7QOBHMJQ
	NYTvhGQlheWZI2tUasbQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1R3A0ycONFuPhko1Zvw9OxjeXH19x+s87tjU9oKwfSw=;
 b=uRVyPXCyFw/vFJ9ptle4zloJMrol+XisBixqDteIGc2z2oG/f4Q8NfKA0B2gilh+Rr
 i+HTajUVnTgL+59CrAsNpIQzGw2bYTsOBSPmi9WVqroK585WsKPK4zT2IIvv2C6f23dJ
 F9grKSKsJ1P0XFYJA4GEnLgn3qb5En9KpzOMyEtJi1cliFP4s9dMdLlWGK2lC/PN9h34
 PzeoJEkp3NKRxc1VVfXDgfbweJjDPzw7KTQ0g9tXmzEx6xT3/YOHh00cgteTAphadXLE
 270H2CcukCX0575S0EAUXv7rBR5pp/bl8ZyBNwBfTku8pgy4LLUWuBo4TdiLZcu1G2r6
 ZGGQ==
Content-Disposition: inline
In-Reply-To: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, Ingo

On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > This series speeds up mremap(2) syscall by copying page tables at the
> > PMD level even for non-THP systems. There is concern that the extra
> > 'address' argument that mremap passes to pte_alloc may do something
> > subtle architecture related in the future that may make the scheme not
> > work.  Also we find that there is no point in passing the 'address' to
> > pte_alloc since its unused. So this patch therefore removes this
> > argument tree-wide resulting in a nice negative diff as well. Also
> > ensuring along the way that the enabled architectures do not do anything
> > funky with 'address' argument that goes unnoticed by the optimization.
> 
> Did you happen to look at the history of where that address argument
> came from? -- just being curious here. ISTR something vague about
> architectures having different paging structure for different memory
> ranges.

I see some archicetures (i.e. sparc and, I believe power) used the address
for coloring. It's not needed anymore. Page allocator and SL?B are good
enough now.

See 3c936465249f ("[SPARC64]: Kill pgtable quicklists and use SLAB.")

-- 
 Kirill A. Shutemov
