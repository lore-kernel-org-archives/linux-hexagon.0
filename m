From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Date: Fri, 26 Oct 2018 10:52:02 +0200
Message-ID: <20181026085202.GC3109@worktop.c.hoisthospitality.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
 <20181025022119.GC13560@joelaf.mtv.corp.google.com>
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
	List-Owner; bh=7QO47gwGNYRYmDxmabBe3Vpr76cakKR1XHrna9n79fk=; b=l0GeRHFCtza9mb
	Ti6KcJbhtDv/B2P4KvC2CuR3yg8qwrvA24sLXXsG5a7SpbPy7Z3vHxeqnZ03zp2DmWyh0yezv0ccc
	P/XkmSAVG+I6rtNFexLNolKIIy6VslKnrcpQJvBL/vsM/WFFSXck9HOUVuW/2ot0DSUP0lDaImvr/
	na0G8PU0EKxG+LYW1iXJlcDSol3TNeLZ2A75uYLxHp6l9eLbF0sfSyxkXixD3+C5HW0gCxNohF6xc
	Yf9oqEOYJOSpVW7F0IaCRkPLNNkosXbIn/2ZbGn6joCeLOTkS53E6YbMX3FqzeN2ukAQpm5a/FSei
	T5t5HbKK8WRGQ3cqAIag==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pbk9Jp4NpLV5KhCv2GieE6eo6VugTGuTfEvdAP/DTOU=; b=ucA2s1NEduQA2HG6o8PHl9GX1
 1c9iAfHE+3hqIl/VOcrEC4U61PEkSMe2UlNY8ypIaHjQM2VFqPCLJW1X9TyB3wWuCgKbVPigZk0cL
 8xXH3vrCr+QLGW8A+8M1aJInEB7Ent4aKqtrYwIq3zSx2xpx4WErOiYwf+CUPAYBaTROX2LN6wtam
 SO+PDPDdJ9gkMza75ER7YzuuEE9Nbr1grRJK7p7fXgBxca+Uj29aAUjQiybM8sVWM4X51T4/vAu3t
 jGJE+MJ5H5/n+ZlZg0mYiuiT+wrbdPBImX4VY03B6CnjBGen3lPKGeN206IfOOZzbJStVnZtSqh8h
 j/PfTfURA==;
Content-Disposition: inline
In-Reply-To: <20181025022119.GC13560@joelaf.mtv.corp.google.com>
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
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, lokeshgidra@google.com, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu, dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-xtensa@linux-xtensa.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m>

On Wed, Oct 24, 2018 at 07:21:19PM -0700, Joel Fernandes wrote:
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
> I didn't happen to do that analysis but from code analysis, no architecutre
> is using it. Since its unused in the kernel, may be such architectures don't
> exist or were removed, so we don't need to bother? Could you share more about
> your concern with the removal of this argument?

No concerns at all with removing it; I was purely curious as to the
origin of the unused argument. Kirill provided that answer.
