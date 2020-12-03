From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix arch_cpu_idle() vs
 tracing
Date: Thu, 3 Dec 2020 15:54:42 +0100
Message-ID: <20201203145442.GC9994@osiris>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7i71fnPLw8c8wSiEag4koDbPBEonUjBwaWZiiIz6ePk=; b=0PKq6U56bU9IZR5Um7u9lSVwx
	Tq/2Y2PQVT+NaKQtyijXYuN4rpeA0n5WAfQl640/7L9+RmJrduckxkCFp8SDrijyRtKKDxJVQwKl8
	YbvjZ1Dw4BxKD2ZuPiCMdEhr+YogKPqtTsCZ45ObVEy+hcypyy8RMOC+IWUHxLWRb+VtdN8Pi1igv
	MCiPkhb50al9UUTMd3s1Xx2j1jsosS1xZTjZcpF5o9RMgORqdWaVLU5BWPoUedchpq3MN+seAY1ag
	r1y6d4wC5dAEnUpIcAhSvAJoZnoipj8bTLycWJ3eSsEtXJw+T8SlVbHVKStXusbKRifKGOYy5VnDU
	BZjplGbBw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=aTanWXDu6GDQOgBiwV6VCa4+Gz8xmuiEnuHmxtcgxPE=;
 b=JqgdPm8hiRdcgHmP2Asq50K14PiR4++DD5Vd+nt7oiR5rd0dVWxNV+CyaTMf2v55XBpe
 s+gVM1OtIwF2Xnm6yZRH5aEnHoH29g2Yy8k/Ydrh+57AZhG9ihxP6O/ACCzsKz7KkpOm
 9uS4eAhzbs0Rj2Rj4AMToilq6M0k4MDriKFj72s90FNSX+Q9/pCO+3fSr2ZGQr23vN8l
 GYsZ4WHeDjYTuCodVhHapE4fIyykKImPmGci1Z/T4XpayaYDLVLAdQj2574h9vrX3CRA
 fq8QCuZA7L9FqVJdEZDAIvcQsl+YOkjb9kuPNJCT0dbuGMlFlnmoHAfQVay2BAazStvv tQ== 
Content-Disposition: inline
In-Reply-To: <20201203132834.930999-27-sashal@kernel.org>
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
To: Sasha Levin <sashal@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-csky@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
> 
> We call arch_cpu_idle() with RCU disabled, but then use
> local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> 
> Switch all arch_cpu_idle() implementations to use
> raw_local_irq_{en,dis}able() and carefully manage the
> lockdep,rcu,tracing state like we do in entry.
> 
> (XXX: we really should change arch_cpu_idle() to not return with
> interrupts enabled)
> 
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch broke s390 irq state tracing. A patch to fix this is
scheduled to be merged upstream today (hopefully).
Therefore I think this patch should not yet go into 5.9 stable.
