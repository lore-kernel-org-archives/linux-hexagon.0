From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
Date: Fri, 15 Aug 2014 10:06:56 +0800
Message-ID: <53ED6B40.8000409@gmail.com>
References: <53ECE9DD.80004@gmail.com>  <CAMo8BfLuXZ8zyEoKdo8yb6nd+pZUnx0YEL9nqHx98kt76ezfYg@mail.gmail.com> <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h5EvHdt+8yp+8ser3AXFJOkyXGDS4RVPgKEPlkYBUnk=;
        b=rS5ZugBS5SXG4UwS6DxAWQVYjb9a3SVguC42GXiEoMrg3tBDzRJY7eT5bbHukJB3gU
         mbCI7TTxXqU6JrNGH4wwMWgeuvTmKVClB70iuOOcJrZa2YdpqM1mIDyqGCQnl5uA1Wzb
         wuFkM9QoysYgJeF1m14HGUkEl/Vk/vRQc6BNyERNlgslwjFG1XYKU5GNYBEwa7JUXg4H
         BNXN/euelb6znGOYgSUnWzSN93Hx5zDT6CBzVfoNimsxjvRpx0X6FGtC1tUcld5BFKcP
         jDabDG4mhZdMSd9fXdjKHKgHwBrj8p72PjFuMCk+V2PzSNqFIg12HR6CjUMF2rB6HLD7
         AlyQ==
In-Reply-To: <CAMo8Bf+=EgXc0hq14y9Kdykaw_7E52kRAENU1P0fAK4tTx=JpA@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: <linux-hexagon.vger.kernel.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
Content-Type: text/plain; charset="us-ascii"
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "vgupta@synopsys.com" <vgupta@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, starvik@axis.com, jesper.nilsson@axis.com, David Howells <dhowells@redhat.com>, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, James Hogan <james.hogan@imgtec.com>

On 8/15/14 9:52, Max Filippov wrote:
> On Fri, Aug 15, 2014 at 5:47 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> Hi Chen,
>>
>> On Thu, Aug 14, 2014 at 8:54 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
>>> Normal architectures:
>>>
>>>  - Big endian: avr32, frv, m68k, openrisc, parisc, s390, sparc
>>>
>>>  - Little endian: alpha, blackfin, cris, hexagon, ia64, metag, mn10300,
>>>                   score, unicore32, x86
>>>
>>>  - Choose in config time: arc, arm, arm64, c6x, m32r, mips, powerpc, sh
>>>
>>> Special architectures:
>>>
>>>  - Deside by compiler: microblaze, tile, xtensa.
>>>
>>>  - Deside by building host: um
>>>
>>>  - Next, need improve Kbuild to probe endian to deside whether need mark
>>>    __BUILDING_TIME_BIG_ENDIAN__ before real config.

Please check this comments, thanks.

>>
>> [...]
>>
>>> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
>>> index 3a617af..a3e8f7e 100644
>>> --- a/arch/xtensa/Kconfig
>>> +++ b/arch/xtensa/Kconfig
>>> @@ -22,6 +22,8 @@ config XTENSA
>>>         select HAVE_IRQ_TIME_ACCOUNTING
>>>         select HAVE_PERF_EVENTS
>>>         select COMMON_CLK
>>> +       select CPU_BIG_ENDIAN if __BUILDING_TIME_BIG_ENDIAN__
>>> +       select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>>         help
>>>           Xtensa processors are 32-bit RISC machines designed by Tensilica
>>>           primarily for embedded systems.  These processors are both
>>
>> I've tested this part and it doesn't select neither CPU_BIG_ENDIAN,
>> nor CPU_LITTLE_ENDIAN. And looking into the Kconfig/Kbuild I cound't
> 
> Correction: it always selects CPU_LITTLE_ENDIAN, regardless of the
> compiler endianness.
> 

Yeah, at present, it always select CPU_LITTLE_ENDIAN, next, Kbuild need
be improved for it, just the comments said.

If this patch can be pass checking, I shall improve the Kbuild for it,
also will modify some individual drivers to use CPU_*_ENDIAN.

I guess, we need Cc to kbuild for getting more ideas, suggestions, or
completions.



THanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed

