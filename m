From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v5 33/36] Hexagon: Add configuration and makefiles for
 the Hexagon architecture.
Date: Tue, 1 Nov 2011 12:27:09 -0500
Message-ID: <20111101172709.GA3035@codeaurora.org>
References: <093448$3uejv7@wolverine01.qualcomm.com>
 <1320139846.14409.129.camel@x61.thuisdomein>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320139846.14409.129.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Nov 01, 2011 at 10:30:46AM +0100, Paul Bolle wrote:
> (I'd like to add some quick comments, Kconfig related. It's too late, I
> guess.)

Sure, always appreciated.
 
> On Mon, 2011-10-31 at 18:55 -0500, Richard Kuo wrote:
> > +	# select GENERIC_PENDING_IRQ if SMP
> 
> Is GENERIC_PENDING_IRQ also a pending project?

Yes.
 
> > +	# mostly generic routines, with some accelerated ones
> 
> What does this comment on?

That was an early debugging thing that was removed; missed the comment
the comment that went with it.
 
> > +#config ZONE_DMA
> > +#	bool
> > +#	default y
> 
> Why is this added commented out?

We were using it before, but not anymore.

> > +config HAS_DMA
> > +	bool
> > +	select HAVE_DMA_ATTRS
> > +	default y
> 
> HAS_DMA isn't supposed to be used this way, is it? See commit
> 411f0f3edc141a582190d3605cadd1d993abb6df ("Introduce CONFIG_HAS_DMA").
> Can't this entry be replaced by a "select HAVE_DMA_ATTRS" line in the
> "config HEXAGON" entry? That seems to be the common idiom.

Yes, that appears to be the more appropriate way to select it.

> > +config STACKTRACE_SUPPORT
> > +	def_bool y
> > +	select STACKTRACE
> 
> Some grepping suggests that the tracing infrastructure will "select
> STACKTRACE" if the architecture sets STACKTRACE_SUPPORT (tile apparently
> also gets this wrong). Have I grepped this correctly?

Only if DEBUG_KMEMLEAK is selected apparently (?)

> > +config GENERIC_BUG
> > +	def_bool y
> > +	depends on BUG
> > +
> > +config BUG
> > +	def_bool y
> 
> Why do you have this? Other architecture don't (there's just one BUG
> entry in all the Kconfig files).

Thought we needed it; didn't realize it was in init/Kconfig.

> > +menu "Machine selection"
> > +
> > +choice
> > +	prompt "System type"
> > +	default HEXAGON_ARCH_V2
> > +
> > +config HEXAGON_COMET
> > +	bool "Comet Board"
> > +	select HEXAGON_ARCH_V2
> > +	---help---
> > +	  Support for the Comet platform.
> > +
> > +endchoice
> 
> The default doesn't match the (single) config option here (it should
> default to HEXAGON_COMET). That shouldn't matter because there's only
> one option, which the config tools will then pick (that's the way they
> seem to work). 
> 
> But why is this a choice when there's nothing to actually choose?
> Moreover, just looking at this patch suggests HEXAGON_COMET is yet
> unused (CONFIG_HEXAGON_COMET is commented out in the Makefile). So at
> first glance this seems an elaborate way to select HEXAGON_ARCH_V2.

Yes...  need to fix that default.

We felt it was better to remove the platform code for this submission
as it was not exactly clean and did not use the devtree code.  That's
why it's commented out of the Makefiles.

> > +config SMP
> > +	bool "Multi-Processing support"
> > +	---help---
> > +	  Enables SMP support in the kernel.  If unsure, say "Y"
> 
> Odd. Even x86 and powerpc (the only two architectures I looked at)
> suggest to say "N" to those not knowing what to do here.

I think for us, I think most people will want an SMP kernel.

> > +config GENERIC_GPIO
> > +	bool "Generic GPIO support"
> > +	default n
> 
> I know next to nothing about GENERIC_GPIO but does it make sense for
> Hexagon? If not, wouldn't a "def_bool n" do? (Perhaps you could even
> drop this entry entirely.)

We have another platform that does use it, but yes, a "def_bool n" 
will suffice.

I'll have these cleaned up in my local tree and produce a followup
patch if necessary...


Thanks for the feedback.
-Richard Kuo
 

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
