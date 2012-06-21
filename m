From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 2/3] Remove useless wrappers of asm-generic/ipc.h
Date: Thu, 21 Jun 2012 15:54:54 -0400
Message-ID: <4FE37C0E.8050306@tilera.com>
References: <1340306466.1773.60.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1340306466.1773.60.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, linux-kernel@vger.kernel.org

On 6/21/2012 3:21 PM, Paul Bolle wrote:
> mn10300 has a header (in its include/asm directory) that is a thin
> wrapper around asm-generic/ipc.h. This wrapper is useless, since that
> header doesn't exist. It is also unused (no file includes asm/ipc.h).
>
> hexagon and tile generate similar headers at build time (using a
> generic-y entry in include/asm/Kbuild). These generated headers are
> useless and unused too.
>
> Remove this header and these generic-y entries.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
>  arch/hexagon/include/asm/Kbuild |    1 -
>  arch/mn10300/include/asm/ipc.h  |    1 -
>  arch/tile/include/asm/Kbuild    |    1 -
>  3 files changed, 0 insertions(+), 3 deletions(-)
>  delete mode 100644 arch/mn10300/include/asm/ipc.h

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

I can queue the tile change if you'd like; otherwise I assume you'll push
this whole commit.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


