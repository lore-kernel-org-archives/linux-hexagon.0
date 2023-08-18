From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Fri, 18 Aug 2023 16:44:26 -0700
Message-ID: <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K2axpYYDrCPGxVDq7gxHgnvbL7lxEHGhjXlA4ZB3BlE=; b=eSaA9eIFSP1GWc
	y6vb0t2wSs59w3UJk+3qTjxoY88fBYyEtnql/qjpiHmYyci41U/2Zh5Rn6dN+xNA+VFL5nKz90+RH
	NF5fTR4bNX9CLmXteCvZF9LZ9QsJhrVxyRX+qoHHjNoZqQ/0JniB/Vg6Jv2GQhtQ/47i7ZVg7/5sF
	jdDTKGbIaw8C+8/OWAzJA78buTwNTx5kK6+8A4g2iVAxFx9ycUVZ7vsV6QboQx5mTigaaQDyP803k
	qGpJxivadSO5K1B9tN7w2aHNXpAAdix5QFAPk7fjHu5+XKnc5/MlFrFNiYI6yS4nf7H5gduKkMtlx
	Vd9tNVzR3JPnIS1JScng==;
Content-Language: en-US
In-Reply-To: <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
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
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@lists.oz

SGkgSmVzc2UsCgpJIHJlcGxpZWQgdG8geW91ciBjb21tZW50IGEgZmV3IGRheXMgYWdvLCBidXQg
Zm9yIHNvbWUgcmVhc29uCnlvdXIgZW1haWwgdG8gbWUgY29udGFpbnM6ClJlcGx5LVRvOiAyMDIz
MDgxNjA1NTAxMC4zMTUzNC0xLXJkdW5sYXBAaW5mcmFkZWFkLm9yZwpzbyBpdCB3YXNuJ3Qgc2Vu
dCBkaXJlY3RseSB0byB5b3UuCgpNeSBmb3JtZXIgcmVwbHkgaXMgYmVsb3cuCgpPbiA4LzE2LzIz
IDIwOjE1LCBSYW5keSBEdW5sYXAgd3JvdGU6Cj4gSGkgSmVzc2UsCj4gCj4gT24gOC8xNi8yMyAx
NTo0NSwgSmVzc2UgVGF1YmUgd3JvdGU6Cj4+IEhpLCBSYW5keQo+Pgo+Pj4gZGlmZiAtLSBhL2lu
aXQvS2NvbmZpZyBiL2luaXQvS2NvbmZpZwo+Pj4gLS0tIGEvaW5pdC9LY29uZmlnCj4+PiArKysg
Yi9pbml0L0tjb25maWcKPj4+IEBAIC0xNzkwLDE0ICsxNzkwLDYgQEAgY29uZmlnIERFQlVHX1JT
RVEKPj4+Cj4+PiDCoMKgwqDCoMKgwqDCoCBJZiB1bnN1cmUsIHNheSBOLgo+Pj4KPj4+IC1jb25m
aWcgRU1CRURERUQKPj4+IC3CoMKgwqAgYm9vbCAiRW1iZWRkZWQgc3lzdGVtIgo+Pj4gLcKgwqDC
oCBzZWxlY3QgRVhQRVJUCj4+PiAtwqDCoMKgIGhlbHAKPj4+IC3CoMKgwqDCoMKgIFRoaXMgb3B0
aW9uIHNob3VsZCBiZSBlbmFibGVkIGlmIGNvbXBpbGluZyB0aGUga2VybmVsIGZvcgo+Pj4gLcKg
wqDCoMKgwqAgYW4gZW1iZWRkZWQgc3lzdGVtIHNvIGNlcnRhaW4gZXhwZXJ0IG9wdGlvbnMgYXJl
IGF2YWlsYWJsZQo+Pj4gLcKgwqDCoMKgwqAgZm9yIGNvbmZpZ3VyYXRpb24uCj4+Cj4+IFdvdWxk
bid0IHJlbW92aW5nIHRoaXMgYnJlYWsgbWFueSBvdXQgb2YgdHJlZSBjb25maWdzPwo+IAo+IEkn
bSBub3QgZmFtaWxpYXIgd2l0aCBvdXQtb2YtdHJlZSBjb25maWdzLgo+IERvIHlvdSBoYXZlIHNv
bWUgZXhhbXBsZXMgb2Ygc29tZSB0aGF0IHVzZSBDT05GSUdfRU1CRURERUQ/Cj4gKG5vdCBkaXN0
cm9zKQo+IAo+PiBTaG91bGQgdGhlcmUgYmUgYSB3YXJuaW5nIGhlcmUgdG8gdXBkYXRlIGNoYW5n
ZSBpdCBpbnN0ZWFkIG9mIHJlbW92YWw/Cj4gCj4ga2NvbmZpZyBkb2Vzbid0IGhhdmUgYSB3YXJu
aW5nIG1lY2hhbmlzbSBBRkFJSy4KPiBEbyB5b3UgaGF2ZSBhbiBpZGVhIG9mIGhvdyB0aGlzIHdv
dWxkIHdvcms/Cj4gCj4gV2UgY291bGQgbWFrZSBhIHNtYWxsZXIgY2hhbmdlIHRvIGluaXQvS2Nv
bmZpZywgbGlrZSBzbzoKPiAKPiAgY29uZmlnIEVNQkVEREVECj4gLQlib29sICJFbWJlZGRlZCBz
eXN0ZW0iCj4gKwlib29sICJFbWJlZGRlZCBzeXN0ZW0gKERFUFJFQ0FURUQpIgo+ICAJc2VsZWN0
IEVYUEVSVAo+ICAJaGVscAo+IC0JICBUaGlzIG9wdGlvbiBzaG91bGQgYmUgZW5hYmxlZCBpZiBj
b21waWxpbmcgdGhlIGtlcm5lbCBmb3IKPiAtCSAgYW4gZW1iZWRkZWQgc3lzdGVtIHNvIGNlcnRh
aW4gZXhwZXJ0IG9wdGlvbnMgYXJlIGF2YWlsYWJsZQo+IC0JICBmb3IgY29uZmlndXJhdGlvbi4K
PiArCSAgVGhpcyBvcHRpb24gaXMgYmVpbmcgcmVtb3ZlZCBhZnRlciBMaW51eCA2LjYuCj4gKwkg
IFVzZSBFWFBFUlQgaW5zdGVhZCBvZiBFTUJFRERFRC4KPiAKPiBidXQgdGhlcmUgaXMgbm8gd2F5
IHRvIHByb2R1Y2UgYSB3YXJuaW5nIG1lc3NhZ2UuIEkuZS4sIGV2ZW4gd2l0aCB0aGlzCj4gY2hh
bmdlLCB0aGUgbWVzc2FnZSB3aWxsIHByb2JhYmx5IGJlIG92ZXJsb29rZWQuCj4gCj4gLS0tCj4g
flJhbmR5CgotLSAKflJhbmR5CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXJpc2N2Cg==
