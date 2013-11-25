From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH] arch: hexagon: kernel: add export symbol function __delay()
Date: Mon, 25 Nov 2013 09:50:30 +0800
Message-ID: <5292ACE6.2020101@gmail.com>
References: <528AD6B3.1060507@gmail.com> <20131125011908.GA18921@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tjLdf9Savg3CBh8CVPvpdoVQCqL9dO5JOrWbBphbmag=;
        b=fIUCHvEgU466CHggK15I7I3cihrityPmz2KI7HP4GOna/yqaGQmnWCmQF1ybOgR7Xr
         2vjSnse1DZHD69f0JO1ZKZgh4Rbi4qqVT35lDPdG3UeeiLR+Apa4V9dzf7lZdvMwG5NS
         x9n3WA8xcMdJtjBhtUA8iE3j3YPzOZRBXRmDL/nT0DOYepI4rhAi92WLOcTNPEyP00BU
         d8b2hvVXpB20O7pFu5dZW6eH3t9xpouoPOYBPxsz8pVhPHlRxRkVednpEhvMFWTWFKWS
         h/2NWCtgQ5Zq+yhOAb38lOeGwF1jFn19CUXHvYkWyrIa6TsoEAJ0N/fAye+MbHKRosiU
         Ib+A==
In-Reply-To: <20131125011908.GA18921@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/25/2013 09:19 AM, rkuo wrote:
> On Tue, Nov 19, 2013 at 11:10:43AM +0800, Chen Gang wrote:
>> Need add __delay() implementation, or can not pass allmodconfig in
>> next-20131118 tree.
>>
>> The related error:
>>
>>     CC      kernel/locking/spinlock_debug.o
>>   kernel/locking/spinlock_debug.c: In function '__spin_lock_debug':
>>   kernel/locking/spinlock_debug.c:114:3: error: implicit declaration of function '__delay' [-Werror=implicit-function-declaration]
>>
>>
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  arch/hexagon/include/asm/delay.h |    1 +
>>  arch/hexagon/kernel/time.c       |    9 +++++++++
>>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> Thanks again for all the cleanups.  I've tested this and the rest of your
> patches on my internal tree and everything checks out.
> 

OK, thanks. I will/should continue. :-)

> Also just to let you know, I'm still waiting to hear back on that compiler
> bug.
> 

If necessary/suitable, can let me join to the related communication.

> 
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Thanks.
-- 
Chen Gang
