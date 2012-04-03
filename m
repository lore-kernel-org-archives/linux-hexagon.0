From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 1/4] hexagon/CPU hotplug: Add missing call to
 notify_cpu_starting()
Date: Tue, 3 Apr 2012 16:09:38 -0500
Message-ID: <20120403210938.GA20952@codeaurora.org>
References: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com>
 <20120322112805.17063.19393.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120322112805.17063.19393.stgit@srivatsabhat.in.ibm.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linas@codeaurora.org, mingo@elte.hu, a.p.zijlstra@chello.nl, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, akpm@linux-foundation.org, benh@kernel.crashing.org, jesper.nilsson@axis.com, cmetcalf@tilera.com, linux@arm.linux.org.uk, jejb@parisc-linux.org, deller@gmx.de, vapier@gentoo.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org

On Thu, Mar 22, 2012 at 04:58:25PM +0530, Srivatsa S. Bhat wrote:
> The scheduler depends on receiving the CPU_STARTING notification, without
> which we end up into a lot of trouble. So add the missing call to
> notify_cpu_starting() in the bringup code.
> 
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/hexagon/kernel/smp.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 

Tested in my tree; thanks!


Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
