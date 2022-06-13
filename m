From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
Date: Mon, 13 Jun 2022 16:33:17 +0200
Message-ID: <CANpmjNM0noP8ieQztyEvijz+MG-cDxxmfwaX_QTpnyT5G33EGA@mail.gmail.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com> <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQCwIkwNzwt5T2z3wlATn5QZJXZyj8/g94B/Y2n7Ov8=;
        b=RsztUVvqZtKDuLU8Lf83jCg2FonaZq3j7tha/V+O/QezKPXwlEvSEPOQX3hz9T78C3
         3I6j6z1A/Cq6rSJmdFgt0oN6wG+e9xT+Ae9I57CN7NuNV7UAGESXGdpL/0qjMFr6J1AO
         j5S+6qJRX5emBJ2bfvZ0aKKWa1x9S44BcdWCp78aC5PfePta2erze8nysaY1ttyVO7kx
         fWJ7ZvaryKTY+6zAJ5UhVNSOJgi3zgc40qe+mrW1Ay0ECDOBytM0OUitt40J2PFHczlR
         Z86EN3athSadQP2xV0dv7LzAY+7OnBLrfmhcH8PuFvJX/KIQYWgquzO8svWkc7MbNA5h
         H1mQ==
In-Reply-To: <20220613141947.1176100-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>

On Mon, 13 Jun 2022 at 16:21, Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: Marco Elver <elver@google.com>
> Date: Fri, 10 Jun 2022 18:32:36 +0200
>
> > On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
> > >
> > > > > +/**
> > > > > + * generic_test_bit - Determine whether a bit is set
> > > > > + * @nr: bit number to test
> > > > > + * @addr: Address to start counting from
> > > > > + */
> > > >
> > > > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > > > is actually atomic and must be kept as a such?
> > >
> > > "atomic" isn't really the right word. The volatile access makes sure that the
> > > compiler does the test at the point that the source code asked, and doesn't
> > > move it before/after other operations.
> >
> > It's listed in Documentation/atomic_bitops.txt.
>
> Oh, so my memory was actually correct that I saw it in the docs
> somewhere.
> WDYT, should I mention this here in the code (block comment) as well
> that it's atomic and must not lose `volatile` as Andy suggested or
> it's sufficient to have it in the docs (+ it's not underscored)?

Perhaps a quick comment in the code (not kerneldoc above) will be
sufficient, with reference to Documentation/atomic_bitops.txt.
