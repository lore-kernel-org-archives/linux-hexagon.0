From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable RFC 00/26] mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all architectures with swap PTEs
Date: Wed, 14 Dec 2022 12:22:49 +0100
Message-ID: <10bd4fc0-4fc0-bd98-6926-7d721a3bb12e@redhat.com>
References: <20221206144730.163732-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lSWQshZH7PwSrjiYcf/87VQdVHfGLPygYjqiDTpoFkE=; b=S2NYRCAWml610d
	NGlu/nwAdn1E0Ti/uzhb2WhU8AJE91ZR/GB3AvKhoxkB42KBjCh7tRlCgQAE3ETF6fR4Qtd9WZj5N
	H7WaRo+mUqZf2mtPvjYmUgQ2cUw2+3QO7sjAmWJrLWz6q/t9IlIlcxxaphG32V4yPOhxkWaSNM7cz
	u5qfk7ZPFaGSa/9wQoQ6/zO18QknGztG9bXVfjrAD75HlgrH9CJCU6OweQZfJ6Skx8ropDNX+DpDi
	jfw/ZIaUsMV2PbxHCdtIAXgqBRCTq1Jdqk1Wk6SduTLmhsFC8MmiiL1z0qtMmA5i2vpcsvgYv/g9J
	eW2gywGogQhow5hpBkOQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671016975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxc01zNwMiugjthmgVOlTrtXQnLfLvXjRGMFtbZZLpc=;
	b=TRsRFy5HWKRJqqxwbSC38MkkVL+pzQVaN48RIhRUvbQBZyedt24vDxP9faiB3QhLUvtPSW
	jUDazLShTTjthZ9qY/reRE4y5Cap5trYiKq0KlvknrQ+4PgoYPXpD9HQWOo6Qg6rAtYfiW
	/1ZfU7LhfXDdM3IHhUpPVAiJXEkDOlY=
In-Reply-To: <20221206144730.163732-1-david@redhat.com>
Content-Language: en-US
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lis

On 06.12.22 15:47, David Hildenbrand wrote:
> This is the follow-up on [1]:
> 	[PATCH v2 0/8] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of
> 	anonymous pages
> 
> After we implemented __HAVE_ARCH_PTE_SWP_EXCLUSIVE on most prominent
> enterprise architectures, implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE on all
> remaining architectures that support swap PTEs.
> 
> This makes sure that exclusive anonymous pages will stay exclusive, even
> after they were swapped out -- for example, making GUP R/W FOLL_GET of
> anonymous pages reliable. Details can be found in [1].
> 
> This primarily fixes remaining known O_DIRECT memory corruptions that can
> happen on concurrent swapout, whereby we can lose DMA reads to a page
> (modifying the user page by writing to it).
> 
> To verify, there are two test cases (requiring swap space, obviously):
> (1) The O_DIRECT+swapout test case [2] from Andrea. This test case tries
>      triggering a race condition.
> (2) My vmsplice() test case [3] that tries to detect if the exclusive
>      marker was lost during swapout, not relying on a race condition.
> 
> 
> For example, on 32bit x86 (with and without PAE), my test case fails
> without these patches:
> 	$ ./test_swp_exclusive
> 	FAIL: page was replaced during COW
> But succeeds with these patches:
> 	$ ./test_swp_exclusive
> 	PASS: page was not replaced during COW
> 
> 
> Why implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE for all architectures, even
> the ones where swap support might be in a questionable state? This is the
> first step towards removing "readable_exclusive" migration entries, and
> instead using pte_swp_exclusive() also with (readable) migration entries
> instead (as suggested by Peter). The only missing piece for that is
> supporting pmd_swp_exclusive() on relevant architectures with THP
> migration support.
> 
> As all relevant architectures now implement __HAVE_ARCH_PTE_SWP_EXCLUSIVE,,
> we can drop __HAVE_ARCH_PTE_SWP_EXCLUSIVE in the last patch.
> 
> 
> RFC because some of the swap PTE layouts are really tricky and I really
> need some feedback related to deciphering these layouts and "using yet
> unused PTE bits in swap PTEs". I tried cross-compiling all relevant setups
> (phew, I might only miss some power/nohash variants), but only tested on
> x86 so far.

As I was messing with sparc64 either way and got debian to boot under 
QEMU, I verified that the sparc64 change also seems to work as expected 
(under sun4u).

-- 
Thanks,

David / dhildenb
