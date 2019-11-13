From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 10:41:21 -0500
Message-ID: <20191113104121.696c9093@gandalf.local.home>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U+ZMfieLUxkWcXsS43l2T2TNQveJoc+tzN/e2xwj3ew=; b=acp4MD7oqmn6Nb
	qvsjx7oGIcMTaoLwRgoQ5qZFWriD+FaFW3wD41rHm/8vYEUW+YUyZxnLnVbWmtS2jHxfc+ndFdhhv
	RoUOnd+hPZMDFDifpAHsTisqVHY0BLwknimP9hsP5MGzIxfUWoaQcul0E3tNfVmPAmhJkppay94xq
	lllWtjjQVOxBOlRiFxnhkVk106zF2d6yIo6SrrxsoSiZJCIHB9pG7tXpshVHTWeOvNXIJ1Pm3OCSm
	ezbdep80oCqtmovB3DiSY+Trom2w7OfN04w1gGR+eSOKN4lbaz9jDpcVOTDLa2SwUOYOP9biUDHWv
	TmLv2U2IZmHym0YTsCZg==;
In-Reply-To: <20191106203440.GH3079@worktop.programming.kicks-ass.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kerne

On Wed, 6 Nov 2019 21:34:40 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I suppose I'm surprised there are backtraces that are not important.
> Either badness happened and it needs printing, or the user asked for it
> and it needs printing.

Unfortunately that is the case. As my tests will fail if a backtrace is
detected.

> 
> Perhaps we should be removing backtraces if they're not important
> instead of allowing to print them as lower loglevels?

I usually end up removing backtraces for my tests, so I'm for this.
Specifically this happens in the drm and i915 drivers :-p

-- Steve
