From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 13/41] mm: Make pte_mkwrite() take a VMA
Date: Wed, 1 Mar 2023 09:16:06 +0100
Message-ID: <550c6035-6dd0-d215-226b-1a82dafa05d6@redhat.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-14-rick.p.edgecombe@intel.com>
 <1f8b78b6-9f34-b646-68f2-eac62136b9f4@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:Subject:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPmDMQmPcAvg0fyI0LBrc0V1r3hzectofYHnuGl6T1A=; b=ouX4cfumInxTVP
	O5BEz7woEgB/ZxAykgqOA2ZVIsfbmxkn5ZxgWUiFcbfSinbO+QrGLCg52tlIXiH0x4YJXv6u1zSuJ
	VqUfCkGNr0dpG5iaWzJSWim9qJC6DRPwxP+NbNK5PoDSSLGOV35nD7sgUkF6K0SuoPcdt6R44kPKP
	YNNAkUMDyGGSibKyh/sOOQMDwSoPDTl/HdSsXVVVs+ylLhZXT3RvBBlS/w/+3met4TI8Dy2I3kNKw
	z5Qt9hKNmpUFmqiiHWGuUZh8oQu4iLH82L2guMos2ZY1tp+6AfSst/zqpvgAeGvQBMMT3WKDTpmuo
	rGDkpgkaDNPPX0cM9EPg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677658571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQIo0hNE1IdmdTJeAfVSWSJHdp/A2L81MbqwgQGi7/s=;
	b=Lgx4494Ki92A8P7KBec9GZ+oniD/so9S6s376pXCBfwIZbpFryYzm7VuUbDCudOmPpuazJ
	BZlYjiR+awKb7+/obJJdaVaNJPlnbEr8EXFHhRoDxhAjgvdnre76/wb2aZFcUicW5ld7qE
	AjRVQKfqtaApCJ9VvbYhapBkNy2Iiis=
In-Reply-To: <1f8b78b6-9f34-b646-68f2-eac62136b9f4@csgroup.eu>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan
Cc: "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <l>

T24gMDEuMDMuMjMgMDg6MDMsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6Cj4gCj4gCj4gTGUgMjcv
MDIvMjAyMyDDoCAyMzoyOSwgUmljayBFZGdlY29tYmUgYSDDqWNyaXTCoDoKPj4gVGhlIHg4NiBD
b250cm9sLWZsb3cgRW5mb3JjZW1lbnQgVGVjaG5vbG9neSAoQ0VUKSBmZWF0dXJlIGluY2x1ZGVz
IGEgbmV3Cj4+IHR5cGUgb2YgbWVtb3J5IGNhbGxlZCBzaGFkb3cgc3RhY2suIFRoaXMgc2hhZG93
IHN0YWNrIG1lbW9yeSBoYXMgc29tZQo+PiB1bnVzdWFsIHByb3BlcnRpZXMsIHdoaWNoIHJlcXVp
cmVzIHNvbWUgY29yZSBtbSBjaGFuZ2VzIHRvIGZ1bmN0aW9uCj4+IHByb3Blcmx5Lgo+Pgo+PiBP
bmUgb2YgdGhlc2UgdW51c3VhbCBwcm9wZXJ0aWVzIGlzIHRoYXQgc2hhZG93IHN0YWNrIG1lbW9y
eSBpcyB3cml0YWJsZSwKPj4gYnV0IG9ubHkgaW4gbGltaXRlZCB3YXlzLiBUaGVzZSBsaW1pdHMg
YXJlIGFwcGxpZWQgdmlhIGEgc3BlY2lmaWMgUFRFCj4+IGJpdCBjb21iaW5hdGlvbi4gTmV2ZXJ0
aGVsZXNzLCB0aGUgbWVtb3J5IGlzIHdyaXRhYmxlLCBhbmQgY29yZSBtbSBjb2RlCj4+IHdpbGwg
bmVlZCB0byBhcHBseSB0aGUgd3JpdGFibGUgcGVybWlzc2lvbnMgaW4gdGhlIHR5cGljYWwgcGF0
aHMgdGhhdAo+PiBjYWxsIHB0ZV9ta3dyaXRlKCkuCj4+Cj4+IEluIGFkZGl0aW9uIHRvIFZNX1dS
SVRFLCB0aGUgc2hhZG93IHN0YWNrIFZNQSdzIHdpbGwgaGF2ZSBhIGZsYWcgZGVub3RpbmcKPj4g
dGhhdCB0aGV5IGFyZSBzcGVjaWFsIHNoYWRvdyBzdGFjayBmbGF2b3Igb2Ygd3JpdGFibGUgbWVt
b3J5LiBTbyBtYWtlCj4+IHB0ZV9ta3dyaXRlKCkgdGFrZSBhIFZNQSwgc28gdGhhdCB0aGUgeDg2
IGltcGxlbWVudGF0aW9uIG9mIGl0IGNhbiBrbm93IHRvCj4+IGNyZWF0ZSByZWd1bGFyIHdyaXRh
YmxlIG1lbW9yeSBvciBzaGFkb3cgc3RhY2sgbWVtb3J5Lgo+Pgo+PiBBcHBseSB0aGUgc2FtZSBj
aGFuZ2VzIGZvciBwbWRfbWt3cml0ZSgpIGFuZCBodWdlX3B0ZV9ta3dyaXRlKCkuCj4gCj4gSSdt
IG5vdCBzdXJlIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGFkZCBhIHNlY29uZCBhcmd1bWVudCB0bwo+
IHB0ZV9ta3dyaXRlKCkuIEFsbCBwdGVfbWt4eHh4KCkgb25seSB0YWtlIGEgcHRlIGFuZCBub3Ro
aW5nIGVsc2UuCgpXZSB0b3VjaGVkIG9uIHRoaXMgaW4gcHJldmlvdXMgcmV2aXNpb25zIGFuZCBz
byBmYXIgdGhlcmUgd2FzIG5vIHN0cm9uZyAKcHVzaCBiYWNrLiBUaGlzIHR1cm5lZCBvdXQgdG8g
YmUgY2xlYW5lciBhbmQgZWFzaWVyIHRoYW4gdGhlIAphbHRlcm5hdGl2ZXMgd2UgZXZhbHVhdGVk
LgoKcHRlX21vZGlmeSgpLCBmb3IgZXhhbXBsZSwgdGFrZXMgYW5vdGhlciBhcmd1bWVudC4gU3Vy
ZSwgd2UgY291bGQgdHJ5IAp0aGlua2luZyBhYm91dCBwYXNzaW5nIHNvbWV0aGluZyBlbHNlIHRo
YW4gYSBWTUEgdG8gaWRlbnRpZnkgdGhlIAp3cml0YWJpbGl0eSB0eXBlLCBidXQgSSBhbSBub3Qg
Y29udmluY2VkIHRoYXQgd2lsbCBsb29rIHBhcnRpY3VsYXJseSBiZXR0ZXIuCgo+IAo+IEkgdGhp
bmsgeW91IHNob3VsZCBkbyB0aGUgc2FtZSBhcyBjb21taXQgZDllZDlmYWFjMjgzICgibW06IGFk
ZCBuZXcKPiBhcmNoX21ha2VfaHVnZV9wdGUoKSBtZXRob2QgZm9yIHRpbGUgc3VwcG9ydCIpCj4g
CgpXZSBhbHJlYWR5IGhhdmUgMyBhcmNoaXRlY3R1cmVzIGludGVuZGluZyB0byBzdXBwb3J0IHNo
YWRvdyBzdGFja3MgaW4gCm9uZSB3YXkgb3IgdGhlIG90aGVyLiBSZXBsYWNpbmcgYWxsIHB0ZV9t
a3dyaXRlKCkgd2l0aCAKYXJjaF9wdGVfbWt3cml0ZSgpIGRvZXNuJ3Qgc291bmQgcGFydGljdWxh
cmx5IGFwcGVhbGluZyB0byBtZS4KCgotLSAKVGhhbmtzLAoKRGF2aWQgLyBkaGlsZGVuYgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJpc2N2
IG1haWxpbmcgbGlzdApsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YK
