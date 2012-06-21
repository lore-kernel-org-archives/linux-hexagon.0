From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] Remove useless wrappers of
	asm-generic/cpumask.h
Date: Fri, 22 Jun 2012 00:06:52 +0100
Message-ID: <32429.1340320012@redhat.com>
References: <1340306406.1773.59.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1340306406.1773.59.camel@x61.thuisdomein>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, linux-hexagon@vger.kernel.org, linux@openrisc.net, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, dhowells@redhat.com, Chris Zankel <chris@zankel.net>

Paul Bolle <pebolle@tiscali.nl> wrote:

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

Acked-by: David Howells <dhowells@redhat.com> [FRV]
