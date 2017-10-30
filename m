From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/3] hexagon/kbuild: replace CFLAGS_MODULE with KBUILD_CFLAGS_MODULE
Date: Tue, 31 Oct 2017 00:43:17 +0900
Message-ID: <CAK7LNAQvJ3nmef__OZ6dB6AncVY-Z4VrmdHYj5nZfKW2Pi6EOA@mail.gmail.com>
References: <1507533107-2069-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <1507533107-2069-3-git-send-email-caoj.fnst@cn.fujitsu.com> <20171010012608.GA23555@codeaurora.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com v9UFhxtO015071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1509378239;
        bh=OYukb0SBFwIwN/hik2adRIMrX16SyX9fHLM2OUi7Wqw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ojFfADkcVuglrimMlM1arfVRsGIcBRq7ppxwC7PxhwCVkZp4UWPbGc/dfg3+wAQv+
         v5XNyNu6xhXhyHt38bOsZ/YY8fjbltR+IbA/yMuVKhCZnbXarAmCeyZpDnuHbMreDz
         dId4Stcozqm1iulusmLNO9uRJDpoVbz7Dhz2cere+jE7O7GhLPQwQ4i5CaLG16PjB+
         Ju0eqy8Nxsaq7PvP9yIpVJuaMA0WrVAtz4pxTLQR+QWRV6JIU93xorF4umWPg4QFRo
         89OGXSYvBBsC68xj7aVAssQBnKnIblmmFMpY8Sd+x2Z2ATUWucGwdhy0V0/EvuOi7P
         DZ/NpS80EwDMA==
In-Reply-To: <20171010012608.GA23555@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-hexagon@vger.kernel.org

2017-10-10 10:26 GMT+09:00 Richard Kuo <rkuo@codeaurora.org>:
> On Mon, Oct 09, 2017 at 03:11:47PM +0800, Cao jin wrote:
>> As kbuild document & commit 6588169d51 says: KBUILD_CFLAGS_MODULE is
>> used to add arch-specific options for $(CC). From commandline,
>> CFLAGS_MODULE shall be used.
>> Doesn't have any functional change, but just follow kbuild rules.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> CC: Richard Kuo <rkuo@codeaurora.org>
>> CC: linux-hexagon@vger.kernel.org
>> ---
>>  arch/hexagon/Makefile | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
>> index 207711a0..4f5c84c 100644
>> --- a/arch/hexagon/Makefile
>> +++ b/arch/hexagon/Makefile
>> @@ -11,9 +11,9 @@ KBUILD_CFLAGS += -fno-short-enums
>>
>>  # Modules must use either long-calls, or use pic/plt.
>>  # Use long-calls for now, it's easier.  And faster.
>> -# CFLAGS_MODULE += -fPIC
>> -# LDFLAGS_MODULE += -shared
>> -CFLAGS_MODULE += -mlong-calls
>> +# KBUILD_CFLAGS_MODULE += -fPIC
>> +# KBUILD_LDFLAGS_MODULE += -shared
>> +KBUILD_CFLAGS_MODULE += -mlong-calls
>>
>>  cflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
>>  aflags-y += $(call cc-option,-mv${CONFIG_HEXAGON_ARCH_VERSION})
>> --
>> 2.1.0
>>
>>
>>
>
> For Hexagon:
>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>
>


Applied to linux-kbuild.  Thanks!


-- 
Best Regards
Masahiro Yamada
