From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 4/4] tile/CPU hotplug: Add missing call to notify_cpu_starting()
Date: Tue, 3 Apr 2012 15:48:12 -0400
Message-ID: <4F7B53FC.7030606@tilera.com>
References: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com> <20120322112905.17063.88829.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20120322112905.17063.88829.stgit@srivatsabhat.in.ibm.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rkuo@codeaurora.org, tglx@linutronix.de, linas@codeaurora.org, mingo@elte.hu, a.p.zijlstra@chello.nl, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, akpm@linux-foundation.org, benh@kernel.crashing.org, jesper.nilsson@axis.com, linux@arm.linux.org.uk, jejb@parisc-linux.org, deller@gmx.de, vapier@gentoo.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org

On 3/22/2012 7:29 AM, Srivatsa S. Bhat wrote:
> The scheduler depends on receiving the CPU_STARTING notification, without
> which we end up into a lot of trouble. So add the missing call to
> notify_cpu_starting() in the bringup code.
>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
>
>  arch/tile/kernel/smpboot.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Thanks!  Taken into the tile tree.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
