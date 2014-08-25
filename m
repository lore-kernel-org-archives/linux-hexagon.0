From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
Date: Mon, 25 Aug 2014 20:26:31 +0800
Message-ID: <53FB2B77.8070606@gmail.com>
References: <53ECE9DD.80004@gmail.com> <20140814180418.GA20777@linux-mips.org> <53ED34CE.3040001@gmail.com> <53EDCC60.5040608@gmail.com> <53F9A48F.3020803@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GQ5QHWpAfHOi1hi/YgRiyZDF/ALDEuRpuJ84ukra6RQ=;
        b=V+hgbNP2nsfJDrU4AXMNY7fQZtxVX5KK29Us+7dzpNhyHfivVktMG7PJC6cJyIppim
         nPzu9z5YatcwWJvfPb1iphd+TXld/aIMsbi0/WTMg/0mFeu9D8G3tp7P+XBYFHvhW3dE
         K9eJhA8h3K+0C5Fuhy2M/5jC2L/N4mwdZEGusMbP+qtOAxbz28JLKt9azOvXd2u75U+g
         7BKqJo52CJPu5iDRbMOXAhi5C1b1JakiX2qAbJW0kQBgpqdKICHWPIQ/pqO12mP7fTA0
         iwZWzLl8P0CqiFDH3zSFAMyKxTwDrmV4w0St89bZNTOU89EC/pM8TtY+ss8tcbudpM3S
         Hjdw==
In-Reply-To: <53F9A48F.3020803@gmail.com>
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
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, takata@linux-m32r.org, james.hogan@imgtec.com, Michal Simek <monstr@monstr.eu>, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, mpe@ellerman.id.au, Mart

Hello all:

It seems no any additional rejections for it. I guess, I need split the
'big' patch into pieces, and each send to its' related mailing list, so
let it not like a spam. And the schedule may like:

 - Firstly, send patch for "init/Kconfig" to add CPU_*_ENDIAN. If pass
   checking (hope it can be passed checking), then

 - Send each related patch to each related architectures which already
   knew their ENDIAN attributes in config time (24 patches, I guess),
   then

 - Make patch for Kbuild to support __BUILDING_TIME_BIG_ENDIAN__, and
   pass checking (hope I can finish), then

 - Finish left architectures which need __BUILDING_TIME_BIG_ENDIAN__
   (4 patches, I guess).

Welcome any ideas, suggestions, or completions. And if no additional
reply, I shall not send any additional information any more to avoid
spam to other members.


Thanks.

On 08/24/2014 04:38 PM, Chen Gang wrote:
> Hello Maintainers:
> 
> Is this patch OK? If it pass basic checking, please let me know, and I
> shall try to make another related patch for KBuild (I can do nothing
> related with Kbuild, before get confirmation for this patch).
> 
> Thanks.
> 
> On 8/15/14 17:01, Chen Gang wrote:
>>
>>
>> On 8/15/14 6:14, Chen Gang wrote:
>>> On 08/15/2014 02:04 AM, Ralf Baechle wrote:
>>>>
>>>
>>> OK, thanks, I assumes when support both endian, the default choice is
>>> CPU_BIG_ENDIAN, although no default value for choice (originally, I did
>>> worry about it).
>>>
>>>> So I think you can just drop the MIPS segment from your patch.
>>>>
>>>
>>> If what I assumes is correct, what you said sounds reasonable to me.
>>>
>>>
>>
>> So for me, it is harmless to add CPU_*_ENDIAN explicitly, and can let
>> other members don't need think of.
>>
>> By the way, for sh, it is almost the same case, except it contents the
>> default value, for me, it is clear enough, so I skip sh architecture in
>> this patch.
>>
>>
>> Thanks
>>
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed

