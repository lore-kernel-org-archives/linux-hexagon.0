From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] hexagon: fix ffz/fls/ffs return type
Date: Tue, 10 Apr 2018 08:31:44 +0200
Message-ID: <CAK8P3a0ZhHY35rDrg5m4o3fTXugAG3QipnaZQupnUafvKcH6HQ@mail.gmail.com>
References: <20180406142832.2243021-1-arnd@arndb.de> <20180408013525.GE3036@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=z1Hyx/s77Q20HK4i4jjQyckKJ7qgga1FPX989DjUyT8=;
        b=GSnUiUmeAoAva4h+yBBc1aunxPPSfa2hfVdvfp5SkfYImQ81W8PHnsl9tCKJl+AMhq
         zf8tQ5fy/ioVBYk/QGyYhCK+Zy1yrwTFgPAQLzEJfPO+V5ZFOKg/ItrhBYVL35vdEGyh
         qO2faY/BWpUwb2Xg+pQtGFxmw1sWJYaHB3s3CABr6KdSkR/LCEhV1/S4C+Oiy1e/xS2t
         oq3RfSlgXBtcSb3yojSqDIkUbQgPJHLIcLDLpK4EHuzYhea6QKFEKDXiq+OXzzDqOwZf
         Bm1xpLj9pxF4bgXTofreiH8Xq3DNaATaDQWvbQIroZdoLGyAqaQXpf3QYozAkXUjtF9V
         IOPQ==
In-Reply-To: <20180408013525.GE3036@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Apr 8, 2018 at 3:35 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Fri, Apr 06, 2018 at 04:28:21PM +0200, Arnd Bergmann wrote:
>> Let's use the same return type as the major architectures to
>> avoid warnings like
>>
>> drivers/ata/libahci_platform.c: In function 'ahci_platform_init_host':
>> drivers/ata/libahci_platform.c:561:12: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/hexagon/include/asm/bitops.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
>> index 5e4a59b3ec1b..8790a50b1f5e 100644
>> --- a/arch/hexagon/include/asm/bitops.h
>> +++ b/arch/hexagon/include/asm/bitops.h
>> @@ -194,7 +194,7 @@ static inline int __test_bit(int nr, const volatile unsigned long *addr)
>>   *
>>   * Undefined if no zero exists, so code should check against ~0UL first.
>>   */
>> -static inline long ffz(int x)
>> +static inline int ffz(int x)
>>  {
>>       int r;
>>
>> @@ -211,7 +211,7 @@ static inline long ffz(int x)
>>   * This is defined the same way as ffs.
>>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>>   */
>> -static inline long fls(int x)
>> +static inline int fls(int x)
>>  {
>>       int r;
>>
>> @@ -232,7 +232,7 @@ static inline long fls(int x)
>>   * the libc and compiler builtin ffs routines, therefore
>>   * differs in spirit from the above ffz (man ffs).
>>   */
>> -static inline long ffs(int x)
>> +static inline int ffs(int x)
>>  {
>>       int r;
>>
>
>
> Isn't ffz usually long/unsigned long on other architectures?

Yes, that's right. Let's drop my patch for the moment and maybe revisit it
later. There were only a couple of warnings in an allmodconfig build from
this one, so it might be better change the generic bitops and the more
common architectures to all consistently use 'long' or maybe 'unsigned long'
as the return type for all those functions.

       Arnd
