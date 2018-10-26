From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Date: Fri, 26 Oct 2018 10:50:47 +0200
Message-ID: <20181026085047.GB3109@worktop.c.hoisthospitality.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
 <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
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
	List-Owner; bh=DSGdF6/iMXAfO2LNryt6tw4ux5kPprgiztoremF+SPM=; b=lTogTAIvogh7oR
	uJzuk6mbTmGcS8PCUIUC9SLt0BrKBjBdQwM947mtOq7aQ/nAUk33tqjYb6M/Semj1XcYUrOnbc0IV
	WI9qvlc7c8EFpdiwsjP9bj5UP9Aez7kinRADiptx3phu/ES0svcIma7ndEqeWhRts/EEjqr98wj3W
	HnkfBHwqJhnUs5UWrSinA7kRuyUPZn9Bi4/FwggICpnjBSx2OXuMEoE7+7483DjN2u1EJvJ4Wh9/f
	ixp629Jr1hGktyz9YvaGFEEnoQA8N3WGt6qWA/vpxFlk14i7JwKrL3WscMp/35fNO8/1Kuw4/bdiT
	LtTkISxpS5Rm9olBQUNg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t4U6dJOCnA0c/EZV0nmuSLy/HD8d4dYO3ZonI67d8Vk=; b=DPhftboxJNVK8gljOSI9ek+lk
 cu0xqt1kC5w7yCxw6Jsznw1tHw2bNfFS/B99G90XrfF2EouGTY+fnjyh2fFe8Ea4pm+LfBzpKsORm
 vHKSHxTajvN1zlzwJSY3IQRIoUSjK9Ks0EaN70/cGAc3V1cVwVubUjQU8B8T3dcCN+Cny2z4IXEkf
 5989+J/lbf4qCCiiXPFuktGNapnha5La8DRY2VrXPeyZAvzLzZFAr0KwXyN2xKeaZefS1TlUOUz9Q
 v3E0AoVoDPrDe463fQg0erQi1phVVaaGU+vviNvYVqHIgoubM4nIzXXBkEBYhhWFO095CIUsfkQj8
 Onm8/N6Lg==;
Content-Disposition: inline
In-Reply-To: <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
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
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, Ingo

On Thu, Oct 25, 2018 at 01:47:03PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > > This series speeds up mremap(2) syscall by copying page tables at the
> > > PMD level even for non-THP systems. There is concern that the extra
> > > 'address' argument that mremap passes to pte_alloc may do something
> > > subtle architecture related in the future that may make the scheme not
> > > work.  Also we find that there is no point in passing the 'address' to
> > > pte_alloc since its unused. So this patch therefore removes this
> > > argument tree-wide resulting in a nice negative diff as well. Also
> > > ensuring along the way that the enabled architectures do not do anything
> > > funky with 'address' argument that goes unnoticed by the optimization.
> > 
> > Did you happen to look at the history of where that address argument
> > came from? -- just being curious here. ISTR something vague about
> > architectures having different paging structure for different memory
> > ranges.
> 
> I see some archicetures (i.e. sparc and, I believe power) used the address
> for coloring. It's not needed anymore. Page allocator and SL?B are good
> enough now.
> 
> See 3c936465249f ("[SPARC64]: Kill pgtable quicklists and use SLAB.")

Ah, shiny. Thanks.
