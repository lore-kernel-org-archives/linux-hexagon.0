From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v2 0/6] bitops: let optimize out non-atomic bitops on compile-time constants
Date: Wed, 15 Jun 2022 16:17:32 +0200
Message-ID: <20220615141732.1265627-1-alexandr.lobakin@intel.com>
References: <20220610113427.908751-1-alexandr.lobakin@intel.com> <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com> <20220613142645.1176423-1-alexandr.lobakin@intel.com> <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655302774; x=1686838774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y34PZ1MCfO2hOMDdvHaZPFb/IY8bQc2YzesGXP5aW7I=;
  b=A/oFOIEr34NCwX17DN63AvAkOvGSGISwyuYbqnrT4q5UJ8WiplXZN2yu
   SbtgglgRKSu8OIldwMfB0oZmlbgBbHQ0ksK/nNA1oUq8sirIzOV8Dq8Ji
   PtmhZZHzRJexQUgUUwkYu3QpKFcpRnO48SszAN1SJNJAhdNHMXQxH2czf
   5AV7g52+ulqSJ94o58TiGx51TuYmqo1JjyijCasgQoB32gQ6fP+oKipy7
   +9EN80FJQJRansLOVIR5HouAx7MoEJ6bRfty5MkoGyIPik95P0qHeskXf
   v4ZVjkAB6WdmLfcLueKtKxnw7OhX7dNevRNYbnSz+Mdv2MobxhGUeoD6W
   g==;
In-Reply-To: <CAMuHMdVayS6hV3CWW6FS-1cQKoGTCDxgVhZVPSyBMvJHBxVwJA@mail.gmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alpha <linux-alpha@vger.kernel.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <>

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2022 17:22:30 +0200

> Hi Olek,

Hi!

> 
> On Mon, Jun 13, 2022 at 4:28 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Fri, Jun 10, 2022 at 1:35 PM Alexander Lobakin
> > > <alexandr.lobakin@intel.com> wrote:
> > > On m68k, using gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04), this
> > > blows up immediately with:
> >
> > Yeah I saw the kernel bot report already, sorry for that >_< Fixed
> > in v3 already, will send in 1-2 days.
> 
> Is it simple to fix?
> I might be able to give the fixed v2 a try before that.
> Thanks!

Oh, sorry for the late reply, was busy with stuff.
It's linear, there are (after applying the series) some static
inlines in arch/m68k/include/asm/bitops.h (those which were
converted from macros in patch 3/6), 7 ops in total, you just need
to create definitions with 'arch_' prefix for each of them, e.g.

#define arch_test_bit	test_bit
#define arch___set_bit	__set_bit // will be ___set_bit after 5/6

etc.
Hope I explained it clear-ish :)

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Thanks,
Olek
