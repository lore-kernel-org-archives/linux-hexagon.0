From: afzal mohammed <afzal.mohd.ma@gmail.com>
Subject: Re: [PATCH 00/18] genirq: Remove setup_irq()
Date: Thu, 27 Feb 2020 16:37:13 +0530
Message-ID: <20200227110713.GA5708@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <87y2somido.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmJQ36No1Gca/vcFrG4Eq9htTy7KPRzUbksdwrxz8LI=;
        b=FY89/SsX+eLNCZfl66UEb1ue7T2rDlxc39BUUNyQcUvYHLhQYmTZm8AV265dDcZriC
         n+pnoFgE+Sf8zXMbshaCCS6PUdHyFAtJ6zdH/VH1FXYuwfzu7iVLsjLF6SXNOrrDux5S
         VamD+96xP7YyeTt6xJaJYHlRfPSsbdooqEZo5JblB/xTNMzIpcuEBudbBh1o9hd+8Pp3
         VCC1Cl49y6FD+xnV0DQbsVUKowy7XWxJSXmwRChAoXpyUp1BbPkGQQ1IWMsgmCulUb0i
         idnYS7ecLxRWLTUTaFORqK3tstLgLRTwqSSk0D4o9TOL/U8ZbVv3Bk/xfDvuCNpgSmSI
         BGEQ==
Content-Disposition: inline
In-Reply-To: <87y2somido.fsf@nanos.tec.linutronix.de>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, x86@kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-omap@vger.kernel.org, linux-alpha@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>

Hi Thomas,

On Thu, Feb 27, 2020 at 11:31:15AM +0100, Thomas Gleixner wrote:

> Vs. merging this series, I suggest the following approach:
> 
>    - Resubmit the individual changes as single patches or small series
>      to the relevant maintainers and subsystem mailing lists. They have
>      no dependency on a core change and can be applied where they belong
>      to.
> 
>    - After 5.6-rc6, verify which parts have made their way into
>      linux-next and resubmit the ignored ones as a series to me along
>      with the removal of the core parts.
> 
> That way we can avoid conflicting changes between subsystems and the tip
> irq/core branch as much as possible.

Okay, i will do accordingly.

[ your mail crossed my v3 (only one patch) posting ]

Regards
afzal
