From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus()
 for arches who used smp_call_function()
Date: Mon, 26 Nov 2018 19:52:27 -0800
Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org>
 <20181114220744.GB4044@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kgdb-bugreport-bounces@lists.sourceforge.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=; b=ZWb2CZe68j2ogBEoe7gmVFCev9
 zW9eV99U+2TuDirHvUhjEYcYtBG3diULhEWK1NCMIAikzomvQS1pBFIlYl7Can7a6GtbJ8kav2dlT
 /+e8jCeM2FlKOBT6Ebeh8KMANiT2JWn5B82UIxOI/7EwJsCvTgf9JHRvGYw7Zcd2W+po=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=; b=LBH2M9DcKwbEfqm3pecmcNJGj1
 wYlixyIpFRD5plCJLVMrmjJgWtLHHwXTE1UZadalfVYoHeoxW8x9SIAl3gstlCxC6cIeMPLf1pGMp
 82kfCMPo34Mh1THL9HUbufeqpcoCQWPShm9ICd0tWd9K4d8hSFI+56XMF3bPT8AzKULs=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
 b=QcPHoePkZX1rXMUYdsVjgFNEGwWi1t+kNzgHHl7f02t25QRLbxRsn38LV2ypdJ1Bet
 e0+PckNHOH/jab6l82SPjcFUnqnD3WPfuEI6R4N3zDp97pjS+o0tFeOUkhgdRhgDOJYl
 Tkr5tUn3ZIRFk36wyPZPqRF9qxyxgtvKyaE9E=
In-Reply-To: <20181114220744.GB4044@brain-police>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Will Deacon <will.deacon@arm.com>
Cc: linux-mips@linux-mips.org, dalias@libc.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, paulus@samba.org, linux-hexagon@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, mpe@ellerman.id.au, Russell King - ARM Linux <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org, linux-snps-arc@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c-s.fr, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com, Jason Wessel <jason.wessel@windriver.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Hi,

On Wed, Nov 14, 2018 at 2:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
>
> I suppose you could pass the cpu as an argument, but it doesn't really
> matter.

I probably won't change it for now if it doesn't matter...


> Also, I think there are cases where the CSD callback can run without
> having received an IPI, so we could potentially up passing NULL for the regs
> here which probably goes boom.

Hrm, good point.  This is not a new issue so I'd tend to add it to the
TODO list rather than block the series.  I'll also add a comment in
the code since I'm touching it anyway.

Interestingly enough quite a bit of things continue to work just fine
even if this is NULL.  I simulated setting this to NULL for all CPUs
and I could drop into the debugger, type "btc" to backtrace all CPUs,
attach to kgdb, etc.  ...but when I typed "cpu 1" it went boom.  So it
seems like parts of kdb use this but definitely not everything.

Also interesting is that on MIPS this is always NULL.  I have no idea
why but my patch series preserves this oddity.  Presumably if someone
was on a SMP MIPS machine and did "cpu 1" from kdb they'd go boom too.

In general kdb has a lot of crufty stuff like this in it.  We need to
work to get rid of the cruft but one step at a time I think.

I've started a kgdb-wishlist:

https://bugs.chromium.org/p/chromium/issues/list?q=label%3Akgdb-wishlist

...and this is crbug.com/908723


> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int this_cpu = get_cpu();
>
> Do you actually need to disable preemption here? afaict, irqs are already
> disabled by the kgdb core.

Ah, right.  I can just use raw_smp_processor_id().  Done.  I didn't
try to see if I could use smp_processor_id() since
kgdb_call_nmi_hook() already used raw_smp_processor_id(), but I can
dig if you wish.


> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
>
> for_each_online_cpu(cpu) ?

Done.


> I'm assuming this is serialised wrt CPU hotplug somehow?

I doubt it.  I can add it to my wishlist (crbug.com/908722) , but I
don't think it's something I'm going to try to solve right now and
it's definitely not new.  I think we need to make some sort of attempt
in kgdb_cpu_enter() to stop hotplugging, though we'd have to take into
account that we may be entering kgdb in an IRQ context so it might be
hard to grab a mutex.  We need to account for it there since that
function has code like:

> while (kgdb_do_roundup && --time_left &&
>        (atomic_read(&masters_in_kgdb) + atomic_read(&slaves_in_kgdb)) !=
>    online_cpus)
> udelay(1000);

...and that would also be broken if cpus were plugging / unplugging.

In general, at least, the worst case would be that we'd either have an
extra 1 second delay entering the debugger (because we were waiting
for a CPU to respond that's been hotplugged) or we'd enter kgdb
without stopping one of the CPUs.  Neither of those is ideal but I
don't think we'd end up in too bad shape.

Oh, but actually, I guess I should probably check the error return of
smp_call_function_single_async() and if it returns an error I should
unset rounding_up...  That would make things behave slightly better
and is probably right anyway.


Overall: thank you very much for the review and the feedback.  Sorry
I'm not really fixing everything here.  My hope is to move things to a
slightly better state but I don't have time to fix everything.
Hopefully I can find some more time soon to fix more, or perhaps
someone else will.


-Doug
