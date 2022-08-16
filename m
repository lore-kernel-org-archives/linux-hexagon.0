From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v3] regmap: mmio: Support accelerared noinc operations
Date: Tue, 16 Aug 2022 22:50:29 +0200
Message-ID: <CACRpkdbHvQm-_X4cpRRfeRSNUpTQbeyyQpBPD6TfeomY0nzSsg@mail.gmail.com>
References: <20220816130823.97903-2-linus.walleij@linaro.org> <202208170316.UKonQfhi-lkp@intel.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RO5o1zeDBrbGGgJvigCNf9N1FTIpLD7LsdR8FYAUFCA=;
        b=mbX6DctOgYFtFo87NIsVH6sCTW5XCGD7g/WUQ50Jx9DEGnIygGgzlyAhWZDWVsI6M8
         smAAFtMa3exakMnltpq8T7dxRMzBG2pwz9164F9LalzD4IbgieCepjXRrXPhfWWoae4z
         o+G4TZzVamOcu9v9ovcbWbd/AV7nQbuKQHsRBqo/GFzMEdPG2pgfbrRdaf22EdH2ZQ/9
         1vrjYAjg+18lO17dFBMcUc20I9huOs5sk0CdN4zjoLOQ0l57P5ylIX3coxFr6Ijfkr/m
         UQfCsdy1IGBqrnqLjeG/ybPyxTV0Wt4XpJV5NijX32crbQJN54oIv1EmOvsngHXl9U+T
         pDNQ==
In-Reply-To: <202208170316.UKonQfhi-lkp@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel test robot <lkp@intel.com>
Cc: Mark Brown <broonie@kernel.org>, llvm@lists.linux.dev, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, Aug 16, 2022 at 9:45 PM kernel test robot <lkp@intel.com> wrote:

> >> drivers/base/regmap/regmap-mmio.c:212:3: error: call to undeclared function 'writesb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    writesb(ctx->regs + reg, (const u8 *)val, val_count);
>                    ^
>    drivers/base/regmap/regmap-mmio.c:212:3: note: did you mean 'writeb'?
>    arch/hexagon/include/asm/io.h:122:20: note: 'writeb' declared here
>    static inline void writeb(u8 data, volatile void __iomem *addr)
>                       ^
> >> drivers/base/regmap/regmap-mmio.c:366:3: error: call to undeclared function 'readsb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    readsb(ctx->regs + reg, (u8 *)val, val_count);
>                    ^
>    drivers/base/regmap/regmap-mmio.c:366:3: note: did you mean 'readb'?
>    arch/hexagon/include/asm/io.h:83:18: note: 'readb' declared here
>    static inline u8 readb(const volatile void __iomem *addr)
>                     ^
>    2 errors generated.

Yeah Hexagon breaks the <asm/io.h> contract and does not provide
readsb/writesb.

OK I just fix Hexagon as part of patch 2, I hope.

Yours,
Linus Walleij
