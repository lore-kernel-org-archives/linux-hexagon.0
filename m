From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [patch v2 21/35] Hexagon: Add SMP support
Date: Tue, 30 Aug 2011 15:50:20 -0500
Message-ID: <20110830205020.GB9938@codeaurora.org>
References: <20110830190729.923334292@codeaurora.org>
 <20110830190801.707601780@codeaurora.org>
 <1314732636.14422.8.camel@Joe-Laptop>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1314732636.14422.8.camel@Joe-Laptop>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Aug 30, 2011 at 12:30:36PM -0700, Joe Perches wrote:
> > +		unsigned long msg = msg = ffz(~*ops);
> 
> Really?  That's unlikely to be the right code.
> Maybe just one msg?

Whoah, you're right.  Although the code does actually work.  Just need
one msg though.
 
> > +			void (*func) (void *info) =
> > +				data->func;
> 
> No need to wrap either of these.

OK, fixed.


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
