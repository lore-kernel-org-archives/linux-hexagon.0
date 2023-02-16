From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Thu, 16 Feb 2023 13:53:21 +0100
Message-ID: <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676552020; x=1676638420; bh=DbrLQv3/pV
        tTQOZWpqNFqEWPdA+pKJ3lEDwvQXG6DB4=; b=oauL0G1TRIlgWSz7p8TU8eHziQ
        UmDyJnfH5478eg3C2PjAxRr2fBk8tvZ2aV8nQVdeXDG1OFRJpOjNnlO9RC8YbKJP
        6u1zBU2soFfeEQJO14Ukd4ELMdGyLuJvzsEB/cM8m/ipQPhZtmEk4KESmv9Mx80d
        +7CYqkOL1aRdBego+2AwNSxvwG8uOgDerQ/vKHnRkcRLzgHV8Z7V7CvoclxqWxg+
        l6WszlcPqwYonGkhmfTkxXKN+zOTqWDJ1ioOfnMvo0yxIM/bCEhHnQW5wz7g6vmx
        qLe2iiMtWJzRJX5db2PRKzbGVpVoTEcsCKrq6S/Qk2nSu7TafxzpMGJBl65w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676552020; x=1676638420; bh=DbrLQv3/pVtTQOZWpqNFqEWPdA+p
        KJ3lEDwvQXG6DB4=; b=t24p3UPWYZ+KCYTj7ighSAiKBdig04/acVYEucG1LfC4
        R+/g9buHJlnRHfHwUN6OzexDtYT3jkuzmFSDMOqGAUD22GEtjYS8jN9WQ69MugDM
        opv8xT4lHdUKFD+LooI2oT5ogfLpPO2fLFJu1XHPyGPhIfZoBxKMnDLm38rDTVoe
        N21pYlEAdqUrqCv6JQQzpS5Wfes/swSdZHYEAFCZqRpFmKJ0N6il6X77AAhXE/6y
        vgxa89YBjC2wZzlhiZOjc6AYdZMxhLvol7Yxo3a8mfOfwWeb9GW/MHqdxXYcGhfO
        wP33vY0sSgAwMiw5dLQsVwGReJBlmf+ToqipESJ4/g==
In-Reply-To: <20230216123419.461016-2-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Niklas Schnelle <schnelle@linux.ibm.com>, David Laight <David.Laight@ACULAB.COM>, Stafford Horne <shorne@gmail.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> diff --git a/arch/hexagon/include/asm/io.h 
> b/arch/hexagon/include/asm/io.h
> index 46a099de85b7..dcd9cbbf5934 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void 
> __iomem *addr)
>  #define writew_relaxed __raw_writew
>  #define writel_relaxed __raw_writel
> 
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> -#define ioremap_uc(X, Y) ioremap((X), (Y))
> +/*
> + * I/O memory mapping functions.
> + */
> +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> +		       (__HEXAGON_C_DEV << 6))
> +
> +#define ioremap_uc(addr, size) ioremap((addr), (size))

I think we probably want to kill off ioremap_uc() here, and use
the generic version that just returns NULL.

I see that there are only two callers of {devm_,}ioremap_uc() left in the
tree, so maybe we can even take that final step and remove it from
the interface. Maybe we can revisit [1] as part of this series.

     Arnd

[1] https://lore.kernel.org/all/20191111192258.2234502-1-arnd@arndb.de/
