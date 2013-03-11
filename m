From: rkuo@codeaurora.org
Subject: Re: [Q] Guest mode in HVM
Date: Mon, 11 Mar 2013 11:55:14 -0700
Message-ID: <216f47b9239f1de2bd1d10e355a32f04.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cotulla@ya.ru
Cc: linux-hexagon@vger.kernel.org

On Wed, Mar 6, 2013 at 5:27 PM, <cotulla@ya.ru> wrote:
> Will it be releases as binary or as source code?

We're hoping to release it as source; currently still working things out.


> Yes, we got busybox to run rather good as well. Most tests are passed.
> Under "we" I mean me and Jonpry. I am working with QDSP6v2 (QSD8250B) and
> he is working with QDSP6v3 (APQ8060).

I see you guys already found the last version of the Linux tools; that's
good.  I was in fact wondering what hardware you were using as well.


> Another question which I want to know - QDSP6 has PIPT cache or VIPT?

It's VIPT; you shouldn't have to worry about the extra cache flushing or
whatever when translations change.



Regards,
Richard Kuo



--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
