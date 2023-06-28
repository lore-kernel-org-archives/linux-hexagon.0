From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Wed, 28 Jun 2023 09:41:18 +0200
Message-ID: <26282cb8-b6b0-f3a0-e82d-b4fec45c5f72@redhat.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
 <e8992eee-4140-427e-bacb-9449f346318@google.com>
 <ac1c162c-07d8-6084-44ca-a2c1a4183df2@redhat.com>
 <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6zs0ITBlj+LpPxGWTn80+biXL3kTNNhF0VLWWCFCmgk=; b=0rCSwW1bSkBkjn
	Eojy2HFuLrQQ1ed8WfKQWyX5g3KBDGr0tj4hv/i7S9L9BYQ0az3TdNDLFg7FLE4sZm+Dygcop1EXM
	BUiCkKhZqsqo2mXWdxo8bg92mkcVSy/FLtBJzTirFAeROf1jcPuVRz5ZymXTMHziyPOl/TQP9PgIx
	w/DONb/Oojpg2DaKEkgJlzjWS1QLdl3CQfC1vRJGd7aVrfb7OTwqI0R211IjZecSQcxyDURvvOdsE
	TVjLnq820+Qm3C8525CYA9yXScWM7IRZ5AGnHKQm+oeXoEcb8Yru9FIR26L1SG34U2qQyDB4uxnaU
	sWAAhUZ1QS2bCKGLkM2g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687938084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SH32jNlN6Jqg7DPKFWcTzn8QudVshhtxY6DizRJx1h4=;
	b=S4D8ghz4dH6SXiRzbL4HnXOL94HXIJ7TdoQEk+FA1LMbfacW8J/dM5fQWvc0FNa8aHq3tS
	vrn3+YLN+GUNj9reo2frJUtFgMlH2zWx0mTzvWwJIMWHVh+dVFFvcwt3Sl3n6EIQkTGIJP
	r5U8KKDWOkaQ4BMCoz8w9Ya4U0q2llM=
In-Reply-To: <90e643ca-de72-2f4c-f4fe-35e06e1a9277@google.com>
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
To: Hugh Dickins <hughd@google.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Claudio

On 27.06.23 22:13, Hugh Dickins wrote:
> On Tue, 27 Jun 2023, David Hildenbrand wrote:
>> On 27.06.23 06:44, Hugh Dickins wrote:
>>> On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
>>>
>>>> The MM subsystem is trying to shrink struct page. This patchset
>>>> introduces a memory descriptor for page table tracking - struct ptdesc.
>>> ...
>>>>    39 files changed, 686 insertions(+), 455 deletions(-)
>>>
>>> I don't see the point of this patchset: to me it is just obfuscation of
>>> the present-day tight relationship between page table and struct page.
>>>
>>> Matthew already explained:
>>>
>>>> The intent is to get ptdescs to be dynamically allocated at some point
>>>> in the ~2-3 years out future when we have finished the folio project ...
>>>
>>> So in a kindly mood, I'd say that this patchset is ahead of its time.
>>> But I can certainly adapt to it, if everyone else sees some point to it.
>>
>> I share your thoughts, that code churn which will help eventually in the far,
>> far future (not wanting to sound too pessimistic, but it's not going to be
>> there tomorrow ;) ).
>>
>> However, if it's just the same as the other conversions we already did (e.g.,
>> struct slab), then I guess there is no reason to stop now -- the obfuscation
>> already happened.
>>
>> ... or is there a difference regarding this conversion and the previous ones?
> 
> I was aware of the struct slab thing, didn't see much point there myself
> either; but it was welcomed by Vlastimil, and barely affected outside of
> slab allocators, so I had no reason to object.
> 
> You think that if a little unnecessary churn (a *lot* of churn if you
> include folios, which did save some repeated calls to compound_head())
> has already occurred, that's a good precedent for allowing more and more?

Well, if you phrase it like that ... no, I'm not in favor of unnecessary 
churn at all. Yes, folios were/are a lot of churn (IMHO not unnecessary, 
though).

I'm not a friend of these "overlays"; it all only really makes sense to 
me once we actually allocate the descriptors dynamically. Maybe some of 
the existing/ongoing conversions were different (that's why I was asking 
for the difference, as you said the "struct slab" thing was well received).

If they are primarily only unnecessary churn for now (and unclear 
when/how it will become useful), I share your opinion.

-- 
Cheers,

David / dhildenb
