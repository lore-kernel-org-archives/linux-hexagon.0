From: "Brian Cain" <bcain@codeaurora.org>
Subject: RE: [PATCH] trap: Fix warning comparing pointer to 0
Date: Mon, 6 Sep 2021 21:23:01 -0500
Message-ID: <0bcb01d7a38f$48dd1c20$da975460$@codeaurora.org>
References: <1630920794-81114-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Reply-To: <bcain@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630981383; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Reply-To: Sender;
 bh=Vf+adD7w2aYCznZWbb7pqeirNPG3QO9k1TYBCSLXyEs=; b=BLAdG2QB8CNrI+BsK//Tgbo7D98gDtD0n5q2SSayxy+m48BypDZ5QbYLKHJWRtCC5Ph4+Jdc
 U3lpg0ZI+zMY4Y1o5E8J1Ia5V4J1s/7GSpf96lzJFWKXeXjORgXucqIbd4HDhBf8CPQhdp0v
 KEfn4I+6GoABMx560zFbBMfnwMQ=
Sender: bcain=codeaurora.org@mg.codeaurora.org
In-Reply-To: <1630920794-81114-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Language: en-us
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Jiapeng Chong' <jiapeng.chong@linux.alibaba.com>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Sent: Monday, September 6, 2021 4:33 AM
> To: bcain@codeaurora.org
> Cc: linux-hexagon@vger.kernel.org; linux-kernel@vger.kernel.org;
> chongjiapeng <jiapeng.chong@linux.alibaba.com>
> Subject: [PATCH] trap: Fix warning comparing pointer to 0
> 
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> Fix the following coccicheck warning:
> 
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/hexagon/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index edfc35d..3b6e0de 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -135,7 +135,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>  		}
> 
>  		/* Attempt to continue past exception. */
> -		if (0 == newfp) {
> +		if (!newfp) {
>  			struct pt_regs *regs = (struct pt_regs *) (((void
*)fp)
>  						+ 8);
> 

Reviewed-by: Brian Cain <bcain@codeaurora.org>


