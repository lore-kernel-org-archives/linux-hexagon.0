From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch v2 09/35] Hexagon: Add checksum functions
Date: Tue, 30 Aug 2011 21:52:11 +0200
Message-ID: <20110830195211.GA10415@merkur.ravnborg.org>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.574002538@codeaurora.org> <1314732887.14422.10.camel@Joe-Laptop>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314732887.14422.10.camel@Joe-Laptop>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Aug 30, 2011 at 12:34:47PM -0700, Joe Perches wrote:
> On Tue, 2011-08-30 at 14:07 -0500, Richard Kuo wrote:
> > Removed most non-assembly functions and use the generic ones instead.
> []
> > +++ linux-hexagon-kernel/arch/hexagon/include/asm/checksum.h	2011-08-24 18:45:48.133877105 -0500
> []
> > +#define do_csum	do_csum
> 
> That looks pretty odd.
> I have a hard time believing that's useful or necessary.

This is "the new way" to tell that an arch supply an arch specific variant of a function.
See lib/checksum.c.

It does:

#ifndef do_csum
...
#endif

So archs that do not define do_csum will get a generic version of do_csum.
And "do_csum" nicely shows up in grep - so it makes sense to do so.

	Sam
