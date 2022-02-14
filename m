From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 20:17:07 +0000
Message-ID: <Ygq4wy9fikDYmuHU@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vxgcn7ma0+r7tUtfwEzcwdhvM3ldj5E80LPXTkZJw3k=; b=1+L1RgJJwmRDsY
	OjmZIjYKU+1pWjD45mWqsrUK5fi+J31woCpf4JINrUQn9CkwQpHswysuvJrBuSzErDzR2oiuTSGPp
	+8A8Z3fRogj0v1LrsgWflet4AHvdovere8vhd8PO9LeChkRgwaz6CEPUBrPLtMr2MjQ4cClIyZVQu
	G7pTdrMHrXQXKHjumRi1Y8zm8aZOLNEsv+ElFN1CtAsZWr0q/HNzdzlsHhhDdGE6iPddTd+4L4i/0
	eW6hgvHMUxGi/n4k1VUtXAj+NC8eCNevJMaoE7euo5XZtVEcYC7QDSHOdT1gahnUgW2J3TDcdRf1k
	vtwOvpKk5R6amhm/syNQ==;
Content-Disposition: inline
In-Reply-To: <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Helge Deller <deller@gmx.de>, the

On Mon, Feb 14, 2022 at 12:01:05PM -0800, Linus Torvalds wrote:
> On Mon, Feb 14, 2022 at 11:46 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > As Al pointed out, they turned out to be necessary on sparc64, but the only
> > definitions are on sparc64 and x86, so it's possible that they serve a similar
> > purpose here, in which case changing the limit from TASK_SIZE to
> > TASK_SIZE_MAX is probably wrong as well.
> 
> x86-64 has always(*) used TASK_SIZE_MAX for access_ok(), and the
> get_user() assembler implementation does the same.
> 
> I think any __range_not_ok() users that use TASK_SIZE are entirely
> historical, and should be just fixed.

IIRC, that was mostly userland stack trace collection in perf.
I'll try to dig in archives and see what shows up - it's been
a while ago...
