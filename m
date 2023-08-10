From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Date: Thu, 10 Aug 2023 21:15:04 +0200
Message-ID: <9f295a4d-5657-4e4d-8740-eb9a56cee97d@app.fastmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
 <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
 <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691694925; x=1691781325; bh=cD
        RJ70tlUw1f5vvydGZnly44JvjoIjvlKIEtTxRqzOA=; b=BfIaANBPx1NIJxHUY8
        7ivOvwDz9pUturVj8bM/Xs6IgBKscXsONpFc3V/Uznsieh33xb8FD23DUZ1fV2OT
        ClwE5f/0TK0qFDpZGFAstr1dnPDg5APnNidEQoEmK5OBty6TOwndwMepEV4wzs8R
        AdNRtcKedt6eDTjYG77XDEe4bwMwHg/bOYVmRSKsGUiPih/fxA2vgZQTk+4/2H7i
        yCBYznxPMWsTIsr/BQcLiTuGcpQvTo32mkYNLPa9UAyiBzQptlHtA9zaWmkIHAET
        ahFv6nMirNlzUR6BbyaRKQ/BhJNZ+wYjlnQtJTt5aEDroonEcJ0y/K7PzmuJFerA
        Fv8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691694925; x=1691781325; bh=cDRJ70tlUw1f5
        vvydGZnly44JvjoIjvlKIEtTxRqzOA=; b=mcGZj3izxVPRaqh0Ac5Zt1zo1A3p7
        DFYh+1Td5wiN5QF/FcBRZxpITogPc+djwFaQmwPS0liywPzGo3wu7Gip5n9apMt/
        WbgAAs6S61KHm+NUzJB4eSfsik1As8ldtUrI/RzE3Qcu6+VaSiuhCCMZ7ndh3f57
        Z06R6SZCk2+VA9V4wvCWOjA2h1x0BQ+XWyc8vHXUvXtMMRMXmMNbv0RrmGoDn7+A
        RE5PzFtRGKFebpUvYAzX1l9Hmb/Sf6f/8OrhAGxwZ+K/gfuxkFspqSqiMjhFK8Ih
        BVVN60rtfYCdMRErxAjk+/6PR5jX+Cy5sJmRfIoHV3gSt3szZfxf8h3lg==
In-Reply-To: <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Deller <deller@gmx.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, 

On Thu, Aug 10, 2023, at 17:59, Helge Deller wrote:
> On 8/10/23 17:21, Arnd Bergmann wrote:
>> On Thu, Aug 10, 2023, at 16:59, Christophe Leroy wrote:
>>
>> I did send other fixes for microblaze and parisc specific drivers,
>> and I could also send patches for the two defconfig warnings if
>> the maintainers are happy with fixing those but leaving allmodconfig
>> to still warn, but I feel that it's easier for them to just
>> do the last fixes themselves and then remove my hack again.
>>
>> I'll wait for Michal and Helge on these.
>
> Arnd, I like your patch!
> For parisc I've done quite some work during the last few weeks to
> get such warnings sqeezed out, so please drop the hunk for parisc from
> your patch. My plan is to become warning-free before 6.5-final.
>
> This last one:
>      arch/parisc/lib/ucmpdi2.c:12:5: error: no previous prototype for 
> '__ucmpdi2' [-Werror=missing-prototypes]
> I'll take care in the parisc for-next tree.

Sounds good to me, thanks!

     Arnd
