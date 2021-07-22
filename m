From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
Date: Thu, 22 Jul 2021 15:57:56 +0200
Message-ID: <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
References: <20210722124814.778059-1-arnd@kernel.org>
         <20210722124814.778059-10-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NNcV9llPrdlEYkKe7+LBF3xFYLJpZdKYVGYe+A5Q+4I=;
        t=1626962351; x=1628171951; b=S42X4+0j590vY4yyWmE9Z6M2vfPMqU6ZVMC2NpDqG24s75X
        p0VZ8+yPU7I8uMB2QbDCZIQ7OJA8yoYCNeFdQ5UqXC/Idybgz5gps27YZ+QR3rh+AMb1OWtUbbZQm
        2ssk/Dr1IEv1rXw45C4ldEf+xi0ArjFqXXHtP9O1VtD32/0BbUZzOwRxxPBwQxOCzBnlNDCypoDZv
        9x0cWOUr/h0K/snr4No81FkSnb+J5iULPldNGBxi8glSLKV6+9yYyASglCaRxtYXNoa0fYMTjenpS
        JIUvnJ/0MIX77P07mRDjzRwlrE6v/Zn86xf+2RgfyG+F3i5gjtghrRspjZ3Pk4Cg==;
In-Reply-To: <20210722124814.778059-10-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Yoshinori Sato <ysato@users.sourceforge.j>

> 
> The remaining architectures at the moment are: ia64, mips, parisc,
> s390, um and xtensa. We should probably convert these as well, but

I'm not sure it makes sense to convert um, the implementation uses
strncpy(), and that should use the libc implementation, which is tuned
for the actual hardware that the binary is running on, so performance
wise that might be better.

OTOH, maybe this is all in the noise given the huge syscall overhead in
um, so maybe unifying it would make more sense.

johannes

