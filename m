From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] hexagon: Make THREAD_SIZE available to vmlinux.lds
Date: Tue, 9 Jan 2018 14:47:27 -0800
Message-ID: <20180109224727.GA26819@roeck-us.net>
References: <20180108165803.GB26729@roeck-us.net>
 <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
 <14310.1515535340@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wc+fRWzSJzaoPAIjWP6XK9QBeeCfDLoHBQa8rZnkAU8=;
        b=hyeQj36MXHZLTTeXaD2aiM0JSjXQxRHFPS8D+Wg/wo6V2pHLnTjyTvCWs/qmo/NZzw
         X3tVtSc6pVyiEYsgN5UOOUbDFiznfkSjJtMCklDxDuzc9ad86qyOCSj+7jjX7MEdnaT8
         NKX5aY5+R7O/9uVNRhCXv9nHRu1fv0O/7uGuekZuegHduRAslSG3hCt3dOXTkaU9j5jJ
         Xn0kbfMVERQGY18pR1RQBUURySWHzYxpFmVK4j+VrTIua6iFCCoIHBufGKvptJJJeh1i
         wW8RY4gUxVHi3vj+IWZgR6+cBqfhwvSJChgG1Q40DRXQ/ixGclxeYNx7uv0jgauARRzH
         daSQ==
Content-Disposition: inline
In-Reply-To: <14310.1515535340@warthog.procyon.org.uk>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

On Tue, Jan 09, 2018 at 10:02:20PM +0000, David Howells wrote:
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > (Build-)Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Should I put that down as Reviewed-by or Acked-by instead?
> 
Both Tested-by: and Reviewed-by: is fine.

Guenter
