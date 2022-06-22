From: Alexander Lobakin <alexandr.lobakin@intel.com>
Subject: Re: [PATCH v4 0/8] bitops: let optimize out non-atomic bitops on compile-time constants
Date: Wed, 22 Jun 2022 16:37:39 +0200
Message-ID: <20220622143739.291698-1-alexandr.lobakin@intel.com>
References: <20220621191553.69455-1-alexandr.lobakin@intel.com> <20220622122440.87087-1-alexandr.lobakin@intel.com> <YrMlrjbue7twWLk1@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655908670; x=1687444670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xA+AX77vbPPnWCLAuym9yD93ebv8XWnin6EN1d9z6Y0=;
  b=Ebul5HJ6tzZzJqE+O+8CvVfxZ6NSsLcMocEAIJU1YAbom+hzmhuxSD91
   QqAU2WUMzEM71hIe+h4pUWlN1heGvz6mHuAKPgnkIvhFuaPs9hhL2pxoZ
   jpyTViF1esxDoFiAR1PBJYG2zK0Ytq0Ulj2e0E1sRgJfTH63lrMjm4BJ7
   nx2ixlUwDNs/q6zbxAsjLmNQppUXwO7O25UWoAnPR9hQT7sv0lAOKW0z4
   BXG6BpHIwR9XTbAP+oq4EUooWYjxt9VBZDNRvWa6S9LGVVElpC0gQGJjF
   pIiKfQL077l3f5nvhLhEuDGnhwwS3s9rTO+ZIlulA1Y0KfPqoiwtW+bQa
   w==;
In-Reply-To: <YrMlrjbue7twWLk1@smile.fi.intel.com>
Content-Disposition: inline
List-ID: <linux-hexagon.vger.kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-alpha@vger.kernel.org, linux-hexagon@vger.ker

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 22 Jun 2022 17:22:38 +0300

> On Wed, Jun 22, 2022 at 02:24:40PM +0200, Alexander Lobakin wrote:
> > From: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Date: Tue, 21 Jun 2022 21:15:45 +0200
> > 
> > > While I was working on converting some structure fields from a fixed
> > > type to a bitmap, I started observing code size increase not only in
> > > places where the code works with the converted structure fields, but
> > > also where the converted vars were on the stack. That said, the
> > > following code:
> > 
> > [...]
> > 
> > Oh gosh, now s390 failed and 7/8 revealed one existing code flaw in
> > the ice driver.
> > I'll fix those, then will try to test more platforms (to not spam
> > series again) and send v5 soon (mentioning this as bots CCs only
> > myself).
> 
> One mail per person? Because I also got a report.

From the headers:

From: kernel test robot <lkp@intel.com>
To: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: <llvm@lists.linux.dev>,
 <kbuild-all@lists.01.org>,
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I guess it's due to your Reviewed-by in the commit message, no one
else from the original CCs list is present.

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Olek
