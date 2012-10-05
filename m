From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [GIT PULL] Disintegrate UAPI for hexagon
Date: Fri, 5 Oct 2012 17:27:33 -0500
Message-ID: <20121005222732.GA1501@codeaurora.org>
References: <17368.1349380279@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17368.1349380279@warthog.procyon.org.uk>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 04, 2012 at 08:51:19PM +0100, David Howells wrote:
> Can you merge the following branch into the hexagon tree please.
> 
> This is to complete part of the UAPI disintegration for which the preparatory
> patches were pulled recently.
> 
> Note that there are some fixup patches which are at the base of the branch
> aimed at you, plus all arches get the asm-generic branch merged in too.
> 
> The following changes since commit 612a9aab56a93533e76e3ad91642db7033e03b69:
> 
>   Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux (2012-10-03 23:29:23 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.infradead.org/users/dhowells/linux-headers.git disintegrate-hexagon
> 
> for you to fetch changes up to 0ee1d088b96a538a1c2572078283452ef39634fc:
> 
>   UAPI: (Scripted) Disintegrate arch/hexagon/include/asm (2012-10-04 18:20:45 +0100)
> 

OK, pulled into my current tree.  I'd like to wait for the generic
stuff to make it into Linus's tree before pushing it out though.


Thanks,
Richard Kuo

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
