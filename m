From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] arch: unexport asm/shmparam.h for all architectures
Date: Wed, 9 Jan 2019 07:19:30 +0900
Message-ID: <20190108221930.GQ3235@lianli.shorne-pla.net>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
 <20190108111032.GP3235@lianli.shorne-pla.net>
 <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/O3sY8celNMvtR9WhIqaTjCanK7+dtn6FuJgraOR7Uw=;
        b=fbmmFUjh8COCYh5vjmZyvsTK03G99sIrzefroQ5j2Uu9CO9ADuBlP173v5pOy8mkv9
         ciWJf5mnLE1UPL7SQi4Yiags1nwwvcqUkSlMhsqptXAjFJMx6tZ01b5pPtOdHzspitut
         Vo597QJWW7ki/mitT1ERlnnvD4obEg0SxPk4+rLodY/MZ5FSEekGfjTcZVXqbE+1kSn+
         Cif7+1EG12rKvpIR+fR3PktyXs/SvTFO4h/5kk/jAXtAlDMGofTanPAFiKqfiZNGkVsY
         Bn5TvhtCbKZx5nVhnJGTdkzyaTR5pJyaBdmz/NAkWosY9WfgkLCGIPoPVvLQn59zi3+9
         vnDg==
Content-Disposition: inline
In-Reply-To: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Guan Xuetao <gxt@pku.edu.cn>, linux-arch <linux-arch@vger.kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-riscv@lists.infradead.org, Greentime Hu <green.hu@gmail.com>, linux-c6x-dev@linux-c6x.org, Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-m68k <linux-m68k@lists.linux-m>

On Wed, Jan 09, 2019 at 12:32:28AM +0900, Masahiro Yamada wrote:
> Hi Stafford,
> 
> 
> 
> On Tue, Jan 8, 2019 at 8:12 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
> > issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.
> 
> 
> Based on Linus' latest tree.
> (commit 3bd6e94be)
> 
> v5.0-rc1 is NOT the latest.

OK, understood, in that case:

Acked-by: Stafford Horne <shorne@gmail.com>

(though I see its already being picked up on the -mm tree)

> > It seems shmparam.h is not there. It was removed with the others in your
> > ("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
> > days ago.
> >
> > Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
> > get it merged asap :)
> 
> 
> I notice the breakage of several arches after v5.0-rc1 release,
> so I asked Linus to pick up 3d6e94be.
> 
> I had already noticed
> having shmparam.h in uapi is werid,
> but I decided to fix the build errors first.

Yes, that makes sense.

-Stafford
