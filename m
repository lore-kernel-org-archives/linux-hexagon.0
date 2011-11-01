From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v5 33/36] Hexagon: Add configuration and makefiles for
 the Hexagon architecture.
Date: Tue, 1 Nov 2011 16:17:59 -0500
Message-ID: <20111101211759.GB3035@codeaurora.org>
References: <093448$3uejv7@wolverine01.qualcomm.com>
 <1320139846.14409.129.camel@x61.thuisdomein>
 <20111101172709.GA3035@codeaurora.org>
 <1320173992.14409.193.camel@x61.thuisdomein>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320173992.14409.193.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Nov 01, 2011 at 07:59:52PM +0100, Paul Bolle wrote:
> So, you'll move it up a line?
>  
> > > > +#config ZONE_DMA
> > > > +#	bool
> > > > +#	default y
> > > 
> > > Why is this added commented out?
> > 
> > We were using it before, but not anymore.
> 
> So, please drop it.

Yes to both of these.

> But "config TRACING" (in kernel/trace/Kconfig) also selects it if
> STACKTRACE_SUPPORT is set. It seems GENERIC_TRACER is the hidden magic
> here. GENERIC_TRACER is selected by the various tracer options - see
> kernel/trace/Kconfig again, I'm unfamiliar with this stuff - and will
> itself select TRACING. So if an arch has STACKTRACE_SUPPORT set it
> doesn't have to select STACKTRACE itself. (Note that - except for tile -
> no other arch selects STACKTRACE.) 
> 
> But hopefully someone who doesn't have to grep the Kconfig files to
> understand this, can tell us for sure.

Ah...  Well, if nothing else, I'll just try not setting it and see if it
works as it seems to be intended.
 
> If you really feel you need to add it, but commented out, perhaps a
> comment can be added to keep people like me from submitting patches to
> remove it.

Sounds reasonable.  I'll either add a comment or just remove it
altogether (which is the long term goal).

Not that I mind getting patches, of course.

I'll have all these fixed in my tree and push them out when I can.


Thanks,
Richard Kuo

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
