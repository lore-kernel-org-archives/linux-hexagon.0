From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] hexagon: kernel: kgdb: include related header for pass
 compiling.
Date: Mon, 04 Nov 2013 09:45:37 +0800
Message-ID: <5276FC41.8030807@asianux.com>
References: <52739669.9000509@asianux.com> <20131104011528.GC4060@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20131104011528.GC4060@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

On 11/04/2013 09:15 AM, rkuo wrote:
> On Fri, Nov 01, 2013 at 07:54:17PM +0800, Chen Gang wrote:
>> Need include related headers for pass compiling, the related error
>> (with allmodconfig for v4):
>>
>>     CC      arch/hexagon/kernel/kgdb.o
>>   arch/hexagon/kernel/kgdb.c:30: error: invalid use of undefined type 'struct pt_regs'
>>   arch/hexagon/kernel/kgdb.c:31: error: invalid use of undefined type 'struct pt_regs'
>>   ...
>>   arch/hexagon/kernel/kgdb.c:220: error: implicit declaration of function 'local_irq_save'
>>   arch/hexagon/kernel/kgdb.c:222: error: implicit declaration of function 'local_irq_restore'
>>   ...
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/hexagon/kernel/kgdb.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
> 
> Thanks for the cleanup.  I can take these patches into my tree for my next
> push, or they can go in one of the other tree.  In that case,
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 
> 

For me, both are OK.

Thanks.
-- 
Chen Gang
