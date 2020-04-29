From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 16/20] mm: remove early_pfn_in_nid() and
 CONFIG_NODES_SPAN_OTHER_NODES
Date: Wed, 29 Apr 2020 17:33:46 +0300
Message-ID: <20200429143346.GI14260@kernel.org>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-17-rppt@kernel.org>
 <20200429141706.GA25142@infradead.org>
Mime-Version: 1.0
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D9eypSqOsC5XLm/gapdjFd3HLPSbUTz8znQDvYgjUjU=; b=cejJ2KpPY6HtWiFt8DeEHp6dK
	vUEPCRGEMaWp7bZueoxvwH8HoxSd3V+bNMqUCnp/E9aEL9GakjwksHiyKmV8FpSlmUYkCDO6mql0Z
	AaU4tWIvDiUr/hF40ZYhLzBJrGP5gVDgArVTIhQRoYHvz35ukZKk+oZHGjJxNPvu7yoA4bT3nWfVN
	PIbl/w12EX6DwX8MGuprLio2UArB4ApW8vfy2uU6kjudQL/oD/JhYZqj7PKens5q6Ot3YsObzei48
	i778zeSV8fbZjsBT9e8vrbXIa2HFuy5sISRNKtYsQbLVCsa1pkNE0/r0sN93P6mtBkbJSNRnapM0s
	L/QL9jARA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588170852;
 bh=WWPVYLJB8cF1eh/bgOa7kKMnwvq4kKVMrtpQ0105+PI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r0MyUrcNByfv40BqZMDUz9VgJFeWUeRjo2JW4VKDF1h/7I/qQIsmP3r+XczFilNcB
 ++CDc2aMtj2e1Vvw7mqelm0S/yNPEGrXgzqXPqqXmHsIltvr+DFp/+T/wSjD9ztS+C
 LzUl9esAqrKIQvImRO0XfT4341bJ3x0mFvf4a1wc=
Content-Disposition: inline
In-Reply-To: <20200429141706.GA25142@infradead.org>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, Ley Foon Tan <ley.foon.tan@intel.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, linux-sh@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hoan Tran <Hoan>

On Wed, Apr 29, 2020 at 07:17:06AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 29, 2020 at 03:11:22PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The commit f47ac088c406 ("mm: memmap_init: iterate over memblock regions
> > rather that check each PFN") made early_pfn_in_nid() obsolete and since
> > CONFIG_NODES_SPAN_OTHER_NODES is only used to pick a stub or a real
> > implementation of early_pfn_in_nid() it is also not needed anymore.
> 
> I don't think you can quote a commit id for something that hasn't been
> commited to mainline yet.i

Ouch, that was one of the things I've indented to fix in v2...

> Then again I would have just merged this
> patch into the one that obsoleted early_pfn_in_nid anyway.

I've kept these commits separate to preserve the authorship.
I'll update the changelog so that it won't mention commit id.

-- 
Sincerely yours,
Mike.

