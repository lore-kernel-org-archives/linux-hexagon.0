From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 1/3] Remove useless wrappers of asm-generic/cpumask.h
Date: Thu, 28 Jun 2012 11:30:23 +0200
Message-ID: <4FEC242F.7050906@suse.cz>
References: <1340306406.1773.59.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1340306406.1773.59.camel@x61.thuisdomein>
Sender: linux-kbuild-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org

On 21.6.2012 21:20, Paul Bolle wrote:
> frv and xtensa both have a header (in their include/asm directories)
> that are thin wrappers around asm-generic/cpumask.h. These wrappers are
> useless, since that header doesn't exist. They are also unused (all
> files including asm/cpumask.h are x86 specific).
> 
> hexagon and openrisc generate similar headers at build time (using a
> generic-y entry in include/asm/Kbuild). These generated headers are
> useless and unused too.
> 
> Remove these headers and generic-y entries.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Thanks, applied to kbuild.git#trivial.

Michal
