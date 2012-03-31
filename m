From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state
 space
Date: Sat, 31 Mar 2012 23:00:08 +0200
Message-ID: <1333227608.2325.4054.camel@edumazet-glaptop>
References: <20120331163321.GA15809@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=cvvbGMem4llGGSx7vHAzopZWFJXuOPwRRXOuYBt14BA=;
        b=Eh/BPLX58xPJw2TTpkmhXwMk53mByIXhcxI4BhB7l68ZBbnmnqR1hyNdlVOwZRiRFW
         AHYcKDHrfHcL/C0JW3Lj3Cqj+IRZNbF5lB/mROhbfoSQnmWixAzEQGHYfmeaHeeYRS8P
         Qq/12wGVWCIo+9NBu4oXc/gc8ObJ41DdevBIe1onk9UL+KU+cAJiXo9C+53uJvRLsWjb
         lNYPwXHPwqkTY+YogostbbUYYinjv8PP3tajMo62Ul9kRr1u176AYyIF1KKwZHeSiK2k
         D/gTPitONv60mxfncwAsosrryDORmQ9yeGUYkl+D1w/98WZkTmgzAeljz5POVmcjbAej
         s1ww==
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
Sender: linux-alpha-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de, linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org, linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com

On Sun, 2012-04-01 at 00:33 +0800, Paul E. McKenney wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
> 
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Hmm... I believe you could go one step forward and allow negative values
as well. Antimatter was proven to exist after all.

Hint : nr_cpu_ids is an "int", not an "unsigned int"

Bonus: Existing bugs become "must have" features.

Of course there is no hurry and this can wait 365 days.


