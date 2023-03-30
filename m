From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before
 bidirectional DMA
Date: Thu, 30 Mar 2023 14:26:18 +0100
Message-ID: <CA+V-a8twDb_P3TOpOqhz3Umump_NZg2Bw-8tgMCAmAdadUxfkw@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-10-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lqzQE+voOPcwid7PtaO0kwiPAVzXxCrOQmTSYDRGwLE=; b=AVvwVR4IAE2VAG
	KG4A62iQXhk0kRRa3JqoBOO5TliDXUVp/cGx4O7n0UD1/1f+JdGJdAJBPuC24AH0hIlSs1jqL6VpB
	OaD2sgy2tMU7WuzpIM408VLPi/rbVLyNqTDH+4ZeA7MxoVI41I50WD/R209zjLAPUOqPDLbA5gL5K
	Ej1yS1ZtjMtjNkkkSLWmObvD0lmYMxOIdzx3hjC3mrL+/vXess8Lbql87QeSmOuQfX27qM2DJFuk+
	MSTHhESRtIjbg5nS3UiNynYYHBwLWq9ktymXWzJ7H9sn7dmRKZgX6CGPQ7y9x9MuqQQZ2ZQAKax8J
	D9u5Sg6pVZ+SUg2GuEJQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182805; x=1682774805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2pZnebNGLahNe2yjgjrKsFqnYvTRYd7uF1JoUeedu4=;
        b=ipMmc4f2rhe9ZxmiesNtaMCdByaDBx7tN+zc7KMJSrXwy2WiELheDph1YzfOyUJK5G
         2D9w1lws05LiLD96ktr9W079igf4FZMXTfy1rli6Syf8wtA/xOvdvesIM/xHoHpQ4mp2
         kGaQPBqZIeQg75WZRmLC1J0vvz0N+J/wHgPfeNx6CWqljr2xVRlnhMmqStDFXeH9OteD
         UdDKlBrcDx+IHVgGRnNql6fNqhC8UJ/0zLJcMACiQdKHQjGURJds5lWBs1vyz5ebkPWw
         0o6fGsGo2wE6PVztfykuJW8aKjmi0krcntJGszy/82gq0ndxxs4fJ8aJQW98nZewfAkA
         hgxg==
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, M

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMToxNuKAr1BNIEFybmQgQmVyZ21hbm4gPGFybmRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgo+
Cj4gRm9yIGEgRE1BX0JJRElSRUNUSU9OQUwgdHJhbnNmZXIsIHRoZSBjYWNoZXMgaGF2ZSB0byBi
ZSBjbGVhbmVkCj4gZmlyc3QgdG8gbGV0IHRoZSBkZXZpY2Ugc2VlIGRhdGEgd3JpdHRlbiBieSB0
aGUgQ1BVLCBhbmQgaW52YWxpZGF0ZWQKPiBhZnRlciB0aGUgdHJhbnNmZXIgdG8gbGV0IHRoZSBD
UFUgc2VlIGRhdGEgd3JpdHRlbiBieSB0aGUgZGV2aWNlLgo+Cj4gcmlzY3YgYWxzbyBpbnZhbGlk
YXRlcyB0aGUgY2FjaGVzIGJlZm9yZSB0aGUgdHJhbnNmZXIsIHdoaWNoIGRvZXMKPiBub3QgYXBw
ZWFyIHRvIHNlcnZlIGFueSBwdXJwb3NlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJuZCBCZXJnbWFu
biA8YXJuZEBhcm5kYi5kZT4KPiAtLS0KPiAgYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQu
YyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4KUmV2aWV3ZWQtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBi
cC5yZW5lc2FzLmNvbT4KCkNoZWVycywKUHJhYmhha2FyCgo+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L21tL2RtYS1ub25jb2hlcmVudC5jIGIvYXJjaC9yaXNjdi9tbS9kbWEtbm9uY29oZXJlbnQu
Ywo+IGluZGV4IDY0MGY0YzQ5NmQyNi4uNjljODBiMjE1NWExIDEwMDY0NAo+IC0tLSBhL2FyY2gv
cmlzY3YvbW0vZG1hLW5vbmNvaGVyZW50LmMKPiArKysgYi9hcmNoL3Jpc2N2L21tL2RtYS1ub25j
b2hlcmVudC5jCj4gQEAgLTI1LDcgKzI1LDcgQEAgdm9pZCBhcmNoX3N5bmNfZG1hX2Zvcl9kZXZp
Y2UocGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLAo+ICAgICAgICAgICAgICAgICBBTFRf
Q01PX09QKGNsZWFuLCB2YWRkciwgc2l6ZSwgcmlzY3ZfY2JvbV9ibG9ja19zaXplKTsKPiAgICAg
ICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIERNQV9CSURJUkVDVElPTkFMOgo+IC0g
ICAgICAgICAgICAgICBBTFRfQ01PX09QKGZsdXNoLCB2YWRkciwgc2l6ZSwgcmlzY3ZfY2JvbV9i
bG9ja19zaXplKTsKPiArICAgICAgICAgICAgICAgQUxUX0NNT19PUChjbGVhbiwgdmFkZHIsIHNp
emUsIHJpc2N2X2Nib21fYmxvY2tfc2l6ZSk7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAg
ICAgICAgZGVmYXVsdDoKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gLS0KPiAyLjM5LjIKPgo+
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51
eC1yaXNjdiBtYWlsaW5nIGxpc3QKPiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
