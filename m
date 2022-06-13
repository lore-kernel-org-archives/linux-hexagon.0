From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
Date: Mon, 13 Jun 2022 16:19:47 +0200
Message-ID: <20220613141947.1176100-1-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com> <22042c14bc6a437d9c6b235fbfa32c8a@intel.com> <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655130093; x=1686666093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRJcWACmO/lwAN79tjxhatvQLKzpV/YPdBZo5g5JtF4=;
  b=Ilxw8Xw2W7MusTNqmJ+s0Uz+bLzQzZ3jhilka9H0oN4yHst6U+MfWoKB
   ywRhtSZMzgu7n/E8qH3qsXUF+snSIOalZY/VcEirFrW+tWov2qD73wnsX
   TOcmB6fK/mcFh4BIsfi1o3FtWgVt/OTiJHpVXK7FQuYb2GjC0ouv0hbvU
   ot/V/fz2M7Q5yefBLLZt98Zd6j1oNKEa/6eMpnYEnnRDXYu7Ix2X6KxGj
   tEizP98o3RZI/R+MM1vCv5pZCzggcGKz6X0xZYEp4TxQgrEqCRss6OCrn
   pxmnEeDpO0ygQDFtbBqgCoUMtWaA8ZmjpShIOnsdKAZslBVdI1LtAZGxA
   A==;
In-Reply-To: <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Tony Luck <tony.luck@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

From: Marco Elver <elver@google.com>
Date: Fri, 10 Jun 2022 18:32:36 +0200

> On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > > +/**
> > > > + * generic_test_bit - Determine whether a bit is set
> > > > + * @nr: bit number to test
> > > > + * @addr: Address to start counting from
> > > > + */
> > >
> > > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > > is actually atomic and must be kept as a such?
> >
> > "atomic" isn't really the right word. The volatile access makes sure that the
> > compiler does the test at the point that the source code asked, and doesn't
> > move it before/after other operations.
> 
> It's listed in Documentation/atomic_bitops.txt.

Oh, so my memory was actually correct that I saw it in the docs
somewhere.
WDYT, should I mention this here in the code (block comment) as well
that it's atomic and must not lose `volatile` as Andy suggested or
it's sufficient to have it in the docs (+ it's not underscored)?

> 
> It is as "atomic" as READ_ONCE() or atomic_read() is. Though you are
> right that the "atomicity" of reading one bit is almost a given,
> because we can't really read half a bit.
> The main thing is that the compiler keeps it "atomic" and e.g. doesn't
> fuse the load with another or elide it completely, and then transforms
> the code in concurrency-unfriendly ways.
> 
> Like READ_ONCE() and friends, test_bit(), unlike non-atomic bitops,
> may also be used to dependency-order some subsequent marked (viz.
> atomic) operations.
> 
> > But there is no such thing as an atomic test_bit() operation:
> >
> >         if (test_bit(5, addr)) {
> >                 /* some other CPU nukes bit 5 */
> >
> >                 /* I know it was set when I looked, but now, could be anything */
> 
> The operation itself is atomic, because reading half a bit is
> impossible. Whether or not that bit is modified concurrently is a
> different problem.
> 
> Thanks,
> -- Marco

Thanks,
Olek
