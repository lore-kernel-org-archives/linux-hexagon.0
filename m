From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
Date: Fri, 23 Jul 2021 14:44:13 +0200
Message-ID: <CAK8P3a0VDtatPx93FAa4ZUszZbcHPyX+aQWnZ2aTuL-dHZ_x5A@mail.gmail.com>
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-10-arnd@kernel.org>
 <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
 <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com> <YPnQAksI2+YBivHb@osiris>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627044271;
        bh=I8EG8KvdkCZRoKrlaYWdZuQlSurV1+XMVadCAjX5YV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nVxmkMHvcnPo9v2E4P0wQkD5Ik+U5FdrwPKUZdVAwInoplBd5SiBtgDftaE8WbUSd
         BzDFLWC46eIel1r1PDWlUs6Aa7qRa4QBxa4elUzKQ+IZiE/8G95d/2F9hgXMYEZdbj
         sMg3Wb+lKhTRCHN7stY+1Hm1oedJnMmb/UTzIC/Vk8Wp7DpG0reeVfShYalWOAASME
         GM9qN4Fvf0xu0543uk/BuTpand2x7kIefBwqsjbqNcc4Yj9KqV03mrOAWGUpjW9/0z
         6728tFNaWvzzzLYtTMR2BbywvcxIJp5tfi5cQRx10e2gbHJ+GgD00wTQ9Gtzrcn5RS
         PPsrAmO3PGAhw==
In-Reply-To: <YPnQAksI2+YBivHb@osiris>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys>

On Thu, Jul 22, 2021 at 10:07 PM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Feel free to add the s390 patch below on top of your series.

Thanks a lot, added now.

> However one question: the strncpy_from_user() prototype now comes everywhere
> without the __must_check attribute. Is there any reason for that?
>
> At least for s390 I want to keep that.

Makes sense, I'll add a patch for that as well.

        Arnd
