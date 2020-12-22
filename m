From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: consolidate pm_power_off callback
Date: Tue, 22 Dec 2020 19:54:48 +0100
Message-ID: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
References: <20201222184510.19415-1-info@metux.net>
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
	 bh=yvPg3ApJ/e219QwxXotk24jS874k/dmRU6o3xAB5snc=; b=vBiscJuxHwDY4cza0q23iSBwV
	/fcjJs9oArYU6HKQG3V5yy89DkrNQV/68VCzN/C3ozMxB0O8ehoK+6L5dIjm66CSLqttD2lMZgeE4
	aNkVl1kSio5wnFsrRw76L6GkIFIwHE2okiTsKJOmKSGWGa1cIW+ngYPRUFN/t5v/6zk/biubmAB4h
	fW969pBrR3+E1GJA0Z8vQEvXYdTUARhb6NSsUsfxCqsljBxGkDOBIvar5UXu+JiCoOHv5FiDPngrK
	xWBZV+faAbsKcJCT0Z811Vu4Sp74k4gdLYHzeSNg8MVwVUnlvb5U4UIk4IKZBNaErG+/TDz7kOOvp
	zOnhmfcXQ==;
In-Reply-To: <20201222184510.19415-1-info@metux.net>
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
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, linux-csky@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-s390 <linux-s390@vger.kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>

Hi Enrico,

On Tue, Dec 22, 2020 at 7:46 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> Move the pm_power_off callback into one global place and also add an
> function for conditionally calling it (when not NULL), in order to remove
> code duplication in all individual archs.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Thanks for your patch!

> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -43,12 +43,6 @@
>  #include "proto.h"
>  #include "pci_impl.h"
>
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void) = machine_power_off;

Assignments like these are lost in the conversion.

> -EXPORT_SYMBOL(pm_power_off);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
