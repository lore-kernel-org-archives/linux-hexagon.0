From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 0/8] bitops: let optimize out non-atomic bitops on
 compile-time constants
Date: Wed, 22 Jun 2022 17:22:38 +0300
Message-ID: <YrMlrjbue7twWLk1@smile.fi.intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com>
 <20220622122440.87087-1-alexandr.lobakin@intel.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655907769; x=1687443769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FIomGT1BU8L+wKYhsbRgrEVpUz0TNAc9c/kXUa0n8fY=;
  b=hA3I3SAh3kYWGHf6tmliGGc4nVZH3XUQrGMS8LOQWSKJAp8e6kkMXaPR
   aSNgiNdOZ6yiYGvC8cTcEyDKZu1EmhB1EJF0NfjXCuL/PQF0/C2YnwGJ7
   XfY2GbrIvWq4o6eCxYzdfZtfqt6m7dCPPjNiEfU97hv8SoJ4sM/ZDrqc9
   x2JCGeNVSqj81dGj+2yEck+rabqiFsdvPy4gGlB/1O3O1mc+AYdrj2yHo
   gODyIdlCYCWo2C5FROq4Q1+JX5aYVGot3NDV0ZKA6gLhxlySL/yf5uMQY
   lq3Rhyl3xh/K6Hg9F/ZOTHBmjeGYSSFlqMED7kAhqd3OpeVrlTXNJbWlV
   g==;
Content-Disposition: inline
In-Reply-To: <20220622122440.87087-1-alexandr.lobakin@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m6

On Wed, Jun 22, 2022 at 02:24:40PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 21 Jun 2022 21:15:45 +0200
> 
> > While I was working on converting some structure fields from a fixed
> > type to a bitmap, I started observing code size increase not only in
> > places where the code works with the converted structure fields, but
> > also where the converted vars were on the stack. That said, the
> > following code:
> 
> [...]
> 
> Oh gosh, now s390 failed and 7/8 revealed one existing code flaw in
> the ice driver.
> I'll fix those, then will try to test more platforms (to not spam
> series again) and send v5 soon (mentioning this as bots CCs only
> myself).

One mail per person? Because I also got a report.

-- 
With Best Regards,
Andy Shevchenko


