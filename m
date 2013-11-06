From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] are they toolchains' issue?
Date: Wed, 06 Nov 2013 10:56:45 +0800
Message-ID: <5279AFED.3000600@asianux.com>
References: <527396BA.7050906@asianux.com> <52739920.4010905@asianux.com> <20131101194238.GA4060@codeaurora.org> <5274FE49.9000104@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <5274FE49.9000104@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

On 11/02/2013 09:29 PM, Chen Gang wrote:
> On 11/02/2013 03:42 AM, rkuo wrote:
>>
>> Thanks for checking all these.  There are newer Hexagon tools available
>> here:
>>
>> https://sourcery.mentor.com/GNUToolchain/release2568?cmpid=7108
>>
>> You might want to try those out.  The tool prefix is hexagon-linux-, but
>> aside from that, a v4 defconfig on 3.12-rc7 compiled for me.
>>
> 
> Thank you for your information.
> 

I finish building the new version of gcc and binutils for kernel. And
now it can continue -- no related issues which mentioned originally
(should be fixed in this new version).

>> 'allmodconfig' does not appear to compile due to DMA related issues...
>>
>> Anyways, would you mind giving the newer tools a try?
>>
>>
> 
> I will/should try. try to let our hexagon pass 'allmodconfig' within
> this month (2013-11-30).
> 

I am continuing, hope we can finish within this month. :-)

Thanks.
-- 
Chen Gang
