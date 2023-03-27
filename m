From: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 06/21] powerpc: dma-mapping: minimize for_cpu flushing
Date: Mon, 27 Mar 2023 15:02:04 +0200
Message-ID: <a0b2c6a1-9f9a-490a-af1b-52d856102bc7@app.fastmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-7-arnd@kernel.org>
 <52eef604-085e-acf9-f3ee-41ba9d8441d2@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=foINxHA1nBKViHuY9q6EMYcI/PyWa1+M4nTKsseHmgA=; b=aPvZ0Mpd7rDdFJ
	Ya2vdH20j9TvXaCO/a0O8eqkprr7iEg84poAQFHlJUPMNJWeFWF/EKio1Uw2+XPKKw1oQyF9pDyOM
	ow6aHajiraWflL6EPIcpGGrDYLxgb+DwPCELJpKNqvqEP9EdLdT/CsAecbtPE9LcW8uwYmnW+osfV
	yoZtcnbcEVPC9QJfbXt3vDZt7YPloOu1JTUjCsPxz3T2XbbNH/I54X2/oQ9djA/exlTBUNXgSiSxv
	k7Y2YaOL4aUwYdvI01/uJduaVfJJvBe/cz39nmT6wbCvCLJGIWhGNrwuvuO6qfn05w4KZAsSEhRDV
	27zdtgKrL3vcuTnCzo6g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1679922148; x=1679929348; bh=C0t+VBsIdNHlcZByrnG5NPOW3/HDBRin4l1
	1iuQ2qiw=; b=Y61mr9XUfXVFhUlJdoF8OWNZ1qM6LGTHSqUwPXey+5SLhbXuszz
	IX4F35TzFt8tNJqu3TdHQy42BVXRNe3bcFUV8/zj9nSivnmtuzQXp6yIK2l3HJtv
	arNn0qdsSFaxnf2jpGCdO42ZY/Yo7maZ9JJxQnYT9zQ6fDNdG0CMXLPJSTiBiuYc
	DxowTYLJD3TZAMG+gAP8IaltLqnFWdByE0RMezkwvVUj8PXoa7+fgC1mMOdcybmk
	FOSp8xBGb8i1lrklfr+C8l8mm7z3rZwyVo/iOqMqn8kIsrxCMYlMByaiI+EkJOfO
	AksZxvdJBavSBPl8RAWIMzvbBRTXG6xIPuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1679922148; x=1679929348; bh=C0t+VBsIdNHlcZByrnG5NPOW3/HDBRin4l1
	1iuQ2qiw=; b=S8t3E1mZSSbesGBfIrPg8iez5iynYZ434j4/P/C+PFUpzIj6OWt
	K13vVMOr45Pq/x54idE06yYJdGJHsAgbut8cysdL7NSE20F2ZB97nGf6sGl0XtnJ
	9XT1e/v2R2VMawWFs9cAUtCqiZnEUzvQi5oNF6VrsD0uvg+IwkaMgefkI++oVxUX
	P6oUU+TSxGqMMY77icyCim+29Cz39zEK5CEbEi/5s9/A6kWKWjnkM9cNn+OZr9OG
	+PTT8iBaVt9Y7UzKaNo9juS2P9bsmSmnzuVEEp99tvwuhj8CNT8gHrMIM+y46L5g
	RgKT+E9GeicOtbPmieJjqHY7nt82g7IMpvg==
In-Reply-To: <52eef604-085e-acf9-f3ee-41ba9d8441d2@csgroup.eu>
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann <arnd@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S . Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christoph Hellwig <hch@lst.de>, Robin

T24gTW9uLCBNYXIgMjcsIDIwMjMsIGF0IDE0OjU2LCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOgo+
IExlIDI3LzAzLzIwMjMgw6AgMTQ6MTMsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoKPj4gRnJv
bTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPj4gCj4+IFRoZSBwb3dlcnBjIGRtYV9z
eW5jXypfZm9yX2NwdSgpIHZhcmlhbnRzIGRvIG1vcmUgZmx1c2hlcyB0aGFuIG9uIG90aGVyCj4+
IGFyY2hpdGVjdHVyZXMuIFJlZHVjZSBpdCB0byB3aGF0IGV2ZXJ5b25lIGVsc2UgZG9lczoKPj4g
Cj4+ICAgLSBObyBmbHVzaCBpcyBuZWVkZWQgYWZ0ZXIgZGF0YSBoYXMgYmVlbiBzZW50IHRvIGEg
ZGV2aWNlCj4+IAo+PiAgIC0gV2hlbiBkYXRhIGhhcyBiZWVuIHJlY2VpdmVkIGZyb20gYSBkZXZp
Y2UsIHRoZSBjYWNoZSBvbmx5IG5lZWRzIHRvCj4+ICAgICBiZSBpbnZhbGlkYXRlZCB0byBjbGVh
ciBvdXQgY2FjaGUgbGluZXMgdGhhdCB3ZXJlIHNwZWN1bGF0aXZlbHkKPj4gICAgIHByZWZldGNo
ZWQuCj4+IAo+PiBJbiBwYXJ0aWN1bGFyLCB0aGUgc2Vjb25kIGZsdXNoaW5nIG9mIHBhcnRpYWwg
Y2FjaGUgbGluZXMgb2YgYmlkaXJlY3Rpb25hbAo+PiBidWZmZXJzIGlzIGFjdGl2ZWx5IGhhcm1m
dWwgLS0gaWYgYSBzaW5nbGUgY2FjaGUgbGluZSBpcyB3cml0dGVuIGJ5IGJvdGgKPj4gdGhlIENQ
VSBhbmQgdGhlIGRldmljZSwgZmx1c2hpbmcgaXQgYWdhaW4gZG9lcyBub3QgbWFpbnRhaW4gY29o
ZXJlbmN5Cj4+IGJ1dCBpbnN0ZWFkIG92ZXJ3cml0ZSB0aGUgZGF0YSB0aGF0IHdhcyBqdXN0IHJl
Y2VpdmVkIGZyb20gdGhlIGRldmljZS4KPgo+IEh1bSAuLi4uLiBXaG8gaXMgcmlnaHQgPwo+Cj4g
VGhhdCBiZWhhdmlvdXIgd2FzIGludHJvZHVjZWQgYnkgY29tbWl0IDAzZDcwNjE3YjhhNyAoInBv
d2VycGM6IFByZXZlbnQgCj4gbWVtb3J5IGNvcnJ1cHRpb24gZHVlIHRvIGNhY2hlIGludmFsaWRh
dGlvbiBvZiB1bmFsaWduZWQgRE1BIGJ1ZmZlciIpCj4KPiBJIHRoaW5rIHlvdXIgY29tbWl0IGxv
ZyBzaG91bGQgZXhwbGFpbiB3aHkgdGhhdCBjb21taXQgd2FzIHdyb25nLCBhbmQgCj4gbWF5YmUg
c2F5IHRoYXQgeW91ciBwYXRjaCBpcyBhIHJldmVydCBvZiB0aGF0IGNvbW1pdCA/CgpPaywgSSds
bCB0cnkgdG8gZXhwbGFpbiB0aGlzIGJldHRlci4gVG8gY2xhcmlmeSBoZXJlOiB0aGUgX19kbWFf
c3luYygpCmZ1bmN0aW9uIGluIGNvbW1pdCAwM2Q3MDYxN2I4YTcgaXMgdXNlZCBib3RoIGJlZm9y
ZSBhbmQgYWZ0ZXIgYSBETUEsCmJ1dCBteSBwYXRjaCAwNS8yMSBzcGxpdHMgdGhpcyBpbiB0d28s
IGFuZCBwYXRjaCAwNi8yMSBvbmx5IGNoYW5nZXMKdGhlIHBhcnQgdGhhdCBnZXRzIGNhbGxlZCBh
ZnRlciB0aGUgRE1BLWZyb20tZGV2aWNlIGJ1dCBsZWF2ZXMgdGhlCnBhcnQgYmVmb3JlIERNQS1m
cm9tLWRldmljZSB1bmNoYW5nZWQsIHdoaWNoIEFuZHJldydzIHBhdGNoCmFkZHJlc3NlZC4KCkFz
IEkgbWVudGlvbmVkIGluIHRoZSBjb3ZlciBsZXR0ZXIsIGl0IGlzIHN0aWxsIHVuY2xlYXIgd2hl
dGhlcgp3ZSB3YW50IHRvIGNvbnNpZGVyIHRoaXMgdGhlIGV4cGVjdGVkIGJlaGF2aW9yIGFzIHRo
ZSBkb2N1bWVudGF0aW9uCnNlZW1zIHVuY2xlYXIsIGJ1dCBteSBzZXJpZXMgZG9lcyBub3QgYXR0
ZW1wdCB0byBhbnN3ZXIgdGhhdApxdWVzdGlvbi4KCiAgICAgQXJuZAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlzY3YgbWFpbGluZyBsaXN0
CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
