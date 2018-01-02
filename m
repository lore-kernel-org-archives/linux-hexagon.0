From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 29/67] dma-direct: use node local allocations for coherent memory
Date: Tue, 2 Jan 2018 11:29:10 +0100
Message-ID: <CAMuHMdU0_p4RHSKL891YCgej_L2KM5cxmhXDLXVUBXgWoUosVA@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-30-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qfjKXtZt+M5JKOq/3qU+LNmrxcg5PJqG2jPHSJt088Q=;
        b=NbZ244SftgiA5W/RcyfKrQSoy2Q7tmtsTwyOyNBGYZTq3MwDsBZ2UiHpEQHGajWfsl
         nnLru9ngeUEqYYJoLrvzdmymhC4+9nfATMh5SroCKTHQOjKyUi+tXT8KWIVMdyzu6xez
         29JogSJd1vaJ42PHcuxi/iM4Z0o6C/5dpvjsFrMZRNzTo0AZj0sX7qy1+MzAtoESZ+Wx
         YDYYpDM0qqeNcEH0BtaTSYFeC8qVC0eh/TuIoy+eLBw5rRrm7KaECEULTNnZALM5Gd2p
         KShnjL6l+g4rB4BIPBdwnAlFyV9s/rpO8Usffm5+iwlOJW+SiuZLxSmPB87WO1yDGl56
         0Lgw==
In-Reply-To: <20171229081911.2802-30-hch@lst.de>
Sender: linux-ia64-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.or>

Missing patch description explaining why this change is desirable.

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -39,7 +39,7 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
>         if (gfpflags_allow_blocking(gfp))
>                 page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
>         if (!page)
> -               page = alloc_pages(gfp, page_order);
> +               page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
>         if (!page)
>                 return NULL;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
