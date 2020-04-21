From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 02/21] mm: make early_pfn_to_nid() and related defintions
 close to each other
Date: Tue, 21 Apr 2020 11:39:46 +0300
Message-ID: <20200421083946.GA14260@kernel.org>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-3-rppt@kernel.org>
 <20200421033114.GA29658@MiWiFi-R3L-srv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bm1zOp+a0RuVIbVElG+1bKd7CJscLbJpk2d/MEaHXsY=; b=AQqG6fBbbh/myi
	YY7SPCPRroSwjFXFtH5wopXa8aPWWoPFAyHbWp7JyJaPUE26e2/MLTbiDxKfaTie4BUHwLcszAN1u
	DnAkf8gUnhOAYpva2qwTXyjSZhbsD127n8Kdm1p31dFqBkdZ+bW4ooqZjHDQhDAr2GO2C/MW/PLNO
	6qzjZ1aJT03DqU6WKP3ARZSMaO3iFauvCR4ekbGBhS8ta+MNGs1Os1v62wItA6gbjWkYsXpOGYNp+
	kAtPj80vhxv4dR4WTWIqTZap43DL/a9QzfXLW0mGbxcPb9tWXiCj+uWLzPKeT0c1dFF+GLfv/dN6f
	SVTYT3eOSYnO+6m4j1kA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587458410;
 bh=l7Z4NyqL5od1jbAA7ZDTEBBIO7g4fvfTfMGTzVGUi6M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zQogE0EBDyWoltfVVcsUWpEc71vAasrtxi/6gSs/avZ4WYft7fCfj1uyPSS2qCFhm
 qXfoaNsKzKhrsS0tm3OJ+UX6E74IIe+p+MaHcBd5yW/yIMKMZQvraj6agwXvN9OW+h
 LGBiCxPTiVUrhobVpOJ55kgsc8GtUkESKuo6vg10=
Content-Disposition: inline
In-Reply-To: <20200421033114.GA29658@MiWiFi-R3L-srv>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>, 
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>

On Tue, Apr 21, 2020 at 11:31:14AM +0800, Baoquan He wrote:
> On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
> > around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.
> > 
> > Drop unused stub for __early_pfn_to_nid() and move its actual generic
> > implementation close to its users.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  include/linux/mm.h     |  4 ++--
> >  include/linux/mmzone.h |  9 --------
> >  mm/page_alloc.c        | 51 +++++++++++++++++++++---------------------
> >  3 files changed, 27 insertions(+), 37 deletions(-)
 
...

> >  int __meminit early_pfn_to_nid(unsigned long pfn)
> >  {
> >  	static DEFINE_SPINLOCK(early_pfn_lock);
> > @@ -6298,32 +6323,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
> >  	zone->initialized = 1;
> >  }
> >  
> > -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
> 
> Here it's apparently removing CONFIG_HAVE_MEMBLOCK_NODE_MAP too early,
> it should be done in patch 3, and its #end is kept there. I just found
> it when I almost became dizzy in reviewing patch 3.

Right, thanks for catching!

> > -#ifndef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
> > -

-- 
Sincerely yours,
Mike.
