From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] hexagon: Use raw_copy_to_user
Date: Wed, 3 May 2017 06:17:12 +0100
Message-ID: <20170503051712.GF29622@ZenIV.linux.org.uk>
References: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

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

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
