From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [RFC PATCH] hexagon: Make THREAD_SIZE available to vmlinux.lds
Date: Mon, 8 Jan 2018 20:01:20 -0600
Message-ID: <20180109020120.GC18623@codeaurora.org>
References: <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515463283;
        bh=pQTeO9Qb2P5yg+pRQ5X66NQ2v3BxQpAWZJ5Rx6K0eC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpzzgdwPEl7BKFo2tkKUSXpwL07IxV1Jl8fuuHQPqP9a3PQfLrVIWN7v6l/Nvd5be
         ianBaKaPDWMkc50/F3lu8uLpygGxNRQycnV3duj8G+bHhZc7RLuoDGgckBDHBX0ckP
         PIu+CF02/rCkYmE+1DjuvawEQAjwTmcLiW96Ykws=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1515463283;
        bh=pQTeO9Qb2P5yg+pRQ5X66NQ2v3BxQpAWZJ5Rx6K0eC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpzzgdwPEl7BKFo2tkKUSXpwL07IxV1Jl8fuuHQPqP9a3PQfLrVIWN7v6l/Nvd5be
         ianBaKaPDWMkc50/F3lu8uLpygGxNRQycnV3duj8G+bHhZc7RLuoDGgckBDHBX0ckP
         PIu+CF02/rCkYmE+1DjuvawEQAjwTmcLiW96Ykws=
Content-Disposition: inline
In-Reply-To: <151541004841.29074.9658886589645056333.stgit@warthog.procyon.org.uk>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-hexagon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

On Mon, Jan 08, 2018 at 11:14:08AM +0000, David Howells wrote:
> Make THREAD_SIZE available to vmlinux.lds on hexagon by including
> asm/thread_info.h the linker script.
> 
> This allows init_stack to be allocated in the linker script in a subsequent
> patch.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Guenter Roeck <linux@roeck-us.net>
> cc: Richard Kuo <rkuo@codeaurora.org>
> cc: linux-hexagon@vger.kernel.org
> ---
> 
>  arch/hexagon/kernel/vmlinux.lds.S |    2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
