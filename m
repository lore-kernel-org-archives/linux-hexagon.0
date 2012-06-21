From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] Remove useless wrappers of asm-generic/ipc.h
Date: Fri, 22 Jun 2012 00:08:51 +0100
Message-ID: <32480.1340320131@redhat.com>
References: <1340306466.1773.60.camel@x61.thuisdomein>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340306466.1773.60.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: dhowells@redhat.com, Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-am33-list@redhat.com, Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org

Paul Bolle <pebolle@tiscali.nl> wrote:

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

Acked-by: David Howells <dhowells@redhat.com> [MN10300]
