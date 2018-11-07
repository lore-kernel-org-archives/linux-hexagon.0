From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus()
 for arches who used smp_call_function()
Date: Tue, 6 Nov 2018 17:04:39 -0800
Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
 <20181103104503.eftn5btx7otgufro@holly.lan>
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
 bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=; b=Fj9S8JSzDcU0qXTR13OfRC+3eu
 oUkAO4EKYIS04lLj1hCIxk3wxvXaGwOHPcnKyAKM8Re5DWBuD5XvM8GLptq0gPZQcEyncGK4z/y1e
 VXFuHyYIbvF2taciUzN0bqnPpGeuZvQDefS/tfuFiJFyB34NY27hsAzWCFhqawBJx04M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=; b=gThMzO6uPoEMHL60VsfpGF+jV8
 UlnQteC8Oxh+ZL2EWjCWtpZHXPTD9s+cen5uND3cYedrUjMK4fFinhjOECOdK1SjJmM2vH+99k312
 CaOxwCbhIH/+Xpk68j7hZXruoUQkQvjDirGMY2c1JgoS9qGcK+zh+MurA9090TS1VjmI=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
 b=eFazb3c7zMawmEuLNjfsk/It40P/kZA634ojboNSO3So2qlyJ29LyFhO0/QW48NaB8
 kbrri3Yn351FGwvXfSV9Lfr6DEeUttVtBJgkrVmcocs0A5GwSrzSsyI2B3buzW3FuyJ/
 hyabXtsc8ANcHIyckTZ0GHWNuBf8WD4smIyJ4=
In-Reply-To: <20181103104503.eftn5btx7otgufro@holly.lan>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kgdb-bugreport>
List-Post: <mailto:kgdb-bugreport@lists.sourceforge.net>
List-Help: <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kgdb-bugreport>, 
 <mailto:kgdb-bugreport-request@lists.sourceforge.net?subject=subscribe>
Errors-To: kgdb-bugreport-bounces@lists.sourceforge.net
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org, dalias@libc.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, mpe@ellerman.id.au, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org, linux-snps-arc@lists.infradead.org, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c-s.fr, Vineet Gupta <vgupta@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.bu

Hi,

On Sat, Nov 3, 2018 at 3:45 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > > As mentioned in another part of the thread we can also add robustness
> > > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > > large comment regarding why). Doing the check directly is abusing
> > > internal knowledge that smp.c normally keeps to itself so an accessor
> > > of some kind would be needed.
> >
> > Sure.  I could add smp_async_func_finished() that just looked like:
> >
> > int smp_async_func_finished(call_single_data_t *csd)
> > {
> >   return !(csd->flags & CSD_FLAG_LOCK);
> > }
> >
> > My understanding of all the mutual exclusion / memory barrier concepts
> > employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> > to just access the structure and check the bit directly.
> >
> > ...but do you think adding a generic accessor like this is better than
> > just keeping track of this in kgdb directly?  I could avoid the
> > accessor by adding a "rounding_up" member to "struct
> > debuggerinfo_struct" and doing something like this in roundup:
> >
> >   /* If it didn't round up last time, don't try again */
> >   if (kgdb_info[cpu].rounding_up)
> >     continue
> >
> >   kgdb_info[cpu].rounding_up = true
> >   smp_call_function_single_async(cpu, csd);
> >
> > ...and then in kgdb_nmicallback() I could just add:
> >
> >   kgdb_info[cpu].rounding_up = false
> >
> > In that case we're not adding a generic accessor to smp.c that most
> > people should never use.
>
> Whilst it is very tempting to make a sarcastic reply here ("Of course! What
> kgdb really needs is yet another set of condition variables") I can't
> because I actually agree with the proposal. I don't really want kgdb to
> be too "special" especially when it doesn't need to be.
>
> Only thing to note is that rounding_up will not be manipulated within a
> common spin lock so you might have to invest a bit of thought to make
> sure any races between the master and slave as the slave CPU clears the
> flag are benign.

OK, so I've hopefully got all this thought through and posted v3.
I've put most of my thoughts in the patch descriptions themselves so
let's continue the discussion there.

-Doug
