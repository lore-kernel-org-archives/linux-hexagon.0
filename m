From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/14] nds32: fix access_ok() checks in get/put_user
Date: Mon, 14 Feb 2022 09:01:10 -0800
Message-ID: <YgqK1ihlJvRFHJ9h@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-4-arnd@kernel.org>
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
	List-Owner; bh=C1YhdCzdV0a/0Pgx0rkgIph9uel/syB3IhfDgXQO4qo=; b=LYLUjWIRoNcClB
	qluQfSZFTDRNG0VlEs2j9/VAu6Rt2lKITXKVyBZe8UJCrei+rTPuTJHcfjWnZllHAPdJ6FSqVAnZK
	IFgScyCb/A+kENR2yrirmBzHkZS8RvAxjwuqn+s53LGVv4qVpnZRo0LMKxW74sK9dilRJtxI80/o2
	ezq5DbYAzQBzv76Y8nctda3Z5X9IalIcNX+u88P94T5lmi+XSRqq6U5k162NpYxYbRNR6iJ/nQX0D
	bpsh/mHBsA1SGws89ybtZNdBVIJIhso8Ndlz5lJcqXywen9FPKRNZBWx6aQ0DnqdzEjLXEagLNYHV
	OXafxnqWi/s5AomPY+yw==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-4-arnd@kernel.org>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, jcmvbkbc@gmail.com, guoren@kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org, linux-s390@vger.kernel.org, bcain@codeaurora.org, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, hca@linux.ibm.com, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, green.hu@gmail.com, s

On Mon, Feb 14, 2022 at 05:34:41PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The get_user()/put_user() functions are meant to check for
> access_ok(), while the __get_user()/__put_user() functions
> don't.
> 
> This broke in 4.19 for nds32, when it gained an extraneous
> check in __get_user(), but lost the check it needs in
> __put_user().

Can we follow the lead of MIPS (which this was originally copied
from I think) and kill the pointless __get/put_user_check wrapper
that just obsfucate the code?
