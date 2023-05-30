From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/2] hexagon/traps.c: use KSYM_NAME_LEN in array size
Date: Tue, 30 May 2023 13:42:13 +0000
Message-ID: <439575eda6b24261aef4c8c7e4c078cb@AcuMS.aculab.com>
References: <CGME20230529111350epcas5p46a1fa16ffb2a39008c26d03c5c63f109@epcas5p4.samsung.com>
 <20230529111337.352990-1-maninder1.s@samsung.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20230529111337.352990-1-maninder1.s@samsung.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Maninder Singh' <maninder1.s@samsung.com>, "bcain@quicinc.com" <bcain@quicinc.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>, "keescook@chromium.org" <keescook@chromium.org>, "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>, "ustavoars@kernel.org" <ustavoars@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>, "ojeda@kernel.org" <ojeda@kernel.org>, "pmladek@suse.com" <pmladek@suse.com>, "wedsonaf@google.com" <wedsonaf@google.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Onkarnath <onkarnath.1@samsung.com>

RnJvbTogTWFuaW5kZXIgU2luZ2gNCj4gU2VudDogMjkgTWF5IDIwMjMgMTI6MTQNCj4gDQo+IGth
bGxzeW1zX2xvb2t1cCB3aGljaCBpbiB0dXJuIGNhbGxzIGZvciBrYWxsc3ltc19sb29rdXBfYnVp
bGRpZCgpDQo+IHdyaXRlcyBvbiBpbmRleCAiS1NZTV9OQU1FX0xFTiAtIDEiLg0KPiANCj4gVGh1
cyBhcnJheSBzaXplIHNob3VsZCBiZSBLU1lNX05BTUVfTEVOLg0KPiANCj4gZm9yIGhleGFnb24g
aXQgd2FzIGRlZmluZWQgYXMgIjEyOCIgZGlyZWN0bHkuDQo+IGFuZCBjb21taXQgJzYxOTY4ZGJj
MmQ1ZCcgY2hhbmdlZCBkZWZpbmUgdmFsdWUgdG8gNTEyLA0KPiBTbyBib3RoIHdlcmUgbWlzc2Vk
IHRvIHVwZGF0ZSB3aXRoIG5ldyBzaXplLg0KDQpUaGUgb25seSBzYWZlIHdheSB0byBwYXNzIGEg
Zml4ZWQgc2l6ZSBzdHJpbmcgaXMgdG8gZW1iZWQgdGhlIGNoYXJbXSBpbg0KYSBzdHJ1Y3R1cmUg
YW5kIHBhc3MgdGhlIHN0cnVjdHVyZSBhZGRyZXNzLg0KDQpQcmV0dHkgbXVjaCBhbnl0aGluZyBl
bHNlIGlzIGRvb21lZCB0byBiZSBidWdneS4NCg0KV2hldGhlciBpcyBpdCBhY3R1YWxseSBzYW5l
IHRvIHJlcXVpcmUgdGhlIGNhbGxlciBhbGxvY2F0ZQ0Kc3VjaCBhIGxhcmdlIGJ1ZmZlciAoaGkg
cnVzdCkgaXMgYW5vdGhlciBtYXR0ZXIgZW50aXJlbHkuDQoNCglEYXZpZA0KDQo+IA0KPiBGaXhl
czogNjE5NjhkYmMyZDVkICgia2FsbHN5bXM6IGluY3JlYXNlIG1heGltdW0ga2VybmVsIHN5bWJv
bCBsZW5ndGggdG8gNTEyIikNCj4gDQo+IENvLWRldmVsb3BlZC1ieTogT25rYXJuYXRoIDxvbmth
cm5hdGguMUBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogT25rYXJuYXRoIDxvbmthcm5h
dGguMUBzYW1zdW5nLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaW5kZXIgU2luZ2ggPG1hbmlu
ZGVyMS5zQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gIGFyY2gvaGV4YWdvbi9rZXJuZWwvdHJhcHMu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvaGV4YWdvbi9rZXJuZWwvdHJhcHMuYyBiL2FyY2gv
aGV4YWdvbi9rZXJuZWwvdHJhcHMuYw0KPiBpbmRleCA2NDQ3NzYzY2U1YTkuLjY1YjMwYjZlYTIy
NiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9oZXhhZ29uL2tlcm5lbC90cmFwcy5jDQo+ICsrKyBiL2Fy
Y2gvaGV4YWdvbi9rZXJuZWwvdHJhcHMuYw0KPiBAQCAtODIsNyArODIsNyBAQCBzdGF0aWMgdm9p
ZCBkb19zaG93X3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzaywgdW5zaWduZWQgbG9uZyAq
ZnAsDQo+ICAJY29uc3QgY2hhciAqbmFtZSA9IE5VTEw7DQo+ICAJdW5zaWduZWQgbG9uZyAqbmV3
ZnA7DQo+ICAJdW5zaWduZWQgbG9uZyBsb3csIGhpZ2g7DQo+IC0JY2hhciB0bXBzdHJbMTI4XTsN
Cj4gKwljaGFyIHRtcHN0cltLU1lNX05BTUVfTEVOXTsNCj4gIAljaGFyICptb2RuYW1lOw0KPiAg
CWludCBpOw0KPiANCj4gLS0NCj4gMi4xNy4xDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

