From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] are they toolchains' issue?
Date: Fri, 08 Nov 2013 17:30:02 +0800
Message-ID: <527CAF1A.40907@asianux.com>
References: <527396BA.7050906@asianux.com> <52739920.4010905@asianux.com> <20131101194238.GA4060@codeaurora.org> <5274FE49.9000104@asianux.com> <5279AFED.3000600@asianux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <5279AFED.3000600@asianux.com>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org

Hello Maintainers:

I met an issue for linux next-20131105

The related error:

    CC [M]  fs/ubifs/lpt_commit.o
  fs/ubifs/lpt_commit.c: In function 'next_pnode_to_dirty':
  fs/ubifs/lpt_commit.c:620:1: internal compiler error: in hwloop_optimize, at config/hexagon/hexagon.c:5796
  Please submit a full bug report,
  with preprocessed source if appropriate.
  See <http://gcc.gnu.org/bugs.html> for instructions.

The related information:

  [root@gchenlinux linux-next]# hexagon-linux-gcc -v
  Using built-in specs.
  COLLECT_GCC=hexagon-linux-gcc
  COLLECT_LTO_WRAPPER=/usr/local/libexec/gcc/hexagon-linux/4.6.1/lto-wrapper
  Target: hexagon-linux
  Configured with: ../gcc-hexagon-2012.03/configure --without-header --disable-nls --enable-language=c --disable-threads --disable-shared --enable-werror=no target_configargs=enable_vtable_verify=yes --target=hexagon-linux
  Thread model: single
  gcc version 4.6.1 (GCC) 
  [root@gchenlinux linux-next]# hexagon-linux-ld -v
  GNU ld (GNU Binutils) 2.21.53.20110905
  [root@gchenlinux linux-next]# hexagon-linux-as -v
  GNU assembler version 2.21.53 (hexagon-linux) using BFD version (GNU Binutils) 2.21.53.20110905

Welcome any suggestions or completions.

Thanks.

On 11/06/2013 10:56 AM, Chen Gang wrote:
> On 11/02/2013 09:29 PM, Chen Gang wrote:
>> On 11/02/2013 03:42 AM, rkuo wrote:
>>>
>>> Thanks for checking all these.  There are newer Hexagon tools available
>>> here:
>>>
>>> https://sourcery.mentor.com/GNUToolchain/release2568?cmpid=7108
>>>
>>> You might want to try those out.  The tool prefix is hexagon-linux-, but
>>> aside from that, a v4 defconfig on 3.12-rc7 compiled for me.
>>>
>>
>> Thank you for your information.
>>
> 
> I finish building the new version of gcc and binutils for kernel. And
> now it can continue -- no related issues which mentioned originally
> (should be fixed in this new version).
> 
>>> 'allmodconfig' does not appear to compile due to DMA related issues...
>>>
>>> Anyways, would you mind giving the newer tools a try?
>>>
>>>
>>
>> I will/should try. try to let our hexagon pass 'allmodconfig' within
>> this month (2013-11-30).
>>
> 
> I am continuing, hope we can finish within this month. :-)
> 
> Thanks.
> 


-- 
Chen Gang
