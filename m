From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] hexagon/time: set ->min_delta_ticks and ->max_delta_ticks
Date: Mon, 3 Apr 2017 10:49:16 -0500
Message-ID: <20170403154916.GA19890@codeaurora.org>
References: <20170326134403.16226-1-nicstange@gmail.com>
 <20170330194332.6915-1-nicstange@gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1491234559;
        bh=sTWjYEf3WAn6gpeoCJSGxRAkYadb7yH7eQ78S1GWGjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/Gu5nmydjTuw9YLplMfBJviv2qhWNhXHCDeBbXXe9JjuIqdNMr/OOL91mt99vYPq
         kH3E9WT9NTgC9K4dkf7KnJRGymWqDHiYrAqikPvJN5MxsyfS5ZoyQ2MVtiy/F+KmEa
         tyV5gAEYbRIuEOI0B6pIFfZqrwS9j41yOZMj2A/8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1491234558;
        bh=sTWjYEf3WAn6gpeoCJSGxRAkYadb7yH7eQ78S1GWGjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8Zr8UeXxdM7J0B1Wu2UUfOY76CsEzE1UUicBx63o5gA9X2Ov3K2Ae+zb9wm1NC//
         9MC0fDJqS+RvXI6Qie3qPQQIxwR3u+uSJ3lxXFSMwv1VRsjqcSVH8anWRBqwwQaG4m
         FZcYsB+VH2ZfYx9EuK+MiB7mX1NpAMqFrBEKvFXc=
Content-Disposition: inline
In-Reply-To: <20170330194332.6915-1-nicstange@gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolai Stange <nicstange@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-hexagon@vger.kernel.org

On Thu, Mar 30, 2017 at 09:43:32PM +0200, Nicolai Stange wrote:
> In preparation for making the clockevents core NTP correction aware,
> all clockevent device drivers must set ->min_delta_ticks and
> ->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
> clockevent device's rate is going to change dynamically and thus, the
> ratio of ns to ticks ceases to stay invariant.
> 
> Make the hexagon arch's clockevent driver initialize these fields
> properly.
> 
> This patch alone doesn't introduce any change in functionality as the
> clockevents core still looks exclusively at the (untouched) ->min_delta_ns
> and ->max_delta_ns. As soon as this has changed, a followup patch will
> purge the initialization of ->min_delta_ns and ->max_delta_ns from this
> driver.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
> 
> Notes:
>     This prerequisite patch is part of a larger effort to feed NTP
>     corrections into the clockevent devices' frequencies and thus
>     avoiding their notion of time to diverge from the system's
>     one. If you're interested, the current state of the whole series
>     can be found at [1].
>     
>     If you haven't got any objections and these prerequisites get
>     merged by 4.12 everywhere, I'll proceed with the remainder of
>     this series in 4.13.
>     
>     Applicable to next-20170324 as well as to John' Stultz tree [2].
>     
>     [1]
>       git://nicst.de/linux.git cev-freq-adj.v10.fortglx-4.12-time
>       https://nicst.de/git/?p=linux.git;a=shortlog;h=refs/heads/cev-freq-adj.v10.fortglx-4.12-time
>     
>     [2]
>       https://git.linaro.org/people/john.stultz/linux.git fortglx/4.12/time
> 
>  arch/hexagon/kernel/time.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
