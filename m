From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] hexagon: kernel: remove useless variables 'dn', 'r' and
 'err' in time_init_deferred() in "time.c"
Date: Mon, 04 Nov 2013 09:44:57 +0800
Message-ID: <5276FC19.1080708@asianux.com>
References: <52738B84.9080704@asianux.com> <20131104011355.GB4060@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20131104011355.GB4060@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

On 11/04/2013 09:13 AM, rkuo wrote:
> On Fri, Nov 01, 2013 at 07:07:48PM +0800, Chen Gang wrote:
>> Remove them, since they are useless. The related warnings (with
>> allmodconfig for v4):
>>
>>     CC      arch/hexagon/kernel/time.o
>>   arch/hexagon/kernel/time.c: In function 'time_init_deferred':
>>   arch/hexagon/kernel/time.c:196: warning: unused variable 'err'
>>   arch/hexagon/kernel/time.c:195: warning: unused variable 'r'
>>   arch/hexagon/kernel/time.c:194: warning: unused variable 'dn'
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/hexagon/kernel/time.c |    3 ---
>>  1 files changed, 0 insertions(+), 3 deletions(-)
>>
> 
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
> 

Thanks.
-- 
Chen Gang
