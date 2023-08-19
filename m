From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Date: Sat, 19 Aug 2023 08:53:25 +0000
Message-ID: <c96756ed-8714-6e67-c6b1-0614f57d41d0@csgroup.eu>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
 <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
 <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
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
	List-Owner; bh=uwA6/s+f/7Hoa6OOaUuPXZkR0+raa6zjw8Z9GxfaYyc=; b=PG9nKo/5fHMh9D
	zMSK8EiRiU0NcmCYFZf6FbDvdbGlSg4rcmsFM+vJylBd+ckit/I/NmugT3p83Sxpl8JFbOQFNntoz
	TZ+KbNiUel7Jq/POBjlNojOHYLydY6DeLIAyBm5Yi9BiWFXlyKvDW7zzngoN7d/296SojrNoiNFZH
	yhRQZOX0/MLXl5OY44yUa2HHvolIlTxfjRhjidRl4TolMYZBBftb64zkOU6RO0EbKevi+A6r/G521
	TqznmhnJo1TEM46TzWSKZ2WsgbayGg0v0PZOMM5qyPwlQpvR2qtW2xb1T32IupkE0+9028E7WG/Y+
	d3Rvp2gJ+YqrAbKvPB7w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwUe6Wo8Ua5nVbNH9rxeKLQvUgz0aX/os4ro/0ncXIE=;
 b=KPgo4roDomgrxWdrgqY4K74PmTVx5YtgDWWCZSRtheFFRq2aTg+1AVQDky4C84aD2kwj6j67xx3Uztq5x+wK1AUkG6IRkvhwUBScazc3JGEoxuj+08k9zusEYKnrVskt+M/Ow/M/pkiYSLnT1QdrAplteeh2xZQf573/lDBcjDKEd434FcwygMbR5y/ddPmaHOgraViop1tGLjnv3/PlP8zjZbNdFnf7AvJoPXgjmQvOGYTiM/h5erwjNahEQJzSyx/9JXINCVZCnfAAvW2YhmtnQvg1u2AUgKOqZWReTq6PorN7LY2rlCEBBi/PQ1Cte0oyePVIvSJBamSrnrD6/Q==
In-Reply-To: <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
Content-Language: fr-FR
Content-ID: <C60E53EA9E3A6E4FA8599A24A5AAC312@FRAP264.PROD.OUTLOOK.COM>
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
To: Jesse T <mr.bossman075@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Jason
 A . Donenfeld" <Jason@zx2c4.com>, "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Vineet Gupta <vgupta@kernel.org>, Brian Cain <bcain@quicinc.com>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

SGksDQoNCkxlIDE5LzA4LzIwMjMgw6AgMDU6MzMsIEplc3NlIFQgYSDDqWNyaXTCoDoNCj4+Pg0K
Pj4+PiBTaG91bGQgdGhlcmUgYmUgYSB3YXJuaW5nIGhlcmUgdG8gdXBkYXRlIGNoYW5nZSBpdCBp
bnN0ZWFkIG9mIHJlbW92YWw/DQo+Pj4NCj4+PiBrY29uZmlnIGRvZXNuJ3QgaGF2ZSBhIHdhcm5p
bmcgbWVjaGFuaXNtIEFGQUlLLg0KPj4+IERvIHlvdSBoYXZlIGFuIGlkZWEgb2YgaG93IHRoaXMg
d291bGQgd29yaz8NCj4gDQo+IE5vLCB1bmZvcnR1bmF0ZWx5LiBBcyB5b3Ugc2FpZCB3aXRob3V0
IGEgd2FybmluZyBpdCB3b3VsZCBiZSBvdmVybG9va2VkIHNvDQo+IGEgY2hhbmdlIHdvdWxkIG5v
dCBiZSBuZWNlc3NhcnkuDQo+IA0KPiBBIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIGNoZWNrIGlu
IGEgaGVhZGVyIGZpbGUgd2l0aDoNCj4gDQo+ICNpZmRlZiBDT05GSUdfRU1CRURERUQNCj4gI3dh
cm5pbmcgIkNPTkZJR19FTUJFRERFRCBoYXMgY2hhbmdlZCB0byBDT05GSUdfRVhQRVJUIg0KPiAj
ZW5kaWYNCj4gDQo+IERvZXMgYW55b25lIGVsc2UgaGF2ZSBhbiBvcGluaW9uIG9uIHRoaXM/DQoN
Ck15IG9waW5pb24gaXMgdGhhdCBoYXMgaGFwcGVuIHNldmVyYWwgdGltZXMgaW4gdGhlIHBhc3Qg
YW5kIHdpbGwgaGFwcGVuIA0KYWdhaW4uIEl0IGlzIG5vdCBhIGJpZyBkZWFsLCB3aG9ldmVyIHVw
ZGF0ZXMgdG8gYSBuZXcga2VybmVsIHdpbGwgbWFrZSBhIA0Kc2F2ZWRlZmNvbmZpZyBhbmQgY29t
cGFyZSB3aXRoIHByZXZpb3VzIGRlZmNvbmZpZyBhbmQgc2VlIHdoYXQgaGFzIA0KY2hhbmdlZC4g
T25jZSB5b3Ugc2VlIHRoYXQgQ09ORklHX0VNQkVEREVEIGlzIGRpc2FwcGVhcmluZyB5b3UgbG9v
ayBhdCANCmtlcm5lbCBoaXN0b3J5IHRvIGZpbmQgb3V0IHdoeSBDT05GSUdfRU1CRURERUQgZGlz
YXBwZWFycywgYW5kIHlvdSANCnVuZGVyc3RhbmQgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UgdGhh
dCB5b3UgaGF2ZSB0byBzZWxlY3QgQ09ORklHX0VYUEVSVCANCmluc3RlYWQuDQoNCkEgY291cGxl
IGV4YW1wbGVzIEkgaGF2ZSBpbiBtaW5kIGZyb20gdGhlIHBhc3Q6DQotIENPTkZJR19GT1JDRV9N
QVhfWk9ORU9SREVSIGJlY2FtZSBDT05GSUdfQVJDSF9GT1JDRV9NQVhfT1JERVINCi0gQ09ORklH
X01URF9OQU5EIGJlY2FtZSBDT05GSUdfTVREX1JBV19OQU5EDQoNCj4gU2luY2Uga2NvbmZpZyBk
b2Vzbid0IGhhdmUgYSB3YXJuaW5nIG1lY2hhbmlzbSB0aGUgcGF0Y2ggc2VlbXMgZmluZSBhcyBp
cy4NCg0KU28geWVzIHRoZSBwYXRjaCBpcyBmaW5lIGFzIGlzIElNSE8uDQoNCkNocmlzdG9waGUN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJp
c2N2IG1haWxpbmcgbGlzdApsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YK
