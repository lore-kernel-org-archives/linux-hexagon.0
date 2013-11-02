From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] hexagon: kernel: kgdb: include related header for pass
 compiling.
Date: Sat, 02 Nov 2013 21:20:08 +0800
Message-ID: <5274FC08.9010405@asianux.com>
References: <52739669.9000509@asianux.com> <CAHrUA342CVjhn92pJw16UQX6ReKCpHAXraYXxzCX1DB3Mkcuug@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <CAHrUA342CVjhn92pJw16UQX6ReKCpHAXraYXxzCX1DB3Mkcuug@mail.gmail.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linasvepstas@gmail.com
Cc: Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org

On 11/02/2013 01:16 AM, Linas Vepstas wrote:
> On 1 November 2013 06:54, Chen Gang <gang.chen@asianux.com> wrote:
>> Need include related headers for pass compiling, the related error
>> (with allmodconfig for v4):
>>
>>     CC      arch/hexagon/kernel/kgdb.o
>>   arch/hexagon/kernel/kgdb.c:30: error: invalid use of undefined type 'struct pt_regs'
> 
> looks good to me
> 
> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> 
> 

Thanks.
-- 
Chen Gang
