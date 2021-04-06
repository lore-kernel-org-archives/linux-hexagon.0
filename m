From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
Date: Tue, 6 Apr 2021 10:38:36 -0700
Message-ID: <20210406173836.GW2469518@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1449; q=dns/txt; s=iport;
  t=1617730721; x=1618940321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHC75exw7z/XvWxaqurh75hAcW+P/hc1Ce2AN8KLAVE=;
  b=G8CemyZRO1sUomjCmS+YE/C6uWze7voF3/OnkJPzCjlApsHtQw/NACu6
   IbzaOOj9YEiobtqOgYiAKbgbugARDCXIRPa+ZrNQSpdtmv1Zjt672WTLx
   0k1ILORDVGZtFP7Z+NpOxvDGSwgPkZcfBivMfAolYWZryTkHbcjWyFPfw
   w=;
Content-Disposition: inline
In-Reply-To: <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: will@kernel.org, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> -config CMDLINE_BOOL
> -	bool "Built-in kernel command line"
> -	help
> -	  For most systems, it is firmware or second stage bootloader that
> -	  by default specifies the kernel command line options.  However,
> -	  it might be necessary or advantageous to either override the
> -	  default kernel command line or add a few extra options to it.
> -	  For such cases, this option allows you to hardcode your own
> -	  command line options directly into the kernel.  For that, you
> -	  should choose 'Y' here, and fill in the extra boot arguments
> -	  in CONFIG_CMDLINE.
> -
> -	  The built-in options will be concatenated to the default command
> -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> -	  command line will be ignored and replaced by the built-in string.
> -
> -	  Most MIPS systems will normally expect 'N' here and rely upon
> -	  the command line from the firmware or the second-stage bootloader.
> -


See how you complained that I have CMDLINE_BOOL in my changed, and you think it
shouldn't exist.

Yet here mips has it, and you just deleted it with no feature parity in your
changes for this.

In my changes I tried to maintain as much feature parity as I could with the
architectures. I did the same huge conversion a long time ago you've done here to be sure all
platforms have the features needed.

Daniel
