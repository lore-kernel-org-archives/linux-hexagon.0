From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] hexagon: add support for TIF_NOTIFY_SIGNAL
Date: Fri, 6 Nov 2020 07:38:54 -0700
Message-ID: <98246feb-68f5-5bc5-9009-05062b5c14a8@kernel.dk>
References: <249d67ab-c3ea-0802-c06a-0f35ae3673d2@kernel.dk>
 <246d01d6b3ff$918170a0$b48451e0$@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=k9MVexHhsCQYAbTIlzM9U3zpnKnUWgjhpsgc0swB1UU=;
        b=1+c4T3c7UfdNbidxS4xqcg9BX5gdmxIqeBmc4okb8Bli1sGaD5eQvvLAQUBP4NhNPt
         JjuHRD479ATHM55bPlQUfWIaI8NHizQwaYeYmWCcA3vmmL0tgfnBFdNKhnGFtqoicY/j
         XdXnGOLptzSBU8TLy5hYwbktM9V0XsxtffiJ0vdb26TsFwWxd0pEUGqLRbVpTT4LJLFR
         wLWDWWvb+xv1qdPRFwHnQXheXz9e+0rnmwYIkc/2cnd3xX38k2BX3Ynq+K3UgxeuGerE
         q0Amcmd7eF5GRd66mw58m3debGe2egN3/s5MqspHnbEstm1ezHaKMOTEgVeOHLvj/sAg
         kS6g==
In-Reply-To: <246d01d6b3ff$918170a0$b48451e0$@codeaurora.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: bcain@codeaurora.org, linux-hexagon@vger.kernel.org

On 11/5/20 10:42 PM, Brian Cain wrote:
>> -----Original Message-----
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Thursday, October 29, 2020 11:14 AM
>> To: linux-hexagon@vger.kernel.org
>> Subject: [PATCH] hexagon: add support for TIF_NOTIFY_SIGNAL
> ...
>> --- a/arch/hexagon/kernel/process.c
>> +++ b/arch/hexagon/kernel/process.c
>> @@ -174,7 +174,7 @@ int do_work_pending(struct pt_regs *regs, u32
>> thread_info_flags)
>>  		return 1;
>>  	}
>>
>> -	if (thread_info_flags & _TIF_SIGPENDING) {
>> +	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>> {
>>  		do_signal(regs);
>>  		return 1;
>>  	}
>> --
>> 2.29.0
>>
> 
> Acked-by: Brian Cain <bcain@codeaurora.org>

Thanks Brian!

-- 
Jens Axboe

