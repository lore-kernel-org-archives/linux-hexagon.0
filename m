From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 09:47:22 +0100
Message-ID: <20191113084722.emzee7g34zki4kkl@pathway.suse.cz>
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
 bh=KkOjqC3Ll9E7U01lXZ2bnQJUC/aAPuEK/i8AYPo7ync=; b=lwuFVvmEUPIA7GR/AHZQ1Kstsc
 t4uTt+APgJGsg+tnAcRsDQC5goBpkrgdUYe7TUeOPWUrOxcOqbxLTUl8QWFz3CVXbb0S8UH865Tdt
 uqcHjfvfCiYOockViiMN3E4kzWUgrf6bH85lO10NZ1RdElkGhmdJtgGSfzOyhPVzm6Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KkOjqC3Ll9E7U01lXZ2bnQJUC/aAPuEK/i8AYPo7ync=; b=Sr8Zi3VOjhJNXav+ke3jtjz24F
 pO0gQn20+dlNJLlJMSZCLeFNcNEv9p730ctuMYA+MdWmbAEZNgkebZ8irwhnspiWcZmM/bB1oY9cp
 jl6eUNBPxoOqKyTRjR8afSY2DezvgokoStMxos0zc+l5Zbx48PLy+9dILUN8bPpRskrA=;
Content-Disposition: inline
In-Reply-To: <20191113063334.GA147997@google.com>
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

On Wed 2019-11-13 15:33:34, Sergey Senozhatsky wrote:
> On (19/11/13 02:25), Dmitry Safonov wrote:
> > I guess I've pointed that in my point of view price for one-time testing
> > code is cheaper than adding a new printk feature to swap log levels on
> > the fly.
> [..]
> > I've gone through functions used by sysrq driver and the same changes
> > introducing log level parameter would be needed for: sched_show_task(),
> > debug_show_all_locks(), show_regs(), show_state(), show_mem(). Some of
> > them don't need any platform changes, but at least show_regs() needs.
> 
> Good points and nice conclusion.
> 
> Well, here we go. There is a number of generally useful functions that
> print nice data and where people might want to have better loglevel control
> (for debugging purposes). show_stack() is just one of them.

Could you please provide some examples so that we get an idea about
the scope, usefulness, and requirements?

> Patching all
> those functions, which you have mentioned above, is hardly a fun task to do.
> Hence the printk() per-CPU per-context loglevel proposition. The code there
> is not clever or complicated and is meant for debugging purposes only, but
> with just 3 lines of code one can do some stuff:
> 
> 	/* @BTW you can't do this with "%s" KERN_FOO ;P */
> +	printk_emergency_enter(LOGLEVEL_SCHED);
> +	debug_show_all_locks();
> +	printk_emergency_exit();

But this will not solve situations where the original loglevel should
stay from any reason. It happened in this patchset, see

https://lkml.kernel.org/r/20191106091258.GS25745@shell.armlinux.org.uk
https://lkml.kernel.org/r/20191106132516.GC5808@willie-the-truck

We would need to investigate more potential users of this feature to
see eventual requirements. If there are too many exceptions and modes
then the generic API might get pretty complicated.

At the moment, I am in favor of this patchset. It is huge and
needed a lot of manual work. But the result is straightforward and
easy to understand.

Best Regards,
Petr
