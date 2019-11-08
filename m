From: Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/50] Add log level to show_stack()
Date: Fri, 8 Nov 2019 21:08:30 +0000
Message-ID: <5a411348-be84-f592-ef2d-ffaec99332bd@gmail.com>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106092039.GT4131@hirez.programming.kicks-ass.net>
 <10db6fa1-5b17-ebe6-09e0-6335e09e4db8@arista.com>
 <20191106203440.GH3079@worktop.programming.kicks-ass.net>
 <CAGrbwDRgX1BZoFrVYSXhAeeUKHrB=q3w8jXFPOuRvO7HV4Ciqw@mail.gmail.com>
 <20191108173045.GY25745@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vwuFpo0UiDnzPFiimc03yYQ0I92lDoFU8ZPsbJmfvdQ=; b=QbbjxG0heFqxkZ
	XHsH/AccYNT3ZYzwIWV5Y4Do9840af3v/UCZo4UggQfpoScwFiSg5n8xLCuJaCm0/JoGKuWfqgvO1
	rne9pxM2hPJyOU2Hbb7tCic1zipJQVIHJC4hnF4b1QHltR97UwRJJ48wIL7aftvtitfESfjccVZkf
	07zUfLmRS+Hyd9lM698b5xAgTD9IUrJs3AEzH+myRzrF73tX29f15NjrHmc0opBODxiU1X+TUG2h2
	xT9QiWLhGgRm2ZRKo0wZOD1siUqX1SnzDqfSn0/z67ZNpWQ/5Fc7dZgKT+lyUpazbWVGuqgZ+kqqr
	9PAoIr7pr5KPW1NCFcCg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=leuvFNJRBbgvPXZJlD4yDG614p9ePBBBJqh6/bi0nWM=;
 b=rjflubiq8T92r7IsfuflmmOLhAbyeUiuHnf/rQSYhhlSmttRaTaotAvL5xYp4yOydT
 GvzpvT1wRN/Se5w5Bamn3iuJIAGtHWJ3FQg7uwfFHiBZYXDG6coXsfRkKjBQWYAriMTe
 4kTrO4cphBn73YaGY9oVhRABcMWkQkwRmG/gGE9R1eQjZ3xrtTYtO4ekpHSWHoSNgXQt
 LOIHB3CeUqi5Hx5sAbRW5lNwEUAqSAnAREOPMl/n34UjrP0bXjp7N2IIvVwOE5dHTyoC
 y/6fNB8lMSjFK19DQSqAbg52NdT8Yh0NvqWS+ZavZPT5hVJ6jwjvtDCEDMZ1djztH8HA
 lzbQ==
In-Reply-To: <20191108173045.GY25745@shell.armlinux.org.uk>
Content-Language: en-US
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
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Dmitry Safonov <dima@arista.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Ben Segall <bsegall@google.com>, Guo Ren <guoren@kernel.org>, Pavel Machek <pavel@ucw.cz>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Burton <paulburton@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Mel Gorman <mgorman@suse.de>, Jiri Slaby <jslaby@suse.com>, Matt Turner <mattst88@gmail.com>, uclinux-h8-devel@lists.sourceforge.jp, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Richard Henderson <rth@twiddle.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <>


On 11/8/19 5:30 PM, Russell King - ARM Linux admin wrote:
> On Fri, Nov 08, 2019 at 04:28:30PM +0000, Dmitry Safonov wrote:
[..]
>>
>> Well, the use-case for lower log-level is that everything goes into logs
>> (/var/log/dmesg or /var/log/messages whatever rsyslog has settting).
>>
>> That has it's value:
>> - after a failure (i.e. panic) messages, those were only signs that
>> something goes wrong can be seen in logs which can give ideas what has
>> happened.
> 
> No they don't.  When the kernel panics, userspace generally stops
> running, so rsyslog won't be able to write them to /var/log/messages.
> 
> How, by "kernel panics" I mean a real kernel panic, which probably
> isn't what you're talking about there.  You are probably talking
> about the whole shebang of non-fatal kernel oops, kernel warnings
> and the like.  If so, I'd ask you to stop confuzzilating terminology.
> 
> If you really want to capture such events, then you need to have the
> kernel write the panic to (e.g.) flash - see the mtdoops driver.

I was talking about things prior the panic: OOMs, MMC write/read
warnings, hung tasks, we also have local patches to produce a warning if
the mutex is being held for too long or a task is starving on CPU time
by hard/soft irqs (I hope I will design something like that for
upstream). I've found those warnings useful to:
(a) have an early message when the things are starting going bad.
(b) analyze contentions or too large scale for a box or faulty hardware
for non-reproducible issues just from logs.

We use kexec to save the dmesg ringbuffer content after the panic.

Thanks,
          Dmitry
