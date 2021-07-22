From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v3 9/9] asm-generic: reverse GENERIC_{STRNCPY_FROM,
 STRNLEN}_USER symbols
Date: Thu, 22 Jul 2021 16:01:39 +0200
Message-ID: <CAK8P3a0xZAHknG8_kc62aaKrKdzD-QwQYHT61_wTbFDYADu-zw@mail.gmail.com>
References: <20210722124814.778059-1-arnd@kernel.org> <20210722124814.778059-10-arnd@kernel.org>
 <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626962518;
        bh=RmFOlaV6cy8f6I9NP3ukwHIYeNH7OwEP2FaF3KMVtFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAJNHnFo1L7vDVOiC5UpRkaDx4pid4TNdNlKZLrXeCR+FFSWM3S5SOfKHU3NBCcgi
         x/mbKRZuCP5sBZWLRH0QyC3jTezIcTdgPNuJkn722HgIPBdCNBSTL40ELD6XBnTs/y
         1ZjVc7/Oq6j6jnQceie9Da0nul67XzXgLTZj2GmS3GDKLgwa7unHRN+n/B9s9iygfR
         gHGpjMzt0PFMYc3FrdBQF57NRhZXStlwHBGM47znuAnJK24bV4xEdnVgYTuM2O9Q9l
         cPPu7vcO0sT3ruel4hr978oxdF6OQbMo96r5w0ZtG5V3ocVCUbJ85hWT9lKdyIIY8o
         uhvj1YnfZDenA==
In-Reply-To: <29adc1c164805e355b37d1d4668ebda9fb7fa872.camel@sipsolutions.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Brian Cain <bcain@codeaurora.org>, Chris Zankel <chris@zankel.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>

On Thu, Jul 22, 2021 at 3:57 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> >
> > The remaining architectures at the moment are: ia64, mips, parisc,
> > s390, um and xtensa. We should probably convert these as well, but
>
> I'm not sure it makes sense to convert um, the implementation uses
> strncpy(), and that should use the libc implementation, which is tuned
> for the actual hardware that the binary is running on, so performance
> wise that might be better.
>
> OTOH, maybe this is all in the noise given the huge syscall overhead in
> um, so maybe unifying it would make more sense.

Right, makes sense. I suppose if we end up converting mips and s390,
we should just do arch/um and the others as well for consistency, even
if that adds some overhead.

      Arnd
