From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 RESEND 02/17] hexagon: mm: Convert to GENERIC_IOREMAP
Date: Tue, 16 May 2023 23:27:37 -0700
Message-ID: <ZGRz2Yf5JFEXIQHN@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-3-bhe@redhat.com>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=C/Ip+nZ88Lg16jN150ohkiRv/K
        hw5otNlOy1KIkGun+Ve6l/Hhji8vSexglMjBtUGCv1TLDuUKw7ky06TJFgA3LscjFYb65Oca5NHVK
        ifzQz5GZSs3Vsco5CF1QJ9DDf4685fe4Ga60xa8NYiu33bCtf+4H0UArAAK6POoYoLEDUTBS7W/Pa
        xPJNuROTu0ikKSjmOJFHjB378xCA35GmUxtI9iKS+sVMCOWlWmkkHOzH0q8PUP4cibvvMGFNsuOSI
        E2gEUHfgaJmPO7j4ykABwKMBGnTUq/FbJ7Op/G7RHJ9pfx05dciQlsfrVlYqst/ebMpxzCfR4H4C0
        XaH0RmQg==;
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-3-bhe@redhat.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu, hch@infradead.org, agordeev@linux.ibm.com, wangkefeng.wang@huawei.com, schnelle@linux.ibm.com, David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org, deller@gmx.de, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
