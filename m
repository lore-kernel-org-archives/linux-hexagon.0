From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
Date: Wed, 16 Feb 2022 23:02:45 +0100
Message-ID: <CAK8P3a2gx2w=RDECNbrO4Zu3ZUTfz2UrLbNSz+ieCgMEFiK3TA@mail.gmail.com>
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-19-arnd@kernel.org>
 <Yg1F/VT4vRX4aHEt@ravnborg.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645048982;
        bh=ay/5589FenTcDxawo4c9r5D5w/FgYtE3zMvoHKiKBw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mp2N4j25K83NMCfLyY4s4Fvr/02r2is80WsbciAWUvDE4/m4hXq9EgLORcancLhbT
         umY9FHnexAjN//UsA7q/C9fckLYXF0oQ8KHvfjTR59rKGClK+gPz3WGNFPqYUuSPAl
         tKqmRElhXMvcu84IyYLNk1Jx9OrqFY1VeIjfZrMgYnNZnH7Q43IubRg0WPfzhGBBBX
         /OdSxH8IZ7Kz0nHhQxDWelZPRHLPHQFw8aTJU8Fd/gQNcc2Tz29BgNtd0/VTT0Eadn
         af5BPEGJl881/LlmZF1PoTMkEDGEvxPy+W0AvrAYWFrqce134uQiJLaLzOGaZJOGGy
         d7XYuXjZgGD6w==
In-Reply-To: <Yg1F/VT4vRX4aHEt@ravnborg.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Russell King - ARM Linux <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>

On Wed, Feb 16, 2022 at 7:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Arnd,
>
> Fix spelling in $subject...

done

> sparc/Kconfig b/arch/sparc/Kconfig
> > index 9f6f9bce5292..9276f321b3e3 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -46,7 +46,6 @@ config SPARC
> >       select LOCKDEP_SMALL if LOCKDEP
> >       select NEED_DMA_MAP_STATE
> >       select NEED_SG_DMA_LENGTH
> > -     select SET_FS
> >       select TRACE_IRQFLAGS_SUPPORT
> >
> >  config SPARC32
> > @@ -101,6 +100,7 @@ config SPARC64
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select SET_FS
> This looks wrong - looks like some merge went wrong here.

Fixed now.

>
> Other than the above the sparc32 changes looks fine, and with the Kconf
> stuff fixed:
> Acked-by: Sam Ravnborg <sam@ravnborg.org> # for sparc32 changes

Thanks!

      Arnd
