From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable
 from roundup
Date: Tue, 30 Oct 2018 15:22:40 -0700
Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org>
 <20181030114603.xdvyvayzw2an5c3q@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sAazuecHDwi7QOcB2SsU+E9xU7Y6+GOHQUh+kocsiVA=; b=ahZDIJbpapc9wu
	Zlt6jxJJDlyB7JWk1oJDAeMKa89Qw8o/eMQ3c7mhRfRU/3LFTwVVmAeYyFxR9jt28V55bPORu4va/
	p36tZHP/lRf9Uxg8vp0SYJ0K1d9lYTK3T4il+5YUocO4u6uhM43CeI2Gzyvg63em9SB6nyCDuph4v
	X+wMQW24eY0GTOuXWOnuF3jTignSb4SAocQ1NbJSe/z56md0OLpSsUnTB3UIAILfPVnKdzCYJmO31
	IcgzFLF60he7Mm+n8jbzPDn7R0FYOldknZjtPXkoYju31Yu0m40R/KgROqTOA02Yn3QUj/UlEDJ2J
	D1YZrC5s0MHirpH+cWuw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
 b=jcKtztE2YqHIN/ivS3T1ZCw84PseggOPg6ZMa6O+Xwi3o8ePR9CuItoF1UQkA4p71Q
 AGZsRypdJ3G1dlog6rYXRUmhTbTueRGExx76PbPoqNk4VZEgIpuWOJayPkTqJ742AM58
 KK7v5W/wbozKkaVztZ4jBMT+ZKckAgfW1zzOQ=
In-Reply-To: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
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
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kstewart@linuxfoundation.org, linux-mips@linux-mips.org, dalias@libc.org, Catalin Marinas <catalin.marinas@arm.com>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, mhocko@suse.com, paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, ying.huang@intel.com, rppt@linux.vnet.ibm.com, bp@alien8.de, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, christophe.leroy@c

Hi,

On Tue, Oct 30, 2018 at 4:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> > The function kgdb_roundup_cpus() was passed a parameter that was
> > documented as:
> >
> > > the flags that will be used when restoring the interrupts. There is
> > > local_irq_save() call before kgdb_roundup_cpus().
> >
> > Nobody used those flags.  Anyone who wanted to temporarily turn on
> > interrupts just did local_irq_enable() and local_irq_disable() without
> > looking at them.  So we can definitely remove the flags.
>
> On the whole I'd rather that this change...
>
>
> > Speaking of calling local_irq_enable(), it seems like a bad idea and
> > it caused a nice splat on my system with lockdep turned on.
> > Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>
> ... and fixes for this this were in separate patches. They don't appear
> especially related.

Agreed that this is cleaner.  Done for v2.

-Doug
