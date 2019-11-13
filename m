From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 11:24:41 -0500
Message-ID: <20191113112441.41f6763c@gandalf.local.home>
References: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
 <20191113012337.GA70781@google.com>
 <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
 <20191113063334.GA147997@google.com>
 <20191113084722.emzee7g34zki4kkl@pathway.suse.cz>
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
	List-Owner; bh=NaklxeAcMrL+zvt9Voth60L6J64AeLh41NktA+sGH5Q=; b=Wx5YV6nNWycf7F
	3W9GXsNYyERa3Hxci0l5dDuuPQZP8EzO4Z2+xRqlLnLisfw8FMB5aUKG/xS10ISzoneD5nPM6t7jj
	V2BMS0XljbpczFlIqBhobfrLpA9hUOh/fMMf/3nM20+RDPp9GvYPJYfN59bh8xewHu9hFdncC9HuM
	cYGZObZb08vV/qbLx7iOntYWlSobSjgGv63az6SZV+yz0X+qJWnctvoABLSFNejsQtX3bgkaSZx1T
	pOp7vSGEOrsRDulsx0F80/W/1pE8NbFa4ywi9fmjhFHbK/f1Q4M+Xrnn0isoQ/YWIPbyMPcp3Tla/
	4Bf0LJE1mfYbBUxraloQ==;
In-Reply-To: <20191113084722.emzee7g34zki4kkl@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.or>

On Wed, 13 Nov 2019 09:47:22 +0100
Petr Mladek <pmladek@suse.com> wrote:

> At the moment, I am in favor of this patchset. It is huge and
> needed a lot of manual work. But the result is straightforward and
> easy to understand.

I'm in favor of this patchset too. If there's other areas that need to
adjust the current loglevel (say per task context), then we can cross
that bridge when the need arises. But I don't want to over engineer
this as the stack trace logic should have a way to explicitly state how
important this stack trace really is (or better yet, we should be
removing stack traces that are not important!)

-- Steve
