From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 21:00:11 +0100
Message-ID: <20220214200011.GA3786@lst.de>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org> <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
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
	List-Owner; bh=UhnY8KAe59qhpZ0jXwVt0pKEl8AP7HoKciOb72NzlHA=; b=EIU9NdwxFypV8O
	uT5FXr6DO3GUBlfOXdl9u90Z6JBazjfCYte/KXF7qrM0E973NMqiPl8qYG+gmzee0/7WgYF4TBXGk
	6Wb3J1heakLOvbfoBxtHisGLBfTrJQgSPicEI7Sr+lMSE9jKwM9D2LVhvZqPR2XOmy6zegOdnN95C
	cxyAmxYVU1IlldVXzOeEUiRuC77K/UYE0JzU8j5zB+3umO1K18t2TOkWpYKFFbeMkF/6o8u9RqyjR
	QDptb8z0NquQC8VSmKZU3cyrG59R698YrBJjwOv+QFk+FWLRwiW0GRbMOqLK+ihmY0j6UUF6iUMcT
	BnJkfZB73lGu/Pu8kIkQ==;
Content-Disposition: inline
In-Reply-To: <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Brian Cain <bcain@codeaurora.org>, Helge Deller <deller@gmx.de>

On Mon, Feb 14, 2022 at 08:45:52PM +0100, Arnd Bergmann wrote:
> As Al pointed out, they turned out to be necessary on sparc64, but the only
> definitions are on sparc64 and x86, so it's possible that they serve a similar
> purpose here, in which case changing the limit from TASK_SIZE to
> TASK_SIZE_MAX is probably wrong as well.
> 
> So either I need to revert the original definition as I did on sparc64, or
> they can be removed completely. Hopefully Al or the x86 maintainers
> can clarify.

Looking at the x86 users I think:

 - valid_user_frame should go away and the caller should use get_user
   instead of __get_user
 - the one in copy_code can just go away, as there is another check
   in copy_from_user_nmi
 - copy_stack_frame should just use access_ok
 - as does copy_from_user_nmi

but yes, having someone who actually knows this code look over it
would be very helpful.
