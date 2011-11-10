From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [PATCH] Hexagon: Use resource_size function
Date: Thu, 10 Nov 2011 09:39:24 +0100
Message-ID: <1320914364.20155.10.camel@localhost.localdomain>
References: <1320778170.8062.134.camel@localhost.localdomain>
	 <20111109010202.GA16505@huya.qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20111109010202.GA16505@huya.qualcomm.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Brown <davidb@codeaurora.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, den 08.11.2011, 17:02 -0800 schrieb David Brown:
> Some minor nits about the formatting of the patch.
> 
> On Tue, Nov 08, 2011 at 07:49:30PM +0100, Thomas Meyer wrote:
> > From: Thomas Meyer <thomas@m3y3r.de>
> 
> Shouldn't need a From: line, since it is the same as the email you
> sent it from.

So do I need a From: line or not?

Documentation/SubmittingPatches says:

        The "from" line must be the very first line in the message body,
        and has the form:
        
                From: Original Author <author@example.com>
        
        The "from" line specifies who will be credited as the author of the
        patch in the permanent changelog.  If the "from" line is missing,
        then the "From:" line from the email header will be used to determine
        the patch author in the changelog.

MUST in the meaning of RFC2119, means it is an absolut requirment. What
should I do?

OTOH some people seems to ignore this, too:

        Do not send more than 15 patches at once to the vger mailing lists!!!

> 
> >  Use resource_size function on resource object
> >  instead of explicit computation.
> 
> The commit text shouldn't be indented.

Will fix that.

> 
> >  The semantic patch that makes this change is available
> >  in scripts/coccinelle/api/resource_size.cocci.
> > 
> >  More information about semantic patching is available at
> >  http://coccinelle.lip6.fr/
> 
> I'm curious if these patches are generated directly by coccinelle,
> since they don't appear to be coming from git.  It'd be nice to have
> diffstats in them (especially when they are larger).

coccinelle doesn't work that way. It's independent from git. I need to
check the manual of spatch.bin if it's possible to produce a diffstat.

> Thanks,
> David
> 


