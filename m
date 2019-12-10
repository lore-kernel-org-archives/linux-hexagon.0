From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] hexagon: io: Define ioremap_uc to fix build error
Date: Tue, 10 Dec 2019 00:23:49 -0800
Message-ID: <42cb2e14-a2d7-8e53-509f-da201f0624a0@roeck-us.net>
References: <20191204133328.18668-1-linux@roeck-us.net>
 <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hmr8rjn6U3tumEScYIjT/0XkqE121FE3es2/36sADFE=;
        b=Us+uzDqVf20qnBiT2ZqtcM2CVaucGD8IMZvxe1CItqcingDyyT1WkEEPJRfgGC5Gz8
         dDnY8K1lJqs1cm1JhdMo7wNVOtjb2rkEIih4VNnLvZHV6uRCpixyB++HrRc9eqMdZ/fr
         doUV7kAyazpljj4/M9ryYE5YcNt1AJB9lrhYaywbGCawWw2chRVPPzo1PreZCnjo4jO6
         U9+1/ZlCYen0F6trcfhcAmKQUz/v3fLQ97jHwsAF6qjmp+O7TGHNP/fX5/Dk/nHT1gHZ
         gKutat4kfaIPbzIBf+QzMs56uLfj5IsRnpeBdwABG3KgfNo+AxnqQMUMR2ws0sgupkxX
         mgQA==
In-Reply-To: <CAMuHMdXwJUzuSNS7CBpU5J6ofOZGrWMStJU9VaT2gp3m5U5=Lw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brian Cain <bcain@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tuowen Zhao <ztuowen@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, Lee Jones <lee.jones@linaro.org>

On 12/10/19 12:09 AM, Geert Uytterhoeven wrote:
> On Wed, Dec 4, 2019 at 2:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> ioremap_uc is now mandatory.
>>
>> lib/devres.c:44:3: error: implicit declaration of function 'ioremap_uc'
>>
>> Fixes: e537654b7039 ("lib: devres: add a helper function for ioremap_uc")
>> Cc: Tuowen Zhao <ztuowen@gmail.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/hexagon/include/asm/io.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
>> index 539e3efcf39c..39e5605c5d42 100644
>> --- a/arch/hexagon/include/asm/io.h
>> +++ b/arch/hexagon/include/asm/io.h
>> @@ -173,7 +173,7 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>>
>>   void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
>>   #define ioremap_nocache ioremap
>> -
>> +#define ioremap_uc ioremap
>>
>>   #define __raw_writel writel
> 
> Do we really need this? There is only one user of ioremap_uc(), which
> Christoph is trying hard to get rid of, and the new devres helper that
> triggers all of this :-(
> https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/
> 


One may ask why we needed a devres helper in the first place if there
is indeed just one user.

Either case, I don't really care, as long as the problem is fixed.

Guenter
