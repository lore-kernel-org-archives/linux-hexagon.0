From: Daniel Walker <danielwa-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 00/20] Implement GENERIC_CMDLINE
Date: Tue, 6 Apr 2021 09:56:10 -0700
Message-ID: <20210406165610.GV2469518@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2543; q=dns/txt; s=iport;
  t=1617728176; x=1618937776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cZx99TFaCLts0bYspySXDfTAZA7sX1ryp1fo4EAJaBw=;
  b=R4llpUe0760jIGN8ajhuGiyQ7AjZYDFP/5B615OEasNtvWFmppzuIAW3
   VrXjn6ragzVpRW3qx6K7svEY9uYFl6mkjVVBmPY7xNyWJyQ+e3/gxLyR4
   wdkyvt9igNCdF816s3S5UUiZ40gU303G8bibEWdCEFcS/weFez4fK01RN
   g=;
Content-Disposition: inline
In-Reply-To: <cover.1617375802.git.christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
Cc: will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel-R/FLGEdV95bo9U+Z1CfBt0SU0eOFXohjCypLqA8HKkk@public.gmane.org, arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, microblaze <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2 <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org, linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org

On Fri, Apr 02, 2021 at 03:18:01PM +0000, Christophe Leroy wrote:
> The purpose of this series is to improve and enhance the
> handling of kernel boot arguments.
> 
> Current situation is that most if not all architectures are using
> similar options to do some manupulation on command line arguments:
> - Prepend built-in arguments in front of bootloader provided arguments
> - Append built-in arguments after bootloader provided arguments
> - Replace bootloader provided arguments by built-in arguments
> - Use built-in arguments when none is provided by bootloader.
> 
> On some architectures, all the options are possible. On other ones,
> only a subset are available.
> 
> The purpose of this series is to refactor and enhance the
> handling of kernel boot arguments so that every architecture can
> benefit from all possibilities.
> 
> It is first focussed on powerpc but also extends the capability
> for other arches.
> 
> The work has been focussed on minimising the churn in architectures
> by keeping the most commonly used namings.
> 
> Main changes in V4:
> - Included patch from Daniel to replace powerpc's strcpy() by strlcpy()
> - Using strlcpy() instead of zeroing first char + strlcat() (idea taken frm Daniel's series)
> - Reworked the convertion of EFI which was wrong in V3
> - Added "too long" command line handling
> - Changed cmdline macro into a function
> - Done a few fixes in arch (NIOS2, SH, ARM)
> - Taken comments into account (see individual responses for details)
> - Tested on powerpc, build tested on ARM64, X86_64.
> 

Why submit your changes ? My changes have been around for almost 10 years, and
are more widely used. Your changes are very new and unstable, but don't really
solve the needs of people using my series.

I've tried to work with you and I take comments from you, but yet you insist to
submit your own series.

I would suggest this isn't going to go anyplace unless we work together.

I can't really support your changes because, honestly, your changes are really
ugly and they just look more and more like my changes with every passing
iteration .. As the maturity of your changes continue they will just become my
change set.

I've been thru every iteration of these changes, and I see those attempts in
your changes. Everything different in your changes I've tried, and found not to
be useful, then it falls away in later iterations.

When you give me comments on something which I haven't tried I typically
incorporate it.

Daniel
