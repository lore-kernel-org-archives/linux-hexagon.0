From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] hexagon: export csum_partial_copy_nocheck
Date: Tue, 10 Apr 2018 08:33:17 +0200
Message-ID: <CAK8P3a3JCYn=QE9A6+ZBOfXex0FdeVAJ0HJdaHVcvGzb2AeQkQ@mail.gmail.com>
References: <20180406142832.2243021-1-arnd@arndb.de> <20180406142832.2243021-3-arnd@arndb.de>
 <20180408013210.GD3036@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IzH9+B/Lwgh7X7JzIiF6qVq97TrukxPYLu08bj6y6Wk=;
        b=YQeO92A2E00DMMYbxhyNjuwikMN6BkivY/waPkf7B4j2tgOdrJ7qVPPO5zTgQ1m7vi
         CPPbjiKM88y7h6KLnsKxVgk3DSnd4ygc4mULl4TVbrcv6xIInl6edl7V2TJeKD9fZX0m
         TiMt0GU4KNqn5cJ7XFGKPB+dL53ANWUlvO5NNlYf9SfG5CU+DU6gqwY7qDDOZnh5EpUH
         EC9ulJxDs/v0YRK70XJkuGjkuKT66REjR5eCz4C+Zl27y6AN/pyc6Gy/pm92V9JR5D9r
         7DHNy/q0ZrKnsyo5z+bIfeOn0CxVcMX8IqZ0Fs07M4A0mNyIcBEeRZIZ2aMjYWYQYry8
         AGmA==
In-Reply-To: <20180408013210.GD3036@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Apr 8, 2018 at 3:32 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Fri, Apr 06, 2018 at 04:28:23PM +0200, Arnd Bergmann wrote:
>> This is needed to link ipv6 as a loadable module, which in turn happens
>> in allmodconfig.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/hexagon/lib/checksum.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
>> index 617506d1a559..7cd0a2259269 100644
>> --- a/arch/hexagon/lib/checksum.c
>> +++ b/arch/hexagon/lib/checksum.c
>> @@ -199,3 +199,4 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
>>       memcpy(dst, src, len);
>>       return csum_partial(dst, len, sum);
>>  }
>> +EXPORT_SYMBOL(csum_partial_copy_nocheck);
>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>

Can you take the two patches you acked through your tree? They are not urgent,
but with those applied, I got very close to building an allmodconfig
kernel without
warnings, using the toolchain I uploaded to
https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.1/

        Arnd
