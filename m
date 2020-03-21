From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH 00/18] genirq: Remove setup_irq()
Date: Sat, 21 Mar 2020 23:13:03 +0530
Message-ID: <20200321174303.GA7930@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <87y2somido.fsf@nanos.tec.linutronix.de>
 <20200227110713.GA5708@afzalpc>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fStVl9rL3YRgIiAf/TzVVtMNrh3VX50fi0qgiiuA8o=;
        b=UXIHaUBhFEcnW+OMHvNaZ8x6pk7Kw7xSi1XSqUQ/ypXJwX+/0kjbU9/UcI39UYrFww
         L4SWYiuz/x5ZDo+euy1EVFm6/xEfsJuGVNtbr58w1aJIyLLbxr5Zvw2YV6+Jz2IFJLx1
         hSKDnD+ugCfCtYPbwa0qtQZzvaVCFI/U0Hh49Bh/9v4+8cPYNZpxmxPxHCL/ucL4FfPB
         t55wM9/sifQrsJ2x7qaYOUyTwSXOMqFFX7kbT5BvfLIkW8EyaBXHAHAACDZSlA65LB0e
         +oYG1mMj2pkG+negyyMWiq2E57sl6r93kYgmOlv5Tvke5FfWZ2pC2/wfVUCgtyT6TaL9
         9P/Q==
Content-Disposition: inline
In-Reply-To: <20200227110713.GA5708@afzalpc>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>

Hi Thomas,

On Thu, Feb 27, 2020 at 04:37:13PM +0530, afzal mohammed wrote:
> On Thu, Feb 27, 2020 at 11:31:15AM +0100, Thomas Gleixner wrote:

> > Vs. merging this series, I suggest the following approach:
> > 
> >    - Resubmit the individual changes as single patches or small series
> >      to the relevant maintainers and subsystem mailing lists. They have
> >      no dependency on a core change and can be applied where they belong
> >      to.
> > 
> >    - After 5.6-rc6, verify which parts have made their way into
> >      linux-next and resubmit the ignored ones as a series to me along
> >      with the removal of the core parts.
> > 
> > That way we can avoid conflicting changes between subsystems and the tip
> > irq/core branch as much as possible.
> 
> Okay, i will do accordingly.

i am on it, is delayed due to the reason as mentioned at,

https://lkml.kernel.org/r/20200321172626.GA6323@afzalpc

[ not repeating contents here since other mail was sent just now,
  cc'ing you ]

Regards
afzal

