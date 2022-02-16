From: Christophe Leroy <christophe.leroy-2tlSp11Fh4xulxpn9UvDqw@public.gmane.org>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Date: Wed, 16 Feb 2022 19:43:22 +0000
Message-ID: <07050857-c9d2-bab2-2191-8d244d6f7708@csgroup.eu>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
 <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <960826EF45C096488B90F51C2BE6F213-CLPaqP/Z8av9SOyiPdwG7kEZadJ+ESx9@public.gmane.org>
List-ID: <linux-hexagon.vger.kernel.org>
To: Arnd Bergmann <arnd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, "linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "open list:MIPS" <linux-mips-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Memory Management List <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, Guo Ren <guoren-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-riscv <linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:S390" <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Cain <bcain-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ru

DQoNCkxlIDE1LzAyLzIwMjIgw6AgMTA6MTIsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgOToxNyBBTSBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4+IE9uIE1vbiwgMTQgRmViIDIwMjIgYXQgMTc6MzcsIEFybmQgQmVy
Z21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4+Pg0KPj4NCj4+IFdpdGggc2V0X2ZzKCkgb3V0IG9mIHRoZSBwaWN0
dXJlLCB3b3VsZG4ndCBpdCBiZSBzdWZmaWNpZW50IHRvIGNoZWNrDQo+PiB0aGF0IGJpdCAjNTUg
aXMgY2xlYXI/ICh0aGUgYml0IHRoYXQgc2VsZWN0cyBiZXR3ZWVuIFRUQlIwIGFuZCBUVEJSMSkN
Cj4+IFRoYXQgd291bGQgYWxzbyByZW1vdmUgdGhlIG5lZWQgdG8gc3RyaXAgdGhlIHRhZyBmcm9t
IHRoZSBhZGRyZXNzLg0KPj4NCj4+IFNvbWV0aGluZyBsaWtlDQo+Pg0KPj4gICAgICBhc20gZ290
bygidGJueiAgJTAsICM1NSwgJTIgICAgIFxuIg0KPj4gICAgICAgICAgICAgICAidGJueiAgJTEs
ICM1NSwgJTIgICAgIFxuIg0KPj4gICAgICAgICAgICAgICA6OiAiciIoYWRkciksICJyIihhZGRy
ICsgc2l6ZSAtIDEpIDo6IG5vdG9rKTsNCj4+ICAgICAgcmV0dXJuIDE7DQo+PiBub3RvazoNCj4+
ICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gd2l0aCBhbiBhZGRpdGlvbmFsIHNhbml0eSBjaGVjayBv
biB0aGUgc2l6ZSB3aGljaCB0aGUgY29tcGlsZXIgY291bGQNCj4+IGVsaW1pbmF0ZSBmb3IgY29t
cGlsZS10aW1lIGNvbnN0YW50IHZhbHVlcy4NCj4gDQo+IFRoYXQgc2hvdWxkIHdvcmssIGJ1dCBJ
IGRvbid0IHNlZSBpdCBhcyBhIGNsZWFyIGVub3VnaCBhZHZhbnRhZ2UgdG8NCj4gaGF2ZSBhIGN1
c3RvbSBpbXBsZW1lbnRhdGlvbi4gRm9yIHRoZSBjb25zdGFudC1zaXplIGNhc2UsIGl0IHByb2Jh
Ymx5DQo+IGlzbid0IGJldHRlciB0aGFuIGEgY29tcGlsZXItc2NoZWR1bGVkIGNvbXBhcmlzb24g
YWdhaW5zdCBhDQo+IGNvbnN0YW50IGxpbWl0LCBidXQgaXQgZG9lcyBodXJ0IG1haW50YWluYWJp
bGl0eSB3aGVuIHRoZSBuZXh0IHBlcnNvbg0KPiB3YW50cyB0byBjaGFuZ2UgdGhlIGJlaGF2aW9y
IG9mIGFjY2Vzc19vaygpIGdsb2JhbGx5Lg0KPiANCj4gSWYgd2Ugd2FudCB0byBnZXQgaW50byBt
aWNyby1vcHRpbWl6aW5nIHVhY2Nlc3MsIEkgdGhpbmsgYSBiZXR0ZXIgdGFyZ2V0DQo+IHdvdWxk
IGJlIGEgQ09ORklHX0NDX0hBU19BU01fR09UT19PVVRQVVQgdmVyc2lvbg0KPiBvZiBfX2dldF91
c2VyKCkvX19wdXRfdXNlciBhcyB3ZSBoYXZlIG9uIHg4NiBhbmQgcG93ZXJwYy4NCj4gDQoNClRo
ZXJlIGlzIGFsc28gdGhlIHVzZXIgYmxvY2sgYWNjZXNzZXMgd2l0aCANCnVzZXJfYWNjZXNzX2Jl
Z2luKCkvdXNlcl9hY2Nlc3NfZW5kKCkgdG9nZXRoZXIgd2l0aCB1bnNhZmVfcHV0X3VzZXIoKSAN
CmFuZCB1bnNhZmVfZ2V0X3VzZXIoKSB3aGljaCBhbGxvd2VkIHVzIHRvIG9wdGltaXNlIHVzZXIg
YWNjZXNzZXMgb24gDQpwb3dlcnBjLCBlc3BlY2lhbGx5IGluIHRoZSBzaWduYWwgY29kZS4NCg0K
Q2hyaXN0b3BoZQ==
