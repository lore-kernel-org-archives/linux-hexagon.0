From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 0/4] arch/CPU hotplug: Add missing CPU Hotplug bits to
 fix nasty issues
Date: Thu, 22 Mar 2012 15:55:24 +0100
Message-ID: <1332428124.2487.15.camel@twins>
References: <20120322112735.17063.21791.stgit@srivatsabhat.in.ibm.com>
	 <1332418412.2487.13.camel@twins>
	 <1332427989.2946.20.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1332427989.2946.20.camel@dabdike.int.hansenpartnership.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, rkuo@codeaurora.org, tglx@linutronix.de, linas@codeaurora.org, mingo@elte.hu, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, akpm@linux-foundation.org, benh@kernel.crashing.org, jesper.nilsson@axis.com, cmetcalf@tilera.com, linux@arm.linux.org.uk, jejb@parisc-linux.org, deller@gmx.de, vapier@gentoo.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org

On Thu, 2012-03-22 at 14:53 +0000, James Bottomley wrote:
> parisc actually uses cpu hotplug to boot its secondary cpus. 

I think we all do these days..
