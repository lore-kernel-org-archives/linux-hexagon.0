From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 22/67] dma-mapping: clear harmful GFP_* flags in common code
Date: Tue, 2 Jan 2018 11:38:07 +0100
Message-ID: <CAMuHMdX6+E0tN-qxybQ27DoygpUsWngi8J+Fz6K2WZ=FCCuO_A@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-23-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kcGZjOVrx3+3i0d5dYGMeXcfaaIL5yWUZlCAVfcHtXE=;
        b=dkN2XbgQn4hX5pk+3HUsHdW00eaBCWsrGcI7TrxsNt9F0rHsVhaRSDRGN/wRBZk5uH
         n9P1yJOpIVe2/p2VIFBjNJyCfFde1vHjxibo8HPjQXMsThEkhjzWsL97PuFtt4xFKph6
         LuijXeqNnPc0R8AFVODousI9s78N4WYft568nXBRphXQ2yzZ5PTgn06h1yTPoFgBESxW
         HVuyzEQsF2xxMBQfsj57jBlItI3pSJRUeK4dJzx3YoRM7xkHaL70Hbacu9b5BBVnNWO6
         SkKUv9l4TgDgzqEunGxjAj8TGPzoPWtQ9+FwUvPjSvz93FlGrNY6au/1BROEtKN5Ar0O
         YFnw==
In-Reply-To: <20171229081911.2802-23-hch@lst.de>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.or>

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Life the code from x86 so that we behave consistently.  In the future we
> should probably warn if any of these is set.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
