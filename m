From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 20:45:52 +0100
Message-ID: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org>
 <YgqLFYqIqkIsNC92@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fkaHXD8FhuNptzi3iz1LyUb5fDm19B15aWEhSso+4E8=; b=WmdC0jJnb6vo8r
	SiUdlAMOSQPNtKmiWUpkH4x5g++ihquQd9f0+wchkV7Rw5jH+mRnWDopVs/bxUACeOGeCn+rlaLYy
	DDDNzHn3pKu+AWDjQ395tsIedvzs04byvniWNGAMDafvN0LnCUiG7VQo+O5wJovpnqlgmxtQQMNei
	/myOYmsAItc2Mkt1bsgExNufZccY0TIHgLtIIGjqmRdJGXGjdfGnY0f0Fp2dMnspXSfF9ncG2XbSf
	skQc0h1dXfvOM6iushlIZTzd6X85ocFQzd6ARIzRJpOoMnjDyLKIRa+T+fhjdxdCwZJ9TS3pYUR5M
	+zZWyHB5z4PBEgROy4Xg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644867970;
 bh=kZ0Ha+ZttRWbRYErkpKyuJC1dyK+QrO2i6Uu5KgHMvM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Y0tFdEItPyIpX9Q57aljIliTeAqJEjfsGhV5sRnV7cHDKUAHBtZxnjnJQ0aG/E0DY
 ntmMdawRiR6T8SjqmJRkg+eiX9WIai06zkYCR7faiov+1eO6KA28Xd0WJ3G4HzZ7Ki
 PswrJdfwevWrM+GcXzzieldjGJJj+F38X56atyYmYHaGjvacQFUxk+Q3y53FA51+T8
 ZklKna1hQALqex7ucGzH+u+kKR6+AMMF6Gi34rWhxaWoueN0V5gBdQpdknscuvJdj6
 4dVyfkX9O/n11Gjix37hL+YmaFTxTy2u9mOy0+3ugdzfzd4uf88HSfSBljtkByDhnd
 ubPSK5lCMcVZQ==
In-Reply-To: <YgqLFYqIqkIsNC92@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers

On Mon, Feb 14, 2022 at 6:02 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Feb 14, 2022 at 05:34:42PM +0100, Arnd Bergmann wrote:
> > +#define __range_not_ok(addr, size, limit)    (!__access_ok(addr, size))
> > +#define __chk_range_not_ok(addr, size, limit)        (!__access_ok((void __user *)addr, size))
>
> Can we just kill these off insted of letting themm obsfucate the code?

As Al pointed out, they turned out to be necessary on sparc64, but the only
definitions are on sparc64 and x86, so it's possible that they serve a similar
purpose here, in which case changing the limit from TASK_SIZE to
TASK_SIZE_MAX is probably wrong as well.

So either I need to revert the original definition as I did on sparc64, or
they can be removed completely. Hopefully Al or the x86 maintainers
can clarify.

         Arnd
