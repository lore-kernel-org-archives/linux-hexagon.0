From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix arch_cpu_idle() vs
 tracing
Date: Sun, 13 Dec 2020 09:10:29 -0500
Message-ID: <20201213141029.GQ643756@sasha-vm>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
 <20201203145442.GC9994@osiris>
 <20201203171015.GN2414@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KZAmvMM7JxP7sn7KQINptYnNCbsp1o2c0NUu2YK8A1w=; b=R26POXAfWoeH7w4cnouDF/Yha
	hDZgjYp16roJftTpjlM732uN1xadbdREH3fgogkw7dXDPK4drxr4nPtw1uPXJmYp8AKV5HWCBKw4K
	HCThFV9D5x9qKT3KL915192D9LweVhb4ypF07Pwr4zcCil5yNO8KOcm1a+a1yw/AhHY5lr3IudJSi
	UOF3vXudTGTyLVIxo2Y2ENcnDbseOszXNYpWniDt5dEYw9MHissZdhtCmwzr9ss4He03z+4qlXgqg
	V+guKgnLnHHwQzYSG/BKCgop6PkOiDplXzq7F+5fwbgr7sGsO8rR/QP9gYnorKMolbt30DDHwTOF+
	4k/peP/7A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607868630;
 bh=S0NZCKTHXO1/XgTBibTeHKY2NyaV+jWp9oZjgvuSOZg=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=nFttyLKxDFdTzDqG+uV+ZMYwIDraCwmT1csa8RGjNQtB2KNQuC3CWvsr8XvQHFTkX
 bOVfEZ3hZGq/q87besC+Bjzp/UHT9BZ6/avesb9g234GUTyQ6mz9ZdKVWLvvWayKcR
 5IsZC3of1cWOok1XpWOR2jKmC5sWYP7UWQbjwfCJNcyT1mEousS3/8Iz7qmQngrF+E
 UBfwNFX/Xim1w8qNAQxV89tayOf16Xozhta7DOpqMYNyp+n+eIU7Y985xkZoMGJ7UI
 W/Q6SnFz+H4jXIWSjxGFg8FVH/fANHjQkaleEJRhOabM6QD83DoUX7CgAE554wRsQU
 Zom91bCLKheaA==
Content-Disposition: inline
In-Reply-To: <20201203171015.GN2414@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-csky@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 03, 2020 at 06:10:15PM +0100, Peter Zijlstra wrote:
>On Thu, Dec 03, 2020 at 03:54:42PM +0100, Heiko Carstens wrote:
>> On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
>> > From: Peter Zijlstra <peterz@infradead.org>
>> >
>> > [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
>> >
>> > We call arch_cpu_idle() with RCU disabled, but then use
>> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
>> >
>> > Switch all arch_cpu_idle() implementations to use
>> > raw_local_irq_{en,dis}able() and carefully manage the
>> > lockdep,rcu,tracing state like we do in entry.
>> >
>> > (XXX: we really should change arch_cpu_idle() to not return with
>> > interrupts enabled)
>> >
>> > Reported-by: Sven Schnelle <svens@linux.ibm.com>
>> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>> > Tested-by: Mark Rutland <mark.rutland@arm.com>
>> > Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> This patch broke s390 irq state tracing. A patch to fix this is
>> scheduled to be merged upstream today (hopefully).
>> Therefore I think this patch should not yet go into 5.9 stable.
>
>Agreed.

I'll also grab b1cae1f84a0f ("s390: fix irq state tracing"). Thanks!

-- 
Thanks,
Sasha
