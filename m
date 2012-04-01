From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Date: Sun, 1 Apr 2012 11:12:11 -0700
Message-ID: <20120401181211.GZ2450@linux.vnet.ibm.com>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331223200.GA32482@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1204011930010.2542@ionos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1204011930010.2542@ionos>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, cmetcalf@tilera.com, jejb@parisc-linux.org, dhowells@redhat.com, linux390@de.ibm.com, linux-am33-list@redhat.com, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On Sun, Apr 01, 2012 at 07:34:55PM +0200, Thomas Gleixner wrote:
> On Sat, 31 Mar 2012, Russell King - ARM Linux wrote:
> 
> > On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> > > Although there have been numerous complaints about the complexity of
> > > parallel programming (especially over the past 5-10 years), the plain
> > > truth is that the incremental complexity of parallel programming over
> > > that of sequential programming is not as large as is commonly believed.
> > > Despite that you might have heard, the mind-numbing complexity of modern
> > > computer systems is not due so much to there being multiple CPUs, but
> > > rather to there being any CPUs at all.  In short, for the ultimate in
> > > computer-system simplicity, the optimal choice is NR_CPUS=0.
> > > 
> > > This commit therefore limits kernel builds to zero CPUs.  This change
> > > has the beneficial side effect of rendering all kernel bugs harmless.
> > > Furthermore, this commit enables additional beneficial changes, for
> > > example, the removal of those parts of the kernel that are not needed
> > > when there are zero CPUs.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Great work, but I don't think you've gone far enough with this.
> > 
> > What would really help is if you could consolidate all these NR_CPUS
> > definitions into one place so we don't have essentially the same thing
> > scattered across all these architectures.  We're already doing this on
> > ARM across our platforms, and its about time such an approach was taken
> > across the entire kernel tree.
> > 
> > It looks like the MIPS solution would be the best one to pick.
> > Could you rework your patch to do this please?
> > 
> > While you're at it, you might like to consider that having zero CPUs
> > makes all this architecture support redundant, so maybe you've missed
> > a trick there - according to my count, we could get rid of almost 3
> > million lines of code from arch.  We could replace all that with a
> > single standard implementation.
> 
> For a first step we can deprecated arch/ and make it depend on
> CONFIG_STAGING. That way we can have it around a bit for sentimental
> reasons w/o having a lot of churn.
> 
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

;-) ;-) ;-)

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

							Thanx, Paul

> Index: tip/Makefile
> ===================================================================
> --- tip.orig/Makefile
> +++ tip/Makefile
> @@ -564,7 +564,9 @@ else
>  KBUILD_CFLAGS	+= -O2
>  endif
> 
> +ifdef CONFIG_ARCH_SUPPORT
>  include $(srctree)/arch/$(SRCARCH)/Makefile
> +endif
> 
>  ifneq ($(CONFIG_FRAME_WARN),0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
> Index: tip/drivers/staging/Kconfig
> ===================================================================
> --- tip.orig/drivers/staging/Kconfig
> +++ tip/drivers/staging/Kconfig
> @@ -1,6 +1,10 @@
> +config ARCH_SUPPORT
> +	bool
> +
>  menuconfig STAGING
>  	bool "Staging drivers"
>  	default n
> +	select ARCH_SUPPORT
>  	---help---
>  	  This option allows you to select a number of drivers that are
>  	  not of the "normal" Linux kernel quality level.  These drivers
> Index: tip/Documentation/feature-removal-schedule.txt
> ===================================================================
> --- tip.orig/Documentation/feature-removal-schedule.txt
> +++ tip/Documentation/feature-removal-schedule.txt
> @@ -537,3 +537,13 @@ When:	3.6
>  Why:	setitimer is not returning -EFAULT if user pointer is NULL. This
>  	violates the spec.
>  Who:	Sasikantha Babu <sasikanth.v19@gmail.com>
> +
> +-----------------------------
> +
> +What:	Remove arch
> +When:	April 1st 2013
> +Why:    NR_CPUS=0 made arch/ obsolete. Keep it around a bit for
> +	sentimental reasons.
> +Who:	paulmck,tglx.rmk
> +
> +	
> 
