From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 3/9] bitops: unify non-atomic bitops prototypes across architectures
Date: Wed, 6 Jul 2022 12:09:33 +0200
Message-ID: <CAMuHMdWB8CjbOarttKSaY2=kASbqU2UBCe9bpU17=MdZP_rGUA@mail.gmail.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com> <20220624121313.2382500-4-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20220624121313.2382500-4-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <tri>

On Fri, Jun 24, 2022 at 2:13 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> Currently, there is a mess with the prototypes of the non-atomic
> bitops across the different architectures:
>
> ret     bool, int, unsigned long
> nr      int, long, unsigned int, unsigned long
> addr    volatile unsigned long *, volatile void *
>
> Thankfully, it doesn't provoke any bugs, but can sometimes make
> the compiler angry when it's not handy at all.
> Adjust all the prototypes to the following standard:
>
> ret     bool                            retval can be only 0 or 1
> nr      unsigned long                   native; signed makes no sense
> addr    volatile unsigned long *        bitmaps are arrays of ulongs
>
> Next, some architectures don't define 'arch_' versions as they don't
> support instrumentation, others do. To make sure there is always the
> same set of callables present and to ease any potential future
> changes, make them all follow the rule:
>  * architecture-specific files define only 'arch_' versions;
>  * non-prefixed versions can be defined only in asm-generic files;
> and place the non-prefixed definitions into a new file in
> asm-generic to be included by non-instrumented architectures.
>
> Finally, add some static assertions in order to prevent people from
> making a mess in this room again.
> I also used the %__always_inline attribute consistently, so that
> they always get resolved to the actual operations.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  arch/m68k/include/asm/bitops.h                | 49 ++++++++++-----

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert
