From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 30/34] sh: Convert pte_free_tlb() to use ptdescs
Date: Thu, 1 Jun 2023 09:42:11 +0200
Message-ID: <CAMuHMdVx_0Dhz1fOsCr3aYAVpk1HypoPJwbdNDj3h08x4esu0g@mail.gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
 <20230531213032.25338-31-vishal.moola@gmail.com> <CAMuHMdU4t4ac_eCH0UaX9F+GQ5-9kYjB_=e+pSfTkxG=3b8DsA@mail.gmail.com>
 <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdtJryEc2f+9Pdii740ycAZ9Nd/vgGPhafNi7AymZQU=; b=hbo2HCyxxrHY9O
	Abz1LSDBHRJce2a1+Kaf0mH22i+OPtPijU3Tcrnw/yxlMlcmQUFUIFxTMwW/96Ihjl1vfCkxmN3VG
	UbS5YR9zLjw/jneRkTd3jdajY3jbSadQGGoBC7fjK5DIWoCVfrIkQWXHd5t5asgMKx+3xTZWAv1i8
	rMJtQMHgqIjaA7qX5iyqu2Tz16YD5w698KqjA8iVpJpWMOi9GKfG2HEzlL06vr0FYsnVhdrUYuQfw
	fsb478XGk2FaUfN6I0nz3ESiGXS28ORuWbc7xuEj4L3Q23X1z7u33OLGC5nJs16XPC5+DgLKuTtBB
	zgBPE4V4gN6WNLGjDchw==;
In-Reply-To: <025fc34a24e1a1c26b187f15dba86d382d9617eb.camel@physik.fu-berlin.de>
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
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

SGkgQWRyaWFuLAoKT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA5OjI44oCvQU0gSm9obiBQYXVsIEFk
cmlhbiBHbGF1Yml0ego8Z2xhdWJpdHpAcGh5c2lrLmZ1LWJlcmxpbi5kZT4gd3JvdGU6Cj4gT24g
VGh1LCAyMDIzLTA2LTAxIGF0IDA5OjIwICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
Cj4gPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAxMTozM+KAr1BNIFZpc2hhbCBNb29sYSAoT3Jh
Y2xlKQo+ID4gPHZpc2hhbC5tb29sYUBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiBQYXJ0IG9mIHRo
ZSBjb252ZXJzaW9ucyB0byByZXBsYWNlIHBndGFibGUgY29uc3RydWN0b3IvZGVzdHJ1Y3RvcnMg
d2l0aAo+ID4gPiBwdGRlc2MgZXF1aXZhbGVudHMuIEFsc28gY2xlYW5zIHVwIHNvbWUgc3BhY2lu
ZyBpc3N1ZXMuCj4gPiA+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBNb29sYSAoT3JhY2xl
KSA8dmlzaGFsLm1vb2xhQGdtYWlsLmNvbT4KPiA+Cj4gPiBMR1RNLCBzbwo+ID4gUmV2aWV3ZWQt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+Cj4KPiBJIGFz
c3VtZSB0aGlzIHNlcmllcyBpcyBzdXBwb3NlZCB0byBnbyB0aHJvdWdoIHNvbWUgbW0gdHJlZT8K
CkkgdGhpbmsgc28sIHNvIHlvdXIgQWNrZWQtYnkgd291bGQgYmUgYXBwcmVjaWF0ZWQuLi4KCkdy
e29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVy
dCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdl
ZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5p
Y2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcg
dG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2Ug
dGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
