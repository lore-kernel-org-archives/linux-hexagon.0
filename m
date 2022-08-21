From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Sun, 21 Aug 2022 00:00:07 -0700
Message-ID: <YwHX98KBEnZw9t6e@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ySj9j9saW2yCa8c+yJi3tbjUYdMOCd4L5+lUeBFBlw=; b=CFKmVhJoVtkiach+yo+gcT08D1
        laKEfLo/oILc9TSGonwru5FCVANzuvnFwQ/3crz8lAV/BpWfSnILYuE//AXjRNbmM8YrOQlJEupHS
        Gg8fYZxHLqsSTkyzOfq/EHNVynE+0A/ZdKOEdoNdxRiFyWN1/o9Uww9lfjerTMmvne5StBJhBMIaV
        8WqTlefjPr0wdF/b287jk6bBPSMrzgTblxlXRYz4yoYNKXM/9Nu+Fn0dZVmthfQBTUengXF73Q1fg
        m0z9GnXcdPuIH8jU84zUdx2pguBjgU1Fwag/Z98gSY8N1BWQsn1OfHUp+IEUTmwLWqV+/AzQKZTsj
        zpBdgLuA==;
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-6-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:19AM +0800, Baoquan He wrote:
> With it, the old ioremap() and iounmap() can be perfectly removed
> since they are duplicated with the standard functions.

Can you write a somewhat better commit message explaining that it
switches to the generic code that has equivalent functionality?

> +#define ioremap_uc(addr, size) ioremap((addr), (size))

This is wrong and hexagon should use the asm-generic version of
ioremap_uc that returns NULL.
