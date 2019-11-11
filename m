From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Mon, 11 Nov 2019 10:12:07 +0100
Message-ID: <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ckDLLBNybB00NN8bJ+zRvU0mCEzS1GZ+ad57vCEWPjg=; b=cQlpD23aP4bfKdyeyN7HiVAGoK
 SflFeTgJLt+AxFRMLefuJ6Xc6DflclklBijDwv5eydJeO8EbgWW/ie/JpJ80vmyObiM9Y5GGTAn//
 wyk1qSt1zx6JcwrVeI1WwxDGIXufOpIqARrNzBgwmx/8Wuk7CvYBBuIoemQm42UwSqtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ckDLLBNybB00NN8bJ+zRvU0mCEzS1GZ+ad57vCEWPjg=; b=Tmc8UAHLOAuFi2NDkHEwALRMzt
 UKbkwF8x9kOmqxZ70/oIK3a5kFFbFiQaEdfQGv5Xhhtzq+6LEyF4Kt8XGX50MOdc+4T1grhMYKI2c
 iODFCXmCsuXTPCRhY3j8yjmNndBWhpvmXY7Ck4stJnaNLIVazdrJkVloKnjVnJzbODto=;
Content-Disposition: inline
In-Reply-To: <20191111012336.GA85185@google.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Dmitry Safonov <dima@arista.com>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kerne

On Mon 2019-11-11 10:23:36, Sergey Senozhatsky wrote:
> On (19/11/08 14:04), Petr Mladek wrote:
> [..]
> > I agree that it is complicated to pass the loglevel as
> > a parameter. It would be better define the default
> > log level for a given code section. It might be stored
> > in task_struct for the normal context and in per-CPU
> > variables for interrupt contexts.
> 
> I do recall that we talked about per-CPU printk state bit which would
> start/end "just print it" section. We probably can extend it to "just
> log_store" type of functionality. Doesn't look like a very bad idea.

The problem with per-CPU printk is that we would need to disable
interrupts. It is not always wanted. Also people might not expect
this from a printk() API.


> "This task/context is in trouble, whatever it printk()-s is important".

It might be a minimal loglevel. More important messages would still
be printed() with the higher loglevel.

But yes, this per-code-section loglevel is problematic. The feedback
against the patchset shows that people want it also the other way.
I mean to keep pr_debug() as pr_debug().

A solution might be to use the per-code-section loglevel only instead
of some special loglevel.


> Per-console loglevel also might help sometimes. Slower consoles would
> ->write() only critical messages, faster consoles everything.

This looks like another problem to me. Anyway, this filtering will
work better when the loglevel will be consistent across the related
lines.

> Passing log_level as part of message payload, which printk machinery
> magically hides is not entirely exciting. What we have in the code
> now - printk("%s blah\n", lvl) - is not what we see in the logs.
> Because the leading '%s' becomes special. And printk()/sprintf()
> documentation should reflect that: '%s' prints a string, but sometimes
> it doesn't.

I personally do not see this as a big problem.

The explicitly passed loglevel makes me feel more confident that
all needed printk() calls were updated. But it might be a false
feeling. I do not really have any strong preference.

Best Regards,
Petr
