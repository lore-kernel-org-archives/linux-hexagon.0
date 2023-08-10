From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 16/17] [RFC] arch: turn -Wmissing-prototypes off
 conditionally
Date: Thu, 10 Aug 2023 17:59:30 +0200
Message-ID: <5bc9d25c-d546-fe94-05cc-41bd5bbbaf67@gmx.de>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <20230810141947.1236730-17-arnd@kernel.org>
 <e0c2f7b1-b137-fbd3-aa28-808498eb8e3f@csgroup.eu>
 <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oru7J9n2gLBpDxkWZVq/bAA6SOdVTfuxm+cv2tpBnL8=; b=rBTCGyTFfC6XQ0
	XPcicOaVjmpMToG/FjmsqRfmJ5Uvz6qAbRWYF1DOLKlomCavD2UW6IwiokUzW7uJ5njWZKJHtWRYb
	8Mv2bU2u8mV+57i3rLmgERJnZkGQYol86WRqu45Bn8g8/lRcLkF3zegVeRRu8aVLX3wiNGXjzX6FC
	Zi7NyAtd/Lg1gZxLahDBkDEuytDFFWd7SWBsvo/mCum0K2tbZ9eZHaOUZPMR5al8c7BN/EcVBuXRR
	cX8WCCRyIcYxsopbf2/2qH0NPRU53HVepNCdUo2a6Ey5zNm6m8kaN/jZq2nhpyAYz6RtSsQmD9Gmp
	SaOLfz7nqDozjAieT+qw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691683191; x=1692287991; i=deller@gmx.de;
 bh=LQ4BoluAVRb0GVjdydcgr6ii6FNpLvdjAbxqzo3k3IM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fVyd7cVX1xb7CULER8aXpZvUDMw34y68dpKhVUs8ZfR2S7048G7MucmX1i5TtqM6R82OMyR
 niOqfo7h9BzQcPM3ryfm4NQYVXaNPXZHHZkiz7VG1FgbUmccZMoRt7G6UJwhoSGn9oi7Ymmkv
 mbj2WMqZTUX9rlYnlvHU6nNlZgb9Rb3yDmafWzLCiiIfUD6X0LAiHIhVG31IXm6sBgI1OqjmK
 ggOkUGW0Ahf2P2Vq0c7++Ovnd8I4T4yVWat9f6Ob6QU9EnQto3j4L2pbtZS4yO+l3QwzXikWF
 s+FIdJZUUAJ1K0MR63xP+VnjXnNb/hlVTtQXE1xcoRa9FftNvh3g==
Content-Language: en-US
In-Reply-To: <a6222c7f-f903-4de5-821a-f90da8ad1dc9@app.fastmail.com>
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Arnd Bergmann <arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko Carstens <hca@linux.ibm.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Nathan Chancellor <nathan@kernel.org>

T24gOC8xMC8yMyAxNzoyMSwgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBUaHUsIEF1ZyAxMCwg
MjAyMywgYXQgMTY6NTksIENocmlzdG9waGUgTGVyb3kgd3JvdGU6Cj4+IExlIDEwLzA4LzIwMjMg
w6AgMTY6MTksIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoKPj4+IEZyb206IEFybmQgQmVyZ21h
bm4gPGFybmRAYXJuZGIuZGU+Cj4+Pgo+Pj4gSSBoYXZlIGNsZWFuZWQgdXAgdGhlIC1XbWlzc2lu
Zy1wcm90b3R5cGVzIHdhcm5pbmdzIGZvciBtb3N0IG9mIHRoZSBtYWpvciBhcmNoaXRlY3R1cmVz
Cj4+PiBhcyB3ZWxsIGFzIGFsbCBkcml2ZXJzIHRoYXQgZ2V0IGVuYWJsZWQgZm9yIENPTkZJR19D
T01QSUxFX1RFU1QsIHNvIG5vdyB0aGVzZSBzaG91bGQgYmUKPj4+IGNsb3NlIHRvIGZpeGVkIG9u
IHg4NiwgYXJtLCBhcm02NCwgcG93ZXJwYywgczM5MCwgYW5kIHJpc2N2Lgo+Pj4KPj4+IFRoZSBv
dGhlciBhcmNoaXRlY3R1cmVzIHRlbmQgdG8gaGF2ZSBhIGxvdCBvZiB0aGVzZSB3YXJuaW5nIGlu
IGFyY2hpdGVjdHVyZSBzcGVjaWZpYwo+Pj4gY29kZSwgcHJpbWFyaWx5IGZyb20gZnVuY3Rpb25z
IHRoYXQgYXJlIG9ubHkgY2FsbGVkIGZyb20gYXNzZW1ibGVyIGNvZGUgYW5kIGRvCj4+PiBub3Qg
b3RoZXJ3aXNlIG5lZWQgYSBkZWNsYXJhdGlvbiBidXQgc3RpbGwgY2F1c2UgYSB3YXJuaW5nIHdp
dGhvdXQgb25lLiBPdGhlciBjYXNlcwo+Pj4gYXJlIHNpbXBseSBmdW5jdGlvbnMgdGhhdCBzaG91
bGQganVzdCBiZSBzdGF0aWMgb3IgYXJlIG1pc3NpbmcgYW4gI2luY2x1ZGUgc3RhdGVtZW50Lgo+
Pj4KPj4+IEluIG9yZGVyIHRvIGJlIGFibGUgdG8gdHVybiB0aGUgd2FybmluZyBvbiBnbG9iYWxs
eSBieSBkZWZhdWx0IHdpdGhvdXQgYnJlYWtpbmcgYWxsCj4+PiB0aGVzZSBhcmNoaXRlY3R1cmVz
LCBhZGQgYSBsaXN0IG9mIGV4Y2VwdGlvbnMgZm9yIGFyY2hpdGVjdHVyZSBkaXJlY3RvcmllcyB0
aGF0Cj4+PiBjYW4gcmV2ZXJ0IGJhY2sgdG8gdGhlIG9sZCBiZWhhdmlvciBvZiBub3Qgd2Fybmlu
ZyBiYXNlZCBvbiBhIG5ldwo+Pj4gQ09ORklHX1dOT19NSVNTSU5HX1BST1RPVFlQRVMgb3B0aW9u
Lgo+Pgo+PiBTb21lIGFyY2hpdGVjdHVyZXMgb25seSBoYXZlIGEgZmV3IG9mIHRob3NlIGVycm9y
cy93YXJuaW5ncy4KPj4KPj4gRm9yIGluc3RhbmNlIG1pY3JvYmxhemUgYW5kIHBhcmlzYyBvbmx5
IGhhdmUgb25lIGVhY2guIElzbid0IGl0IGJldHRlcgo+PiB0byBmaXggdGhlbSByYXRoZXIgdGhl
biB0dXJuIHRoZSBlcnJvcnMgb2ZmID8KPgo+IFRoZSBsaXN0IHdhcyBvbmx5IHRoZSAnZGVmY29u
ZmlnJyB3YXJuaW5ncywgdGhlcmUgYXJlIGEgY291cGxlIG1vcmUKPiB0aGF0IEkgc2F3IHdpdGgg
J2FsbG1vZGNvbmZpZycsIGFuZCBJJ20gc3VyZSB0aGVyZSBhcmUgZXZlbiBtb3JlCj4gd2hlbiBk
ZWFsaW5nIHdpdGggb3RoZXIgcmFuZG9tIGNvbmZpZ3VyYXRpb25zLgo+Cj4gSSBkaWQgc2VuZCBv
dGhlciBmaXhlcyBmb3IgbWljcm9ibGF6ZSBhbmQgcGFyaXNjIHNwZWNpZmljIGRyaXZlcnMsCj4g
YW5kIEkgY291bGQgYWxzbyBzZW5kIHBhdGNoZXMgZm9yIHRoZSB0d28gZGVmY29uZmlnIHdhcm5p
bmdzIGlmCj4gdGhlIG1haW50YWluZXJzIGFyZSBoYXBweSB3aXRoIGZpeGluZyB0aG9zZSBidXQg
bGVhdmluZyBhbGxtb2Rjb25maWcKPiB0byBzdGlsbCB3YXJuLCBidXQgSSBmZWVsIHRoYXQgaXQn
cyBlYXNpZXIgZm9yIHRoZW0gdG8ganVzdAo+IGRvIHRoZSBsYXN0IGZpeGVzIHRoZW1zZWx2ZXMg
YW5kIHRoZW4gcmVtb3ZlIG15IGhhY2sgYWdhaW4uCj4KPiBJJ2xsIHdhaXQgZm9yIE1pY2hhbCBh
bmQgSGVsZ2Ugb24gdGhlc2UuCgpBcm5kLCBJIGxpa2UgeW91ciBwYXRjaCEKRm9yIHBhcmlzYyBJ
J3ZlIGRvbmUgcXVpdGUgc29tZSB3b3JrIGR1cmluZyB0aGUgbGFzdCBmZXcgd2Vla3MgdG8KZ2V0
IHN1Y2ggd2FybmluZ3Mgc3FlZXplZCBvdXQsIHNvIHBsZWFzZSBkcm9wIHRoZSBodW5rIGZvciBw
YXJpc2MgZnJvbQp5b3VyIHBhdGNoLiBNeSBwbGFuIGlzIHRvIGJlY29tZSB3YXJuaW5nLWZyZWUg
YmVmb3JlIDYuNS1maW5hbC4KClRoaXMgbGFzdCBvbmU6CiAgICAgYXJjaC9wYXJpc2MvbGliL3Vj
bXBkaTIuYzoxMjo1OiBlcnJvcjogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciAnX191Y21wZGky
JyBbLVdlcnJvcj1taXNzaW5nLXByb3RvdHlwZXNdCkknbGwgdGFrZSBjYXJlIGluIHRoZSBwYXJp
c2MgZm9yLW5leHQgdHJlZS4KClRoYW5rcyEKSGVsZ2UKCj4+IE90aGVycyBsaWtlIGxvb25nYXJj
aCB3aGljaCBpcyBhIHJlY2VudCBhY3RpdmVseSBtYWludGFpbmVkCj4+IGFyY2hpdGVjdHVyZSwg
SSdkIGV4cGVjdCB0aGUgMzAgZXJyb3JzIHRvIGJlIGVhc3kgdG8gZml4Lgo+Cj4gQWdyZWVkLCB0
aGV5IHByb2JhYmx5IGFyZS4KPgo+PiBNYW55IG9mIHRoZSBhbHBoYSBvbmVzIHNlZW1zIHRvIGJl
IGJyb3VnaHQgYnkgeW91ciBjb21taXQgZTE5ZDRlYmM1MzZkCj4+ICgiYWxwaGE6IGFkZCBmdWxs
IGlvcmVhZDY0L2lvd3JpdGU2NCBpbXBsZW1lbnRhdGlvbiIpCj4KPiBBcyBmYXIgYXMgSSBjYW4g
c2VlLCB0aG9zZSBhbHJlYWR5IGV4aXN0aW5nIGJlZm9yZSB0aGF0IHBhdGNoLCB0aG91Z2gKPiBJ
IGRpZCB0b3VjaCB0aGUgc2FtZSBsaW5lcyB0aGVyZS4KPgo+IEluIHRoZSBlbmQgaXQncyBhIG1h
dHRlciBvZiB3aGVyZSB0byBzdG9wLCBhcyB0aGVyZSBhcmUgZW5kbGVzcwo+IGNvbmZpZ3VyYXRp
b25zIHRvIHRlc3QgaWYgSSB3YW50IHRvIGRvIGEgY29tcGxldGUgam9iLiBJIGRyZXcgdGhlCj4g
bGluZSBiZXR3ZWVuIHBvd2VycGMgKHdoaWNoIEkgdHJpZWQgdG8gZml4KSBhbmQgbWlwcyAod2hp
Y2ggSSBsZWZ0Cj4gYWxvbmUpLCBtYWlubHkgYmVjYXVzZSB0aGUgcG93ZXJwYyBzaWRlIHdhcyBh
bHJlYWR5IGV4aGF1c3RpbmcKPiBhbmQgbWlwcyBoYXMgZXZlbiBtb3JlIG9ic2N1cmUgY29uZmln
dXJhdGlvbnMuIFRoZSBvdGhlciBvbmVzIG9uCj4gdGhlIGxpc3QgYXJlIGFsbCBsZXNzIGFjdGl2
ZWx5IG1haW50YWluZWQgdGhhbiB0aGVzZSB0d28uCj4KPiAgICAgICBBcm5kCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlzY3YgbWFpbGlu
ZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
