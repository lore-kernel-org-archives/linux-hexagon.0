From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 10/35] Disintegrate asm/system.h for Hexagon [ver #2]
Date: Tue, 13 Mar 2012 11:31:02 -0500
Message-ID: <20120313163102.GB31083@codeaurora.org>
References: <201203130916.15118.arnd@arndb.de>
 <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
 <20120312233747.13888.75605.stgit@warthog.procyon.org.uk>
 <27808.1331632900@redhat.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27808.1331632900@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Mar 13, 2012 at 10:01:40AM +0000, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Looking at this example, it could easily use the asm-generic versions of
> > switch_to.h and barrier.h, but that would complicate the dependency chain
> > again.
> 
> Yep.  The plan is to throw more patches on to the end of the series to
> consolidate those.
> 
> In fact, I wonder if we still really need the switch_to() macro wrapper, or
> whether we could replace it with an function, inline or otherwise, that
> returns the macro's third argument.
> 

Alrighty...  well, let me test this patch as is, and if I can, I'll see if
I can change over to the generic versions of switch_to.h and barrier.h as
well.


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
