From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Wed, 13 Nov 2019 15:33:34 +0900
Message-ID: <20191113063334.GA147997@google.com>
References: <20191108103719.GB175344@google.com>
 <20191108130447.h3wfgo4efjkto56f@pathway.suse.cz>
 <20191111012336.GA85185@google.com>
 <20191111091207.u3lrd6cmumnx4czr@pathway.suse.cz>
 <20191112044447.GA121272@google.com>
 <20191112045704.GA138013@google.com>
 <20191112083509.gmgjpkjffsfaw5lm@pathway.suse.cz>
 <20191112101229.GA201294@google.com>
 <20191113012337.GA70781@google.com>
 <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Edn5IFU3R6j4VJjv3ztj6aOXKuKU2LSfKbAcMlqy9Cs=; b=qwxMZe7FYCvbEG
	8naiImeMyj7fVPv2Yayhn+ttya80FCV10L57m+KXfzFlnbiG1bk7y3dfso0xoYsqCaKvsvcI6RTa2
	sXrzetn5HHMOalVaiJRDKAPxFC+soyMmJDf6xowRcqJmZqdvIaCAIf0/mMnuNCtbJ0tUrQ24okduj
	v2HjXgkiOvCoQZUfJSfrXnA9Kqzj+wVjZpOR9+0HAY2TRBzfOpr6XK74wOQbilpKAsVz8AJ4PDmoa
	3dqice+DZaW4n7iJ4iu086YmqLbEhfobEENcOHttM2bcecr9h8TxWaq+Syj3oA8aM0jZ4m7QdEefe
	hDn7aOMHh8C8hglC3P3A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=KPZG4VqXDKJQhwt8QhBKSdwu6zZ1yvGSLXAAovETV8E=;
 b=U+7/ZvVfxKk+hxsLJDRIKIa9v9E62t1+RHHdRG8fTOKlKCc4Kg8kLlVghoiEvtLKpI
 pPB/09WWUgNDAvmTd9ZCgUOuDBo7+0/f9WrOXWR2uZQ/aTiznYX6i7YMJNAQqiVBiT9D
 uNMlkpfHxoC092SA3lqUUmN6Py1jaNvbxPVR7bhPPMcnC5VVTdQfrrvn9g+mwUT9wmS5
 IpQo+ozODVnxdup9AaHr+12x4K6wNPJd6H6aHacy3JkNKTrjQ9VPgzg12dvkP1Aua/p8
 JdT9N+L+Gr2JhZIIZgVnzKCc48NZMHSHGJjqaFnpF0Bg0opyuGJWVOEoMHo8Jbl+CwGg
 Qilw==
Content-Disposition: inline
In-Reply-To: <25ff45f0-6420-f660-55a8-637f11ab5ab4@arista.com>
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
To: Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Petr Mladek <pmladek@suse.com>, linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwyso>

On (19/11/13 02:25), Dmitry Safonov wrote:
> I guess I've pointed that in my point of view price for one-time testing
> code is cheaper than adding a new printk feature to swap log levels on
> the fly.
[..]
> I've gone through functions used by sysrq driver and the same changes
> introducing log level parameter would be needed for: sched_show_task(),
> debug_show_all_locks(), show_regs(), show_state(), show_mem(). Some of
> them don't need any platform changes, but at least show_regs() needs.

Good points and nice conclusion.

Well, here we go. There is a number of generally useful functions that
print nice data and where people might want to have better loglevel control
(for debugging purposes). show_stack() is just one of them. Patching all
those functions, which you have mentioned above, is hardly a fun task to do.
Hence the printk() per-CPU per-context loglevel proposition. The code there
is not clever or complicated and is meant for debugging purposes only, but
with just 3 lines of code one can do some stuff:

	/* @BTW you can't do this with "%s" KERN_FOO ;P */
+	printk_emergency_enter(LOGLEVEL_SCHED);
+	debug_show_all_locks();
+	printk_emergency_exit();

Now...
I'm not sure if this whole thing is up to "printk maintainers only".
If no one is going to use "emergency printk contexts" then there is
no point in having that code in the kernel.

	-ss
