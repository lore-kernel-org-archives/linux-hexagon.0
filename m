From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 05/14] uaccess: add generic __{get,put}_kernel_nofault
Date: Mon, 14 Feb 2022 09:02:48 -0800
Message-ID: <YgqLONpDAru08JBZ@infradead.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-6-arnd@kernel.org>
Mime-Version: 1.0
Return-path: <linux-arch-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=QlojU+/FbZdIPV2CfVg0g9FlaD
        X9kD9i79czFm+XrIeETqIBZWp7KUAm9gvK8opnry/mfeikiv8qulZrrIaoXhzvURd/9eHLViQwxv5
        LXc/98qskY802/1wdBsFyrYTQ+nvdvOcj9mkxEJaE5tu86xQ3mVdrUG3zLa6PvZZs/wj4/RphKMgX
        Aw4bQl2nwAmM1vfC+2xAC6FWvZxY0AyRmh3Vm08qT5mHqejiG45EXR3L32AXhzoztk3bs49LY+vd9
        B71zul4Ag63ikl89BxppR2RYdf6sfYunHxkkekkdUEP6CO/3vpDXnf6oETlru/9IYq/AaSIK3lD//
        3fbzMB6w==;
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-6-arnd@kernel.org>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, mark.rutland@arm.com, dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, peterz@infradead.org, jcmvbkbc@gmail.com, guoren@kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org, linux-s390@vger.kernel.org, bcain@codeaurora.org, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, linux-csky@vger.kernel.org, mingo@redhat.com, geert@linux-m68k.org, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, hca@linux.ibm.com, linux-alpha@vger.kernel.org, linux-um@lists.in

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
