From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Date: Thu, 14 Feb 2019 11:37:15 +0100
Message-ID: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L1RZvNpNmYNgItvuOG3lCne3bJroGTsE0pTD2TQlxN4=; b=gk53SqT43fd0Ud
	hAAsPD9fwwI489ZB3dYSB4OHF2aM7HuVlM7EhZ+QanIo4LeEjrUV2lzpNj7a/ii1QlfaDda7CAPZs
	DV8roIPqVNsmFW5px09L2rZjc5Zk+t3cCAeP9EsVLw0FYMOMbFokrYmBV48htBUePyF6q9NESZ8NS
	O89rPpqkfo9B7ZxSsZz20ppAC1oGRxBaKgYcPi4NXnSN0KDzvZYJEeCisU1Gxn430ojX6jz/XmASo
	ZZ5BIyqTRjhmI/q2FcBBpjgZ6sP+vitMCTaapNs+NQuAdP9r9Qe7Cfvi0WgbuRqVGzcdHmRwf3hLJ
	38/DtO8lPZ5adGbLdA7w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7yZM4QttJ1fb4ZQ7Mabo7VnLkRDJj+lx0G2X8XXS/q0=; b=fx1rpYHBqJrLjmSSs1gePTKzK
 Ni/DauvFgKLMitkNhK5aW9m4wpH6Xo6Rn7SO+LZool3ojYYBe0dsltLVAgUPMw9zlAWx39NxZLo3n
 e7DTq12YagL1S9+b1JtJSmTbkuZ8pcAUfrr6AY/BHVxNPrLBYwQWW8NdefDr6gS8H9Lxxkbitnu0Q
 VupOqNRJPsPjHUuNI2y93XB8buCKOfO0sxZXubBWy8FtYbq0u2cn9KdQp9/Ttih4UzYwFrsFhla9R
 iOdEi8vQQJ+6bmKp3FVg9Z+ptgbw3Znx9sxvKOfICpLgcc4ogCklFEcHlZZiG0A4rWpwJEP7Iq8N6
 uxvBePSeQ==;
Content-Disposition: inline
In-Reply-To: <1550095217-12047-1-git-send-email-longman@redhat.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.ker

On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> v4:
>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> 
> v3:
>  - Optimize __down_read_trylock() for the uncontended case as suggested
>    by Linus.
> 
> v2:
>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
>  - Update performance test data in patch 1.
> 
> The goal of this patchset is to remove the architecture specific files
> for rwsem-xadd to make it easer to add enhancements in the later rwsem
> patches. It also removes the legacy rwsem-spinlock.c file and make all
> the architectures use one single implementation of rwsem - rwsem-xadd.c.
> 
> Waiman Long (3):
>   locking/rwsem: Remove arch specific rwsem files
>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
>     archs
>   locking/rwsem: Optimize down_read_trylock()

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

with the caveat that I'm happy to exchange patch 3 back to my earlier
suggestion in case Will expesses concerns wrt the ARM64 performance of
Linus' suggestion.
