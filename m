From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH 17/67] microblaze: rename dma_direct to dma_microblaze
Date: Fri, 29 Dec 2017 21:11:56 +1100
Message-ID: <CAGRGNgW1qwLcCAvU2Jc=3_7b-0Bu016to3cQUgVsc+ca0No_6g@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-18-hch@lst.de>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OZDKQObnogCo43/g0ZefdMeItSxZ/d1jpfe8RdFWxFc=;
        b=A1dyY1BvC81xdajAaWe5z6Iod6eMrkXkCitK1deR7L6htbFsYIvEK/HdbyI6HodMKZ
         sbn5FwmNuHKzpKbfV0hH/O4ObLYRlUQjxosVGUMMRq+StM8KaucLTwmd/4eTI8pnosCv
         O3z7n7OvBMWKS2DppdyEiK6rhNS3qNU3z4kP+t+auEYs9M5Oqcvwo0I9k2DLfbmwV//2
         sqWGOCudUxtlua44JMnRNsk4xFZpM6Z6ZB/tpbniEd9ha1qDcOzmTs6+yJEzuBtzqHIY
         GImtxUK4KKmUt+oISe07ZXBZePl0GTQ8J+nT/kInjx2jj+fmacU+mE4gKOSjW5l8Z0H0
         ri6g==
In-Reply-To: <20171229081911.2802-18-hch@lst.de>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Christoph,

On Fri, Dec 29, 2017 at 7:18 PM, Christoph Hellwig <hch@lst.de> wrote:
> This frees the dma_direct_* namespace for a generic implementation.

Don't you mean "dma_nommu" not "dma_microblaze" in the subject line?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
