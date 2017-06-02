From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: hexagon: Use raw_copy_to_user
Date: Fri, 2 Jun 2017 06:03:53 -0700
Message-ID: <20170602130353.GA11696@roeck-us.net>
References: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GDGePfaZrC5/Sv45tGlf+yQc+QI18OherDcwHdULeXs=; b=ftW75C6n8l2rQsIBNydsI0Ceee
        1baLdI4CjXqvl3N+LK2Co3YzZtr8RuyhMFjVHHbEMwyLt1zVAtP7McdVxlvV/n4i3jANVyjeFiYqr
        +HssC0kDpoJr6dlKi2pNE6v0v8tqcHgSEr5lxwmjj/J3Km2M2Daz5exbx7AAZ0yLPqi8+DXr9Gkmh
        CMRqNosYXq7Gsh7tWcJ40ip6WwKiHvhVwlNAopoupdHcIMi08Fcb6if2K1gGt0bRJP9cZKdc9Nq80
        eZKC7DivqUoTjNHKljSAqcIubH3qASC8JFOK8yHBWJzorU9cGPq40cv8NDLaIkWp0ejJcq4hAm/sv
        ufzONA 
Content-Disposition: inline
In-Reply-To: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

ping ....

On Tue, May 02, 2017 at 08:52:48PM -0700, Guenter Roeck wrote:
> Commit ac4691fac8ad ("hexagon: switch to RAW_COPY_USER") replaced
> __copy_to_user_hexagon() with raw_copy_to_user(), but did not catch
> all callers, resulting in the following build error.
> 
> arch/hexagon/mm/uaccess.c: In function '__clear_user_hexagon':
> arch/hexagon/mm/uaccess.c:40:3: error:
> 	implicit declaration of function '__copy_to_user_hexagon'
> 
> Fixes: ac4691fac8ad ("hexagon: switch to RAW_COPY_USER")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/hexagon/mm/uaccess.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/hexagon/mm/uaccess.c b/arch/hexagon/mm/uaccess.c
> index ec90afdb3ad0..c599eb126c9e 100644
> --- a/arch/hexagon/mm/uaccess.c
> +++ b/arch/hexagon/mm/uaccess.c
> @@ -37,15 +37,14 @@ __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count)
>  	long uncleared;
>  
>  	while (count > PAGE_SIZE) {
> -		uncleared = __copy_to_user_hexagon(dest, &empty_zero_page,
> -						PAGE_SIZE);
> +		uncleared = raw_copy_to_user(dest, &empty_zero_page, PAGE_SIZE);
>  		if (uncleared)
>  			return count - (PAGE_SIZE - uncleared);
>  		count -= PAGE_SIZE;
>  		dest += PAGE_SIZE;
>  	}
>  	if (count)
> -		count = __copy_to_user_hexagon(dest, &empty_zero_page, count);
> +		count = raw_copy_to_user(dest, &empty_zero_page, count);
>  
>  	return count;
>  }
