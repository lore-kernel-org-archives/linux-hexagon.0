From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH][resend] hexagon: Remove unneeded include of version.h
Date: Tue, 10 Apr 2012 16:53:57 -0500
Message-ID: <20120410215356.GA2513@codeaurora.org>
References: <alpine.LNX.2.00.1204102333460.31626@swampdragon.chaosbits.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1204102333460.31626@swampdragon.chaosbits.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Linas Vepstas <linasvepstas@gmail.com>, trivial@kernel.org

On Tue, Apr 10, 2012 at 11:37:23PM +0200, Jesper Juhl wrote:
> "make versioncheck" points out that arch/hexagon/include/asm/spinlock_types.h
> does not need to include version.h .
> A quick look at the file seems to confirm its findings, so here's a patch that
> removes the include.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> ---
>  arch/hexagon/include/asm/spinlock_types.h |    2 --
>  1 file changed, 2 deletions(-)
> 

I've applied this patch to my tree (it's already spent some time in
linux-next as well) and it will go out with my next pull request.


Thanks,
Richard Kuo
