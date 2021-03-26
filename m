From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
Date: Fri, 26 Mar 2021 15:20:20 +0100
Message-ID: <81a7e63f-57d4-5c81-acc5-35278fe5bb04@csgroup.eu>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 <87zgyqdn3d.fsf@igel.home>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZI/1yvUOcOk4sEtWQc6fEtJBKH0RLHB7BSMjg1HtzN4=; b=oKULVnD30+HjfGjlx/NoFgVGR
	SwKk5H5FPP6pJM+M2NVOUtyZJJK8NBBQj1Jv/LPWZ5yKu7eMXMwLa40z9tM5X53Si1T3icqdQtsk+
	fcf2dTVag4+EMJ9IrtryyzToiDOhtEU7wK42aQidCrIMU00BATwRvrIvk+tt8BGsaN7wKuIcpyl/l
	MxmzbaB/yVZJ2WBm+sDDhh0QbU4bvMhYSNVnBxZ/jGBE7mlkmDBWVBgFXQFWwEuVt9k9h2HaNkjwO
	pyC/R0dzh143IHkOhrFatPqW2k2ozd5rF8zPUFqyYBTXYoD/MZyhAv21aj/CZoNDJSmq8o7l6lLJJ
	jE8r9HcHA==;
In-Reply-To: <87zgyqdn3d.fsf@igel.home>
Content-Language: fr
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
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: will@kernel.org, danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

CgpMZSAyNi8wMy8yMDIxIMOgIDE1OjA4LCBBbmRyZWFzIFNjaHdhYiBhIMOpY3JpdMKgOgo+IE9u
IE3DpHIgMjYgMjAyMSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToKPiAKPj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9zZXR1cC5jCj4+
IGluZGV4IGY4ZjE1MzMyY2FhMi4uZTdjOTFlZTQ3OGQxIDEwMDY0NAo+PiAtLS0gYS9hcmNoL3Jp
c2N2L2tlcm5lbC9zZXR1cC5jCj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMKPj4g
QEAgLTIwLDYgKzIwLDcgQEAKPj4gICAjaW5jbHVkZSA8bGludXgvc3dpb3RsYi5oPgo+PiAgICNp
bmNsdWRlIDxsaW51eC9zbXAuaD4KPj4gICAjaW5jbHVkZSA8bGludXgvZWZpLmg+Cj4+ICsjaW5j
bHVkZSA8bGludXgvY21kbGluZS5oPgo+PiAgIAo+PiAgICNpbmNsdWRlIDxhc20vY3B1X29wcy5o
Pgo+PiAgICNpbmNsdWRlIDxhc20vZWFybHlfaW9yZW1hcC5oPgo+PiBAQCAtMjI4LDEwICsyMjks
OCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgcGFyc2VfZHRiKHZvaWQpCj4+ICAgCX0KPj4gICAKPj4g
ICAJcHJfZXJyKCJObyBEVEIgcGFzc2VkIHRvIHRoZSBrZXJuZWxcbiIpOwo+PiAtI2lmZGVmIENP
TkZJR19DTURMSU5FX0ZPUkNFCj4+IC0Jc3RybGNweShib290X2NvbW1hbmRfbGluZSwgQ09ORklH
X0NNRExJTkUsIENPTU1BTkRfTElORV9TSVpFKTsKPj4gKwljbWRsaW5lX2J1aWxkKGJvb3RfY29t
bWFuZF9saW5lLCBOVUxMLCBDT01NQU5EX0xJTkVfU0laRSk7Cj4+ICAgCXByX2luZm8oIkZvcmNp
bmcga2VybmVsIGNvbW1hbmQgbGluZSB0bzogJXNcbiIsIGJvb3RfY29tbWFuZF9saW5lKTsKPiAK
PiBTaG91bGRuJ3QgdGhhdCBtZXNzYWdlIGJlY29tZSBjb25kaXRpb25hbCBpbiBzb21lIHdheT8K
PiAKCllvdSBhcmUgcmlnaHQsIEkgZGlkIHNvbWV0aGluZyBzaW1pbGFyIG9uIEFSTSBidXQgbG9v
a3MgbGlrZSBJIG1pc3NlZCBpdCBvbiBSSVNDVi4KCkNocmlzdG9waGUKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJpc2N2IG1haWxpbmcgbGlz
dApsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YK
