From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Tue, 27 Jun 2023 09:14:29 +0200
Message-ID: <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JMo470WvEChn2ztx7PdY56ZRWeSxU2eKyKWa+7ZOkjQ=; b=KBhARn6lq13B3I
	R29tYotEQpO5z457cvhuWH/X73PV0VgYc2HS4m6CcZurqmjz6X/qTFkEaL7pmqkKyUjmu+OjxlRjz
	+J25jIXpb/euBrb2R24RtfokWuqFedM7DqvQ5tXBaB3gWwU26q0m4GXuJb3zVfdwp8C8daDcgFbeq
	KuLyvU9+yhXw5EI+X9x8MmHLIfXJpFbr29fiPV4/+Uii6XixJqTKjKYoyPtpFWAKRu5HTJpNJefqg
	tqi1xON1eaM0RBVqbON+68C7hnMI2nrYUvPGjwmIiL0ax5W8cuciNnHdpT4gcVSd7287fisTD1L0Z
	W8BV1mCXsdWlGi1IqJXg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687850074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1scKhPxxz/YxysE64BuheSdyQmgV4XhiinPf6icWX8=;
	b=Dn/UUUaYUbwjIQ68CDVKfTpiqL3HVvDYjn8rQZkyUA8eNqQO6LCQ/4zOQJK7dJVYbVVVyr
	UN/cVIcuku792pRTFsNpUKEBqx+imPELoNIZypUwSqq3rjs7/KceX7XOvthKDTekoc2Rph
	bI4CMZbD419KTcuqOOYsw1OhLXkM9S8=
In-Reply-To: <e8992eee-4140-427e-bacb-9449f346318@google.com>
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
To: Hugh Dickins <hughd@google.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Paul Walmsley <paul.wa>

On 27.06.23 06:44, Hugh Dickins wrote:
> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> 
>> The MM subsystem is trying to shrink struct page. This patchset
>> introduces a memory descriptor for page table tracking - struct ptdesc.
> ...
>>   39 files changed, 686 insertions(+), 455 deletions(-)
> 
> I don't see the point of this patchset: to me it is just obfuscation of
> the present-day tight relationship between page table and struct page.
> 
> Matthew already explained:
> 
>> The intent is to get ptdescs to be dynamically allocated at some point
>> in the ~2-3 years out future when we have finished the folio project ...
> 
> So in a kindly mood, I'd say that this patchset is ahead of its time.
> But I can certainly adapt to it, if everyone else sees some point to it.

I share your thoughts, that code churn which will help eventually in the 
far, far future (not wanting to sound too pessimistic, but it's not 
going to be there tomorrow ;) ).

However, if it's just the same as the other conversions we already did 
(e.g., struct slab), then I guess there is no reason to stop now -- the 
obfuscation already happened.

... or is there a difference regarding this conversion and the previous 
ones?

-- 
Cheers,

David / dhildenb
