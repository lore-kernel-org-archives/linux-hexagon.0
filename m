From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] Hexagon: Delete stale barrier.h
Date: Thu, 01 May 2014 14:20:53 -0700
Message-ID: <5362BAB5.7060703@roeck-us.net>
References: <1397808515-8013-1-git-send-email-vgupta@synopsys.com>	<1397808515-8013-3-git-send-email-vgupta@synopsys.com>	<20140501161005.GA6212@roeck-us.net> <CA+55aFwCOW+bZHfAYMJsFQqEiX7bE79B-JwcJxZ67UVtEQgpcA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwCOW+bZHfAYMJsFQqEiX7bE79B-JwcJxZ67UVtEQgpcA@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On 05/01/2014 10:10 AM, Linus Torvalds wrote:
> On Thu, May 1, 2014 at 9:10 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hexagon build is still broken with 3.15-rc3 and with the latest upstream.
>> This patch fixes the (build) problem. Would be great if the arch maintainer
>> could apply this (or a similar) patch and send it to Linus.
>
> I took it directly, since you compile-tested it.
>

Great, thanks!

Guenter

