From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 26/26] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
Date: Thu, 23 Jun 2022 22:11:26 -0700
Message-ID: <YrVHfuWsRCDq8yWm@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-27-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2GQmE4wpGszBczHjwvtfZyfMa6
        QogWMdymTjPg5XZOUhXij8uvDIrmHLPTalVWmgMeJy2PeomTEabCD8eIZNj8Bhzhu6VGbhWH+ghNJ
        sWSwU1GSy7ksgPL/29ADir39+i3q/Q4DXasGhFBp+UAZ/3ss24jHWpscbqhPKzoBBqB2m86CCUwt4
        r/U4PSNRJY2DRagOfbocXVwxuCa7Owx8jsWAgbqIsvfHCh2d7j2ZPKNzmnybdSuW8CVKwgGxxm4JV
        hqzEdK/brFNnhKm5V8hP87B7M1yEwoRUUTkU2GXcA4HfUVVqA8KREKrKm3hHI05sz9HDImIYrFGE+
        D9iMxPcA==;
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-27-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
