From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on compile-time constants
Date: Thu, 30 Jun 2022 18:56:11 +0200
Message-ID: <20220630165611.1551808-1-alexandr.lobakin@intel.com>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656608229; x=1688144229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bL9nkQHpWXRcPQiclQNvTJObFea+2bIOo5Icywa3vMA=;
  b=fmrnj/6XuSpY1hnOWZabHa7oDtPIZ/7Bh+RzopLp14OHknBAX57nHps+
   hL5jBriVpX/QkW93R0zu0Im+Scz9SCMknY/iOCVSHSS2S8n+mKecZgyHQ
   Bj7eBMp9wg9++qnorxgkRFae5QI68Ufol1Zw3FVTWM9ltXapLCo//Tj26
   9Kxt8LZ2qLG3s4QZZ6QJUPHIBI+jiJrwD8thm/mMC7PGeyX+J3CV/8SMn
   PUlmia2grWt0+sj7f7hIdMOsNypeNBNyPtP/nF2FJrYVf6/8tUDwXrhTm
   a/SMH+lmmn9h8jAOslm763iFDv28yTpVnQqU9eUHwUpe3DyX9d9HKP6LI
   Q==;
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri, 24 Jun 2022 14:13:04 +0200

> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:

Hey,

Seems like everything is fine this time. I got some reports, but
those aren't caused by any of the changes from the series.
Maybe we can take it to -next and see how it goes?

[...]

>  arch/alpha/include/asm/bitops.h               |  32 ++--
>  arch/hexagon/include/asm/bitops.h             |  24 ++-
>  arch/ia64/include/asm/bitops.h                |  42 ++---
>  arch/ia64/include/asm/processor.h             |   2 +-
>  arch/m68k/include/asm/bitops.h                |  49 ++++--
>  arch/s390/include/asm/bitops.h                |  61 +++----
>  arch/sh/include/asm/bitops-op32.h             |  34 ++--
>  arch/sparc/include/asm/bitops_32.h            |  18 +-
>  arch/sparc/lib/atomic32.c                     |  12 +-
>  arch/x86/include/asm/bitops.h                 |  22 +--
>  drivers/net/ethernet/intel/ice/ice_switch.c   |   2 +-
>  .../asm-generic/bitops/generic-non-atomic.h   | 161 ++++++++++++++++++
>  .../bitops/instrumented-non-atomic.h          |  35 ++--
>  include/asm-generic/bitops/non-atomic.h       | 121 +------------
>  .../bitops/non-instrumented-non-atomic.h      |  16 ++
>  include/linux/bitmap.h                        |  22 ++-
>  include/linux/bitops.h                        |  50 ++++++
>  lib/test_bitmap.c                             |  62 +++++++
>  tools/include/asm-generic/bitops/non-atomic.h |  34 ++--
>  tools/include/linux/bitops.h                  |  16 ++
>  20 files changed, 544 insertions(+), 271 deletions(-)
>  create mode 100644 include/asm-generic/bitops/generic-non-atomic.h
>  create mode 100644 include/asm-generic/bitops/non-instrumented-non-atomic.h
> 
> -- 
> 2.36.1

Thanks,
Olek
