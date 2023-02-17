From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 01/16] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Fri, 17 Feb 2023 20:11:00 +0800
Message-ID: <Y+9u1CP6yGnDwGlF@MiWiFi-R3L-srv>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-2-bhe@redhat.com>
 <056cc71f-7fb9-4d38-a442-a05de6f7d437@app.fastmail.com>
 <Y+5B/PmGinjCk/fN@MiWiFi-R3L-srv>
 <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676635870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYiaBSjEl56ySuDVwZK8XF9Z2JRTm2SiNTi4k9/d4dY=;
        b=DnOebkU4ibZobaEOGCAept0qSx1mn058XAWEFZpxFhFCGVFAjtX33b4AYsDPKdnvVWzkRj
        ePz/xc80z4UxKZvP1xPhfDAKGWyzDv/hzncO1+B2+cPsxtrfWAbxqZxLZILLcFhjU4Q3+c
        Jb5IlTp7UFmlA+fD0ABKtnQ5fr5PINE=
Content-Disposition: inline
In-Reply-To: <f93fdb4e-05e0-4301-95c9-3e1b1200d9b2@app.fastmail.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, Christoph Hellwig <hch@infradead.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Niklas Schnelle <schnelle@linux.ibm.com>, David Laight <David.Laight@aculab.com>, Stafford Horne <shorne@gmail.com>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On 02/16/23 at 03:51pm, Arnd Bergmann wrote:
> On Thu, Feb 16, 2023, at 15:47, Baoquan He wrote:
> > On 02/16/23 at 01:53pm, Arnd Bergmann wrote:
> >> On Thu, Feb 16, 2023, at 13:34, Baoquan He wrote:
> >> I see that there are only two callers of {devm_,}ioremap_uc() left in the
> >> tree, so maybe we can even take that final step and remove it from
> >> the interface. Maybe we can revisit [1] as part of this series.
> >
> > I see now. Christoph Hellwig ever mentioned in v2 reviewing, I
> > didn't get why. Thanks for the details. 
> > https://lore.kernel.org/all/YwHX98KBEnZw9t6e@infradead.org/T/#u
> >
> > I am not sure if it's OK to do the change in this patchset, maybe
> > another patch?
> 
> Yes, a separate patch would be ideal. If you do the same change in
> more than one architecture (other than ia64 and x86), you can combine
> those into one patch.

I am making a patch to achieve this. There's trouble in mips since it
hasn't had <asm-generic/io.h> in <asm/io.h>, and adding that will cuase
build error. I will post the patch for reviewing.

