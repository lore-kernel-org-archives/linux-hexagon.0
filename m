From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v4 0/8] bitops: let optimize out non-atomic bitops on compile-time constants
Date: Wed, 22 Jun 2022 14:24:40 +0200
Message-ID: <20220622122440.87087-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655900700; x=1687436700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nRwykYNWJOMVjV6KXtUwB8jzGM4hq74AzeD0f7K2mG8=;
  b=oA4zzjp38HoavGgm25b3i5YBxG5ycm5OwmmkeqlAIAfAosMhtMhw+C88
   nD39BBEJ8P4v06p/wPJlHvVipcVYhVhpPlLtBbwIL0OqLjvs6+nbEzOj9
   clrf9HCk/2zZepmtkxkDQmyV3eJGaQS4Kv3nu0SiopBEVtY5Xg7GNX9e1
   RSOv/aVaeeq0OjjYI2lr6TpRNu+y7P3wOkJzRggPLxLMuDLNkAPBjELTZ
   5RueQINTxsbsdEw/Uued6PvM1+Lij2X3dRmK8hjp28xgxkoQb7UBd3Dkj
   FSF/ayGdwVJHemUmznwW7oM5m4iXMY69updWPv7ryRhoc3xd13q3fZ9VF
   g==;
In-Reply-To: <20220621191553.69455-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 21 Jun 2022 21:15:45 +0200

> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:

[...]

Oh gosh, now s390 failed and 7/8 revealed one existing code flaw in
the ice driver.
I'll fix those, then will try to test more platforms (to not spam
series again) and send v5 soon (mentioning this as bots CCs only
myself).

> -- 
> 2.36.1

Thanks,
Olek
