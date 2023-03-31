From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 17/21] ARM: dma-mapping: use arch_sync_dma_for_{device,cpu}()
 internally
Date: Fri, 31 Mar 2023 11:10:44 +0200
Message-ID: <CACRpkdZdnTX4-jnnXZveXxwOg76yH4Zyoa-ZSGeC7KzOnn+6Lg@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-18-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680253856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5CSdrZ6l2xgXTKH1xLlq+jBgcd46ofV0BIoXJ6/6jM=;
        b=NHiE7PIU/1phremrSsF3/CQl6d7YKEdlDtlJ9Vwel53T7D2fDOz9Eopk4FcpZ1dSIm
         yu9e8Xh0JHbk1x3sJ/r5+kRcRDuV43DeZbQfu0w/kMYchm+WG+IUDHf/BC224Jw6v7Hy
         BSChRpraLXKpD4dnyCnfqBFCzvRsPoxHhXE18GrmUrPhY5zXpmqt7RX+zSjGr8+FpZWf
         ToQfnMbBgbPLRwCOIxrk4oSI0MRhYms+6xQVhERPGNAPOHshN0F5ZLgiT7jrBiYwUPBP
         vXOpSg0fjuin5LV315t/YgapeHNpqFNhTohezab0YMYOQMGNlql4NMgvD7BZ1XLyiAEG
         j5lA==
In-Reply-To: <20230327121317.4081816-18-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John

On Mon, Mar 27, 2023 at 2:16=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The arm specific iommu code in dma-mapping.c uses the page+offset based
> __dma_page_cpu_to_dev()/__dma_page_dev_to_cpu() helpers in place of the
> phys_addr_t based arch_sync_dma_for_device()/arch_sync_dma_for_cpu()
> wrappers around the.

Broken sentence?

> In order to be able to move the latter part set of functions into
> common code, change the iommu implementation to use them directly
> and remove the internal ones as a separate interface.
>
> As page+offset and phys_address are equivalent, but are used in
> different parts of the code here, this allows removing some of
> the conversion but adds them elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, took me some time to verify and understand
the open-coded version of PFN_UP() and this refactoring alone
makes the patch highly valuable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
