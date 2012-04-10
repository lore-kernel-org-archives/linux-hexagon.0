From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH][resend] hexagon: Remove unneeded include of version.h
Date: Wed, 11 Apr 2012 00:02:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204110002110.31626@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204102333460.31626@swampdragon.chaosbits.net> <20120410215356.GA2513@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20120410215356.GA2513@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Linas Vepstas <linasvepstas@gmail.com>, trivial@kernel.org

On Tue, 10 Apr 2012, Richard Kuo wrote:

> On Tue, Apr 10, 2012 at 11:37:23PM +0200, Jesper Juhl wrote:
> > "make versioncheck" points out that arch/hexagon/include/asm/spinlock_types.h
> > does not need to include version.h .
> > A quick look at the file seems to confirm its findings, so here's a patch that
> > removes the include.
> > 
> > Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> > Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> > ---
> >  arch/hexagon/include/asm/spinlock_types.h |    2 --
> >  1 file changed, 2 deletions(-)
> > 
> 
> I've applied this patch to my tree (it's already spent some time in
> linux-next as well) and it will go out with my next pull request.
> 
I see.

Thanks.

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
