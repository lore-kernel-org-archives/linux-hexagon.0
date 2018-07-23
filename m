From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
Date: Mon, 23 Jul 2018 16:34:27 -0500
Message-ID: <20180723213427.GB12771@codeaurora.org>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
 <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
 <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381670;
        bh=8xQullK9wZoW8wzeo1wIYBPufpfhTLbwqnJhOL/vVSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlczpNt2fjaRhXSHnKsZ+/2BalmDh3EFov8HuHNUEj/fgrMTPOWaax3QRIbHjQ/MQ
         2CocbUvWmFhmdDJEticmNDiA8LP1hxbAxvuYwB40dz+RiYjSxd6HDZFgiHkKlcCALp
         lG8AjVFrfYCqgA6Vu/OBArIgfm48E3ahCuoR5QsM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532381670;
        bh=8xQullK9wZoW8wzeo1wIYBPufpfhTLbwqnJhOL/vVSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlczpNt2fjaRhXSHnKsZ+/2BalmDh3EFov8HuHNUEj/fgrMTPOWaax3QRIbHjQ/MQ
         2CocbUvWmFhmdDJEticmNDiA8LP1hxbAxvuYwB40dz+RiYjSxd6HDZFgiHkKlcCALp
         lG8AjVFrfYCqgA6Vu/OBArIgfm48E3ahCuoR5QsM=
Content-Disposition: inline
In-Reply-To: <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jul 22, 2018 at 10:24:58AM -0700, Randy Dunlap wrote:
> On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> > CC hexagon
> > 
> > hexagon != H8/300 != SuperH
> 
> argh.  Thanks.
> 
> > On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
> >> to unsigned long to match the function parameter type.
> >>
> >> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
> >> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
> >> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Rich Felker <dalias@libc.org>
> >> Cc: linux-sh@vger.kernel.org
> >> ---
> >>  arch/hexagon/kernel/dma.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>

Thanks all the same!

For Hexagon:


Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
