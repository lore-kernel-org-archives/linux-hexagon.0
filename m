From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 02/21] mm: make early_pfn_to_nid() and related defintions
 close to each other
Date: Tue, 21 Apr 2020 17:33:43 +0800
Message-ID: <20200421093343.GR4247@MiWiFi-R3L-srv>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-3-rppt@kernel.org>
 <20200421022435.GP4247@MiWiFi-R3L-srv>
 <20200421084935.GB14260@kernel.org>
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
	List-Owner; bh=Lt+PFesyRLYuFha+WzVdqnlln6pZ8n+Kn6qaEFjJ3cg=; b=AglGC6Ie3XA9Ax
	Ku6SLGjFN3lmdsT+zMtJMX7WrCO0WEQZ9s1vL8dZ9ZzSx53ZMhyNBJANTUNnFTpVfMO0cY/QlpaaN
	lw5teySh2qk/0udGaphL1zHhXwUzOg8qtOMFD2j6husPZv1HYXznKc798UqJTiHZOaw3E33GLp8ts
	qh88p4/sJ2f6MgnxihvU/Wq4RLFJHVqA6wUOkN1zu+CwZUF+NPRQYaVlg3RpOBQCsAYtuzSs1yOwP
	YjRSoroLyYZ8baOnA6iLYZJ7KPh6KBPQIOzyUcL6/IRnGZUFF1qXLm/QQWyKifB3On8RuMeBDi5JN
	DXmrv2KXyzwPwSsV19+A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587461638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZvQHIk5yGSRjXjKFjsIWFy/S1Ns+gE0RZWu1SFT0Hc=;
 b=c5KuZwro3sja7Atniy/S291LqSxCuvYWhMWE/tBDplitsQjrfzds/VWEfh37i/i4WBwpUe
 82EJ27iiHMzK7FkpQ1k4N5z343RXsq7eKpjPXbHIybZT52H9vcfZ8uVB9j5Kj2r9NojNNr
 nr1GAFiluwgzq615vRZJt5CffxHvNu0=
Content-Disposition: inline
In-Reply-To: <20200421084935.GB14260@kernel.org>
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.>

On 04/21/20 at 11:49am, Mike Rapoport wrote:
> On Tue, Apr 21, 2020 at 10:24:35AM +0800, Baoquan He wrote:
> > On 04/12/20 at 10:48pm, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > The early_pfn_to_nid() and it's helper __early_pfn_to_nid() are spread
> > > around include/linux/mm.h, include/linux/mmzone.h and mm/page_alloc.c.
> > > 
> > > Drop unused stub for __early_pfn_to_nid() and move its actual generic
> > > implementation close to its users.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > ---
> > >  include/linux/mm.h     |  4 ++--
> > >  include/linux/mmzone.h |  9 --------
> > >  mm/page_alloc.c        | 51 +++++++++++++++++++++---------------------
> > >  3 files changed, 27 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 5a323422d783..a404026d14d4 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -2388,9 +2388,9 @@ extern void sparse_memory_present_with_active_regions(int nid);
> > >  
> > >  #if !defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) && \
> > >      !defined(CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID)
> > > -static inline int __early_pfn_to_nid(unsigned long pfn,
> > > -					struct mminit_pfnnid_cache *state)
> > > +static inline int early_pfn_to_nid(unsigned long pfn)
> > >  {
> > > +	BUILD_BUG_ON(IS_ENABLED(CONFIG_NUMA));
> > >  	return 0;
> > >  }
> > 
> > It's better to make a separate patch to drop __early_pfn_to_nid() here.
> 
> Not sure it's really worth it.
> This patch anyway only moves the code around without any actual changes.

OK, it's fine to me.
