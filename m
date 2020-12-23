From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: consolidate pm_power_off callback
Date: Wed, 23 Dec 2020 11:37:56 +0100
Message-ID: <CAMuHMdXoHVPwqC_v6DL2MTi2j_tgnCqy9eiuLHvmZ9cB5scbQA@mail.gmail.com>
References: <20201222184510.19415-1-info@metux.net>
 <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
 <2f1d53e9-0dbb-78ef-22d5-ab230438ddf0@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ja49/ChS5tVjpJBp/leZg007U8s5XPVtF/ircbvX7w4=; b=i9SZ/OJw7/xVQCxLYOezpOvo1
	ullrAN2zGpw+RqIKMx2R3QRplObBWA8VmOnejcc0EY+o1Cm9mELuHyA9D1UhVEoQvyZAPWVqZsD0X
	xC4mq61walzsQzC4BqoN5+UFJOlmGpscAyklw1jmQbI2aE4WH+mdvmWuSwPxqj5uO8AFuFtx4TVdq
	BGC40YONlzxdvJkysahKadYpRJticw3j+rf3j7AKUXrdfDIU0B8CK/IuwWyGrjBv+i2dXB02tv54G
	G5wVUR5GUW1hG/UR3Iaaobx9dUd5vgB8C6MtDReoe32qwg3Op0Ee2UfS2xFji/CEEmXXFjCan5mxH
	J72F1RUNQ==;
In-Reply-To: <2f1d53e9-0dbb-78ef-22d5-ab230438ddf0@metux.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, linux-csky@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-s390 <linux-s390@vger.kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>

Hi Enrico,

On Tue, Dec 22, 2020 at 9:15 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 22.12.20 19:54, Geert Uytterhoeven wrote:
> > On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
> > <info@metux.net> wrote:
> >> Move the pm_power_off callback into one global place and also add an
> >> function for conditionally calling it (when not NULL), in order to remove
> >> code duplication in all individual archs.
> >>
> >> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/alpha/kernel/process.c
> >> +++ b/arch/alpha/kernel/process.c
> >> @@ -43,12 +43,6 @@
> >>  #include "proto.h"
> >>  #include "pci_impl.h"
> >>
> >> -/*
> >> - * Power off function, if any
> >> - */
> >> -void (*pm_power_off)(void) = machine_power_off;
> >
> > Assignments like these are lost in the conversion.
>
> Yes, but this doesn't seem to be ever called anyways. (in arch/alpha)
> And, BTW, letting it point to machine_power_off() doesn't make much
> sense, since it's the arch's machine_power_off() function, who're
> calling pm_power_off().
>
> Actually, we could remove pm_power_off completely from here, assuming
> nobody would *build* any drivers that register themselves into
> pm_power_off.
>
> If you feel better with it, I could post a patch that just removes
> pm_power_off from arch/alpha.

This is not limited to alpha, there are similar initializations on
m68k, openrisc,
and s390.
If none of these are called, they can be removed, but you should mention
that in the patch description.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
