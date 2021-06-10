From: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Date: Thu, 10 Jun 2021 13:54:28 +0000
Message-ID: <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tKeWZwrbZWPBqmrF8s472Q4a1fYd4dLM6zjPEUlZa8c=;
 b=opVB72hJXdjQRdwvy60NwQTGvVAtzG/KQS/g7lglALJRD3mu4a8G2E0gfZen9zvyq0Ek
 8pv5SjP68oTYlyRR88ETLHuYZ5LB2TnRM4vI57AlW4KSn/yZKBhyRAa2vs4QXKLPa0Ow
 Kg5/QvYv5AUU3t4njQsU7vPcMXk651YW4Oo= 
In-Reply-To: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
Content-ID: <8C74CC486588ED45B87C30682826B4BF@namprd15.prod.outlook.com>
List-ID: <linux-hexagon.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-btrfs <linux-btrfs@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>

DQo+IE9uIEp1biAxMCwgMjAyMSwgYXQgMToyMyBBTSwgQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0
b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4gDQo+IFdpdGggYSBjb25maWcgaGF2aW5n
IFBBR0VfU0laRSBzZXQgdG8gMjU2SywgQlRSRlMgYnVpbGQgZmFpbHMNCj4gd2l0aCB0aGUgZm9s
bG93aW5nIG1lc3NhZ2UNCj4gDQo+IGluY2x1ZGUvbGludXgvY29tcGlsZXJfdHlwZXMuaDozMjY6
Mzg6IGVycm9yOiBjYWxsIHRvICdfX2NvbXBpbGV0aW1lX2Fzc2VydF83OTEnIGRlY2xhcmVkIHdp
dGggYXR0cmlidXRlIGVycm9yOiBCVUlMRF9CVUdfT04gZmFpbGVkOiAoQlRSRlNfTUFYX0NPTVBS
RVNTRUQgJSBQQUdFX1NJWkUpICE9IDANCj4gDQo+IEJUUkZTX01BWF9DT01QUkVTU0VEIGJlaW5n
IDEyOEssIEJUUkZTIGNhbm5vdCBzdXBwb3J0IHBsYXRmb3JtcyB3aXRoDQo+IDI1NksgcGFnZXMg
YXQgdGhlIHRpbWUgYmVpbmcuDQo+IA0KPiBUaGVyZSBhcmUgdHdvIHBsYXRmb3JtcyB0aGF0IGNh
biBzZWxlY3QgMjU2SyBwYWdlczoNCj4gLSBoZXhhZ29uDQo+IC0gcG93ZXJwYw0KPiANCj4gRGlz
YWJsZSBCVFJGUyB3aGVuIDI1NksgcGFnZSBzaXplIGlzIHNlbGVjdGVkLg0KPiANCg0KV2XigJls
bCBoYXZlIG90aGVyIHN1YnBhZ2UgYmxvY2tzaXplIGNvbmNlcm5zIHdpdGggMjU2SyBwYWdlcywg
YnV0IHRoaXMgQlRSRlNfTUFYX0NPTVBSRVNTRUQgI2RlZmluZSBpcyBhcmJpdHJhcnkuICBJdOKA
mXMganVzdCB0cnlpbmcgdG8gaGF2ZSBhbiB1cHBlciBib3VuZCBvbiB0aGUgYW1vdW50IG9mIG1l
bW9yeSB3ZeKAmWxsIG5lZWQgdG8gdW5jb21wcmVzcyBhIHNpbmdsZSBwYWdl4oCZcyB3b3J0aCBv
ZiByYW5kb20gcmVhZHMuDQoNCldlIGNvdWxkIGNoYW5nZSBpdCB0byBtYXgoUEFHRV9TSVpFLCAx
MjhLKSBvciBqdXN0IGJ1bXAgdG8gMjU2Sy4NCg0KLWNocmlzDQoNCg==
