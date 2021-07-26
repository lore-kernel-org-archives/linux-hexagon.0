From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse
 GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
Date: Mon, 26 Jul 2021 10:55:17 +0200
Message-ID: <b89d9932-7498-edd2-0369-227ce17bcba6@gmx.de>
References: <20210722124814.778059-1-arnd@kernel.org>
 <20210722124814.778059-10-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627289727;
        bh=WkWs2yjbuB7rMLWgvsxBc4/Z976NwWWIEDiSOgTN55I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=E7jOP/dwH1+3UHoNaSbTx2XDQRxAN5F8L7jEpZmRIgESVf9ne0KM7xfW0ObhH8vkT
         ABXz8dsUiPiO1dwu3MUYUkMNesxVe0Yk5ji3YVzpNZGn/BfZ3uPtXbOes3Ed2hx1cN
         YAlh6MXWhHfFt0OlfJQAeFIRfElfQswmhjdssuBY=
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-csky@vger.ke

On 7/22/21 2:48 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Most architectures do not need a custom implementation, and in most
> cases the generic implementation is preferred, so change the polariy
> on these Kconfig symbols to require architectures to select them when
> they provide their own version.
>
> The new name is CONFIG_ARCH_HAS_{STRNCPY_FROM,STRNLEN}_USER.
>
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but
> I was not sure how far to take this series.

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge
