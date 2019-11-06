From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 6 Nov 2019 10:20:39 +0100
Message-ID: <20191106092039.GT4131@hirez.programming.kicks-ass.net>
References: <20191106030542.868541-1-dima@arista.com>
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
	List-Owner; bh=jLdOs52hI5GhLd4q4hoEvHWuK/6NVdB3BpbytkCFyrk=; b=KiV69S5GRHn/8q
	WgGk2i7KQBVBp21dc3JUN1pIfI/rABrvddXhZc//+z2BCCNbdLWTu0m+KqAYyGSf50CEadbbtzMNp
	1tOI77m18Ri/ox3HX4+iyIeJD4scSuN5KXIRzxUtMuX1iHUqF8gxsdTu2NWAOVUkaOlrP7CpuxI2A
	yfB0knciKDinkbWVGBQ3IHpki1WytAHXq7i4TF93pqbYkv46fZE5qicS6PJV7qO/3Hc1Zq93jCuIb
	Uy4IzBl1GF/IFQclRCq4I1Y7O87Drh9JJ/qyXUR7EzuR+7Wm2wOCVot4lMlHZnkbuaew/z3uUnKH3
	iE4Ke8zki1525oP4GZbg==;
Content-Disposition: inline
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
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
To: Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ralf Baechle <r>

On Wed, Nov 06, 2019 at 03:04:51AM +0000, Dmitry Safonov wrote:
> Add log level argument to show_stack().
> Done in three stages:
> 1. Introducing show_stack_loglvl() for every architecture
> 2. Migrating old users with an explicit log level
> 3. Renaming show_stack_loglvl() into show_stack()
> 
> Justification:
> o It's a design mistake to move a business-logic decision
>   into platform realization detail.
> o I have currently two patches sets that would benefit from this work:
>   Removing console_loglevel jumps in sysrq driver [1]
>   Hung task warning before panic [2] - suggested by Tetsuo (but he
>   probably didn't realise what it would involve).
> o While doing (1), (2) the backtraces were adjusted to headers
>   and other messages for each situation - so there won't be a situation
>   when the backtrace is printed, but the headers are missing because
>   they have lesser log level (or the reverse).
> o As the result in (2) plays with console_loglevel for kdb are removed.

I really don't understand that word salad. Why are you doing this?
