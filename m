From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 27/34] nios2: Convert __pte_free_tlb() to use ptdescs
Date: Wed, 14 Jun 2023 11:30:05 +0200
Message-ID: <CAMuHMdXPASfLM8St_JZOW3Wke+ickJoo1oDr+orRbTERy=Zgwg@mail.gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-28-vishal.moola@gmail.com> <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cqPNv0lPa7jtqQZYA8yTVeKiaSxGzYtV2rdhNMSjOhc=; b=t1x76BCnI8UnYy
	allwUuJa50xb00LeaAEjnGsYkt/RYPrwYhelEbyw+M8b5NP1gZZTKc9MoyXAuv+VSgmL7FRlgXSsc
	n+Q4oqvYydbzysVTXJpJt1hVBC7Mqz6HhhpvwTZlJgtyn+NPvFiGGB3e91y/WxDxexrm3Xb11Xn8Z
	/x1IFf/gNWH9AkZ7YdMBqz08VKTdgggB1Il6pnNjpC8Q4bOxes/SxEuap5MXppHqzTqNDdM5Wfqku
	xvBhCixX4D6XrNMhuHjXARNb8Ur4BOycHnbzlw8DgvyIFNzrhxL80oIaQCZEy3HVkDKg1bqn3kZjd
	EfNpTw3U6Rg9YJBuP8pQ==;
In-Reply-To: <e52c7a74-da68-08d2-54e2-f95a8c5b52e7@kernel.org>
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
Content-Type: text/plain; charset="windows-1252"
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>

SGkgRGluaCwKCk9uIFdlZCwgSnVuIDE0LCAyMDIzIGF0IDEyOjE34oCvQU0gRGluaCBOZ3V5ZW4g
PGRpbmd1eWVuQGtlcm5lbC5vcmc+IHdyb3RlOgo+IE9uIDYvMTIvMjMgMTY6MDQsIFZpc2hhbCBN
b29sYSAoT3JhY2xlKSB3cm90ZToKPiA+IFBhcnQgb2YgdGhlIGNvbnZlcnNpb25zIHRvIHJlcGxh
Y2UgcGd0YWJsZSBjb25zdHJ1Y3Rvci9kZXN0cnVjdG9ycyB3aXRoCj4gPiBwdGRlc2MgZXF1aXZh
bGVudHMuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIE1vb2xhIChPcmFjbGUpIDx2aXNo
YWwubW9vbGFAZ21haWwuY29tPgo+ID4gLS0tCj4gPiAgIGFyY2gvbmlvczIvaW5jbHVkZS9hc20v
cGdhbGxvYy5oIHwgOCArKysrLS0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9hcmNoL25pb3MyL2luY2x1
ZGUvYXNtL3BnYWxsb2MuaCBiL2FyY2gvbmlvczIvaW5jbHVkZS9hc20vcGdhbGxvYy5oCj4gPiBp
bmRleCBlY2QxNjU3YmIyY2UuLmNlNmJiOGU3NDI3MSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvbmlv
czIvaW5jbHVkZS9hc20vcGdhbGxvYy5oCj4gPiArKysgYi9hcmNoL25pb3MyL2luY2x1ZGUvYXNt
L3BnYWxsb2MuaAo+ID4gQEAgLTI4LDEwICsyOCwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcG1k
X3BvcHVsYXRlKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwbWRfdCAqcG1kLAo+ID4KPiA+ICAgZXh0
ZXJuIHBnZF90ICpwZ2RfYWxsb2Moc3RydWN0IG1tX3N0cnVjdCAqbW0pOwo+ID4KPiA+IC0jZGVm
aW5lIF9fcHRlX2ZyZWVfdGxiKHRsYiwgcHRlLCBhZGRyKSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCj4gPiAtICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwKPiA+IC0gICAgICAgICAgICAgcGd0YWJsZV9wdGVfcGFnZV9k
dG9yKHB0ZSk7ICAgICAgICAgICAgICAgICAgICAgXAo+ID4gLSAgICAgICAgICAgICB0bGJfcmVt
b3ZlX3BhZ2UoKHRsYiksIChwdGUpKTsgICAgICAgICAgICAgICAgICBcCj4gPiArI2RlZmluZSBf
X3B0ZV9mcmVlX3RsYih0bGIsIHB0ZSwgYWRkcikgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcCj4gPiArICAgICBkbyB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ID4gKyAgICAgICAgICAgICBwYWdldGFi
bGVfcHRlX2R0b3IocGFnZV9wdGRlc2MocHRlKSk7ICAgICAgICAgICAgICAgICAgIFwKPiA+ICsg
ICAgICAgICAgICAgdGxiX3JlbW92ZV9wYWdlX3B0ZGVzYygodGxiKSwgKHBhZ2VfcHRkZXNjKHB0
ZSkpKTsgICAgICBcCj4gPiAgICAgICB9IHdoaWxlICgwKQo+ID4KPiA+ICAgI2VuZGlmIC8qIF9B
U01fTklPUzJfUEdBTExPQ19IICovCj4KPiBBcHBsaWVkIQoKSSBkb24ndCB0aGluayB5b3UgY2Fu
IGp1c3QgYXBwbHkgdGhpcyBwYXRjaCwgYXMgdGhlIG5ldyBmdW5jdGlvbnMKd2VyZSBvbmx5IGlu
dHJvZHVjZWQgaW4gW1BBVENIIHY0IDA1LzM0XSBvZiB0aGlzIHNlcmllcy4KCkdye29ldGplLGVl
dGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJo
b2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4
LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3Bs
ZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5h
bGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlzY3YgbWFpbGlu
ZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
