From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off conditionally
Date: Sat, 12 Aug 2023 10:02:07 +0200
Message-ID: <13f9c06a-f840-4010-ae2f-97d8b2883e76@app.fastmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org> <ZNaVYh2qi0VQQKWf@antec>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691827352; x=1691913752; bh=B7
        pOJdGFDOf/BCasjh0dVOxmA3Mm35lZV2aH6kqC0w8=; b=bWL46N0sK4mIYpWzoj
        J/+e+b8Mu9CpgyBLRhbmW/TyuCEnsAuKlS4X0lT5efId871OmOj5YcYmYg00NGPd
        IcAELxQotBSuJ/90jbsZktoCZaBeDjcMja4UE7PY/KJ9BQxHMR8ttw19gadY4pLD
        wcpu71/4NgDXLZF/K7TzADQEKciG8tdFwEV+hn9mwnLC982sMNooAap2Ahr2ic02
        OX1TDcc92+mLu+noqL+P1+HfjKrPOssbrzLOWiTlGBYyQ2X6xUoDe8FH5hLbs8Zs
        FmxsgM31F6ThFZX8SA1a+xBdVxbX9hhX71mg/b6+C5V15wIo2qBJ6zjh3xckiJob
        8oqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691827352; x=1691913752; bh=B7pOJdGFDOf/B
        Casjh0dVOxmA3Mm35lZV2aH6kqC0w8=; b=tJ1h5kA/J6E62tVerAQCZa0aQUiLa
        dZExElcAFIrHaz4IwM7Ow1ltkUruuCWsOJCyh1z7aQtGI+w5HaBlSmZ+g3sMPCda
        xubPC3utl1cj6/nHtnBh0zC5LTFR+KNkRg4EMhDLuERXDLZ4Aw4RkebGXJaIBZ2z
        wqa854o60Ce1tMXNWniimZ3W3nrC3twAjPDF+DoFqhA6k/7W4Q8yP6gpTqTX3H4D
        A1+7oickvOZ3pG8fapNcg2rld2K7G5tar0BTq01+PtwsrthFpU9JUN88b64SrWxE
        i+I6EhM3NmuwXev5m6HLAkhNfUxNiuURcXLhz5qvBlOtnzaNWe1YrJFpg==
In-Reply-To: <ZNaVYh2qi0VQQKWf@antec>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Lero

On Fri, Aug 11, 2023, at 22:09, Stafford Horne wrote:
> On Thu, Aug 10, 2023 at 04:19:34PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>

>> arch/openrisc/mm/fault.c:44:17: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
>> arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]
>
> I'll try to get these fixed for 6.6.  I was looking at them recently but did not
> actually make any changes and just put on my TODO.  Your series moves it up in
> priority and it should be easy to get the fixes out.

Thanks!

Since we already have the majority of architecture maintainers stepping
in to fix the warnings, I wonder if I should just drop my patch 16/17
completely and let the others handle it as well rather than shutting up
the warnings. Only the asm-offsets change is really needed to compile
test most of the kernel even with CONFIG_WERROR, and without that this
is just some harmless output.

    Arnd
