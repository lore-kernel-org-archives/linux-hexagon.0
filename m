From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: hexagon: Use raw_copy_to_user
Date: Fri, 2 Jun 2017 15:45:48 -0700
Message-ID: <20170602224548.GA20386@roeck-us.net>
References: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
 <20170602130353.GA11696@roeck-us.net>
 <20170602213303.GA30438@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=h2hSjVMIfmkJMbYlB3/NKNWVM0Df2rWa5q2y/Qwdpws=; b=FgEyFsRiR5khzKqa+XyJC98P7r
        kAW6QBw0F4BAUIE6k6oZo93zxzMA7qHd5LUbGLA3z6wubyXZfNkp+IqDV3nFUghuDgzfb/GW4F9F7
        Vkejx0snIOxWSJPinBL1qWJP7/vBD6lP069ierbbLOsVG79fKm5Az1FZtyUEg5XBuVDmLonQFk+pg
        7Ot2VLjxh9Jrg3SQI6SA63/uxqNd5KUc6cJP8g1cHtWIGuhGmsGN5wdOrANwquhgvs6sw8HaEbrFR
        bsU5W7MfasDajxm0zeryOSM724ZqqzI8z64aK19kgffDnhhH1p+w8Gh1PXk6HZ5H+J/W/Pa3hQtCe
        SdzOto 
Content-Disposition: inline
In-Reply-To: <20170602213303.GA30438@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

Hi Richard,

On Fri, Jun 02, 2017 at 04:33:04PM -0500, Richard Kuo wrote:
> On Fri, Jun 02, 2017 at 06:03:53AM -0700, Guenter Roeck wrote:
> > ping ....
> > 
> > On Tue, May 02, 2017 at 08:52:48PM -0700, Guenter Roeck wrote:
> > > Commit ac4691fac8ad ("hexagon: switch to RAW_COPY_USER") replaced
> > > __copy_to_user_hexagon() with raw_copy_to_user(), but did not catch
> > > all callers, resulting in the following build error.
> > > 
> > > arch/hexagon/mm/uaccess.c: In function '__clear_user_hexagon':
> > > arch/hexagon/mm/uaccess.c:40:3: error:
> > > 	implicit declaration of function '__copy_to_user_hexagon'
> > > 
> > > Fixes: ac4691fac8ad ("hexagon: switch to RAW_COPY_USER")
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  arch/hexagon/mm/uaccess.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/hexagon/mm/uaccess.c b/arch/hexagon/mm/uaccess.c
> > > index ec90afdb3ad0..c599eb126c9e 100644
> > > --- a/arch/hexagon/mm/uaccess.c
> > > +++ b/arch/hexagon/mm/uaccess.c
> > > @@ -37,15 +37,14 @@ __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count)
> > >  	long uncleared;
> > >  
> > >  	while (count > PAGE_SIZE) {
> > > -		uncleared = __copy_to_user_hexagon(dest, &empty_zero_page,
> > > -						PAGE_SIZE);
> > > +		uncleared = raw_copy_to_user(dest, &empty_zero_page, PAGE_SIZE);
> > >  		if (uncleared)
> > >  			return count - (PAGE_SIZE - uncleared);
> > >  		count -= PAGE_SIZE;
> > >  		dest += PAGE_SIZE;
> > >  	}
> > >  	if (count)
> > > -		count = __copy_to_user_hexagon(dest, &empty_zero_page, count);
> > > +		count = raw_copy_to_user(dest, &empty_zero_page, count);
> > >  
> > >  	return count;
> > >  }
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 
Do you want me to send it to Linus ?

Thanks,
Guenter
