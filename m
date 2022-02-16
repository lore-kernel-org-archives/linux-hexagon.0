From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 15/18] sparc64: remove CONFIG_SET_FS support
Date: Wed, 16 Feb 2022 19:34:59 +0100
Message-ID: <Yg1D08+olCSGmnYU@ravnborg.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-16-arnd@kernel.org>
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
	List-Owner; bh=x3AQV/mUmVUfjxULoan5IUvh0X4ZE7ARd4LUHGxje9s=; b=sASGfmea3iXGI/
	Zbb8dJKeVkKdC/Lfr/+iG9TY4YUumUgr6lfVCHIxqRp+InRhOj3hVfJYYQMaPirtGm8ISPI/AFTts
	hjdZyh6EzTiqrEFdtn5LB21a/b9GACR7pDnBsLQfWCPFAQR/9YTXA2hKDxbuZfWngT0VurGkwdlqT
	5PYQyRBRKG0+hsazKckpAIgTj7lKhRGbBRwTeDvuSJs/Mk/J32kM9aEzFOLen+wkrTFg91Kk+my/2
	a2HvHpSzs+g/d0hhNWcIrAFrd3SmV4gT6gu3XdiRpwNurZ+RcrNk74wJIxE5SxVlJkO+4EtFCta3g
	k3bchAEv7Nzw2kowsByg==;
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-16-arnd@kernel.org>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org, bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de, nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net, richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, li

Hi Arnd.

On Wed, Feb 16, 2022 at 02:13:29PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> sparc64 uses address space identifiers to differentiate between kernel
> and user space, using ASI_P for kernel threads but ASI_AIUS for normal
> user space, with the option of changing between them.
> 
> As nothing really changes the ASI any more, just hardcode ASI_AIUS
> everywhere. Kernel threads are not allowed to access __user pointers
> anyway.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sparc/include/asm/processor_64.h   |  4 ----
>  arch/sparc/include/asm/switch_to_64.h   |  4 +---
>  arch/sparc/include/asm/thread_info_64.h |  4 +---
>  arch/sparc/include/asm/uaccess_64.h     | 20 +-------------------
>  arch/sparc/kernel/process_64.c          | 12 ------------
>  arch/sparc/kernel/traps_64.c            |  2 --
>  arch/sparc/lib/NGmemcpy.S               |  3 +--
>  arch/sparc/mm/init_64.c                 |  7 ++++---
>  8 files changed, 8 insertions(+), 48 deletions(-)

I think you somehow missed the Kconfig change, and also the related
sparc32 change which continue to have set_fs() after this patch.


I did not manage to review the patch - as I am too unfamiliar with the
code paths and the set_fs() removal changes.

	Sam
