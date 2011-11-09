From: David Brown <davidb@codeaurora.org>
Subject: Re: [PATCH] Hexagon: Use resource_size function
Date: Tue, 8 Nov 2011 17:02:02 -0800
Message-ID: <20111109010202.GA16505@huya.qualcomm.com>
References: <1320778170.8062.134.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320778170.8062.134.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Richard Kuo <rkuo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

Some minor nits about the formatting of the patch.

On Tue, Nov 08, 2011 at 07:49:30PM +0100, Thomas Meyer wrote:
> From: Thomas Meyer <thomas@m3y3r.de>

Shouldn't need a From: line, since it is the same as the email you
sent it from.

>  Use resource_size function on resource object
>  instead of explicit computation.

The commit text shouldn't be indented.

>  The semantic patch that makes this change is available
>  in scripts/coccinelle/api/resource_size.cocci.
> 
>  More information about semantic patching is available at
>  http://coccinelle.lip6.fr/

I'm curious if these patches are generated directly by coccinelle,
since they don't appear to be coming from git.  It'd be nice to have
diffstats in them (especially when they are larger).

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
