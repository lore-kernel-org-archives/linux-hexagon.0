From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Date: Fri, 24 Jun 2022 14:51:15 +0200
Message-ID: <YrWzQ6GleophO75b@zn.tnic>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656075079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ufyLq98aM5sPCb/A9DZ82OxnbOu+snINKekaV1aDRU=;
        b=z/SG5u8nE+UvZJM1KMXfsdsJS4gFo9gKNUD1jqnZCEfQktOpJL+HUho2xWseFYUUxljXxm
        4Vbo35uQa3H7cCMHdFOtFc7bAQUGtQsQgAEW5RP+6bwSdbrCaZOzz/8N0BYLpyE6Dp73T/
        bEaYS6aVjoMfSGXUcWCoGG+0KRxQxvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656075079;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ufyLq98aM5sPCb/A9DZ82OxnbOu+snINKekaV1aDRU=;
        b=cITdCFre6nFiuMrbQP1LlPRDxLJEO+oY2+mpe4FddCjNeDzFUXzaMlRw1mDzLIdh6rfNdW
        DQtygG0C3l0HHwAw==
Content-Disposition: inline
In-Reply-To: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Fri, Jun 24, 2022 at 02:13:04PM +0200, Alexander Lobakin wrote:
> While I was working on converting some structure fields from a fixed

Can you please send your patchset once a week instead of spamming people
with it every three days?

Thank you.

--=20
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG N=C3=BCrnberg)
