From: Brian Cain <bcain@quicinc.com>
Subject: RE: [linux-next:master 9995/11651] fs/buffer.c:2254:5: warning: stack
 frame size (2144) exceeds limit (1024) in 'block_read_full_folio'
Date: Tue, 17 May 2022 04:16:45 +0000
Message-ID: <SN6PR02MB4205A0695B4B2543A9B981FCB8CE9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <202205150051.3RzuooAG-lkp@intel.com>
 <Yn/YsTpOh898B30l@casper.infradead.org>
 <YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1652761008; x=1653365808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuV3usiLssSybTu4j9FRTZvEKND67MRdqXoM2qs8+tc=;
  b=igAmqVz/MF76zToRwE/ozs3oN4r8jrTwOuH827mAWqkd/wC7Js/ZAptq
   jkk+yP0PXVtqgrDu4f/ETavWQir1PUdt0cKAKN+O4gOvpqTQM70zgvtw1
   q1Xh8jHlzDX/NdDEHYE9yyhcCEboK3TQAnI1V+78c+31DIwEiTV1IC12N
   U=;
In-Reply-To: <YoAlvnyjEbYV4T1L@dev-arch.thelio-3990X>
Content-Language: en-US
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Nathan Chancellor <nathan@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <lkp@intel.com>, "llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, Linux Memory Management List <linux-mm@kvack.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, Sid Manning <sidneym@quicinc.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYXRoYW4gQ2hhbmNlbGxvciA8
bmF0aGFuQGtlcm5lbC5vcmc+DQouLi4NCj4gQXMgYSBzaWRlIG5vdGUuLi4gQnJpYW4sIGlzIHRo
ZXJlIGFueSByZWFzb24gZm9yIDI1NksgcGFnZXMgdG8gZXhpc3QgZm9yDQo+IEhleGFnb24/IFRo
aXMgaGFzIGJlZW4gYW4gb3B0aW9uIHNpbmNlIEhleGFnb24ncyBpbnRyb2R1Y3Rpb24gYnV0IGlz
IGl0DQo+IGFjdHVhbGx5IHVzZWQ/IDRLIHBhZ2VzIGlzIHRoZSBkZWZhdWx0IGFuZCB0aGUgaGVs
cCB0ZXh0IHNheXMgInVzZSB3aXRoDQo+IGNhdXRpb24iLiBQZXJoYXBzIHRoZSBjaG9pY2Ugc2hv
dWxkIGJlIHR1cm5lZCBvZmYgYWx0b2dldGhlciBmb3INCj4gQ09ORklHX0NPTVBJTEVfVEVTVCBz
byB0aGF0IHdlIGNhbm5vdCBzZWxlY3QgdGhpcyBjb25maWd1cmF0aW9uIGFuZA0KPiBib3RoZXIg
ZGV2ZWxvcGVycyB3aXRoIHRoZXNlIHJlcG9ydHMuDQoNCkl0J3Mgbm90IHRoZSBtb3N0IGNvbW1v
bmx5IHVzZWQgcGFnZSBzaXplLCB5ZWFoLiAgT2ssIHdlIHdpbGwgZGlzYWJsZSBpdCBmb3IgQ09O
RklHX0NPTVBJTEVfVEVTVC4NCg0KLUJyaWFuDQo=
