From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v5] regmap: mmio: Support accelerared noinc operations
Date: Wed, 31 Aug 2022 16:07:28 +0200
Message-ID: <CACRpkdbn_v7g4=2+jGwxTr2z4ZLcFFfRF4F0oohn0VOf4uJ1SQ@mail.gmail.com>
References: <20220816204832.265837-1-linus.walleij@linaro.org>
 <20220816204832.265837-2-linus.walleij@linaro.org> <Yw48R+EBmmZYl9x+@smile.fi.intel.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SSE1HwMVcYk2UrtKirDe64NX+1tKMWo/CAq8zQgdjxY=;
        b=gVt3VwChWCb8oP15iESWk4rihn+xtdYj1oXd5L8WISu2a1tF4jK3rEuTB7v9ySbeog
         HgcdJ1f+K8DTlgJ45wz9Yo1+MlalUv+zlqhEy5mgfpIA6bMQqaPk2nRdWvCEbni6lIwt
         nzN58amEGfpMhHYEiXwoP3RRtQilGWuNomP+6GnHaKnuU0iQLCWZoHrkM8X9M1DYXRke
         /br92uXTzcm9iBSqpq68jxDQEuKBoyZYWx1crpHuRjl8j2TLqNE2MbVn3YJ+n4++T2O1
         u4lRk4oN4pbjkDr/IyR2KbhhPxgEhDtKDnWX50xV8asGD2qN7rEel/E9C529YsVbIxN7
         /RmA==
In-Reply-To: <Yw48R+EBmmZYl9x+@smile.fi.intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-alpha <linux-alpha@vger.kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On Tue, Aug 30, 2022 at 6:39 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Tue, Aug 16, 2022 at 10:48:32PM +0200, Linus Walleij wrote:
> > Use the newly added callback for accelerated noinc MMIO
> > to provide writesb, writesw, writesl, writesq, readsb, readsw,
> > readsl and readsq.
> >
> > A special quirk is needed to deal with big endian regmaps: there
> > are no accelerated operations defined for big endian, so fall
> > back to calling the big endian operations itereatively for this
> > case.
> >
> > The Hexagon architecture turns out to have an incomplete
> > <asm/io.h>: writesb() is not implemented. Fix this by doing
> > what other architectures do: include <asm-generic/io.h> into
> > the <asm/io.h> file.
>
> Wonderful!
>
> So, I have seen a recent blow up by kernel bot due to Alpha issues on these
> accessors.

There is a patch for that:
https://lore.kernel.org/linux-arch/20220818092059.103884-1-linus.walleij@linaro.org/

Alpha maintainance is not very active.

The problem is that some (fringe) architectures do not fulfil the contract
to provide full accessors. I can fix them all, I am fixing powerpc right now,
but the breakage is just random compile tests, they don't really use
regmap-mmio, we're just enabling regmap-mmio to compile on archs
that don't ever use it, so it's not urgent.

> > +     if (!IS_ERR(ctx->clk)) {
> > +             ret = clk_enable(ctx->clk);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
>
> It's a new place of the duplicating check, can we have a helper for that?
>
> ...
>
> > +     /*
> > +      * There are no native, assembly-optimized write single register
> > +      * operations for big endian, so fall back to emulation if this
> > +      * is needed. (Single bytes are fine, they are not affected by
> > +      * endianness.)
> > +      */
>
> Wouldn't be faster to memdup() / swap / use corresponding IO accessor?

Hm I would like a real BE target to test on and profile that.
If someone has a target I can make a patch.

> > +     /*
> > +      * There are no native, assembly-optimized write single register
> > +      * operations for big endian, so fall back to emulation if this
> > +      * is needed. (Single bytes are fine, they are not affected by
> > +      * endianness.)
> > +      */
> > +     if (ctx->big_endian && (ctx->val_bytes > 1)) {
> > +             switch (ctx->val_bytes) {
> > +             case 2:
> > +             {
> > +                     u16 *valp = (u16 *)val;
> > +                     for (i = 0; i < val_count; i++)
> > +                             valp[i] = swab16(valp[i]);
> > +                     break;
> > +             }
> > +             case 4:
> > +             {
> > +                     u32 *valp = (u32 *)val;
> > +                     for (i = 0; i < val_count; i++)
> > +                             valp[i] = swab32(valp[i]);
> > +                     break;
> > +             }
> > +#ifdef CONFIG_64BIT
> > +             case 8:
> > +             {
> > +                     u64 *valp = (u64 *)val;
> > +                     for (i = 0; i < val_count; i++)
> > +                             valp[i] = swab64(valp[i]);
> > +                     break;
> > +             }
> > +#endif
> > +             default:
> > +                     ret = -EINVAL;
> > +                     break;
> > +             }
> > +     }
>
> So, two questions here:
>
> 1) can we use helpers from include/linux/byteorder/generic.h, such as
>    cpu_to_be32_array()/be32_to_cpu_array()?
>
> 2) have you considered using memcpy_toio() / memcpy_fromio() and why
>    it's not okay to use them?

I got scared of all of these accessors because of
commit 7e7ba58c94127efa97c249e38cc2d1c0ed78b58f
"regmap: mmio: Fix MMIO accessors to avoid talking to IO port"
so I don't know if I dare to trust them. Therefore I opted for the
simplest thing that I could write that fulfils the requirement.

Again, if someone has a BE target to test on, I can write a patch!

> > +out_clk:
> > +     if (!IS_ERR(ctx->clk))
> > +             clk_disable(ctx->clk);
> > +
> > +     return ret;
> > +
> > +     return 0;
>
> Seems like misrebase? I believe this has to be fixed.

Ooops I fix. Also the double newline.

Yours,
Linus Walleij
