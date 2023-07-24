From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/9] vgacon: rework Kconfig dependencies
Date: Mon, 24 Jul 2023 14:07:25 +0200
Message-ID: <CAMuHMdVszR+oZi8x8L0iXx=ydTiaNUZxToBSdf=2ZH5t85+D_Q@mail.gmail.com>
References: <20230719123944.3438363-1-arnd@kernel.org> <20230719123944.3438363-2-arnd@kernel.org>
 <87pm4lj1w3.fsf@mail.lhotse> <19631e74-415e-4dcb-b79d-33dcf03d2dfc@app.fastmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vpf0hcvpF8EIoBvBBQIbtiw51fxTwJl7I9KAoo813ZY=; b=VzjOuSIJXS6Xae
	FthbfCTXI08S7kwEN39Kba1idddQ+58bxEm/CJ1DBBaij0ZswpOPG0qCtenHLnrR/Khq32LUcAtZk
	26qFieNJILyBwxqEcnlHZJMnc8If4wmIAMkVgFZr9N4DY7RoaSk2r2vcsh767hTOVj+JeS2X4AhWV
	IzAGpZivt14Iw3cCuSsBOpvrnDvcr8bvAgJPZ99EoiQtBs2MzCDKt62wsEsgE/v2hERaVaMi15s0L
	xnIRumzKiNYIcXyEjrH4z4tFl/13pEvJgnf9fPj3dvUs/4IUg5Y12/i7ZBSL/LunXw62BzAknVG/5
	V2FXA6AilimRXzQm+KBA==;
In-Reply-To: <19631e74-415e-4dcb-b79d-33dcf03d2dfc@app.fastmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>, "David S . Miller" <davem@davemloft.net>, "K. Y. Srinivasan" <kys@microsoft.com>, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Vetter <daniel@ffwll.ch>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Airlie <airlied@gmail.com>, Deepak Rawat <drawat.floss@gmail.com>, Dexuan Cui <decui@microsoft.com>, Dinh Nguyen <dinguyen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guoren <guoren@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mi>

SGkgQXJuZCwKCk9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDEwOjI54oCvQU0gQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4gd3JvdGU6Cj4gT24gRnJpLCBKdWwgMjEsIDIwMjMsIGF0IDA2OjU5
LCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOgo+ID4gQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwu
b3JnPiB3cml0ZXM6Cj4gPj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiA+
Pgo+ID4+IFRoZSBsaXN0IG9mIGRlcGVuZGVuY2llcyBoZXJlIGlzIHBocmFzZWQgYXMgYW4gb3B0
LW91dCwgYnV0IHRoaXMgaXMgbWlzc2luZwo+ID4+IGEgbG90IG9mIGFyY2hpdGVjdHVyZXMgdGhh
dCBkb24ndCBhY3R1YWxseSBzdXBwb3J0IFZHQSBjb25zb2xlcywgYW5kIHNvbWUKPiA+PiBvZiB0
aGUgZW50cmllcyBhcmUgc3RhbGU6Cj4gPj4KPiA+PiAgLSBwb3dlcnBjIHVzZWQgdG8gc3VwcG9y
dCBWR0EgY29uc29sZXMgaW4gdGhlIG9sZCBhcmNoL3BwYyBjb2RlYmFzZSwgYnV0Cj4gPj4gICAg
dGhlIG1lcmdlZCBhcmNoL3Bvd2VycGMgbmV2ZXIgZGlkCj4gPgo+ID4gTm90IGRpc3B1dGluZyB0
aGlzLCBidXQgaG93IGRpZCB5b3UgY29tZSB0byB0aGF0IGNvbmNsdXNpb24/IEkgZ3JlcHBlZAo+
ID4gYXJvdW5kIGFuZCBjb3VsZG4ndCBjb252aW5jZSBteXNlbGYgd2hldGhlciBpdCBjYW4gd29y
ayBvbiBwb3dlcnBjIG9yCj4gPiBub3QuIGllLiBjdXJyZW50bHkgaXQncyBwb3NzaWJsZSB0byBl
bmFibGUgQ09ORklHX1ZHQV9DT05TT0xFIGFuZAo+ID4gcG93ZXJwYyBkb2VzIGhhdmUgYSBzdHJ1
Y3Qgc2NyZWVuX2luZm8gZGVmaW5lZCB3aGljaCBzZWVtcyBsaWtlIGl0IHdvdWxkCj4gPiBhbGxv
dyB2Z2Fjb25fc3RhcnR1cCgpIHRvIGNvbXBsZXRlLgo+Cj4gVGhlIFZHQSBjb25zb2xlIG5lZWRz
IGJvdGggc2NyZWVuX2luZm8gYW5kIHZnYV9jb24gdG8gd29yay4gSW4gYXJjaC9wcGMKPiB3ZSBo
YWQgYm90aCwgYnV0IGluIGFyY2gvcG93ZXJwYyB3ZSBvbmx5IHJldGFpbmVkIHRoZSBzY3JlZW5f
aW5mbzoKPgo+ICQgZ2l0IGdyZXAgdmdhX2NvbiB2Mi42LjI2IC0tIGFyY2gvcHBjIGFyY2gvcHBj
NjQgYXJjaC9wb3dlcnBjCj4gdjIuNi4yNjphcmNoL3BwYy9wbGF0Zm9ybXMvcHBsdXMuYzogICAg
IGNvbnN3aXRjaHAgPSAmdmdhX2NvbjsKPiB2Mi42LjI2OmFyY2gvcHBjL3BsYXRmb3Jtcy9wcmVw
X3NldHVwLmM6ICAgICAgICBjb25zd2l0Y2hwID0gJnZnYV9jb247Cj4KPiBzbyBhZnRlciBhcmNo
L3BwYyB3YXMgcmVtb3ZlZCwgdGhpcyBiZWNhbWUgaW1wb3NzaWJsZSB0byB1c2Ugb24gYm90aAo+
IHBwbHVzIGFuZCBwcmVwLiBUaGVzZSB0d28gcGxhdGZvcm1zIHdlcmUgYWxzbyAoYXMgZmFyIGFz
IEkgY2FuIHRlbGwpCj4gdGhlIG9ubHkgb25lcyB0byBzdXBwb3J0IHZnYTE2ZmIgYXMgYW4gYWx0
ZXJuYXRpdmUgdG8gdmdhY29uLCBidXQKPiBib3RoIHBsYXRmb3JtcyB3ZXJlIHJlbW92ZWQgbGF0
ZXIgb24uCgpJIGRpZCB1c2UgdmdhY29uIGFuZCB2Z2ExNmZiIG9uIENIUlAgb24gYSBzZWNvbmQg
dmlkZW8gY2FyZAooaW5pdGlhbGl6ZWQgdXNpbmcgR2FicmllbCBQYXViZXJ0J3MgeDg2IEJJT1Mg
ZW11bGF0b3IpLCBidXQgdGhhdCB3YXMKZGVmaW5pdGVseSBiZWZvcmUgdGhlIGFkdmVudCBvZiBh
cmNoL3Bvd2VycGMvLgoKR3J7b2V0amUsZWV0aW5nfXMsCgogICAgICAgICAgICAgICAgICAgICAg
ICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMgb2YgTGludXgg
YmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcKCkluIHBlcnNvbmFsIGNvbnZlcnNh
dGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLiBCdXQK
d2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBv
ciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0t
IExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXJpc2N2Cg==
