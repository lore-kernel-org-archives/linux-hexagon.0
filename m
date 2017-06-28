From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH -next] hexagon: Fix compile error
Date: Wed, 28 Jun 2017 15:53:29 +0200
Message-ID: <20170628135329.GB1268@lst.de>
References: <1498610594-5993-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498610594-5993-1-git-send-email-linux@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>

On Tue, Jun 27, 2017 at 05:43:14PM -0700, Guenter Roeck wrote:
> Fix:
> 
> arch/hexagon/kernel/dma.c: At top level:
> arch/hexagon/kernel/dma.c:209:40: error: expected '}' before ';' token
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: 8715a7227c30b ("hexagon: switch to use ->mapping_error for ...")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Maybe fold into the offending patch if possible ?

Will do.  So it looks like your build farm builds hexagon, but the
official build bot doesn't, sigh..
