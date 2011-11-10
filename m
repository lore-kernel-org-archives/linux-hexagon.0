From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] Hexagon: Use resource_size function
Date: Thu, 10 Nov 2011 07:28:25 -0800
Message-ID: <20111110152825.GA13341@huya.qualcomm.com>
References: <1320778170.8062.134.camel@localhost.localdomain>
 <20111109010202.GA16505@huya.qualcomm.com>
 <1320914364.20155.10.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320914364.20155.10.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Meyer <thomas@m3y3r.de>
Cc: David Brown <davidb@codeaurora.org>, Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 10, 2011 at 09:39:24AM +0100, Thomas Meyer wrote:
> Am Dienstag, den 08.11.2011, 17:02 -0800 schrieb David Brown:
> > Some minor nits about the formatting of the patch.
> > 
> > On Tue, Nov 08, 2011 at 07:49:30PM +0100, Thomas Meyer wrote:
> > > From: Thomas Meyer <thomas@m3y3r.de>
> > 
> > Shouldn't need a From: line, since it is the same as the email you
> > sent it from.
> 
> So do I need a From: line or not?
> 
> Documentation/SubmittingPatches says:
> 
>         The "from" line must be the very first line in the message body,
>         and has the form:
>         
>                 From: Original Author <author@example.com>
>         
>         The "from" line specifies who will be credited as the author of the
>         patch in the permanent changelog.  If the "from" line is missing,
>         then the "From:" line from the email header will be used to determine
>         the patch author in the changelog.
> 
> MUST in the meaning of RFC2119, means it is an absolut requirment. What
> should I do?

The absolute requirement is that the from line must be the first line
in the message body.  The "If the 'from' line is missing" even
suggests that it is optional.  I agree that the wording isn't all that
great.

I don't believe it hurts anything to use it, it just looks kind of odd
to have a From line that is the same as the originating email address.

You certainly don't need it, given that a vast majority of patches
posted don't contain a from line.  Git send-email only generates one
if the author is different from the one sending the message.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
