From: Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v5 3/7] arch/*/uprobes: simplify
 arch_uretprobe_hijack_return_addr
Date: Mon, 27 Feb 2023 10:54:46 +0100
Message-ID: <Y/x95g9aUmMdO7Hu@ashyti-mobl2.lan>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
 <20230118154450.73842-3-andrzej.hajda@intel.com>
Mime-Version: 1.0
Return-path: <linux-parisc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677491699; x=1709027699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rr6xwo2PCVOiBN2/EFJWwIunjAZhcH+OTt1joV7rt6Y=;
  b=jWKd9bXais7/EgYjrU9s4vs9XIRDdDyepV71prZiHfAg8otmbpptD5EL
   GTO969l0Ujvzkicc/nbrMRi419UTqtIbw1NWCEHDW3OvqBr9PXtvkryk1
   V/H/H5SJ2Nsn40jnLEceHZIWZIEqiI79rlS9tCniom3BDI4WMnH7AzdRB
   yQRVXBRXobfDjB5sRpHDSKbvm688u3RYs5pfqgKRKrbvQCizfh0pVz6I9
   lLob/EbgwkKjd5fx0iff6ufy2eATntug6cR+itTiwt3wLljq82euwhHq/
   fi0JE9Sm8fxVywbQondGoV3zuyr3UZHYKAvkRXiMO13A60imp6pxNlPzC
   g==;
Content-Disposition: inline
In-Reply-To: <20230118154450.73842-3-andrzej.hajda@intel.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, And

Hi Andrzej,

On Wed, Jan 18, 2023 at 04:44:46PM +0100, Andrzej Hajda wrote:
> In all architectures, except x86, arch_uretprobe_hijack_return_addr
> is just __xchg.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
