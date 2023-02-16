From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Thu, 16 Feb 2023 22:47:24 +0800
Message-ID: <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676558857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFaX4cxZUJf+Ng89cRL/nlepV5PVhHHLPICLCsLRqZ4=;
        b=Z5GhV3dsQbv6Od4Puaqc6GGqb8MEGwy0Ydhac0Hg9H218glkVU9yxM1Hz51jnq9bGVMg4K
        QHjXcF36VLH368rECh9Hn3GCTXnDO2VN7t1A9bowfiXaUc8uwsmqKR6RbTxEoNGgXAnO50
        mhdJfj8P8BzxpOJYbAVmgAJw7rUtrQs=
Content-Disposition: inline
In-Reply-To: <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Niklas Schnelle <schnelle@linux.ibm.com>, David Laight <David.Laight@aculab.com>, Stafford Horne <shorne@gmail.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> > diff --git a/arch/hexagon/include/asm/io.h 
> > b/arch/hexagon/include/asm/io.h
> > index 46a099de85b7..dcd9cbbf5934 100644
> > --- a/arch/hexagon/include/asm/io.h
> > +++ b/arch/hexagon/include/asm/io.h
> > @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void 
> > __iomem *addr)
> >  #define writew_relaxed __raw_writew
> >  #define writel_relaxed __raw_writel
> > 
> > -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> > -#define ioremap_uc(X, Y) ioremap((X), (Y))
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> > +		       (__HEXAGON_C_DEV << 6))
> > +

Thanks for reviewing.

> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> 
> I think we probably want to kill off ioremap_uc() here, and use
> the generic version that just returns NULL.


-#define ioremap_uc(X, Y) ioremap((X), (Y))
+#define ioremap_uc(addr, size) ioremap((addr), (size))

Here, in fact the ioremap_uc() definition is not related. I just
improve the old definition passingly. And similar for other
ioremap_uc() adaptation.

> 
> I see that there are only two callers of {devm_,}ioremap_uc() left in the
> tree, so maybe we can even take that final step and remove it from
> the interface. Maybe we can revisit [1] as part of this series.

I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
didn't get why. Thanks for the details. 
https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u

I am not sure if it's OK to do the change in this patchset, maybe
another patch?

Thanks
Baoquan

