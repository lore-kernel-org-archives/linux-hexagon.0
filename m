From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/7] Introduce __xchg, non-atomic xchg
Date: Wed, 22 Feb 2023 18:04:31 +0100
Message-ID: <Y/ZLH5F8LA3H10aL@hirez.programming.kicks-ass.net>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
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
	List-Owner; bh=ViolIE2o7kDoAnHTLRQRRC7e9Cvort9zWK1nhqF77Mc=; b=taeutXQ9ASuXDS
	IOB8MZsh9EC8AQpOCp0oqi1ICRHlveEFB30SG7OFtZU68f/apeuc2eV8cmnchwm0BjU/t0n/U5eYC
	1/M4TEr8RF3M0XpHBmo3n8aV1LBUrSMh/pe/VadU1VrKxTmY43XYVVMpzZZS6KAiX6edvXb9SUceS
	H6Z1wYoWwLSgMNdIof/IiLyCaQlibn48b0pw5B5Fhn1cFvXB0uKqk6HKwK0YTD7D6Z+9W+m265bIN
	Xs9Ei1kEP3EPrXccRysitaUNS7+nkuEg/8W+wlMZClkL1QG3PLXTCELf9HBo01iVQxkmcr+gqc7NA
	9M7NMazJK/HyJbWzf03Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8seSikIduHdwWlxLKvtsNdKihKZpOnnG/byEzPIYqpo=; b=Y1ljMAsEbY1xeALhV24P6D+VB8
	W1bdI7nU0WhWoHx4NgJjUs1eL4F579QHnU+VRNoxr0EmxLBTqZ3vOKnmHpwMB+Sofv3xiO5BeF6WD
	1LD1NvVLmJ2+7rgSzEr2KFdkQGbvBYCsMTfz8sZqwESBDJCLccPcpvy9GuBpXxB4wGZyirHyFJlTf
	gndmj7kqHoQ049GccgXjz/BpbKTlsy/A8I1wozGsWIJRtFjTTw2VRwpq8mSkA9UdnUdhM7yIf7jgi
	NcbLaUrNNJrkpHmN4j4xvoM8KhBnKHeFAYPSNMidGw19ugtisIBpD9l0VLYU1g+Tbm+Yn6Ihuibqi
	eg9uba3g==;
Content-Disposition: inline
In-Reply-To: <20230118153529.57695-1-andrzej.hajda@intel.com>
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
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>

On Wed, Jan 18, 2023 at 04:35:22PM +0100, Andrzej Hajda wrote:

> Andrzej Hajda (7):
>   arch: rename all internal names __xchg to __arch_xchg
>   linux/include: add non-atomic version of xchg
>   arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
>   llist: simplify __llist_del_all
>   io_uring: use __xchg if possible
>   qed: use __xchg if possible
>   drm/i915/gt: use __xchg instead of internal helper

Nothing crazy in here I suppose, I somewhat wonder why you went through
the trouble, but meh.

You want me to take this through te locking tree (for the next cycle,
not this one) where I normally take atomic things or does someone else
want this?
