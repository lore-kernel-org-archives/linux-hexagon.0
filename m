From: Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v5 6/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Date: Fri, 15 Jul 2022 07:19:12 -0700
Message-ID: <YtF3YIBA0Dd4KXZ+@yury-laptop>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220624121313.2382500-7-alexandr.lobakin@intel.com>
 <20220715000402.GA512558@roeck-us.net>
 <20220715132633.61480-1-alexandr.lobakin@intel.com>
 <8c949bd4-d25a-d5f5-49be-59d52e4b6c9d@roeck-us.net>
Mime-Version: 1.0
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VM8umUUF8nWEq+3AaJAtV0L0dG1DVjrEYAJskHQ0LoQ=;
        b=oPyPC8JND1jmk0qt6wIXCgqcuLOOl8rGUp32GLJy5a41WTs+t/zQKDnMPfvvn9vQYG
         hVNBmIiqK0CZJ7KeXvsfaLz5vgoIdjp4xEo6HcryvOJ98g7OVrHRBi+33W44+bXjbIH5
         YTxxqMTh3CAaGcgmPDUM6IDfsaSWOJEpSpSzax//VcMzEfSiDPKfKy5X9/uWPGIMq9/y
         OeaA8Q6pvUv8mQay4ZtyK/hv8ZgKNk7gzzL0D5IazIZCptUcaMBMEKuq1L6v3n/0eq4Y
         jp3xHaJTKOhHzVpoh4jgNGbZoiH7M3R8hbqK5sFOwtVyzVo8kMBlwqPLUiV42dTI7CkI
         X85w==
Content-Disposition: inline
In-Reply-To: <8c949bd4-d25a-d5f5-49be-59d52e4b6c9d@roeck-us.net>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Matt Turner <mattst88@gmail.com>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Kees Cook <keescook@chromium.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>

On Fri, Jul 15, 2022 at 06:49:46AM -0700, Guenter Roeck wrote:
> On 7/15/22 06:26, Alexander Lobakin wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> > Date: Thu, 14 Jul 2022 17:04:02 -0700
> > 
> > > On Fri, Jun 24, 2022 at 02:13:10PM +0200, Alexander Lobakin wrote:
> > > > Currently, many architecture-specific non-atomic bitop
> > > > implementations use inline asm or other hacks which are faster or
> > 
> > [...]
> > 
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > > Reviewed-by: Marco Elver <elver@google.com>
> > > 
> > > Building i386:allyesconfig ... failed
> > > --------------
> > > Error log:
> > > arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'send_ebook_state':
> > > arch/x86/platform/olpc/olpc-xo1-sci.c:83:63: error: logical not is only applied to the left hand side of comparison
> > 
> > Looks like a trigger, not a cause... Anyway, this construct:
> > 
> > 	unsigned char state;
> > 
> > 	[...]
> > 
> > 	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> > 
> > doesn't look legit enough.
> > That redundant double-negation [of boolean value], together with
> > comparing boolean to char, provokes compilers to think the author
> > made logical mistakes here, although it works as expected.
> > Could you please try (if it's not automated build which you can't
> > modify) the following:
> > 
> 
> Agreed, the existing code seems wrong. The change below looks correct
> and fixes the problem. Feel free to add
> 
> Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> to the real patch.
> 
> Thanks,
> Guenter
> 
> > --- a/arch/x86/platform/olpc/olpc-xo1-sci.c
> > +++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
> > @@ -80,7 +80,7 @@ static void send_ebook_state(void)
> >   		return;
> >   	}
> > -	if (!!test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == state)
> > +	if (test_bit(SW_TABLET_MODE, ebook_switch_idev->sw) == !!state)
> >   		return; /* Nothing new to report. */
> >   	input_report_switch(ebook_switch_idev, SW_TABLET_MODE, state);
> > ---
> > 
> > We'd take it into the bitmap tree then. The series revealed
> > a fistful of existing code issues already :)

Would you like me to add your signed-off-by and apply, or you prefer
to send it out as a patch?

Thanks,
Yury
