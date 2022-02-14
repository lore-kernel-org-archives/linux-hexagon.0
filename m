From: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Subject: RE: [PATCH 04/14] x86: use more conventional access_ok() definition
Date: Mon, 14 Feb 2022 22:13:34 +0000
Message-ID: <2dda07f893cb4ef9b5ea2265adccb98f@AcuMS.aculab.com>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-5-arnd@kernel.org> <YgqLFYqIqkIsNC92@infradead.org>
 <CAK8P3a1F3JaYaJPy9bSCG1+YV6EN05PE0DbwpD_GT1qRwFSJ-w@mail.gmail.com>
 <CAHk-=whq6_Nh3cB3FieP481VcRyCu69X3=wO1yLHGmcZEj69SA@mail.gmail.com>
 <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHk-=wgYu67OwP4LhcrPdDVxv2mOsx-Xsc2DKoVW6GZwKFtOYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Linus Torvalds' <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arnd Bergmann <arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, "linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guo Ren <guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-riscv <linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-s390 <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTQgRmVicnVhcnkgMjAyMiAyMDoyNA0KPiA+
DQo+ID4geDg2LTY0IGhhcyBhbHdheXMoKikgdXNlZCBUQVNLX1NJWkVfTUFYIGZvciBhY2Nlc3Nf
b2soKSwgYW5kIHRoZQ0KPiA+IGdldF91c2VyKCkgYXNzZW1ibGVyIGltcGxlbWVudGF0aW9uIGRv
ZXMgdGhlIHNhbWUuDQo+IA0KPiBTaWRlIG5vdGU6IHdlIGNvdWxkIGp1c3QgY2hlY2sgdGhlIHNp
Z24gYml0IGluc3RlYWQsIGFuZCBhdm9pZCBiaWcNCj4gY29uc3RhbnRzIHRoYXQgd2F5Lg0KDQpU
aGUgY2hlYXAgdGVzdCBmb3IgbW9zdCA2NGJpdCBpcyAoYWRkciB8IHNpemUpID4+IDYyICE9IDAu
DQoNCkkgZGlkIHNvbWUgdGVzdHMgbGFzdCB3ZWVrIGFuZCB0aGUgY29tcGlsZXJzIGNvcnJlY3Rs
eSBvcHRpbWlzZQ0Kb3V0IGNvbnN0YW50IHNpemUuDQoNCkRvZXNuJ3Qgc3BhcmM2NCBzdGlsbCBu
ZWVkIGEgd3JhcCB0ZXN0Pw0KT3IgaXMgdGhhdCBhc3N1bWVkIGJlY2F1c2UgdGhlcmUgaXMgYWx3
YXlzIGFuIHVubWFwcGVkIHBhZ2UNCmFuZCB0cmFuc2ZlciBhcmUgJ2FkZXF1YXRlbHknIGRvbmUg
b24gaW5jcmVhc2luZyBhZGRyZXNzZXM/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

