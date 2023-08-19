From: Jesse T <mr.bossman075@gmail.com>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Fri, 18 Aug 2023 23:33:49 -0400
Message-ID: <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org> <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gCPPvnFakvZ8noaOUVmxWilfLNQDzNOHjlZQ+RFyvnM=; b=HDKDbrOHR1Xfhl
	IJV2eVTLnc5zsvxhxiRTTey+v8ZtZpoOvWUsQhqAmwtLJ/fBoqEYcnC3srAvFqI3D6UpSZYr5mmAi
	9ItY+R4o11LnJvGLoXtm63obiX3OgSmRpcXYmXzsaMuoQJi7Zn/ZgUSyCc+Hi2Xn8WFbf6kH3GN5U
	QIDY7Tyis/QcL/t9cxAxlmboU0ZvaoBNumBoS8TPSTwr/kwRIUDF94uIjTvHYJfIWYe9RyLCnwA+/
	di5064mDUlMEiCenuKBlQq+r7VJeorXFctlQTyP6/gZ5bEb3jPvxGMiyndbYfwSFNaNJCzexVRFGQ
	eSddbP2Antyw9oGanLPw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692416065; x=1693020865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOjVxX/Eg0iGmCqhVv5cIZBql9TtO2CXYAj6O50hbSE=;
        b=IqtJwsF0pUQX7izyHeTreyTJTJhKy5hiG0L5LG7pklRm5ruz2z314lR30cJBIft8IF
         lHOgWqUBHxsrHRZ/n+H1wKK9DAmo6l6M6vOqnptgdlcjmAJVnPdA6vRI0gXUbNjLjw2O
         HaCa2GQWI2H3P/PJF/kO6bmYeR/Nyn9f2ZprmcA/D0k+kc6aE9gt4/58CgSA7F801jjd
         XX+T7G5Lv1/7anA6wENrFajkkBfdYnNLgzsdEjOaJ3u6npvNqyydM0GqNQ4HtJ58/8Bk
         W4eV1DvzXq38mo16H9W9Oyvm8s/Iciep4KukBQTEpuiauG6fJdSHO4J2dBeLWJsNSNRu
         GvHA==
In-Reply-To: <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com, linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, linux-openrisc@vger.kernel.org, linux-mips@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 

T24gRnJpLCBBdWcgMTgsIDIwMjMgYXQgNzo0NOKAr1BNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IEhpIEplc3NlLAo+Cj4gSSByZXBsaWVkIHRvIHlvdXIg
Y29tbWVudCBhIGZldyBkYXlzIGFnbywgYnV0IGZvciBzb21lIHJlYXNvbgo+IHlvdXIgZW1haWwg
dG8gbWUgY29udGFpbnM6Cj4gUmVwbHktVG86IDIwMjMwODE2MDU1MDEwLjMxNTM0LTEtcmR1bmxh
cEBpbmZyYWRlYWQub3JnCj4gc28gaXQgd2Fzbid0IHNlbnQgZGlyZWN0bHkgdG8geW91LgoKU29y
cnkgYWJvdXQgdGhhdCBJIG1lc3NlZCB1cCB0aGUgZW1haWwgaGVhZGVycy4uLgo+Cj4gTXkgZm9y
bWVyIHJlcGx5IGlzIGJlbG93Lgo+Cj4gT24gOC8xNi8yMyAyMDoxNSwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+ID4gSGkgSmVzc2UsCj4gPgo+ID4gT24gOC8xNi8yMyAxNTo0NSwgSmVzc2UgVGF1YmUg
d3JvdGU6Cj4gPj4gSGksIFJhbmR5Cj4gPj4KPiA+Pj4gZGlmZiAtLSBhL2luaXQvS2NvbmZpZyBi
L2luaXQvS2NvbmZpZwo+ID4+PiAtLS0gYS9pbml0L0tjb25maWcKPiA+Pj4gKysrIGIvaW5pdC9L
Y29uZmlnCj4gPj4+IEBAIC0xNzkwLDE0ICsxNzkwLDYgQEAgY29uZmlnIERFQlVHX1JTRVEKPiA+
Pj4KPiA+Pj4gICAgICAgICBJZiB1bnN1cmUsIHNheSBOLgo+ID4+Pgo+ID4+PiAtY29uZmlnIEVN
QkVEREVECj4gPj4+IC0gICAgYm9vbCAiRW1iZWRkZWQgc3lzdGVtIgo+ID4+PiAtICAgIHNlbGVj
dCBFWFBFUlQKPiA+Pj4gLSAgICBoZWxwCj4gPj4+IC0gICAgICBUaGlzIG9wdGlvbiBzaG91bGQg
YmUgZW5hYmxlZCBpZiBjb21waWxpbmcgdGhlIGtlcm5lbCBmb3IKPiA+Pj4gLSAgICAgIGFuIGVt
YmVkZGVkIHN5c3RlbSBzbyBjZXJ0YWluIGV4cGVydCBvcHRpb25zIGFyZSBhdmFpbGFibGUKPiA+
Pj4gLSAgICAgIGZvciBjb25maWd1cmF0aW9uLgo+ID4+Cj4gPj4gV291bGRuJ3QgcmVtb3Zpbmcg
dGhpcyBicmVhayBtYW55IG91dCBvZiB0cmVlIGNvbmZpZ3M/Cj4gPgo+ID4gSSdtIG5vdCBmYW1p
bGlhciB3aXRoIG91dC1vZi10cmVlIGNvbmZpZ3MuCj4gPiBEbyB5b3UgaGF2ZSBzb21lIGV4YW1w
bGVzIG9mIHNvbWUgdGhhdCB1c2UgQ09ORklHX0VNQkVEREVEPwo+ID4gKG5vdCBkaXN0cm9zKQoK
QnVpbGRyb290IGhhcyBhIGZldy4KSXQgd29uJ3QgaW1tZWRpYXRlbHkgYnJlYWsgQnVpbGRyb290
IGFuZCBZb2N0byBhcyB0aGV5IGhhdmUgYSBzZXQgdmVyc2lvbiwKYnV0IGl0IGNvdWxkIGJlIGNv
bmZ1c2luZyBmb3IgYW55b25lIHVwZGF0aW5nIHRoZSBrZXJuZWwuCgo+ID4KPiA+PiBTaG91bGQg
dGhlcmUgYmUgYSB3YXJuaW5nIGhlcmUgdG8gdXBkYXRlIGNoYW5nZSBpdCBpbnN0ZWFkIG9mIHJl
bW92YWw/Cj4gPgo+ID4ga2NvbmZpZyBkb2Vzbid0IGhhdmUgYSB3YXJuaW5nIG1lY2hhbmlzbSBB
RkFJSy4KPiA+IERvIHlvdSBoYXZlIGFuIGlkZWEgb2YgaG93IHRoaXMgd291bGQgd29yaz8KCk5v
LCB1bmZvcnR1bmF0ZWx5LiBBcyB5b3Ugc2FpZCB3aXRob3V0IGEgd2FybmluZyBpdCB3b3VsZCBi
ZSBvdmVybG9va2VkIHNvCmEgY2hhbmdlIHdvdWxkIG5vdCBiZSBuZWNlc3NhcnkuCgpBIHBvc3Np
YmxlIHNvbHV0aW9uIGlzIHRvIGNoZWNrIGluIGEgaGVhZGVyIGZpbGUgd2l0aDoKCiNpZmRlZiBD
T05GSUdfRU1CRURERUQKI3dhcm5pbmcgIkNPTkZJR19FTUJFRERFRCBoYXMgY2hhbmdlZCB0byBD
T05GSUdfRVhQRVJUIgojZW5kaWYKCkRvZXMgYW55b25lIGVsc2UgaGF2ZSBhbiBvcGluaW9uIG9u
IHRoaXM/ClNpbmNlIGtjb25maWcgZG9lc24ndCBoYXZlIGEgd2FybmluZyBtZWNoYW5pc20gdGhl
IHBhdGNoIHNlZW1zIGZpbmUgYXMgaXMuCgpUaGFua3MsCkplc3NlIFRhdWJlCj4gPgo+ID4gV2Ug
Y291bGQgbWFrZSBhIHNtYWxsZXIgY2hhbmdlIHRvIGluaXQvS2NvbmZpZywgbGlrZSBzbzoKPiA+
Cj4gPiAgY29uZmlnIEVNQkVEREVECj4gPiAtICAgICBib29sICJFbWJlZGRlZCBzeXN0ZW0iCj4g
PiArICAgICBib29sICJFbWJlZGRlZCBzeXN0ZW0gKERFUFJFQ0FURUQpIgo+ID4gICAgICAgc2Vs
ZWN0IEVYUEVSVAo+ID4gICAgICAgaGVscAo+ID4gLSAgICAgICBUaGlzIG9wdGlvbiBzaG91bGQg
YmUgZW5hYmxlZCBpZiBjb21waWxpbmcgdGhlIGtlcm5lbCBmb3IKPiA+IC0gICAgICAgYW4gZW1i
ZWRkZWQgc3lzdGVtIHNvIGNlcnRhaW4gZXhwZXJ0IG9wdGlvbnMgYXJlIGF2YWlsYWJsZQo+ID4g
LSAgICAgICBmb3IgY29uZmlndXJhdGlvbi4KPiA+ICsgICAgICAgVGhpcyBvcHRpb24gaXMgYmVp
bmcgcmVtb3ZlZCBhZnRlciBMaW51eCA2LjYuCj4gPiArICAgICAgIFVzZSBFWFBFUlQgaW5zdGVh
ZCBvZiBFTUJFRERFRC4KPiA+Cj4gPiBidXQgdGhlcmUgaXMgbm8gd2F5IHRvIHByb2R1Y2UgYSB3
YXJuaW5nIG1lc3NhZ2UuIEkuZS4sIGV2ZW4gd2l0aCB0aGlzCj4gPiBjaGFuZ2UsIHRoZSBtZXNz
YWdlIHdpbGwgcHJvYmFibHkgYmUgb3Zlcmxvb2tlZC4KPiA+Cj4gPiAtLS0KPiA+IH5SYW5keQo+
Cj4gLS0KPiB+UmFuZHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdApsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
cmlzY3YK
