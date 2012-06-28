From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 2/3] Remove useless wrappers of asm-generic/ipc.h
Date: Thu, 28 Jun 2012 11:30:47 +0200
Message-ID: <4FEC2447.40309@suse.cz>
References: <1340306466.1773.60.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1340306466.1773.60.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-kbuild@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com, Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org

On 21.6.2012 21:21, Paul Bolle wrote:
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

Applied to kbuild.git#trivial.

Michal
