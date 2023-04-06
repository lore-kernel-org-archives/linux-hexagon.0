From: Shahab Vahedi <Shahab.Vahedi@synopsys.com>
Subject: Re: [PATCH 13/21] arc: dma-mapping: skip invalidating before
 bidirectional DMA
Date: Thu, 6 Apr 2023 09:01:15 +0000
Message-ID: <ba0c6b04-cb7d-87ba-a435-919a910282dd@synopsys.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-14-arnd@kernel.org>
 <2b298e8c-e6fc-a973-9f42-b6a88e92838a@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-m68k-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Gd2cDNip62Ji14ds4OdoQBlo1z5VlqewCRbyiVCpDNg=;
 b=eB2MReypWcK1+ctba7WH3lOxUPpqvfrfHamccSASd4XErbB5iGRd+mCZeIW7eqYUwTXv
 4gkbHSZk1JwKaHXtKdrxAXuF1o3jtUX63zTMtLC/mf2G3OrVZUREqw1UWpb8RxeixvFt
 rlg6BTSn2NrDE86yDl9Bx2d1gY8wcbQ2uTe4oOKSstatNtE/3WJLS2MdCibENX4XjZhA
 xzWcq1a/3NOR1EN9KH4SYydh4Ljo2d1QsyhR0yaznuHLbqd580lb32GcZ7xEx0J2Qm2e
 vMCNX1Ow/wczPRhT4Ha7v4E151adLpU5Hig4VltsHRzwqzOdak3bl97vzOqiG2aq62BN Vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680772112; bh=Gd2cDNip62Ji14ds4OdoQBlo1z5VlqewCRbyiVCpDNg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hHCQe9EE5vPCy+QfIbZeNMC0iUCPD50BX3tmngIRaZ2h6EZgOSjVHBNYMs8eLDwrP
         vzfCRrn8noIOky8f1NOykeh1pnqe1iwE9kDJUBeDjopvTh+uvS4EgIcy/Ui/3LTUWl
         gZOxWs/ZlTGq6hR3WjjzLemSA9QiicFaAexf7qirZ5EcpVgLFaiNsotrx0dDwoXvGJ
         q7Prxa9NJ6sZqayHMY68QypkTIBFC1bK8Y3b0yHEcErVqhBzNKwJxDSOIdKioRhjsH
         YltW5v5RzR5esMFJFTFR4psSsoAPxZUtlJ5PdfB3pvMMNxSO01hg983Vikbni6ehyR
         LCSdp0USajVzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd2cDNip62Ji14ds4OdoQBlo1z5VlqewCRbyiVCpDNg=;
 b=ldIZkLcxPRkjGLN/+/2pAhw1+InAMKNlkCA8Y6E5BfxxY2WBYXLjS8860mR5z4I8cJHX//SVIMLPc7zEnamTHxUZyNvwyiXhEvqUGBpk/N+pBWMPJmedl98rnrfol2tHqTK9ELN+mMDdUeNcfK9asfKwEM2OYkxrnYBkeUh9fI8=
In-Reply-To: <2b298e8c-e6fc-a973-9f42-b6a88e92838a@kernel.org>
Content-Language: en-US
Content-ID: <449DE09BAE01DB419F0D7A0AFD51E943@namprd12.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Vineet Gupta <vgupta@kernel.org>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@phys>

T24gNC8yLzIzIDA4OjUyLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IENDIFNoYWhhYg0KPiANCj4g
T24gMy8yNy8yMyAxNzo0MywgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4+IEZyb206IEFybmQgQmVy
Z21hbm48YXJuZEBhcm5kYi5kZT4NCj4+DQo+PiBTb21lIGFyY2hpdGVjdHVyZXMgdGhhdCBuZWVk
IHRvIGludmFsaWRhdGUgYnVmZmVycyBhZnRlciBiaWRpcmVjdGlvbmFsDQo+PiBETUEgYmVjYXVz
ZSBvZiBzcGVjdWxhdGl2ZSBwcmVmZXRjaGluZyBvbmx5IGRvIGEgc2ltcGxlciB3cml0ZWJhY2sN
Cj4+IGJlZm9yZSB0aGF0IERNQSwgd2hpbGUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbid0IG5lZWQg
dG8gZG8gdGhlIHNlY29uZA0KPj4gaW52YWxpZGF0ZSB0ZW5kIHRvIGhhdmUgYSBjb21iaW5lZCB3
cml0ZWJhY2sraW52YWxpZGF0ZSBiZWZvcmUgdGhlDQo+PiBETUEuDQo+Pg0KPj4gYXJjIGlzIG9u
ZSBvZiB0aGUgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvZXMgYm90aCwgd2hpY2ggc2VlbXMgdW5uZWNl
c3NhcnkuDQo+Pg0KPj4gQ2hhbmdlIGl0IHRvIGJlaGF2ZSBsaWtlIGFybS9hcm02NC94dGVuc2Eg
aW5zdGVhZCwgYW5kIHVzZSBqdXN0IGENCj4+IHdyaXRlYmFjayBiZWZvcmUgdGhlIERNQSB3aGVu
IHdlIGRvIHRoZSBpbnZhbGlkYXRlIGFmdGVyd2FyZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
QXJuZCBCZXJnbWFubjxhcm5kQGFybmRiLmRlPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFZpbmVldCBH
dXB0YSA8dmd1cHRhQGtlcm5lbC5vcmc+DQo+IA0KPiBTaGFoYWIgY2FuIHlvdSBnaXZlIHRoaXMg
YSBzcGluIG9uIGhzZGsgLSBydW4gZ2xpYmMgdGVzdHN1aXRlIG92ZXIgc3NoDQo+IGFuZCBtYWtl
IHN1cmUgbm90aGluZyBzdHJhbmdlIGhhcHBlbnMuDQo+IA0KPiBUaHgsDQo+IC1WaW5lZXQNCg0K
VGVzdGVkLWJ5OiBTaGFoYWIgVmFoZWRpIDxzaGFoYWJAc3lub3BzeXMuY29tPg0KDQpObyByZWdy
ZXNzaW9uIHdhcyBvYnNlcnZlZCBmb3IgdGhlIEFSQyB0YXJnZXQgYmVmb3JlIGFuZCBhZnRlciBh
cHBseWluZw0KdGhlc2UgMjEgcGF0Y2hlcy4gVGhlIHRlc3QgZW52aXJvbm1lbnQgYW5kIGl0cyBz
dW1tYXJ5IGZvbGxvdy4NCg0KYm9hcmQ6ICBBUkMgSFNESw0KYmFzZTogICByZXBvOiAgIGxpbnV4
LW5leHQNCiAgICAgICAgdGFnOiAgICBuZXh0LTIwMjMwNDAzDQogICAgICAgIGNvbW1pdDogMzFi
ZDM1YjY2MjQ5IEFkZCBsaW51eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAyMDIzMDQwMw0KaG90
Zml4OiBuZXQ6IHN0bW1hYzogY2hlY2sgZndub2RlIGZvciBwaHkgZGV2aWNlIGJlZm9yZSBzY2Fu
bmluZyBmb3IgcGh5IFsxXQ0KZ2xpYmM6ICAyLjM3DQoNClN1bW1hcnkgb2YgdGVzdCByZXN1bHRz
Og0KICAgICAyMCBGQUlMDQogICA0MjI3IFBBU1MNCiAgICAgMzggVU5TVVBQT1JURUQNCiAgICAg
MTYgWEZBSUwNCiAgICAgIDIgWFBBU1MNCg0KWzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9s
a21sLzIwMjMwNDA1MDkzOTQ1LjM1NDk0OTEtMS1taWNoYWVsLndlaS5ob25nLnNpdEBpbnRlbC5j
b20vI3INCg0KLS0gDQpTaGFoYWINCg0K
