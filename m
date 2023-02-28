From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v1 19/26] riscv/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date: Tue, 28 Feb 2023 16:56:30 +0100
Message-ID: <bd656b2c-9a20-dea9-dcef-9cc965bccc9e@redhat.com>
References: <mhng-b8dc8a57-dde0-4995-bbb7-3948a95ba0b1@palmer-ri-x1c9a>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kCGwvpiKxCWgpwYAsI1H2zryLWp7cFNXQvrTdc4pIz4=; b=QiLPIY48+1T9za
	e3GBzRg3V+kXVfnaRqg/mZeyNtaMZCupGqRjb2Mg2RXKm9iIL2lZiS7AiwT/8A0FFospoqIkb2qM3
	cvPrgiO0Rcigch/kxtV4yKeUFCsJ8qhAaZtVA7ABFk3uE2CsSFnag/FF1ShqrqmVNY8+5CRK062kR
	fwLHVHPlEIHssU0HbBTVCEyDbs5eb+/a1TBx8Atlfol98H3xkp9CPZPVEGCWNHPDIxF41rAn1g8XP
	Xcgn9P90pLEB6TbTYUPMF64pBvnwrKRlRn/3M+6UWtofrHxyBxngJGxiXnU6SSj4x01fQklsD9/AI
	UWsKgdgdapdUIwRQg5Sg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677599795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7pSWC5euLmUDx9YG5RWzWaGkcDB950fdhQfUYWKICc=;
	b=L7YliKV/d3202CCEuU9Fu2ac86tPOoUC+750FU1UZiFNnKKVsSvv9T7SgjZOSG/zn0wRsS
	KY458A7FWA74fitA5SLEBpgpLgM7VD7z6cx4ectDFvde8wsW2gXG2GVzJ6wVslmhqI/Rb1
	YK4AHB1E0McrSW3VjATaBEavJpoDBjY=
In-Reply-To: <mhng-b8dc8a57-dde0-4995-bbb7-3948a95ba0b1@palmer-ri-x1c9a>
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
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, hughd@google.com, jhubbard@nvidia.com, jgg@nvidia.com, rppt@linux.ibm.com, shy828301@gmail.com, vbabka@suse.cz, namit@vmware.com, aarcange@redhat.com, peterx@redhat.com, linux-mm@kvack.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu

On 28.02.23 16:50, Palmer Dabbelt wrote:
> On Fri, 13 Jan 2023 09:10:19 PST (-0800), david@redhat.com wrote:
>> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
>> from the offset. This reduces the maximum swap space per file: on 32bit
>> to 16 GiB (was 32 GiB).
> 
> Seems fine to me, I doubt anyone wants a huge pile of swap on rv32.

Patch is already upstream, so we can't add tags unfortunately. Thanks 
for the review!

-- 
Thanks,

David / dhildenb
