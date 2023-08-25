From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: (subset) [PATCH 00/17] -Wmissing-prototype warning fixes
Date: Sat, 26 Aug 2023 10:44:13 +1200
Message-ID: <130b3b57-edb0-184d-5b5f-69b013715773@gmail.com>
References: <20230810141947.1236730-1-arnd@kernel.org>
 <169292577153.789945.11297239773543112051.b4-ty@oracle.com>
 <3956e2a4-c545-1212-e95f-3cf61a60d6a4@gmail.com>
 <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tRCXQYGzeqKCk+15+zd18jdD3Ec3LMwgH5NlG80Zk98=; b=pl7JUNJKcHewa6ZtXsLUnR3dG9
	TjklNB+Cs6/ZlHmEGaNsomhzTdJnNSzWZQl6dYqKi70jte6ZFzrWmszmgCl5gIXCeqUM0gIoxSL8p
	ebPbwOJnYS/dl66wypYmnupJpFjnSeP1Rc3VrgBjYX0fHNgVpkpGosJ8s9p/kAmWa8pW9XbwfV0yL
	480Ok0hMOsAYGbVL3Ql8FT01+kB9D1n69VkSeFpi79QIMkEWeDh94quLJDST9S5k3m946nDNs8Uuj
	NAlSRohnZV1HXDWzyGR1bSD+ua7b18gYikNqhC8rPLWE5MSsphiEEGVpEePxnT/ehP+DjoKtlcYEo
	f2SNdZAQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693003477; x=1693608277;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:subject:from:references:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EfHZKV5Rs50FUqRYXClC9vzZD5WlxrYeYbs3IamXT4=;
        b=YxGLOPcaOZR604IVjJRcGcoKnB33IZ0CTfYuHyWKXt+0pInUOQSMoNyJ0dS6B1KmgY
         cxaBOMvor3UlQ6MZnz8hco99YltIQ+TVGTfUiOj3M6EtIom4aLy5Ogu10qSlU6URXk+W
         RnRGmXEhLIg0POh+PDKptxk33OVTKsM2/52zz5494dr8R8CSNGpoqbrRI3gpmS9Q+cTN
         hJYUsHOFyiz+AcMtmJLq8rt6PHOWgX+jhYTNJt4ghkMZ1YZYHd+UADqGIVtKxfSRzrdW
         eHx1TWLsT9QLE3Re7SH9KzLMTXlxKvezJrH+R76CylIu77symnMHbROv+J2zJ4UP/BTK
         7yuQ==
In-Reply-To: <CAMuHMdWC2S330_Vb_NTHTDC=BakBsw4ouP-eFJv0erV1-jmvTQ@mail.gmail.com>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christo

SGkgR2VlcnQsCgpBbSAyNS4wOC4yMyB1bSAxOTozOSBzY2hyaWViIEdlZXJ0IFV5dHRlcmhvZXZl
bjoKPiBIaSBNaWNoYWVsLAo+Cj4gT24gRnJpLCBBdWcgMjUsIDIwMjMgYXQgMzozMeKAr0FNIE1p
Y2hhZWwgU2NobWl0eiA8c2NobWl0em1pY0BnbWFpbC5jb20+IHdyb3RlOgo+PiBPbiAyNS8wOC8y
MyAxMzoxMiwgTWFydGluIEsuIFBldGVyc2VuIHdyb3RlOgo+Pj4gWzExLzE3XSBzY3NpOiBndnAx
MTogcmVtb3ZlIHVudXNlZCBndnAxMV9zZXR1cCgpIGZ1bmN0aW9uCj4+PiAgICAgICAgICBodHRw
czovL2dpdC5rZXJuZWwub3JnL21rcC9zY3NpL2MvYmZhYTRhMGNlMWJiCj4+IEkgc29tZWhvdyBt
aXNzZWQgdGhhdCBvbmUgLi4uCj4+Cj4+IFRoZSBndnAxMV9zZXR1cCgpIGZ1bmN0aW9uIHdhcyBw
cm9iYWJseSBhIHJlbGljIGZyb20gdGhlIHRpbWVzIGJlZm9yZQo+PiBtb2R1bGUgcGFyYW1ldGVy
cy4KPj4KPj4gU2luY2UgZ3ZwMTFfeGZlcl9tYXNrIGFwcGVhcnMgdG8gYmUgcmVxdWlyZWQgZm9y
IHNvbWUgQW1pZ2Egc3lzdGVtcyB0bwo+PiBzZXQgdGhlIERNQSBtYXNrLCBJJ2QgYmVzdCBzZW5k
IGEgcGF0Y2ggdG8gYWRkIHN1Y2ggYSBtb2R1bGUgcGFyYW1ldGVyIC4uLgo+Pgo+PiBEbyB5b3Ug
a25vdyBhbnkgZGV0YWlscyBhcm91bmQgdGhlIHVzZSBvZiBETUEgbWFza3MgZm9yIEFtaWdhIFdE
MzNDOTMKPj4gZHJpdmVycywgR2VlcnQ/Cj4gRG9oLCBpdCdzIGJlZW4gYSB3aGlsZSwgYW5kIEkg
bmV2ZXIgaGFkIGFuIGFmZmVjdGVkIHN5c3RlbS4KPiBQcm9iYWJseSBpdCdzIG5lZWRlZCBvbiBB
MjAwMCB3aXRoIGFuIGFjY2VsZXJhdG9yIGNhcmQgYW5kIEdWUCBJSSBTQ1NJLAo+IHRvIHByZXZl
bnQgRE1BIHRvIFJBTSBiYW5rcyB0aGF0IGRvIG5vdCBzdXBwb3J0IGZhc3QgRE1BIGN5Y2xlcy4K
ClRoYW5rcywgdGhhdCdzIGdvb2QgZW5vdWdoIGZvciBtZS4KCkxpbnV4IDIuMCBoYWQgdGhpcyBj
b21tZW50OgoKfC8qICogRE1BIHRyYW5zZmVyIG1hc2sgZm9yIEdWUCBTZXJpZXMgSUkgU0NTSSBj
b250cm9sbGVyLiAqIFNvbWUKdmVyc2lvbnMgY2FuIG9ubHkgRE1BIGludG8gdGhlIDI0IGJpdCBh
ZGRyZXNzIHNwYWNlICogKDAtPjE2TSkuIE90aGVycwpjYW4gRE1BIGludG8gdGhlIGZ1bGwgMzIg
Yml0IGFkZHJlc3MgKiBzcGFjZS4gVGhlIGRlZmF1bHQgaXMgdG8gb25seQphbGxvdyBETUEgaW50
byB0aGUgMjQgYml0ICogYWRkcmVzcyBzcGFjZS4gVGhlICJndnAxMT0weEZGRkZGRkZFIiBzZXR1
cApwYXJhbWV0ZXIgY2FuICogYmUgc3VwcGxpZWQgdG8gZm9yY2UgYW4gYWx0ZXJuYXRlICgzMiBi
aXQpIG1hc2suICovIHwKCnxXZSBub3cgaGFuZGxlIHRoYXQgKHNpbmNlIDIuNi4zNSkgdGhyb3Vn
aCBtYXNrcyBkZWZpbmVkIGluCmd2cDExX3pvcnJvX3RibFtdICh0aG91Z2ggSSBub3RlIHRoZXNl
IGRvbid0IGFjY291bnQgZm9yIHVuYWxpZ25lZAphZGRyZXNzZXMgc3VjaCBhcyBpbXBsaWVkIGJ5
IHRoZSBleGFtcGxlIGluIHRoZSBjb21tZW50LiBBcmUgdW5hbGlnbmVkCkRNQSBidWZmZXJzIHN0
aWxsIHBvc3NpYmxlIHRvZGF5PykuIFdvdWxkIHRoYXQgY292ZXIgdGhlICdBMjAwMCB3aXRoCmFj
Y2VsZXJhdG9yJyBjYXNlPwp8Cgp8fAoKSSdtIGhhcHB5IHRvIHNlbmQgYSBwYXRjaCBpZiBhbiBv
dmVycmlkZSB0byB0aGUgZGV2aWNlIGRlZmF1bHQgRE1BIG1hc2sKaXMgc3RpbGwgbmVjZXNzYXJ5
LgoKKEluY2lkZW50YWxseSAtIGRpZCB5b3UgZXZlciBwdWJsaXNoIHRoZSBtNjhrIGZ1bGwgaGlz
dG9yeSB0cmVlIGFueXdoZXJlCmluIGdpdD8pCgpDaGVlcnMsCgrCoMKgwqAgTWljaGFlbAoKCj4K
PiBHcntvZXRqZSxlZXRpbmd9cywKPgo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0Cj4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1y
aXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
