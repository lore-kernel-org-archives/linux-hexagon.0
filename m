From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Date: Thu, 10 Aug 2023 17:21:04 +0200
Message-ID: <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691680887; x=1691767287; bh=2Q9/wkZuAqGaPUlwVeMbpzA59zc+JfHIktY
        O4gpFXEA=; b=ZCcOvD/TT/PSev+2Dyu9ZRKhlD4q/bxEv5m+kvnNStn5eSszZWm
        w9D5rrEsvkBLmz306pN0MqgCBrkdacFLlP0rSRb/WNaZNJc5uMDd5iDiMN+uBXYv
        GJOyPmA70xOSVNmpH/ET30WSOY/HTl7/mzDWPBLgMgllw73V+Wv/UFpDGv0WYEPU
        jtUByC4uRRJ9OjRPV5CNx4fob5dB60qcHFbzeHEg6+R6a57BUKfeNUoGYWovUIwx
        vkeit7Rlnxv0zWR6jkbC368cwJlumjjVa75wl8kXhsl3JJ4muOCtwGQNk5fIhkuq
        znkzlDD0Cg6bRbITDLIDSH2A0JKt/5wgXSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691680887; x=1691767287; bh=2Q9/wkZuAqGaPUlwVeMbpzA59zc+JfHIktY
        O4gpFXEA=; b=mms0pG75QfEGRdY/ORQ0MstTvMIXTCXtbdJmNVVzt+DPpXNBlxD
        +5UMexA4voHGOBrQCEgGvYUXvBBPVnElQGSTKN9uQ8of7OyWgnvQiBUp3C/yIlpy
        T8an/+4gYsr+5skEsqiLG48DUKeq8u9j9UtmpBVUujkjk2ll6C5FtSa5b+haekJ9
        OYWWYQ7A6PKlUtSVrMal7TiMysf/suC9L/GvlijFC/9PWaapAgwmMSMO0BPq04x/
        L0g0JH5xn86tizCEsedGoJzcSUulJHdXcLb6W1ZtqmRKS99y2tntFCSMjAa6TicL
        b1YxAem1VYQEPfpVW+ue+k4iDarYNL+9IGQ==
In-Reply-To: <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko

On Thu, Aug 10, 2023, at 16:59, Christophe Leroy wrote:
> Le 10/08/2023 =C3=A0 16:19, Arnd Bergmann a =C3=A9crit=C2=A0:
>> From: Arnd Bergmann <arnd@arndb.de>
>>=20
>> I have cleaned up the -Wmissing-prototypes warnings for most of the m=
ajor architectures
>> as well as all drivers that get enabled for CONFIG_COMPILE_TEST, so n=
ow these should be
>> close to fixed on x86, arm, arm64, powerpc, s390, and riscv.
>>=20
>> The other architectures tend to have a lot of these warning in archit=
ecture specific
>> code, primarily from functions that are only called from assembler co=
de and do
>> not otherwise need a declaration but still cause a warning without on=
e. Other cases
>> are simply functions that should just be static or are missing an #in=
clude statement.
>>=20
>> In order to be able to turn the warning on globally by default withou=
t breaking all
>> these architectures, add a list of exceptions for architecture direct=
ories that
>> can revert back to the old behavior of not warning based on a new
>> CONFIG_WNO_MISSING_PROTOTYPES option.
>
> Some architectures only have a few of those errors/warnings.
>
> For instance microblaze and parisc only have one each. Isn't it better=20
> to fix them rather then turn the errors off ?

The list was only the 'defconfig' warnings, there are a couple more
that I saw with 'allmodconfig', and I'm sure there are even more
when dealing with other random configurations.

I did send other fixes for microblaze and parisc specific drivers,
and I could also send patches for the two defconfig warnings if
the maintainers are happy with fixing those but leaving allmodconfig
to still warn, but I feel that it's easier for them to just
do the last fixes themselves and then remove my hack again.

I'll wait for Michal and Helge on these.

> Others like loongarch which is a recent actively maintained=20
> architecture, I'd expect the 30 errors to be easy to fix.

Agreed, they probably are.

> Many of the alpha ones seems to be brought by your commit e19d4ebc536d=20
> ("alpha: add full ioread64/iowrite64 implementation")

As far as I can see, those already existing before that patch, though
I did touch the same lines there.

In the end it's a matter of where to stop, as there are endless
configurations to test if I want to do a complete job. I drew the
line between powerpc (which I tried to fix) and mips (which I left
alone), mainly because the powerpc side was already exhausting
and mips has even more obscure configurations. The other ones on
the list are all less actively maintained than these two.

     Arnd
