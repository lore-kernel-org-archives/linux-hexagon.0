From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Sun, 28 Aug 2022 23:08:16 +0800
Message-ID: <YwuE4O/NnRADyrC+@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
 <YwHX98KBEnZw9t6e@infradead.org>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8neMr6g7eV8otY6VIAU2DNTfHwU5LClkKQL29JabBA=;
        b=EgP09V2kGHWufGBeeExTy+cQOZV1m53bJR+lLCUT0O0pLUsSn8M+rhaAFLrgpouthTrGCO
        NN0bbkKsrTl/Y+Gyw1htctkJpk8ZAOyFUOloAbi9IO0EVqZ40dGVx3RdB1QFWxnuyFpdRc
        sYvV218I/NjR5meJz232XwveImjwkNo=
Content-Disposition: inline
In-Reply-To: <YwHX98KBEnZw9t6e@infradead.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On 08/21/22 at 12:00am, Christoph Hellwig wrote:
> On Sat, Aug 20, 2022 at 08:31:19AM +0800, Baoquan He wrote:
> > With it, the old ioremap() and iounmap() can be perfectly removed
> > since they are duplicated with the standard functions.
> 
> Can you write a somewhat better commit message explaining that it
> switches to the generic code that has equivalent functionality?

OK, I will rephrase like below. Please check if it's OK.
==
By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. Arch only needs to
provide implementation of arch_ioremap() or arch_iounmap() if there's
arch specific handling needed in its ioremap() or iounmap(). This
change will simplify implementation by removing duplicated codes with
generic ioremap() and iounma(), and has the equivalent functioality
as before.

> 
> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> 
> This is wrong and hexagon should use the asm-generic version of
> ioremap_uc that returns NULL.

I don't follow. Do you mean the function verion, but not a macro? Or
define it like below?

#define ioremap_uc(addr, size)  \
        ioremap_prot((addr), (size), _PAGE_IOREMAP)

