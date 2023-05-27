From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Date: Sat, 27 May 2023 16:09:31 +0100
Message-ID: <ZHIdK+170XoK2jVe@casper.infradead.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
 <20230525090956.GX4967@kernel.org>
 <CAOzc2pxSH6GhBnAoSOjvYJk2VdMDFZi3H_1qGC5Cdyp3j4AzPQ@mail.gmail.com>
 <20230525202537.GA4967@kernel.org>
 <CAOzc2pxD21mxisy-M5b_SDUv0MYwNHqaVDJnJpARuDG_HjCbOg@mail.gmail.com>
 <20230527104144.GH4967@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SmhIuS86a+uo+RW0XDZAll8EVRJUwySc8mbfZ9ljVJk=; b=Rasg30Fdck9s4o
	dh3SSIIqeS6Jl2YNNl27unovOX7ADwwc1v/17bLOJYNh1kTtQgnq5mBOcsbUYywz9PIA1LV6r8HEt
	eVdgnVCZitC46r2FrwQ14GDAxE3LhQquoTlAq4dvhBkmJL8UVoaoWb+E3k4LwpYP7NUpFfv9FQ1L/
	OPJhJnRG6wi+77EZ+CM3SvyFY2cxbLoZElHAgYU6w6r9kvBiX62Z1JCArtWWtyJ0Wv1882/Z4NZOP
	XkbntN+y1QPwHea2Q6HnZPVOoZOgdWbDO6f1FF9Cx5UAY14OFvOE6r1/zDp0SUHxp851zb0/cGfZt
	MXUUuCEDltx/f8DP3B7w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u50hcZSLxjXk+ZnHObIQ29gSZuYnejTLeMWOgyxvfyQ=; b=kvDbU0q2z5jUTh3d5nQNpnIto9
	5xrW767Q1PCPoDvq7cJx36GAZEG2mizda3DrQtiBOGyiytCq2OMTOEXq8TWh2LZ+xzaLqiKD9V9Eb
	EJX8E77j208rlnFcLKHX2rZvcHGssHh261tJ08qNlv2+zYnLCkftBGtSrrF/p39TJSIPJr0ITg4/l
	1g7Vh1u4qG6tN9I49LGc4DG6JUJ0KFWAYdrSkVV8XgiRrI/avMqTujLKkfiEnrTSZ/y+N3Nd9R9D8
	/OJnFeU9SGlsUclnIO5MUMB9v4WCZl1IYBNx4a3hMv/KnLwfYzmktawxgr1m6qrMuAbL8hw04B8Os
	8rYGwubA==;
Content-Disposition: inline
In-Reply-To: <20230527104144.GH4967@kernel.org>
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Vishal Moola <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org

On Sat, May 27, 2023 at 01:41:44PM +0300, Mike Rapoport wrote:
> Sorry if I wasn't clear, by "page table page" I meant the page (or memory
> for that matter) for actual page table rather than struct page describing
> that memory.
> 
> So what we allocate here is the actual memory for the page tables and not
> the memory for the metadata. That's why I think the name ptdesc_alloc is
> confusing.

But that's going to be the common pattern in the Glorious Future.
You allocate a folio and that includes both the folio memory descriptor
and the 2^n pages of memory described by that folio.  Similarly for all
the other memory descriptors.
