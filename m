From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: Arches that don't support PREEMPT
Date: Wed, 20 Sep 2023 10:37:42 +0000
Message-ID: <c3d5937c27824f7f879012cdeb876a14@AcuMS.aculab.com>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "mgorman@suse.de" <mgorman@suse.de>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "jon.grimm@amd.com" <jon>

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgU2VwdGVtYmVyIDIwMjMgMTg6MjUNCj4g
DQo+IE9uIFR1ZSwgMTkgU2VwdCAyMDIzIGF0IDA2OjQ4LCBKb2huIFBhdWwgQWRyaWFuIEdsYXVi
aXR6DQo+IDxnbGF1Yml0ekBwaHlzaWsuZnUtYmVybGluLmRlPiB3cm90ZToNCj4gPg0KPiA+IEFz
IEdlZXJ0IHBvaW5lZCBvdXQsIEknbSBub3Qgc2VlaW5nIGFueXRoaW5nIHBhcnRpY3VsYXIgcHJv
YmxlbWF0aWMgd2l0aCB0aGUNCj4gPiBhcmNoaXRlY3R1cmVzIGxhY2tpbmcgQ09ORklHX1BSRUVN
UFQgYXQgdGhlIG1vbWVudC4gVGhpcyBzZWVtcyB0byBiZSBtb3JlDQo+ID4gc29tZXRoaW5nIGFi
b3V0IG9yZ2FuaXppbmcgS0NvbmZpZyBmaWxlcy4NCj4gDQo+IEl0IGNhbiBkZWZpbml0ZWx5IGJl
IHByb2JsZW1hdGljLg0KPiANCj4gTm90IHRoZSBLY29uZmlnIGZpbGUgcGFydCwgYW5kIG5vdCB0
aGUgcHJlZW1wdCBjb3VudCBwYXJ0IGl0c2VsZi4NCj4gDQo+IEJ1dCB0aGUgZmFjdCB0aGF0IGl0
IGhhcyBuZXZlciBiZWVuIHVzZWQgYW5kIHRlc3RlZCBtZWFucyB0aGF0IHRoZXJlDQo+IG1pZ2h0
IGJlIHRvbnMgb2YgInRoaXMgYXJjaGl0ZWN0dXJlIGNvZGUga25vd3MgaXQncyBub3QgcHJlZW1w
dGlibGUsDQo+IGJlY2F1c2UgdGhpcyBhcmNoaXRlY3R1cmUgZG9lc24ndCBzdXBwb3J0IHByZWVt
cHRpb24iLg0KDQpEbyBkaXN0b3MgZXZlbiBidWlsZCB4ODYga2VybmVscyB3aXRoIFBSRUVNUFRf
RlVMTD8NCkkga25vdyBJJ3ZlIGhhZCBpc3N1ZXMgd2l0aCBtYXNzaXZlIGxhdGVuY2llcyBjYXVz
ZWQgZ3JhcGhpY3MgZHJpdmVyDQpmb3JjaW5nIHdyaXRlLWJhY2tzIG9mIGFsbCB0aGUgZnJhbWVi
dWZmZXIgbWVtb3J5Lg0KKEkgdGhpbmsgaXQgaXMgYSBmYWlsZWQgYXR0ZW1wdCB0byBmaXggYSB0
ZW1wb3JhcnkgZGlzcGxheSBjb3JydXB0aW9uLikNCg0KT1RPSCBTTVAgc3VwcG9ydCBhbmQgQ09O
RklHX1JUIHdpbGwgdGVzdCBtb3N0IG9mIHRoZSBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

