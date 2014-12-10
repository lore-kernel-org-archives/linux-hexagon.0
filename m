From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hexagon: Fix build failures in linux-next
Date: Tue, 09 Dec 2014 19:13:57 -0800
Message-ID: <5487BA75.4010604@roeck-us.net>
References: <1418163705-1816-1-git-send-email-linux@roeck-us.net> <20141210002523.GA17946@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=8p6p9PsBZZiIRnY/1qTPgQKz6vpGnUC/jfwNQnl+n9o=;
	b=DfHkf0EdX4tVPN65GqvOOg5sEE/ZQZM4HmkzzLDxVJxlTENpFBhghX34nfp9ooJf92JjbsemIeLY90/G3n+9PNu+scwVhcMEkh+/+a652Tczs6bP+E6zmk+QB/p76Lc73wNwostLSOuw6S8iCdwKXQgCZjyeLNi8C9KEjiGEyi0=;
In-Reply-To: <20141210002523.GA17946@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On 12/09/2014 04:25 PM, rkuo wrote:
> On Tue, Dec 09, 2014 at 02:21:45PM -0800, Guenter Roeck wrote:
>> hexagon:defconfig fails to build in linux-next since commit 332fd7c4fef5
>> ("genirq: Generic chip: Change irq_reg_{readl,writel} arguments").
>>
>> The primary build failure is
>>
>> arch/hexagon/include/asm/cacheflush.h: In function 'copy_to_user_page':
>> arch/hexagon/include/asm/cacheflush.h:89:22: error: 'VM_EXEC' undeclared
>>
>> This is the result of including of <linux/io.h> from <linux/irq.h>,
>> which is now necessary due to the use of readl and writel from irq.h.
>> This causes recursive inclusions in hexagon code; cacheflush.h is included
>> from mm.h prior to the definition of VM_EXEC.
>>
>> Fix the problem by moving copy_to_user_page from the hexagon include file to
>> arch/hexagon/mm/cache.c, similar to other architectures. After this change,
>> several redefinitions of readl and writel are reported. Those are caused
>> by recursive inclusions of io.h and asm/cacheflush.h. Fix those problems by
>> reducing the number of files included from those files. Also, it was necessary
>> to stop including asm-generic/cacheflush.h from asm/cacheflush.h. Instead,
>> functionality originally provided by asm-generic/cacheflush.h is now coded
>> in asm/cacheflush.h directly.
>>
>> Cc: Kevin Cernekee <cernekee@gmail.com>
>> Cc: Jason Cooper <jason@lakedaemon.net>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> Compile tested only. Applies to linux-next as well as mainline.
>>
>>   arch/hexagon/include/asm/cacheflush.h | 36 ++++++++++++++++++-----------------
>>   arch/hexagon/include/asm/io.h         |  5 -----
>>   arch/hexagon/kernel/setup.c           |  1 +
>>   arch/hexagon/mm/cache.c               | 10 ++++++++++
>>   arch/hexagon/mm/ioremap.c             |  1 +
>>   5 files changed, 31 insertions(+), 22 deletions(-)
>>
>
> Thanks for the cleanup; tested working on hardware.
>
> I'm fine taking this into my tree, or it can go via another tree if more
> expedient.
>
Hi Richard,

Your tree should be fine as long as you plan to push your changes to Linus
during the current release cycle.

Thanks,
Guenter
