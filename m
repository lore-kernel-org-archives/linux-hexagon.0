From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 02/21] xtensa: dma-mapping: use normal cache invalidation rules
Date: Mon, 27 Mar 2023 08:42:59 -0700
Message-ID: <CAMo8BfJwjcQxWVW9o6brvBYTgUe9v=QGgs39=_V6Oc9-OKv7Sw@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-3-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iCcB7w5Ay20W0zb7RDec7Px2KIgerdlymA/YA8Hl2Qc=; b=RtU03rZyV1AooN
	gShzsxPuiWRaqnrlXP5nDos7XfLJFKJcsLkR0KZV6hfZPPioLrvcB7pHh6ZnlDWlw431ki0RsKN5J
	/MuO+YGjMxHytZB5exAad6Foci/viLHE2rfgKBmGvLxRy6EfMuDwLASogHz80W8pCiCKq8AAi9AJu
	4DE/4heZePmGXS3uSGM45D0MuR6V5uwS7ZfRrUwws+IW/bsVr+SaMWmiMzc7H9kcYacjWI7zw6IRo
	NUESlPk1MVSMLVOiiukF9zjlBIcNIPrgmlBO737147ubbgD/wfkx1wdyR7qHTzVuQXflCLDQb0I5t
	Sm+2GjRc21yM9s96KrRQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679931790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRasUUTOEu/ok1S92mQy2tcMp/4KwW2lXbLEiKBj/7o=;
        b=HZFjetxTrU0/nv8Y55FAOK1Apm3VUH13SuQEA6blI4LQsquf470BO/HxA5cmFNd3aK
         KhVXkKlmZq93fBkC6giJvUDlt7FuVro1W64JdaQrEtphQxoptl43dqOAsJuOdXDllTly
         etHqoII3GsZRYL1O1XM8c2+DB4jJ3oBH+CWict03ya4f003TK7u/v0bAMMATlIwbsHEE
         Eab9bSU2vOsS7u7Hi3cpukhSfrOKg/M8N1PXdsx2k+lYCOOyiPnKWQEclkXPeaKbVR3e
         gND/Ow1eDKT0AYLAkJBh79+oSz/WTGmxOT1B4ufDuEkJHS9CEZchC2NFdFV6xpk2+oqj
         wINA==
In-Reply-To: <20230327121317.4081816-3-arnd@kernel.org>
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
Content-Type: text/plain; charset="windows-1252"
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, C

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgNToxNOKAr0FNIEFybmQgQmVyZ21hbm4gPGFybmRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+
Cj4geHRlbnNhIGlzIG9uZSBvZiB0aGUgcGxhdGZvcm1zIHRoYXQgaGFzIGJvdGggd3JpdGUtYmFj
ayBhbmQgd3JpdGUtdGhyb3VnaAo+IGNhY2hlcywgYW5kIG5lZWRzIHRvIGFjY291bnQgZm9yIGJv
dGggaW4gaXRzIERNQSBtYXBwaW5nIG9wZXJhdGlvbnMuCj4KPiBJdCBkb2VzIHRoaXMgdGhyb3Vn
aCBhIHNldCBvZiBvcGVyYXRpb25zIHRoYXQgaXMgZGlmZmVyZW50IGZyb20gYW55Cj4gYXJjaGl0
ZWN0dXJlLiBUaGlzIGlzIG5vdCBhIHByb2JsZW0gYnkgaXRzZWxmLCBidXQgaXQgbWFrZXMgaXQg
cmF0aGVyCj4gaGFyZCB0byBmaWd1cmUgb3V0IHdoZXRoZXIgdGhpcyBpcyBjb3JyZWN0IG9yIG5v
dCwgYW5kIHRvIHVuaWZ5IHRoaXMKPiBpbXBsZW1lbnRhdGlvbiB3aXRoIHRoZSBvdGhlcnMuCj4K
PiBDaGFuZ2UgdGhlIHNlbWFudGljcyB0byB0aGUgdXN1YWwgb25lcyBmb3Igbm9uLXNwZWN1bGF0
aW5nIENQVXM6Cj4KPiAgLSBPbiBETUFfVE9fREVWSUNFLCBjYWxsIF9fZmx1c2hfZGNhY2hlX3Jh
bmdlKCkgdG8gcGVyZm9ybSB0aGUKPiAgICB3cml0ZWJhY2sgZXZlbiBvbiB3cml0ZXRocm91Z2gg
Y2FjaGVzLCB3aGVyZSB0aGlzIGlzIGEgbm9wLgo+Cj4gIC0gT24gRE1BX0ZST01fREVWSUNFLCBp
bnZhbGlkYXRlIHRoZSBtYXBwaW5nIGJlZm9yZSB0aGUgRE1BIHJhdGhlcgo+ICAgIHRoYW4gYWZ0
ZXJ3YXJkcy4KPgo+ICAtIE9uIERNQV9CSURJUkVDVElPTkFMLCBjb21iaW5lIHRoZSBwcmUtd3Jp
dGViYWNrIHdpdGggdGhlCj4gICAgcG9zdC1pbnZhbGlkYXRlIGludG8gYSBjYWxsIHRvIF9fZmx1
c2hfaW52YWxpZGF0ZV9kY2FjaGVfcmFuZ2UoKQo+ICAgIHRoYXQgdHVybnMgaW50byBhIHNpbXBs
ZSBpbnZhbGlkYXRlIG9uIHdyaXRlYmFjayBjYWNoZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+IC0tLQo+ICBhcmNoL3h0ZW5zYS9LY29uZmlnICAg
ICAgICAgICAgICAgICAgfCAgMSAtCj4gIGFyY2gveHRlbnNhL2luY2x1ZGUvYXNtL2NhY2hlZmx1
c2guaCB8ICA2ICsrKy0tLQo+ICBhcmNoL3h0ZW5zYS9rZXJuZWwvcGNpLWRtYS5jICAgICAgICAg
fCAyOSArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBNYXggRmlsaXBwb3Yg
PGpjbXZia2JjQGdtYWlsLmNvbT4KCi0tIApUaGFua3MuCi0tIE1heAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlzY3YgbWFpbGluZyBsaXN0
CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
