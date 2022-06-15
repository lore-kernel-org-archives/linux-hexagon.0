From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic
 bitops
Date: Tue, 14 Jun 2022 19:47:42 -0700
Message-ID: <YqlITqttNYqT/xpN@yury-laptop>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com>
 <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com>
 <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com>
 <CANpmjNM0noP8ieQztyEvijz+MG-cDxxmfwaX_QTpnyT5G33EGA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NX493qPAQUrj6ioWF1jnmkJZEbKs1Z+Hiz8Q7SOMdJc=;
        b=CQVSPpZxgQLRrldrZt26nPVIEXM4/7qMFk8dKvjGgw1iaCmkhmgf1FIsFOFPyzgx3h
         l2NsM46f9Tx+tDhapROO0VMF+f+h40YS5jDFP9l34So1j75zs3sLOKDE9NgOvg22zaHn
         peDbKBfc+40NOpLm/mO2mNmi35eK3vL6W2o6IelRysxNBAIQcBAD5CrwS04wLzffuxAh
         iAHKel08mQgQSIKMxN23DwfIU13+AODm07ZdW3ZRh5dnOR/yImnaPEOqnLbm5KL7idlW
         ujWAV+QC7WAS7fvST9mMbnasGN30MJj5SoLVyExKJOUuJQPRd4dr7KJ/ycf9G2jhyTny
         5Dzw==
Content-Disposition: inline
In-Reply-To: <CANpmjNM0noP8ieQztyEvijz+MG-cDxxmfwaX_QTpnyT5G33EGA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marco Elver <elver@google.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Tony Luck <tony.luck@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vg>

On Mon, Jun 13, 2022 at 04:33:17PM +0200, Marco Elver wrote:
> On Mon, 13 Jun 2022 at 16:21, Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> >
> > From: Marco Elver <elver@google.com>
> > Date: Fri, 10 Jun 2022 18:32:36 +0200
> >
> > > On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
> > > >
> > > > > > +/**
> > > > > > + * generic_test_bit - Determine whether a bit is set
> > > > > > + * @nr: bit number to test
> > > > > > + * @addr: Address to start counting from
> > > > > > + */
> > > > >
> > > > > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > > > > is actually atomic and must be kept as a such?
> > > >
> > > > "atomic" isn't really the right word. The volatile access makes sure that the
> > > > compiler does the test at the point that the source code asked, and doesn't
> > > > move it before/after other operations.
> > >
> > > It's listed in Documentation/atomic_bitops.txt.
> >
> > Oh, so my memory was actually correct that I saw it in the docs
> > somewhere.
> > WDYT, should I mention this here in the code (block comment) as well
> > that it's atomic and must not lose `volatile` as Andy suggested or
> > it's sufficient to have it in the docs (+ it's not underscored)?
> 
> Perhaps a quick comment in the code (not kerneldoc above) will be
> sufficient, with reference to Documentation/atomic_bitops.txt.

If it may help, we can do:

/*
 * Bit testing is a naturally atomic operation because bit is 
 * a minimal quantum of information.
 */
#define __test_bit test_bit

