From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Wed, 16 Aug 2023 20:15:09 -0700
Message-ID: <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TUAdz5yZn8JIHNgOz7SbxCC3r+czN4bHPUfIUbY7nww=; b=SQaMrV/PTRBRCk
	GwoftQ+/E/YqRDret/Z6JH9Xr/A5P/AZYftsXTYco86Lj8+jqJaJXkcwXJv2vJRo64afqAR+6d+V8
	265VODRQNpLBHA7KP4xqyfTOQhvQuCnFZNJbull0jMMHgC4dNAnyAvHwvhbx14r8ypQ9mdz0g6//c
	GQK8K5liU4WZz3LTiKSwKotKscImq2mmjs2pMbZTnDGbc2i9x59CY/YkF1/9Wu4owQ+g+uT20O/DE
	DhiTQM3B6RgSwG1N6swRqILb/LQMx6pm1r1rYfJrmwzy28ZJqUYq3Kld8ARZTt0CrYSrwF1YFcQBo
	XcQOXYEbQ1tjHKhvLvIQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=P/kFyzCr/eSDaJkbY0OlCILEe1j9xWTLXn/yJLAYIu4=; b=A9+ZOyBLxgvkefgcCG3G+GbFOc
	t3Q4LPTtkkpyh0LBpbAFdc+3lhG3pcvB3Tuy2cTe9/M//iW+Sx1QS7+tpwHS9HCucIDpD/RDGCGIr
	FphyIapebkE7eEjeEnFtOi+9dwumQAvsQRYGjE0GEiZ5WBo53AxtXkFjlluHJQQSFYe1ZQ0mwCfpK
	6X/okD9sKE4Z8iWegd56l1SCJXl6wUSJ5Uk04klLzVcTy3SNTh8mgr2aL00kPfkoj1Td2N2/Azxck
	21ORjXTS2+GmCUfbeyQtLCC4mizooGziW6L1eBdD4Ta+hfKURTJGkPtTMCT5Ht16ny8Gi1C8JbRXm
	mdreectQ==;
Content-Language: en-US
In-Reply-To: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
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
To: 20230816055010.31534-1-rdunlap@infradead.org
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.oz

SGkgSmVzc2UsCgpPbiA4LzE2LzIzIDE1OjQ1LCBKZXNzZSBUYXViZSB3cm90ZToKPiBIaSwgUmFu
ZHkKPiAKPj4gZGlmZiAtLSBhL2luaXQvS2NvbmZpZyBiL2luaXQvS2NvbmZpZwo+PiAtLS0gYS9p
bml0L0tjb25maWcKPj4gKysrIGIvaW5pdC9LY29uZmlnCj4+IEBAIC0xNzkwLDE0ICsxNzkwLDYg
QEAgY29uZmlnIERFQlVHX1JTRVEKPj4KPj7CoMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBO
Lgo+Pgo+PiAtY29uZmlnIEVNQkVEREVECj4+IC3CoMKgwqAgYm9vbCAiRW1iZWRkZWQgc3lzdGVt
Igo+PiAtwqDCoMKgIHNlbGVjdCBFWFBFUlQKPj4gLcKgwqDCoCBoZWxwCj4+IC3CoMKgwqDCoMKg
IFRoaXMgb3B0aW9uIHNob3VsZCBiZSBlbmFibGVkIGlmIGNvbXBpbGluZyB0aGUga2VybmVsIGZv
cgo+PiAtwqDCoMKgwqDCoCBhbiBlbWJlZGRlZCBzeXN0ZW0gc28gY2VydGFpbiBleHBlcnQgb3B0
aW9ucyBhcmUgYXZhaWxhYmxlCj4+IC3CoMKgwqDCoMKgIGZvciBjb25maWd1cmF0aW9uLgo+IAo+
IFdvdWxkbid0IHJlbW92aW5nIHRoaXMgYnJlYWsgbWFueSBvdXQgb2YgdHJlZSBjb25maWdzPwoK
SSdtIG5vdCBmYW1pbGlhciB3aXRoIG91dC1vZi10cmVlIGNvbmZpZ3MuCkRvIHlvdSBoYXZlIHNv
bWUgZXhhbXBsZXMgb2Ygc29tZSB0aGF0IHVzZSBDT05GSUdfRU1CRURERUQ/Cihub3QgZGlzdHJv
cykKCj4gU2hvdWxkIHRoZXJlIGJlIGEgd2FybmluZyBoZXJlIHRvIHVwZGF0ZSBjaGFuZ2UgaXQg
aW5zdGVhZCBvZiByZW1vdmFsPwoKa2NvbmZpZyBkb2Vzbid0IGhhdmUgYSB3YXJuaW5nIG1lY2hh
bmlzbSBBRkFJSy4KRG8geW91IGhhdmUgYW4gaWRlYSBvZiBob3cgdGhpcyB3b3VsZCB3b3JrPwoK
V2UgY291bGQgbWFrZSBhIHNtYWxsZXIgY2hhbmdlIHRvIGluaXQvS2NvbmZpZywgbGlrZSBzbzoK
CiBjb25maWcgRU1CRURERUQKLQlib29sICJFbWJlZGRlZCBzeXN0ZW0iCisJYm9vbCAiRW1iZWRk
ZWQgc3lzdGVtIChERVBSRUNBVEVEKSIKIAlzZWxlY3QgRVhQRVJUCiAJaGVscAotCSAgVGhpcyBv
cHRpb24gc2hvdWxkIGJlIGVuYWJsZWQgaWYgY29tcGlsaW5nIHRoZSBrZXJuZWwgZm9yCi0JICBh
biBlbWJlZGRlZCBzeXN0ZW0gc28gY2VydGFpbiBleHBlcnQgb3B0aW9ucyBhcmUgYXZhaWxhYmxl
Ci0JICBmb3IgY29uZmlndXJhdGlvbi4KKwkgIFRoaXMgb3B0aW9uIGlzIGJlaW5nIHJlbW92ZWQg
YWZ0ZXIgTGludXggNi42LgorCSAgVXNlIEVYUEVSVCBpbnN0ZWFkIG9mIEVNQkVEREVELgoKYnV0
IHRoZXJlIGlzIG5vIHdheSB0byBwcm9kdWNlIGEgd2FybmluZyBtZXNzYWdlLiBJLmUuLCBldmVu
IHdpdGggdGhpcwpjaGFuZ2UsIHRoZSBtZXNzYWdlIHdpbGwgcHJvYmFibHkgYmUgb3Zlcmxvb2tl
ZC4KCi0tLQp+UmFuZHkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXJpc2N2Cg==
