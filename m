From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: hexagon: Use raw_copy_to_user
Date: Fri, 2 Jun 2017 16:33:04 -0500
Message-ID: <20170602213303.GA30438@codeaurora.org>
References: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
 <20170602130353.GA11696@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496439190;
        bh=t83qTL3LTekbYwZNvQ3xi8hQxBkZf3TuLaSSFMCYjp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUMBP29uIRT/RFWYKFKutIoF63MXkRHsdecMsJruxKwxnFFcBCAqeaLtMcKnRfx5V
         hr/wQGTCgGU/+QlOtA5oE5s5FXXXXCQ8MRPO/zDW0OCSScpg8IT7gkqJJP7tw19htx
         8Wu01FmU4kWUTPjlSqBWTPp7kui7Y+2VOroxFWls=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496439186;
        bh=t83qTL3LTekbYwZNvQ3xi8hQxBkZf3TuLaSSFMCYjp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COIfY0ImaA9XEIVSURprO6g7OYlxnk1Q5gyGgLuGD1qDQIvxI5XY+2Kj0C/kqnNdZ
         MSThVkycoQqjxO3yqFHO4tNY2iw1i33VxzqLjtccgACVpKkTJKx0B2mtseUzh3zZDb
         q8dMt5yMl8k6v/3aWwPwlCP1twz9mRqSAAz0GDxs=
Content-Disposition: inline
In-Reply-To: <20170602130353.GA11696@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Fri, Jun 02, 2017 at 06:03:53AM -0700, Guenter Roeck wrote:
> ping ....
> 
> On Tue, May 02, 2017 at 08:52:48PM -0700, Guenter Roeck wrote:
> > Commit ac4691fac8ad ("hexagon: switch to RAW_COPY_USER") replaced
> > __copy_to_user_hexagon() with raw_copy_to_user(), but did not catch
> > all callers, resulting in the following build error.
> > 
> > arch/hexagon/mm/uaccess.c: In function '__clear_user_hexagon':
> > arch/hexagon/mm/uaccess.c:40:3: error:
> > 	implicit declaration of function '__copy_to_user_hexagon'
> > 
> > Fixes: ac4691fac8ad ("hexagon: switch to RAW_COPY_USER")
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  arch/hexagon/mm/uaccess.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/hexagon/mm/uaccess.c b/arch/hexagon/mm/uaccess.c
> > index ec90afdb3ad0..c599eb126c9e 100644
> > --- a/arch/hexagon/mm/uaccess.c
> > +++ b/arch/hexagon/mm/uaccess.c
> > @@ -37,15 +37,14 @@ __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count)
> >  	long uncleared;
> >  
> >  	while (count > PAGE_SIZE) {
> > -		uncleared = __copy_to_user_hexagon(dest, &empty_zero_page,
> > -						PAGE_SIZE);
> > +		uncleared = raw_copy_to_user(dest, &empty_zero_page, PAGE_SIZE);
> >  		if (uncleared)
> >  			return count - (PAGE_SIZE - uncleared);
> >  		count -= PAGE_SIZE;
> >  		dest += PAGE_SIZE;
> >  	}
> >  	if (count)
> > -		count = __copy_to_user_hexagon(dest, &empty_zero_page, count);
> > +		count = raw_copy_to_user(dest, &empty_zero_page, count);
> >  
> >  	return count;
> >  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hexagon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Acked-by: Richard Kuo <rkuo@codeaurora.org>


Thanks!



-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
