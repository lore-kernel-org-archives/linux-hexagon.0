From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v3] arch: Kconfig: Let all architectures set endian explicitly
Date: Fri, 15 Aug 2014 06:22:35 +0800
Message-ID: <53ED36AB.8020703@gmail.com>
References: <53ECE9DD.80004@gmail.com> <C2D7FE5348E1B147BCA15975FBA230753C4BA528@IN01WEMBXA.internal.synopsys.com> <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3nzQZTqA3gZs/buEqy2I49eTrxCes76fxE0EE0gouqQ=;
        b=Nidk833Lh8/nl7p3QYwcytHHrbMDJWOTtQbEMUMc8F41EiXums5/AiXulOq5nCFATw
         pGngNZFql4NenkVbkLndpej7YSlwmx/xmnxKYnVQPRiq+mseOTDFVv2L6sB47Ri8xloU
         mxBfvU0ZjGfAz3Nb++aLwY7jAVtHqX2IPqFFrNdzZ0lVdiyZQLz0taIYS7Ju9a/3rhpi
         lc5tuoD1L3k2aLYEHI8xbEZ6RRhbb3Z1JuaxSyTNSzo0rxXFTaA+V1P7Z3khh7CfRfLT
         60naZP6z5REzRQVCduBHAiVRiTgkVrCb5J4WHHn688cMfJoWRCg35eE/6yswBQHHWaWT
         5Dbg==
In-Reply-To: <CAF0htA6qfhyVXEuLbruiz+dfxnieF-309NdxSDhoEYHM=aBhQA@mail.gmail.com>
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
To: Lennox Wu <lennox.wu@gmail.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rth@twiddle.net" <rth@twiddle.net>, "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com" <mattst88@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <jdelvare@suse.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "msalter@redhat.com" <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, "starvik@axis.com" <starvik@axis.com>, jesper.n

On 08/15/2014 02:27 AM, Lennox Wu wrote:
> I don't think it's necessary, what's the benfit?
> 
> 2014-08-15 2:21 GMT+08:00 Vineet Gupta <Vineet.Gupta1@synopsys.com>:
> 
>> On Thursday 14 August 2014 09:55 AM, Chen Gang wrote:
[...]
>>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>>> index 9596b0a..e939abd 100644
>>> --- a/arch/arc/Kconfig
>>> +++ b/arch/arc/Kconfig
>>> @@ -35,6 +35,7 @@ config ARC
>>>       select OF_EARLY_FLATTREE
>>>       select PERF_USE_VMALLOC
>>>       select HAVE_DEBUG_STACKOVERFLOW
>>> +     select CPU_LITTLE_ENDIAN if !CPU_BIG_ENDIAN
>>
>> It is not clear what exactly are you trying to fix. What doesn't work w/o
>> this
>> patch !
>>

For many individual modules may need check CPU_LITTLE_ENDIAN or
CPU_BIG_ENDIAN, which is an architecture's attribute.

Or they have to list many architectures which they support, which they
don't support. And still, it is not precise.

For architecture API, endian is a main architecture's attribute which
may be used by outside, so every architecture need let outside know
about it, explicitly.


Thanks.
-- 
Chen Gang

Open share and attitude like air water and life which God blessed

