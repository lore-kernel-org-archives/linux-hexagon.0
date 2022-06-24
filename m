From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V4 06/26] x86/mm: Move protection_map[] inside the
 platform
Date: Thu, 23 Jun 2022 22:10:06 -0700
Message-ID: <YrVHLgHPX2qy+prc@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-7-anshuman.khandual@arm.com>
Mime-Version: 1.0
Return-path: <linux-mips-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=neA8VFkXS3Kz43SJHW5VgrkqEX
        WVjFO74EN06Un2VuV8+fVAxZbk2/LOrhp7EdZ8Lim8Rde4L5Sq+tw8RKUy5quykHhHhJesAaPLeOW
        ua367qVwAuBY2edMdCIibaJaKVso+n5ZQGhqmRL41Ve4hHHCIXAFfG7WR2FUJBljywJJayNgekP0j
        +zE8l99Lr6RToyG8Si3vS1ltCDlQ0dPJbYTQABsyQNIszO8Z7fI/8hT69sxOaHPihqrrTfbxquyHo
        4bfQD/6vmwZUKhQ0S1CvWi4jIWdOSyhxh6kyhaxDm62VTmQp/pu1m8XXOXrlky3eKXb5D69sWY8Xc
        qpp4qIxA==;
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-7-anshuman.khandual@arm.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, x86@kernel.org, openrisc@lists.librecores.org, linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
