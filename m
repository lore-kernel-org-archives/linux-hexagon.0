From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 10:44:46 -0500
Message-ID: <20191113104446.419e4d8a@gandalf.local.home>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
 <20191106232512.GU25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1FcMnrlSz7GnnA3DU9kLB2rkj6wtu0Uh/x/5dLvxumw=; b=kVY5OSbjNxqndK
	bDsErsGS8qOEfMKGrHCX4mmwI5wYomt4bG5nRYvmi3bXg2F3KupiIvDQkSL6TtyJ9GqJWKLyDdht1
	p2/vsepkB7HZuDMS5NFoU7t1M2yf1HHeMJaTx9RIhxSTM6p1jncEbSach3EsH45Wqk1GRWQ2xumQ7
	qYLvMS9Iy+XfOOlR/qaLk1nb8G8hNN3OLXSxgCwMbXVK9xnywqSVI9aMCFEASpXpzyIPE0fnrCtla
	ZgMny4bmYNYPg9CdOqO3Le+IQ6Nf5BX9HGiOr5tpXLZ9t5drTwIm8s2R3fdCksOdao67DkDl6TmKM
	76GetKgassVu8sezUuGw==;
In-Reply-To: <20191106232512.GU25745@shell.armlinux.org.uk>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kerne

On Wed, 6 Nov 2019 23:25:13 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

> On Wed, Nov 06, 2019 at 09:34:40PM +0100, Peter Zijlstra wrote:
> > I suppose I'm surprised there are backtraces that are not important.
> > Either badness happened and it needs printing, or the user asked for it
> > and it needs printing.  
> 
> Or utterly meaningless.
> 
> > Perhaps we should be removing backtraces if they're not important
> > instead of allowing to print them as lower loglevels?  
> 
> Definitely!  WARN_ON() is well overused - and as is typical, used
> without much thought.  Bound to happen after Linus got shirty about
> BUG_ON() being over used.  Everyone just grabbed the next nearest thing
> to assert().
> 
> As a kind of example, I've recently come across one WARN_ON() in a
> driver subsystem (that shall remain nameless at the moment) which very
> likely has multiple different devices on a platform.  The WARN_ON()
> triggers as a result of a problem with the hardware, but because it's a
> WARN_ON(), you've no idea which device has a problem.  The backtrace is
> mostly meaningless.  So you know that a problem has occurred, but the
> kernel prints *useless* backtrace to let you know, and totally omits
> the *useful* information.
> 

I would like to bring up a topic for the next maintainers summit
(although I may not even be there), that we define a clear use of
WARN_ON(). I use it only if the code does something I do not expect it
to do, and is considered a bug in the code if it triggers. But it
appears that some drivers use it for "oh I didn't realize this hardware
does something I didn't expect". And is ignored when the warn on is
triggered and reported, with "you have buggy hardware" but my hardware
appears to work just fine!

-- Steve
