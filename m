From: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Subject: Re: [patch v2 17/35] Hexagon: Add interrupts
Date: Wed, 31 Aug 2011 11:16:16 -0500
Message-ID: <20110831161616.GA11117@codeaurora.org>
References: <20110830190729.923334292@codeaurora.org>
 <20110830190801.353140948@codeaurora.org>
 <201108311550.23240.arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201108311550.23240.arnd@arndb.de>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wed, Aug 31, 2011 at 03:50:23PM +0200, Arnd Bergmann wrote:
> > +/*
> > + * XXX TODO FIXME this should be pulled from a platform file!
> > + * Must define NR_IRQS before including <asm-generic/irq.h>
> > + * 64 == the two SIRC's, 176 == the two gpio's
> > + */
> > +#define NR_IRQS (HEXAGON_CPUINTS + 64 + 176)
> 
> I disagree with that comment: NR_IRQS is a constant and should
> not be platform specific. There should be no compile-time settings
> that are strictly specific to one platform, otherwise you are not

OK.  The interrupt handling on hexagon really is under construction:
not only do we need to finish support for the device tree, but there's
also a bunch of nasty ugliness in how the second & third-level
interrupt cntrollers are handled.  Some of the difficulties are due
the fact that we are re-cycling some of the msm drivers in the 
arm platform directories. The hexagon and the arm are on the same
chip, and see the same controllers, more or less, just with 
different address ranges and sometimes with different permissions,
different pin numberings, etc. 

Some of these patches are missing Signed-off-by-me lines, I take
full responsibility for all triple-X's that are lingering.

-- Linas

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
