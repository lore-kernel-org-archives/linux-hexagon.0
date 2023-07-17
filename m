From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Date: Mon, 17 Jul 2023 15:55:50 +0000
Message-ID: <87acbb49fa83b0e3f261315a531e105da9e5b9d6.camel@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
         <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
         <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-alpha-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689609356; x=1721145356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pyrnp3e0ft0lUNotDieIaaw+/wrylRvfaKtSsCJv0Rw=;
  b=b0QiR0pQcRknEE1JcFRDYu4w/kSZe1Aowve9zP9pKKW4a7ir8331nbgw
   3jUlvqnr7C+lwtoFquyjQVmi3/7ZEjaM8QWFfvTRg1sg5VIKsBztuyis3
   UH9WXlBv/+ZnXi+bFsq7HbMdGivPVGfFQ68j2PQ6vhnTXyDFR9jTuWrwA
   2RmeA+DsSjXlh+WZAAfTkSBQdZB2KGQPWtjxitu1uWUOTd5CUuB7TaaY8
   hiBt3Ype7tcUk8mYqboNWqwRubVvRI5OMq0vCz5vgbU2IELV0uMGeFsKP
   M+YuvNfCIyyZOPgWECnDr+jRilCGSKO43TQweVdCDYSRCTjfHt9wz1wF5
   g==;
In-Reply-To: <b389274a-abed-40dc-8e33-7ce922ea9b61@sirena.org.uk>
Content-Language: en-US
Content-ID: <F76615E78E972040956CCDC0942351CA@namprd11.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: "broonie@kernel.org" <broonie@kernel.org>
Cc: "Schimpe, Christina" <christina.schimpe@intel.com>, "Yang, Weijiang" <weijiang.yang@intel.com>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, "x86@kernel.org" <x86@kernel.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "rppt@kernel.org" <rppt@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "Torvalds, Linus" <torvalds@linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "dinguyen@kernel.org" <dinguyen@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, arnd@

T24gRnJpLCAyMDIzLTA3LTE0IGF0IDIzOjU3ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBNb24sIEp1biAxMiwgMjAyMyBhdCAwNToxMDoyN1BNIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3
cm90ZToNCj4gPiBUaGUgeDg2IFNoYWRvdyBzdGFjayBmZWF0dXJlIGluY2x1ZGVzIGEgbmV3IHR5
cGUgb2YgbWVtb3J5IGNhbGxlZA0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrLiBUaGlzIHNoYWRvdyBz
dGFjayBtZW1vcnkgaGFzIHNvbWUgdW51c3VhbCBwcm9wZXJ0aWVzLCB3aGljaA0KPiA+IHJlcXVp
cmVzDQo+ID4gc29tZSBjb3JlIG1tIGNoYW5nZXMgdG8gZnVuY3Rpb24gcHJvcGVybHkuDQo+IA0K
PiBUaGlzIHNlZW1zIHRvIGJyZWFrIHNwYXJjNjRfZGVmY29uZmlnIHdoZW4gYXBwbGllZCBvbiB0
b3Agb2YgdjYuNS0NCj4gcmMxOg0KPiANCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC9ob21lL2Jy
b29uaWUvZ2l0L2Jpc2VjdC9pbmNsdWRlL2xpbnV4L21tLmg6MjksDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZyb20gL2hvbWUvYnJvb25pZS9naXQvYmlzZWN0L25ldC9jb3Jl
L3NrYnVmZi5jOjQwOg0KPiAvaG9tZS9icm9vbmllL2dpdC9iaXNlY3QvaW5jbHVkZS9saW51eC9w
Z3RhYmxlLmg6IEluIGZ1bmN0aW9uDQo+ICdwbWRfbWt3cml0ZSc6DQo+IC9ob21lL2Jyb29uaWUv
Z2l0L2Jpc2VjdC9pbmNsdWRlL2xpbnV4L3BndGFibGUuaDo1Mjg6OTogZXJyb3I6DQo+IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdwbWRfbWt3cml0ZV9ub3ZtYSc7IGRpZCB5b3Ug
bWVhbg0KPiAncHRlX21rd3JpdGVfbm92bWEnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1k
ZWNsYXJhdGlvbl0NCj4gwqAgcmV0dXJuIHBtZF9ta3dyaXRlX25vdm1hKHBtZCk7DQo+IMKgwqDC
oMKgwqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn4NCj4gwqDCoMKgwqDCoMKgwqDCoCBwdGVfbWt3
cml0ZV9ub3ZtYQ0KPiAvaG9tZS9icm9vbmllL2dpdC9iaXNlY3QvaW5jbHVkZS9saW51eC9wZ3Rh
YmxlLmg6NTI4Ojk6IGVycm9yOg0KPiBpbmNvbXBhdGlibGUgdHlwZXMgd2hlbiByZXR1cm5pbmcg
dHlwZSAnaW50JyBidXQgJ3BtZF90JyB7YWthICdzdHJ1Y3QNCj4gPGFub255bW91cz4nfSB3YXMg
ZXhwZWN0ZWQNCj4gwqAgcmV0dXJuIHBtZF9ta3dyaXRlX25vdm1hKHBtZCk7DQo+IMKgwqDCoMKg
wqDCoMKgwqAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gVGhlIHNhbWUgaXNzdWUgc2Vl
bXMgdG8gYXBwbHkgd2l0aCB0aGUgdmVyc2lvbiB0aGF0IHdhcyBpbiAtbmV4dA0KPiBiYXNlZA0K
PiBvbiB2Ni40LXJjNCB0b28uDQoNClRoZSB2ZXJzaW9uIGluIHlvdXIgYnJhbmNoIGlzIG5vdCB0
aGUgc2FtZSBhcyB0aGUgdmVyc2lvbiBpbiB0aXAgKHdoaWNoDQpoYWQgYSBzcXVhc2hlZCBidWls
ZCBmaXgpLiBJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgYnVpbGQgZXJyb3Igd2l0aA0KeW91
ciBicmFuY2guIEJ1dCBub3Qgd2l0aCB0aGUgb25lIGluIHRpcCByZWJhc2VkIG9uIHY2LjUtcmMx
LiBTbyBjYW4NCnlvdSB0cnkgdGhpcyB2ZXJzaW9uOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQvY29tbWl0Lz9oPXg4Ni9zaHN0ayZp
ZD04OTkyMjNkNjljZTlmMzM4MDU2ZjRjNDFlZjg3MGQ3MDA0MGZjODYwDQoNCg0K
