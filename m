From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
Date: Fri, 10 Jun 2022 18:32:36 +0200
Message-ID: <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhv02q67MOioDvIeN4y+a/ybeIh94RUFpBdk0EW721Q=;
        b=gTSqAdTJjftykkKV3LvI3BgIEdnFPO1tIX2Ja3yrYtQNH7qkYO5md+ofkXUFp0r5AW
         G6gcWOkM0lg+gYk1xVlJLK69IVjiD2uEY/paaLVpsJSAUJr3ix3CnTM3jTjnVHIGrITZ
         8qOTeStSyYFo4Xt1uIWq/JcAZJafn7HdU8yhoSTqaMMSwSE/odkOqaPLeyUKWL5sO4fY
         YvCEOzFgGYsioj0kFMpYKr9Y6KDxyzq/x30hfjgDctRhz4XpICUW+ZTe11KlQpTSKF0Q
         MmwpTmp6Vj4zz6mr/A1YZvGF2iMEYWObj9GWEHshf9njpmcmcbzr60kAblJRSOIE1DnE
         +7SA==
In-Reply-To: <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Lobakin, Alexandr" <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia6>

On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
>
> > > +/**
> > > + * generic_test_bit - Determine whether a bit is set
> > > + * @nr: bit number to test
> > > + * @addr: Address to start counting from
> > > + */
> >
> > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > is actually atomic and must be kept as a such?
>
> "atomic" isn't really the right word. The volatile access makes sure that the
> compiler does the test at the point that the source code asked, and doesn't
> move it before/after other operations.

It's listed in Documentation/atomic_bitops.txt.

It is as "atomic" as READ_ONCE() or atomic_read() is. Though you are
right that the "atomicity" of reading one bit is almost a given,
because we can't really read half a bit.
The main thing is that the compiler keeps it "atomic" and e.g. doesn't
fuse the load with another or elide it completely, and then transforms
the code in concurrency-unfriendly ways.

Like READ_ONCE() and friends, test_bit(), unlike non-atomic bitops,
may also be used to dependency-order some subsequent marked (viz.
atomic) operations.

> But there is no such thing as an atomic test_bit() operation:
>
>         if (test_bit(5, addr)) {
>                 /* some other CPU nukes bit 5 */
>
>                 /* I know it was set when I looked, but now, could be anything */

The operation itself is atomic, because reading half a bit is
impossible. Whether or not that bit is modified concurrently is a
different problem.

Thanks,
-- Marco
