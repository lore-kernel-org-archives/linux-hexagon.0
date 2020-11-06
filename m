From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] hexagon: add support for TIF_NOTIFY_SIGNAL
Date: Thu, 5 Nov 2020 23:42:07 -0600
Message-ID: <246d01d6b3ff$918170a0$b48451e0$@codeaurora.org>
References: <249d67ab-c3ea-0802-c06a-0f35ae3673d2@kernel.dk>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604641337; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: To:
 From: Reply-To: Sender;
 bh=l3xVv4fUlyNXeiFyHav1PYFEEJzdPnHccCBwqokY+MI=; b=WI0UmGtPc+RsNpd0QageN+RD3tpvHS1HG8e0cNugs2t9mWw1x/lD09fGqy+OLmu1aPVg1CRU
 Y1iRp6XMjwu1DLwwctOKNTu0DT4GsPi86UcH/0jAnrU1TGJmNnhZZgVBSWtzSLD/iznOjFWF
 jxnOc7gwWPJsRuxulTDEZBgirIk=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <249d67ab-c3ea-0802-c06a-0f35ae3673d2@kernel.dk>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Jens Axboe' <axboe@kernel.dk>, linux-hexagon@vger.kernel.org

> -----Original Message-----
> From: Jens Axboe <axboe@kernel.dk>
> Sent: Thursday, October 29, 2020 11:14 AM
> To: linux-hexagon@vger.kernel.org
> Subject: [PATCH] hexagon: add support for TIF_NOTIFY_SIGNAL
...
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -174,7 +174,7 @@ int do_work_pending(struct pt_regs *regs, u32
> thread_info_flags)
>  		return 1;
>  	}
> 
> -	if (thread_info_flags & _TIF_SIGPENDING) {
> +	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> {
>  		do_signal(regs);
>  		return 1;
>  	}
> --
> 2.29.0
> 

Acked-by: Brian Cain <bcain@codeaurora.org>


