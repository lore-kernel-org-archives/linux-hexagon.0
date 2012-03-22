From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/4] arch/CPU hotplug: Add missing CPU Hotplug bits to
 fix nasty issues
Date: Thu, 22 Mar 2012 13:32:38 +0100
Message-ID: <1332419558.2487.14.camel@twins>
References: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com>
	 <1332418412.2487.13.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1332418412.2487.13.camel@twins>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rkuo@codeaurora.org, tglx@linutronix.de, linas@codeaurora.org, mingo@elte.hu, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, akpm@linux-foundation.org, benh@kernel.crashing.org, jesper.nilsson@axis.com, cmetcalf@tilera.com, linux@arm.linux.org.uk, jejb@parisc-linux.org, deller@gmx.de, vapier@gentoo.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org

On Thu, 2012-03-22 at 13:13 +0100, Peter Zijlstra wrote:
> 
> Furthermore, I was pondering the scenario where a 3rd cpu IPIs the newly
> booting cpu, I suspect we need a smp_wmb() after setting cpu_active and
> a rmb in select_fallback_rq() before reading active.

Hmm, not IPI, that would be covered by the disabling of interrupts on
bringup, but somehow manage to wake a thread that's strictly affine that
the fresh cpu, like queue_work_on() or so.

