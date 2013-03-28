From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH] arch: remove CONFIG_GENERIC_FIND_NEXT_BIT again
Date: Thu, 28 Mar 2013 16:04:27 +0100
Message-ID: <51545BFB.9010806@southpole.se>
References: <1363872898.1390.143.camel@x61.thuisdomein> <ed19f23c22d5a92cda8e3622060bed61.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <ed19f23c22d5a92cda8e3622060bed61.squirrel@www.codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: rkuo@codeaurora.org
Cc: Paul Bolle <pebolle@tiscali.nl>, linux-hexagon@vger.kernel.org, linux@lists.openrisc.net, linux-kernel@vger.kernel.org

Hi Richard,

On 03/26/2013 03:53 AM, rkuo@codeaurora.org wrote:
>> CONFIG_GENERIC_FIND_NEXT_BIT was removed in v3.0, but reappeared in two
>> architectures. Remove it again.
>>
>
> I'd be fine pulling these into my tree to go with my next batch of
> changes, or the OpenRISC folks can if they want.  Ack would be nice.

Go ahead and take this patch via your tree.

>
> Just in case:
>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Jonas Bonn <jonas@southpole.se>

Thanks,
Jonas
