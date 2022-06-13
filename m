From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [Pv-drivers] [PATCH 29/36] cpuidle, xenpv: Make more PARAVIRT_XXL
 noinstr clean
Date: Mon, 13 Jun 2022 19:23:13 +0000
Message-ID: <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.759631860@infradead.org>
 <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejRHp+UcTOOouITaszW4Xrm66IuBZfWvbS1+dB+rQfw=;
 b=GN7f2JaCeyN018ZVg8mIF1IsJ0XiFtX+hl1IknUK6qH7KFCN4gTa9x1TUyVNT+DrZmbbDfa6497/96T9/OHJIg3QTuaBxDScN5x0TY6TyL3E9tO4UsN9C7BOYxZ3obiKYusMzp5m2nOyio7MHH/sqhIIFx4ddj/daXcNeHSSMA8=
In-Reply-To: <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
Content-Language: en-US
Content-ID: <342EB95D035E904BB3A2D5C393810F2D@namprd05.prod.outlook.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Cc: "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bsegall@google.com" <bsegall@google.com>, "guoren@kernel.org" <guoren@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, "xen-devel@lists.xenproject.org" <xen-dev>

T24gSnVuIDEzLCAyMDIyLCBhdCAxMTo0OCBBTSwgU3JpdmF0c2EgUy4gQmhhdCA8c3JpdmF0c2FA
Y3NhaWwubWl0LmVkdT4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBPbiA2
LzgvMjIgNDoyNyBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+PiB2bWxpbnV4Lm86IHdhcm5p
bmc6IG9ianRvb2w6IGFjcGlfaWRsZV9lbnRlcl9zMmlkbGUrMHhkZTogY2FsbCB0byB3YmludmQo
KSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9i
anRvb2w6IGRlZmF1bHRfaWRsZSsweDQ6IGNhbGwgdG8gYXJjaF9zYWZlX2hhbHQoKSBsZWF2ZXMg
Lm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiB2bWxpbnV4Lm86IHdhcm5pbmc6IG9ianRvb2w6IHhl
bl9zYWZlX2hhbHQrMHhhOiBjYWxsIHRvIEhZUEVSVklTT1Jfc2NoZWRfb3AuY29uc3Rwcm9wLjAo
KSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFBl
dGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IFNyaXZhdHNhIFMuIEJoYXQgKFZNd2FyZSkgPHNyaXZhdHNhQGNzYWlsLm1pdC5lZHU+
DQo+IA0KPj4gDQo+PiAtc3RhdGljIGlubGluZSB2b2lkIHdiaW52ZCh2b2lkKQ0KPj4gK2V4dGVy
biBub2luc3RyIHZvaWQgcHZfbmF0aXZlX3diaW52ZCh2b2lkKTsNCj4+ICsNCj4+ICtzdGF0aWMg
X19hbHdheXNfaW5saW5lIHZvaWQgd2JpbnZkKHZvaWQpDQo+PiB7DQo+PiAgICAgIFBWT1BfQUxU
X1ZDQUxMMChjcHUud2JpbnZkLCAid2JpbnZkIiwgQUxUX05PVChYODZfRkVBVFVSRV9YRU5QVikp
Ow0KPj4gfQ0KDQpJIGd1ZXNzIGl0IGlzIHlldCBhbm90aGVyIGluc3RhbmNlIG9mIHdyb25nIGFj
Y291bnRpbmcgb2YgR0NDIGZvcg0KdGhlIGFzc2VtYmx5IGJsb2Nrc+KAmSB3ZWlnaHQuIEkgZ3Vl
c3MgaXQgaXMgbm90IGEgc29sdXRpb24gZm9yIG9sZGVyDQpHQ0NzLCBidXQgcHJlc3VtYWJseSBf
X19fUFZPUF9BTFRfQ0FMTCgpIGFuZCBmcmllbmRzIHNob3VsZCBoYXZlDQp1c2VkIGFzbV9pbmxp
bmUgb3Igc29tZSBuZXcg4oCcYXNtX3ZvbGF0aWxlX2lubGluZeKAnSB2YXJpYW50Lg0KDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
