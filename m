From: rkuo@codeaurora.org
Subject: Re: [PATCH] arch: remove CONFIG_GENERIC_FIND_NEXT_BIT again
Date: Mon, 25 Mar 2013 19:53:37 -0700
Message-ID: <ed19f23c22d5a92cda8e3622060bed61.squirrel@www.codeaurora.org>
References: <1363872898.1390.143.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1363872898.1390.143.camel@x61.thuisdomein>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Richard Kuo <rkuo@codeaurora.org>, Jonas Bonn <jonas@southpole.se>, linux-hexagon@vger.kernel.org, linux@lists.openrisc.net, linux-kernel@vger.kernel.org

> CONFIG_GENERIC_FIND_NEXT_BIT was removed in v3.0, but reappeared in two
> architectures. Remove it again.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
>
> 1) See commit 63e424c84429903c92a0f1e9654c31ccaf6694d0 ("arch: remove
> CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}") for the removal of this
> Kconfig symbol.
>
> 2) Sent as one patch. Feel free to tell me to split it up in two
> patches.
>
>  arch/hexagon/Kconfig  | 3 ---
>  arch/openrisc/Kconfig | 3 ---
>  2 files changed, 6 deletions(-)
>

I'd be fine pulling these into my tree to go with my next batch of
changes, or the OpenRISC folks can if they want.  Ack would be nice.

Just in case:

Acked-by: Richard Kuo <rkuo@codeaurora.org>


Thanks,
Richard Kuo



--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

