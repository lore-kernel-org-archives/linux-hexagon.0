From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across
 platforms
Date: Thu, 23 Jun 2022 22:12:30 -0700
Message-ID: <YrVHvv0spuMsC1In@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-ia64-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=20i464jFDQRcmcNOUSKspwUa6bqXoH9FmrotpkAtY4c=; b=st+tFTnm+PpdRCXxa+K5x7vb5B
        R72N8aDZCXlJ6KJzgb+yzmuCts+GeEibm9tVn6M/vW5eMvoUfMxGmIHoP8sQen1ut1CzMeQicil+t
        AeGBjo6UR11rDKgEJi38MST8WmEmtWCcee1yD8QUR1kmo4TSuiJbnJnTnSbcivjvtbu4Ss17aXwHc
        v5lzeWw6loI9CgVv8kJJqHHCJjGOCeUhpeaS3IJ/hcngLd48UXd0QGHVu9pWuGAMSj6M5Q6EkMMj/
        L7VJ7J7Bm39XO6VnOIkLtGXPk7WzthXyckA4mHE55qtxJrEsgKcEXSnZRobi+UQhLQQ5def5khxAa
        IPU3+6Sg==;
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:13:13AM +0530, Anshuman Khandual wrote:
> vm_get_page_prot(), in order for it to be reused on platforms that do not
> require custom implementation. Finally, ARCH_HAS_VM_GET_PAGE_PROT can just
> be dropped, as all platforms now define and export vm_get_page_prot(), via
> looking up a private and static protection_map[] array. protection_map[]
> data type is the following for all platforms without deviation (except the
> powerpc one which is shared between 32 and 64 bit platforms), keeping it
> unchanged for now.
> 
> static pgprot_t protection_map[16] __ro_after_init

On most architectures this should be const now, only very few ever
modify it.
