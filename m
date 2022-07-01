From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Date: Thu, 30 Jun 2022 19:58:11 -0700
Message-ID: <Yr5iw9Ruj+LdlB+R@yury-laptop>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220630165611.1551808-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOvmRX5TfFX/UtEGzQDHuFSxkP0i5beuEIqtb7CEA/w=;
        b=WelpAaI3njYPrQSfHDzi8D3Dc8rtvD01QTHIWuSTBpUCspUSZA5CiPOn1FmsBxK2d1
         n+NvrQ429oVmXtDqyobXXKenmqQR1H4B2ygsgygEyJJsgDS7yFbtnMTx/Yat7tla7IGb
         f81YC5UvSkGSiC8iaxaum9eibqhYQJgbGxT2mCiuwPfUJl9ROYkck29M4SFGJ5LzsLJP
         VMJvj4NIDqtL/H8VtZGuM3kOpVqOTkedC07tTTX3LXleA88NKqFOJjONifGSPFrF1T5M
         MZBE+oi0zJaomy+MpwcjtkMzDFGUMj1gM3gdD0ksFZaravUlIe1wlA6yFdxpI1+5Wu8A
         05kw==
Content-Disposition: inline
In-Reply-To: <20220630165611.1551808-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Thu, Jun 30, 2022 at 06:56:11PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Fri, 24 Jun 2022 14:13:04 +0200
> 
> > While I was working on converting some structure fields from a fixed
> > type to a bitmap, I started observing code size increase not only in
> > places where the code works with the converted structure fields, but
> > also where the converted vars were on the stack. That said, the
> > following code:
> 
> Hey,
> 
> Seems like everything is fine this time. I got some reports, but
> those aren't caused by any of the changes from the series.
> Maybe we can take it to -next and see how it goes?

Applied on github.com:/norov/linux.git branch bitmap-for-next

Thanks!
