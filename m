From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/4] kgdb: Remove irq flags from roundup
Date: Wed, 14 Nov 2018 21:51:13 +0000
Message-ID: <20181114215112.GA4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-2-dianders@chromium.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112182659.245726-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, kgdb-bugreport@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>, Ralf Baechle <ralf@linux-mips.org>, linux-snps-arc@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh>

On Mon, Nov 12, 2018 at 10:26:55AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

I'm hopeful that you'll keep hacking on kgdb, because it definitely needs
some love in its current state.

Will
