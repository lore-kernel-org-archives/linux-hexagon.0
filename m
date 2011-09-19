From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH v4 18/36] Hexagon: Add time and timer functions
Date: Mon, 19 Sep 2011 10:54:03 -0500
Message-ID: <20110919155403.GB2627@codeaurora.org>
References: <e97c6e$3hno05@wolverine02.qualcomm.com>
 <alpine.LFD.2.02.1109191536330.2723@ionos>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1109191536330.2723@ionos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 19, 2011 at 03:38:02PM +0200, Thomas Gleixner wrote:
> On Wed, 14 Sep 2011, Richard Kuo wrote:
> > +
> > +void debug_adsp_timers(void)
> > +{
> > +	printk(KERN_INFO "rtos_timer->match=0x%08x\n", rtos_timer->match);
> > +	printk(KERN_INFO "rtos_timer->count=%d\n", rtos_timer->count);
> > +	printk(KERN_INFO "rtos_timer->enable=%d\n", rtos_timer->enable);
> > +	printk(KERN_INFO "rtos_timer->clear=%d\n", rtos_timer->clear);
> > +}
> 
> Does this have a caller and is it useful ?
> 
> Otherwise this looks good.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Mostly just me being paranoid.  It can be removed.


Thanks,
Richard Kuo


-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
