From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH] hexagon: Make THREAD_SIZE available to vmlinux.lds
Date: Mon, 8 Jan 2018 08:58:03 -0800
Message-ID: <20180108165803.GB26729@roeck-us.net>
References: <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gWp+Xu+SrOd7FDGK373Rub7hLbOowMLuTildglT8OuY=;
        b=eUPJg3Y2oPsxUauNsJoKdGj9c1sf0FsMO6yDxhFOnVLb99zO7fJ3BxHEu7O5ILV56+
         p0nZfX1/pWj2rd6tjS6mPdA4NsF6acUSBLk4r6WH/qsMSy/PTkrnsC7qMee8HzsW8MAY
         6fwMqQ1jHwqe7T3DPn6rdjn4CAsbizEuepDh2JPCBvj0X1U40mPSCV6PKzKbQu3s6Trb
         +hhGDfBegWZDar0hk4+1LO3sXuTw5oTxbE394tLdrS2EzaOQyEbaNjERhUrK9z3YkZai
         YyvaK6IlopJcy5b4+Gnn+QAOcZY16uy98pLfKnlGR4wezroqynkuZ1gprjBDFHQVBeaL
         Z8nw==
Content-Disposition: inline
In-Reply-To: <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: rkuo@codeaurora.org, linux-hexagon@vger.kernel.org

On Mon, Jan 08, 2018 at 11:14:08AM +0000, David Howells wrote:
> Make THREAD_SIZE available to vmlinux.lds on hexagon by including
> asm/thread_info.h the linker script.
> 
> This allows init_stack to be allocated in the linker script in a subsequent
> patch.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: David Howells <dhowells@redhat.com>

(Build-)Tested-by: Guenter Roeck <linux@roeck-us.net>

> cc: Guenter Roeck <linux@roeck-us.net>
> cc: Richard Kuo <rkuo@codeaurora.org>
> cc: linux-hexagon@vger.kernel.org
> ---
> 
>  arch/hexagon/kernel/vmlinux.lds.S |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
> index ec87e67feb19..ad69d181c939 100644
> --- a/arch/hexagon/kernel/vmlinux.lds.S
> +++ b/arch/hexagon/kernel/vmlinux.lds.S
> @@ -22,6 +22,8 @@
>  #include <asm/asm-offsets.h>	/*  Most of the kernel defines are here  */
>  #include <asm/mem-layout.h>	/*  except for page_offset  */
>  #include <asm/cache.h>		/*  and now we're pulling cache line size  */
> +#include <asm/thread_info.h>	/*  and we need THREAD_SIZE too */
> +
>  OUTPUT_ARCH(hexagon)
>  ENTRY(stext)
>  
> 
