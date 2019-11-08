From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 8 Nov 2019 14:04:47 +0100
Message-ID: <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106083538.z5nlpuf64cigxigh@pathway.suse.cz>
 <20191108103719.GB175344@google.com>
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
 bh=La9f0W75O1O7X1+adHiQmzYierWrtdMcZjwxWFaAWaY=; b=Ia/x75D+qPN88hlqG+6OH92iow
 RpimJ2UEoZ4xf2uCLU4w4CUja9pQhlHPWsEh9kwV9CnVzNIM28TZIcGOn7LlWjUDQat9Wpw+I42hD
 JNUa3Lw7x2ip4HyXPd9zMp1G6SDl14GD/7TlR6Ydr1vCRpWrlpK5+AnzmUMqJHU0Zso8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=La9f0W75O1O7X1+adHiQmzYierWrtdMcZjwxWFaAWaY=; b=YhSqVZ81sU9s0spE/9o1ff3DTM
 Ypyn9P5WlxNjQ0pzpnADo0qB9I4W5iyLA/13EK6f0lfdQ2r+jraEoAvWQNu5jAqPnxP3Y8ZqeoaVk
 4pa8m8wjIzDH4GhR5JdMiCuagn89E4qp85CChMYYLqYB3yWpSNO7y5vO8YmTQedbO9GI=;
Content-Disposition: inline
In-Reply-To: <20191108103719.GB175344@google.com>
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

On Fri 2019-11-08 19:37:19, Sergey Senozhatsky wrote:
> On (19/11/06 09:35), Petr Mladek wrote:
> > I agree with all the other justification.
> > 
> > I would add. The backtrace is really useful for debugging. It should
> > be possible to print it even in less critical situations.
> 
> Hmm, I don't know.
> Do we really need debug/info level backtraces?

debug is exactly the loglevel where registry content and backtrace
might be very useful. It is not always important to reach the console.


> May be all backtraces can be converted to something more severe
> (so we can stop playing games with loglvl) and then we can
> clean up "(ab)users"?

IMHO, we should distinguish warning, error, crit, alert, emerg
situations. Backtraces and any related messages should be
filtered the same way. Any information might be useless without
the context.

I agree that it is complicated to pass the loglevel as
a parameter. It would be better define the default
log level for a given code section. It might be stored
in task_struct for the normal context and in per-CPU
variables for interrupt contexts.

Best Regards,
Petr
