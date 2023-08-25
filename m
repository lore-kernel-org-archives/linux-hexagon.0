From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Fri, 25 Aug 2023 09:39:28 +0200
Message-ID: <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org> <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4bN663ITfI1/ZjN+GrTdoIJJwiYrqQHRDVoR2KZ1U5c=; b=DyNNbYeJh6TuP9
	qkfquLPTWuiYHuI5mhZxrntPjr/gyGllFtNSDUuPVSwrQXZJ3uJd87P+pGa0jqJWwOGOV3aoAuDTQ
	awZQjETecH7cIYeam4sLCU/TDctR3G6norcVb5BJRZjC32zLxvCdIVXfMdhLBBMVtI7tFV5vomaGq
	a5T2zjaT0hJ4TPN2exp7tLmd/v0uatljIR8NCjLylYRc8AdnGJipy7ADGDmulWvCb9RUxJjh5gAqE
	mv3UnK5I0OkRe8+gALLj9nutoOZWIHcmtUydzGIiVDuXqCKfD/Ig0KAOgTFmIgWnNvtHHfvaP5Tun
	to6DDYkeiYZEbFirp2Yw==;
In-Reply-To: <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
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
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Ch

SGkgTWljaGFlbCwKCk9uIEZyaSwgQXVnIDI1LCAyMDIzIGF0IDM6MzHigK9BTSBNaWNoYWVsIFNj
aG1pdHogPHNjaG1pdHptaWNAZ21haWwuY29tPiB3cm90ZToKPiBPbiAyNS8wOC8yMyAxMzoxMiwg
TWFydGluIEsuIFBldGVyc2VuIHdyb3RlOgo+ID4gWzExLzE3XSBzY3NpOiBndnAxMTogcmVtb3Zl
IHVudXNlZCBndnAxMV9zZXR1cCgpIGZ1bmN0aW9uCj4gPiAgICAgICAgICBodHRwczovL2dpdC5r
ZXJuZWwub3JnL21rcC9zY3NpL2MvYmZhYTRhMGNlMWJiCj4KPiBJIHNvbWVob3cgbWlzc2VkIHRo
YXQgb25lIC4uLgo+Cj4gVGhlIGd2cDExX3NldHVwKCkgZnVuY3Rpb24gd2FzIHByb2JhYmx5IGEg
cmVsaWMgZnJvbSB0aGUgdGltZXMgYmVmb3JlCj4gbW9kdWxlIHBhcmFtZXRlcnMuCj4KPiBTaW5j
ZSBndnAxMV94ZmVyX21hc2sgYXBwZWFycyB0byBiZSByZXF1aXJlZCBmb3Igc29tZSBBbWlnYSBz
eXN0ZW1zIHRvCj4gc2V0IHRoZSBETUEgbWFzaywgSSdkIGJlc3Qgc2VuZCBhIHBhdGNoIHRvIGFk
ZCBzdWNoIGEgbW9kdWxlIHBhcmFtZXRlciAuLi4KPgo+IERvIHlvdSBrbm93IGFueSBkZXRhaWxz
IGFyb3VuZCB0aGUgdXNlIG9mIERNQSBtYXNrcyBmb3IgQW1pZ2EgV0QzM0M5Mwo+IGRyaXZlcnMs
IEdlZXJ0PwoKRG9oLCBpdCdzIGJlZW4gYSB3aGlsZSwgYW5kIEkgbmV2ZXIgaGFkIGFuIGFmZmVj
dGVkIHN5c3RlbS4KUHJvYmFibHkgaXQncyBuZWVkZWQgb24gQTIwMDAgd2l0aCBhbiBhY2NlbGVy
YXRvciBjYXJkIGFuZCBHVlAgSUkgU0NTSSwKdG8gcHJldmVudCBETUEgdG8gUkFNIGJhbmtzIHRo
YXQgZG8gbm90IHN1cHBvcnQgZmFzdCBETUEgY3ljbGVzLgoKR3J7b2V0amUsZWV0aW5nfXMsCgog
ICAgICAgICAgICAgICAgICAgICAgICBHZWVydAoKLS0gCkdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBU
aGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcK
CkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwg
bXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1
c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGlu
dXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
