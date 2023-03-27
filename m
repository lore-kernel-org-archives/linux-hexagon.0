From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 06/21] powerpc: dma-mapping: minimize for_cpu flushing
Date: Mon, 27 Mar 2023 12:56:33 +0000
Message-ID: <52eef604-085e-acf9-f3ee-41ba9d8441d2@csgroup.eu>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-7-arnd@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cghdQmoE9OvEyvqjFsL3EX4Vb4d6Y7eYCExJoCfFkAU=; b=adTFo5JxaJ2DKc
	ZruXR5yfWt1bHuOS8HCXXQCCfBGkm4oG5pjo8rmyMZhWsy/+UG5fQJUX5Gg+i388A1ln1SiIFU7de
	Y1jZ5NcVKCZFsj83bDeKwQ5QKJoEBp+h574Xq3KrEOt3mTMehh2uHio3yyvmRQo+MDRsLdBxVJg6y
	Kg1iX5YTkf0y2j2P40EdlFheB4NOiAkTIJTEfouEvYssUJxdIwcSdvE4AlpsjTYjGr2ZxdcBRtJM7
	nNUU5Q238cShU8mWpDcJBXfdAbIp5y9O66WJxWuPY03PvXVd+6QXARseyyNU6KvwnP5ecw4yHgeK0
	P2yaYlAcZ5oNTCh0kgLw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVvzJ8c3OeTDYtC3Bdo3EwgLzgZiH5nog31XPUOl6aE=;
 b=OrdtC62m1JMf6Ilrz2tdBq6u3E1ENrFoNPu52M02aLf7zpG1aUTazunlOBMko45xt704NkNWpN8lPk8znpmAR7wdo+uP4yBrR+Bcw4IJfs4rRA01YuV4AAdOnQjU3yshbknTduoc8wzq9E7AAFm6SXTiZHmYc27jLZMgRsypxKeaAAmQkD9pdx5xlat0lNaRfXA2bmH5azmad5rFyGFfIDgDKENsg/10LpifYRy5TDKpZ6Rj/oIR0Goicq2Hfuk79WF6MKCHmi7q+CARSZlHmA+RWE4DWsakZAyB7DqV72G6XsVKQaoJzLLYgid9FLe+dIrkEyAQYWJrw7mjFqDbYw==
In-Reply-To: <20230327121317.4081816-7-arnd@kernel.org>
Content-Language: fr-FR
Content-ID: <5815D0CB14B71F41946F2AF708C5275A@FRAP264.PROD.OUTLOOK.COM>
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
To: Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.>

DQoNCkxlIDI3LzAzLzIwMjMgw6AgMTQ6MTMsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IFRoZSBwb3dlcnBjIGRt
YV9zeW5jXypfZm9yX2NwdSgpIHZhcmlhbnRzIGRvIG1vcmUgZmx1c2hlcyB0aGFuIG9uIG90aGVy
DQo+IGFyY2hpdGVjdHVyZXMuIFJlZHVjZSBpdCB0byB3aGF0IGV2ZXJ5b25lIGVsc2UgZG9lczoN
Cj4gDQo+ICAgLSBObyBmbHVzaCBpcyBuZWVkZWQgYWZ0ZXIgZGF0YSBoYXMgYmVlbiBzZW50IHRv
IGEgZGV2aWNlDQo+IA0KPiAgIC0gV2hlbiBkYXRhIGhhcyBiZWVuIHJlY2VpdmVkIGZyb20gYSBk
ZXZpY2UsIHRoZSBjYWNoZSBvbmx5IG5lZWRzIHRvDQo+ICAgICBiZSBpbnZhbGlkYXRlZCB0byBj
bGVhciBvdXQgY2FjaGUgbGluZXMgdGhhdCB3ZXJlIHNwZWN1bGF0aXZlbHkNCj4gICAgIHByZWZl
dGNoZWQuDQo+IA0KPiBJbiBwYXJ0aWN1bGFyLCB0aGUgc2Vjb25kIGZsdXNoaW5nIG9mIHBhcnRp
YWwgY2FjaGUgbGluZXMgb2YgYmlkaXJlY3Rpb25hbA0KPiBidWZmZXJzIGlzIGFjdGl2ZWx5IGhh
cm1mdWwgLS0gaWYgYSBzaW5nbGUgY2FjaGUgbGluZSBpcyB3cml0dGVuIGJ5IGJvdGgNCj4gdGhl
IENQVSBhbmQgdGhlIGRldmljZSwgZmx1c2hpbmcgaXQgYWdhaW4gZG9lcyBub3QgbWFpbnRhaW4g
Y29oZXJlbmN5DQo+IGJ1dCBpbnN0ZWFkIG92ZXJ3cml0ZSB0aGUgZGF0YSB0aGF0IHdhcyBqdXN0
IHJlY2VpdmVkIGZyb20gdGhlIGRldmljZS4NCg0KSHVtIC4uLi4uIFdobyBpcyByaWdodCA/DQoN
ClRoYXQgYmVoYXZpb3VyIHdhcyBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCAwM2Q3MDYxN2I4YTcgKCJw
b3dlcnBjOiBQcmV2ZW50IA0KbWVtb3J5IGNvcnJ1cHRpb24gZHVlIHRvIGNhY2hlIGludmFsaWRh
dGlvbiBvZiB1bmFsaWduZWQgRE1BIGJ1ZmZlciIpDQoNCkkgdGhpbmsgeW91ciBjb21taXQgbG9n
IHNob3VsZCBleHBsYWluIHdoeSB0aGF0IGNvbW1pdCB3YXMgd3JvbmcsIGFuZCANCm1heWJlIHNh
eSB0aGF0IHlvdXIgcGF0Y2ggaXMgYSByZXZlcnQgb2YgdGhhdCBjb21taXQgPw0KDQpDaHJpc3Rv
cGhlDQoNCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4NCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL21tL2RtYS1ub25jb2hlcmVudC5jIHwgMTggKysr
Ky0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTQg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21tL2RtYS1ub25j
b2hlcmVudC5jIGIvYXJjaC9wb3dlcnBjL21tL2RtYS1ub25jb2hlcmVudC5jDQo+IGluZGV4IGYx
MDg2OWQyN2RlNS4uZTEwOGNhY2Y4NzdmIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvbW0v
ZG1hLW5vbmNvaGVyZW50LmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL21tL2RtYS1ub25jb2hlcmVu
dC5jDQo+IEBAIC0xMzIsMjEgKzEzMiwxMSBAQCB2b2lkIGFyY2hfc3luY19kbWFfZm9yX2NwdShw
aHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUsDQo+ICAgCXN3aXRjaCAoZGlyZWN0aW9uKSB7
DQo+ICAgCWNhc2UgRE1BX05PTkU6DQo+ICAgCQlCVUcoKTsNCj4gLQljYXNlIERNQV9GUk9NX0RF
VklDRToNCj4gLQkJLyoNCj4gLQkJICogaW52YWxpZGF0ZSBvbmx5IHdoZW4gY2FjaGUtbGluZSBh
bGlnbmVkIG90aGVyd2lzZSB0aGVyZSBpcw0KPiAtCQkgKiB0aGUgcG90ZW50aWFsIGZvciBkaXNj
YXJkaW5nIHVuY29tbWl0dGVkIGRhdGEgZnJvbSB0aGUgY2FjaGUNCj4gLQkJICovDQo+IC0JCWlm
ICgoc3RhcnQgfCBlbmQpICYgKEwxX0NBQ0hFX0JZVEVTIC0gMSkpDQo+IC0JCQlfX2RtYV9waHlz
X29wKHN0YXJ0LCBlbmQsIERNQV9DQUNIRV9GTFVTSCk7DQo+IC0JCWVsc2UNCj4gLQkJCV9fZG1h
X3BoeXNfb3Aoc3RhcnQsIGVuZCwgRE1BX0NBQ0hFX0lOVkFMKTsNCj4gLQkJYnJlYWs7DQo+IC0J
Y2FzZSBETUFfVE9fREVWSUNFOgkJLyogd3JpdGViYWNrIG9ubHkgKi8NCj4gLQkJX19kbWFfcGh5
c19vcChzdGFydCwgZW5kLCBETUFfQ0FDSEVfQ0xFQU4pOw0KPiArCWNhc2UgRE1BX1RPX0RFVklD
RToNCj4gICAJCWJyZWFrOw0KPiAtCWNhc2UgRE1BX0JJRElSRUNUSU9OQUw6CS8qIHdyaXRlYmFj
ayBhbmQgaW52YWxpZGF0ZSAqLw0KPiAtCQlfX2RtYV9waHlzX29wKHN0YXJ0LCBlbmQsIERNQV9D
QUNIRV9GTFVTSCk7DQo+ICsJY2FzZSBETUFfRlJPTV9ERVZJQ0U6DQo+ICsJY2FzZSBETUFfQklE
SVJFQ1RJT05BTDoNCj4gKwkJX19kbWFfcGh5c19vcChzdGFydCwgZW5kLCBETUFfQ0FDSEVfSU5W
QUwpOw0KPiAgIAkJYnJlYWs7DQo+ICAgCX0NCj4gICB9DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgt
cmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
