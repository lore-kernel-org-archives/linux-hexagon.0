From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Thu, 01 Jun 2023 09:46:06 +0200
Message-ID: <d0ab5473947004ab9f26a07784a2f122574b7a60.camel@physik.fu-berlin.de>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
	 <20230531213032.25338-31-vishal.moola@gmail.com>
	 <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
	 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
	 <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cuKpiSK2vHLbqd9J5fXvozG1fjCHQDkLWVYelzrqJ3A=; b=S2M4G/NIk3X1GO
	/1PQJtBfenPNQbF9w41HAhFEZaYoRN+L+MsrXcKd20RyrMH6Ng4MjeYO+EPi2FhsMGPRsJO57wZSQ
	+qiMnKb5NItVYmuAvD5s0SXBYt12bts0/Hxljtjgk+N4cA+TJ7ytISOSKxJzdv5Cq9s5yXUAMR/fl
	6Jw40LHXt/I45Yny8n+uRcXrgzzicwddhItLHRw5h/hTfLJyQFjufVjIpq9mwjoKoMo6bWkHhX2nC
	jjlsk2YE7amXAa1lMT8PjuxiQ9EtwLTiLvfNGWdw3YrO6eaODxDpsWSkcfu2YmJzgEpg28rBuuiAh
	uf+hpnuVYvm636RDqEDw==;
In-Reply-To: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDA5OjQyICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6Cj4gSGkgQWRyaWFuLAo+IAo+IE9uIFRodSwgSnVuIDEsIDIwMjMgYXQgOToyOOKAr0FNIEpv
aG4gUGF1bCBBZHJpYW4gR2xhdWJpdHoKPiA8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4g
d3JvdGU6Cj4gPiBPbiBUaHUsIDIwMjMtMDYtMDEgYXQgMDk6MjAgKzAyMDAsIEdlZXJ0IFV5dHRl
cmhvZXZlbiB3cm90ZToKPiA+ID4gT24gV2VkLCBNYXkgMzEsIDIwMjMgYXQgMTE6MzPigK9QTSBW
aXNoYWwgTW9vbGEgKE9yYWNsZSkKPiA+ID4gPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3Rl
Ogo+ID4gPiA+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxhY2UgcGd0YWJsZSBjb25z
dHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gPiA+ID4gcHRkZXNjIGVxdWl2YWxlbnRzLiBBbHNv
IGNsZWFucyB1cCBzb21lIHNwYWNpbmcgaXNzdWVzLgo+ID4gPiA+IAo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xlKSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+
ID4gCj4gPiA+IExHVE0sIHNvCj4gPiA+IFJldmlld2VkLWJ5OiBHZWVydCBVeXR0ZXJob2V2ZW4g
PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPgo+ID4gCj4gPiBJIGFzc3VtZSB0aGlzIHNlcmllcyBp
cyBzdXBwb3NlZCB0byBnbyB0aHJvdWdoIHNvbWUgbW0gdHJlZT8KPiAKPiBJIHRoaW5rIHNvLCBz
byB5b3VyIEFja2VkLWJ5IHdvdWxkIGJlIGFwcHJlY2lhdGVkLi4uCgpPSywgSSB3aWxsIGhhdmUg
YSBsb29rLiBCdHcsIGNhbiB5b3UgaGF2ZSBhIGxvb2sgYXQgdGhlIHNlY29uZCBzZXJpZXMgYnkK
QXJ0dXIgKCJTdXBlckggRE1BQyBmaXhlcyIpPyBJIGhhdmVuJ3QgaGFkIHRoZSB0aW1lIGZvciB0
aGVzZSB5ZXQsIGJ1dApJIHdpbGwgaGF2ZSB0aW1lIGluIHRoZSB3ZWVrZW5kLgoKQWRyaWFuCgot
LSAKIC4nJ2AuICBKb2huIFBhdWwgQWRyaWFuIEdsYXViaXR6CjogOicgOiAgRGViaWFuIERldmVs
b3BlcgpgLiBgJyAgIFBoeXNpY2lzdAogIGAtICAgIEdQRzogNjJGRiA4QTc1IDg0RTAgMjk1NiA5
NTQ2ICAwMDA2IDc0MjYgM0IzNyBGNUI1IEY5MTMKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdApsaW51eC1yaXNj
dkBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcmlzY3YK
