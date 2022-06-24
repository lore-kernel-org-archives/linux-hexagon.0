From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 01/26] mm/mmap: Build protect protection_map[] with
 __P000
Date: Thu, 23 Jun 2022 22:08:38 -0700
Message-ID: <YrVG1hohcGD56pwV@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-2-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4bN1q5MSAmhJBVSkMIF1AEFBH6
        osYQjeZT9Gm0eNWvIbr6B5A/hfaU7gDlqGDQvFES8oJLhbDSSPdBVAor+f7KOu2jd+T9PRseXXMG/
        B1jAfzmeEKECOOhsQCVHYgtA+0hlcZt5rHStrIJcKwF1UBeCpWbKKklcsctJ9/DgWVM2Aqo5ITIL7
        17jxscatHbqSMl+uzXLGWcirWTk7/WN3VPgeGrh+4kuVJzRZnIticTFn9dPhbXjUiW9uBbgpXoECi
        zqJmt28nR7/TwYIBVozsSEQPahUuBKL1P7p8RimKEZzD9F8c0vlY8PJvBsKm4xpBLhXNk5V+tyCpS
        c/6nVhbg==;
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-2-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
