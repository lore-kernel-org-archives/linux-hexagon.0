From: Daniel Walker <danielwa@cisco.com>
Subject: Re: [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
Date: Thu, 8 Apr 2021 18:23:49 -0700
Message-ID: <20210409012349.GG3981976@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
 <20210406173836.GW2469518@zorba>
 <20210408190408.GA1724284@robh.at.kernel.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1925; q=dns/txt; s=iport;
  t=1617931440; x=1619141040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkzLqPqjAxF6Ch0t2FT084suyCe7GM/KMpezthHSR4s=;
  b=Gap38DrgAFYo7ZYtYj3EvA00VRAvBXaTMJHcOvwkNJVDT4HPXjse3J2D
   Wam4qRi03A5ot7Rf2AqNJn295G4c85LGxBe56kFeO3V2wvq1mgqITfilJ
   drIjp9AFnBn0GO22oASshvs+nTKSZIL5IUvC5aRimTMSDO6kDRejFhvAH
   w=;
Content-Disposition: inline
In-Reply-To: <20210408190408.GA1724284@robh.at.kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, will@kernel.org, daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

On Thu, Apr 08, 2021 at 02:04:08PM -0500, Rob Herring wrote:
> On Tue, Apr 06, 2021 at 10:38:36AM -0700, Daniel Walker wrote:
> > On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> > > -config CMDLINE_BOOL
> > > -	bool "Built-in kernel command line"
> > > -	help
> > > -	  For most systems, it is firmware or second stage bootloader that
> > > -	  by default specifies the kernel command line options.  However,
> > > -	  it might be necessary or advantageous to either override the
> > > -	  default kernel command line or add a few extra options to it.
> > > -	  For such cases, this option allows you to hardcode your own
> > > -	  command line options directly into the kernel.  For that, you
> > > -	  should choose 'Y' here, and fill in the extra boot arguments
> > > -	  in CONFIG_CMDLINE.
> > > -
> > > -	  The built-in options will be concatenated to the default command
> > > -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> > > -	  command line will be ignored and replaced by the built-in string.
> > > -
> > > -	  Most MIPS systems will normally expect 'N' here and rely upon
> > > -	  the command line from the firmware or the second-stage bootloader.
> > > -
> > 
> > 
> > See how you complained that I have CMDLINE_BOOL in my changed, and you think it
> > shouldn't exist.
> > 
> > Yet here mips has it, and you just deleted it with no feature parity in your
> > changes for this.
> 
> AFAICT, CMDLINE_BOOL equates to a non-empty or empty CONFIG_CMDLINE. You 
> seem to need it just because you have CMDLINE_PREPEND and 
> CMDLINE_APPEND. If that's not it, what feature is missing? CMDLINE_BOOL 
> is not a feature, but an implementation detail.

Not true.

It makes it easier to turn it all off inside the Kconfig , so it's for usability
and multiple architecture have it even with just CMDLINE as I was commenting
here.

Daniel
