From: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Date: Fri, 11 Jun 2021 16:56:31 +0000
Message-ID: <94F797B5-8936-44DF-ABA5-808C1F3F559F@fb.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
 <20210610162046.GB28158@suse.cz>
 <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
 <20210611132121.GF28158@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kkrHewb9AjX4WCwsG6viMUjh2jA3sq7bDTycJFkaocs=;
 b=pfq6Zwlf3Sz2hHY14kk02ZPoyFbEjU9ZfVHKBni+Fv8NsW0BcqxyIOyJLzI6YGeyC3Fk
 1KVNqt9QospJaZOlYW/JjEbHvkWCdEd6jiTKRrjqjZ58XwuVXj5VrbJibD54A2qPViD0
 9cBvpOgXUN+cWNKzDLuqHhEAEswJxNr2dwY= 
In-Reply-To: <20210611132121.GF28158@twin.jikos.cz>
Content-Language: en-US
Content-ID: <649F282159EC374A915FA51DB49FDE31@namprd15.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: "dsterba@suse.cz" <dsterba@suse.cz>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

DQo+IE9uIEp1biAxMSwgMjAyMSwgYXQgOToyMSBBTSwgRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1
c2UuY3o+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBKdW4gMTEsIDIwMjEgYXQgMTI6NTg6NThQTSAr
MDAwMCwgQ2hyaXMgTWFzb24gd3JvdGU6DQo+Pj4gT24gSnVuIDEwLCAyMDIxLCBhdCAxMjoyMCBQ
TSwgRGF2aWQgU3RlcmJhIDxkc3RlcmJhQHN1c2UuY3o+IHdyb3RlOg0KPj4+IE9uIFRodSwgSnVu
IDEwLCAyMDIxIGF0IDA0OjUwOjA5UE0gKzAyMDAsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+
Pj4+IExlIDEwLzA2LzIwMjEgw6AgMTU6NTQsIENocmlzIE1hc29uIGEgw6ljcml0IDoNCj4+Pj4+
PiBPbiBKdW4gMTAsIDIwMjEsIGF0IDE6MjMgQU0sIENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9w
aGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6DQo+Pj4gQW5kIHRoZXJlJ3Mgbm8gc3VjaCB0aGlu
ZyBsaWtlICJqdXN0IGJ1bXAgQlRSRlNfTUFYX0NPTVBSRVNTRUQgdG8gMjU2SyIuDQo+Pj4gVGhl
IGNvbnN0YW50IGlzIHBhcnQgb2Ygb24tZGlzayBmb3JtYXQgZm9yIGx6byBhbmQgb3RoZXJ3aXNl
IGNoYW5naW5nIGl0DQo+Pj4gd291bGQgaW1wYWN0IHBlcmZvcm1hbmNlIHNvIHRoaXMgd291bGQg
bmVlZCBwcm9wZXIgZXZhbHVhdGlvbi4NCj4+IA0KPj4gU29ycnksIGhvdyBpcyBpdCBiYWtlZCBp
bnRvIExaTz8gIEl0IGRlZmluaXRlbHkgd2lsbCBoYXZlIHBlcmZvcm1hbmNlIGltcGxpY2F0aW9u
cywgSSBhZ3JlZSB0aGVyZS4NCj4gDQo+IGx6b19kZWNvbXByZXNzX2JpbzoNCj4gDQo+IDMwOSAg
ICAgICAgIC8qDQo+IDMxMCAgICAgICAgICAqIENvbXByZXNzZWQgZGF0YSBoZWFkZXIgY2hlY2su
DQo+IDMxMSAgICAgICAgICAqDQo+IDMxMiAgICAgICAgICAqIFRoZSByZWFsIGNvbXByZXNzZWQg
c2l6ZSBjYW4ndCBleGNlZWQgdGhlIG1heGltdW0gZXh0ZW50IGxlbmd0aCwgYW5kDQo+IDMxMyAg
ICAgICAgICAqIGFsbCBwYWdlcyBzaG91bGQgYmUgdXNlZCAod2hvbGUgdW51c2VkIHBhZ2Ugd2l0
aCBqdXN0IHRoZSBzZWdtZW50DQo+IDMxNCAgICAgICAgICAqIGhlYWRlciBpcyBub3QgcG9zc2li
bGUpLiAgSWYgdGhpcyBoYXBwZW5zIGl0IG1lYW5zIHRoZSBjb21wcmVzc2VkDQo+IDMxNSAgICAg
ICAgICAqIGV4dGVudCBpcyBjb3JydXB0ZWQuDQo+IDMxNiAgICAgICAgICAqLw0KPiAzMTcgICAg
ICAgICBpZiAodG90X2xlbiA+IG1pbl90KHNpemVfdCwgQlRSRlNfTUFYX0NPTVBSRVNTRUQsIHNy
Y2xlbikgfHwNCj4gMzE4ICAgICAgICAgICAgIHRvdF9sZW4gPCBzcmNsZW4gLSBQQUdFX1NJWkUp
IHsNCj4gMzE5ICAgICAgICAgICAgICAgICByZXQgPSAtRVVDTEVBTjsNCj4gMzIwICAgICAgICAg
ICAgICAgICBnb3RvIGRvbmU7DQo+IDMyMSAgICAgICAgIH0NCg0KQWggSSBzZWUsIHNvIGdvaW5n
IGJhY2sgdG8gYW4gb2xkIExaTyBrZXJuZWwgd2lsbCBnZXQgdXBzZXQuICBPaywgZmFpciBlbm91
Z2guICBTbyBpZiB3ZSB3YW50IHRvIGJ1bXAgdGhpcyBmb3Igb3RoZXIgcmVhc29ucywgd2XigJls
bCBuZWVkIHRvIG1ha2UgYW4gTFpPIG1heCBzaXplIHRvIG1haW50YWluIGNvbXBhdGliaWxpdHku
DQoNCi1jaHJpcw==
