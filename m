From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] arch: Export machine_restart() instances so they can
 be called from modules
Date: Thu, 5 Aug 2021 20:41:23 +0200
Message-ID: <YQww08x2whx/LIIT@kroah.com>
References: <20210805075032.723037-1-lee.jones@linaro.org>
 <20210805075032.723037-2-lee.jones@linaro.org>
 <20210805173625.GH6719@arm.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628188887;
        bh=DJstyoIneDhJWe2M45tnolj4HGCE0gCrRv38Ul0FPvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yLSS87676hn106VIngpXBP/rOEU9YnrWCbO+LvhheiKjxKARCwKmpPaCV3EXfwCgP
         eswsJEhyB34IGotQMI4++5xN+H6/H2Zsa8YN4zRquACi04W3hFcBWcF1DF3HWEIxIo
         hfvqM78wNk4u3fnnSgFl6tYnBJF7uBTAQJcXiptc=
Content-Disposition: inline
In-Reply-To: <20210805173625.GH6719@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Brian Cain <bcain@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, John Crispin <john@phrozen.org>, Ley Foon Tan <ley.foon.tan@intel.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walm>

On Thu, Aug 05, 2021 at 06:36:25PM +0100, Catalin Marinas wrote:
> On Thu, Aug 05, 2021 at 08:50:30AM +0100, Lee Jones wrote:
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index b4bb67f17a2ca..cf89ce91d7145 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -212,6 +212,7 @@ void machine_restart(char *cmd)
> >  	printk("Reboot failed -- System halted\n");
> >  	while (1);
> >  }
> > +EXPORT_SYMBOL(machine_restart);
> 
> Should we make this EXPORT_SYMBOL_GPL? I suppose it's not for general
> use by out of tree drivers and it matches the other pm_power_off symbol
> we export in this file.

Yes please.
