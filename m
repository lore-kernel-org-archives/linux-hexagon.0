From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 20/21] ARM: dma-mapping: split out arch_dma_mark_clean() helper
Date: Fri, 31 Mar 2023 16:00:07 +0200
Message-ID: <df6340c8-6ac2-4459-a9e5-c411020962d6@app.fastmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-21-arnd@kernel.org>
 <cb9367fb-0897-244d-15b6-fdfafde2a1c0@arm.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680271232; x=1680278432; bh=N4
        WD590DO+hPCMhWnriCpuvGtJsGQmYQ3+9FXgeZTtc=; b=REpduR9CC3w/0FF9Iv
        EBH9KHHpZAkRv+W9aThRognDHqxxXErt1hEf262htgmfU1y7J8I/og12pQbF1QY9
        z/0+3+/Bf2oK+XUqQ1up2zoCUTbBItrTDBxbm/DdhVRyQkbfie0xE3OFe/uFVR+g
        bks9fZAGQKmrcGDNEtLT86tfn4Wms5mpNyxZklg1B0YWQfy7g9hvGDntPvsCkCeJ
        wLqLsQR9c7xNiHy3PDZ3zK2RyfRwh8d+h+Q+id4O9QFBuDiG38QiGwFwY4W/6byQ
        pNhd/J6qIoDVk9dy/Mdw+8Tf65QdzUWqpPIiUv5wn3AR7WW2l24R3SQbLghgPyUF
        F7gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680271232; x=1680278432; bh=N4WD590DO+hPC
        MhWnriCpuvGtJsGQmYQ3+9FXgeZTtc=; b=i3D+2hFUqX2bGpzs9rCNqcr3CpE2N
        rt7cbXlRcTHCWGo/szfA6As2ip+aj8s1suA1RYGH89iU3g1ca7fdoQJNHyYwLXNr
        WC1WRAlkGPS93OO7BATELyF5zFYGJWHyOuPym1F/LtRkCwUjFR6xo7so3vFgV9vY
        IVCo8mq7pf1tL4yq8LWAbqZdlON6KFVL3Sapxm6koAA4gN8G5B28UEccNxYiAtHQ
        dvIbN7+ejsM+GITaw6ebr/XqJrMfO1ez3Qm4YcHOOMz99mIsNZvq856hdCwflb78
        BjnKIQ+2qfc2YpkHszA6wodj1J2AgunOKqhhPHInMSpLYh9uMkriYgwXQ==
In-Reply-To: <cb9367fb-0897-244d-15b6-fdfafde2a1c0@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, J

On Mon, Mar 27, 2023, at 14:48, Robin Murphy wrote:
> On 2023-03-27 13:13, Arnd Bergmann wrote:
>> 
>> [ HELP NEEDED: can anyone confirm that it is a correct assumption
>>    on arm that a cache-coherent device writing to a page always results
>>    in it being in a PG_dcache_clean state like on ia64, or can a device
>>    write directly into the dcache?]
>
> In AMBA at least, if a snooping write hits in a cache then the data is 
> most likely going to get routed directly into that cache. If it has 
> write-back write-allocate attributes it could also land in any cache 
> along its normal path to RAM; it wouldn't have to go all the way.
>
> Hence all the fun we have where treating a coherent device as 
> non-coherent can still be almost as broken as the other way round :)

Ok, thanks for the information. I'm still not sure whether this can
result in the situation where PG_dcache_clean is wrong though.

Specifically, the question is whether a DMA to a coherent buffer
can end up in a dirty L1 dcache of one core and require to write
back the dcache before invalidating the icache for that page.

On ia64, this is not the case, the optimization here is to
only flush the icache after a coherent DMA into an executable
user page, while Arm only does this for noncoherent DMA but not
coherent DMA.

From your explanation it sounds like this might happen,
even though that would mean that "coherent" DMA is slightly
less coherent than it is elsewhere.

To be on the safe side, I'd have to pass a flag into
arch_dma_mark_clean() about coherency, to let the arm
implementation still require the extra dcache flush
for coherent DMA, while ia64 can ignore that flag.

    Arnd
