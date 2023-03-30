From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Date: Thu, 30 Mar 2023 10:12:00 +0200
Message-ID: <CACRpkdYuyzkvSQY0sQJei39d9ZoGM_DbJQ5LxUg3sXsBmzJyaQ@mail.gmail.com>
References: <20230327121317.4081816-1-arnd@kernel.org> <20230327121317.4081816-19-arnd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xyl7Ap9g97P7+gJkruUFUPXNAmDQG1qU8u636ArlFhM=; b=ZsEN+Ntr21A+VL
	JIyde5ksgAWIkM4dLWYXY1S+h74BRQ28lHth+UVWPMsfpIE2FPJEG1+e2iJt2UxL6wSsI0ZMd2Iz2
	UiQbRO5FBlDUYZOfcchu3rE+L3P5eS9XP0scKi4ZEoLTipCNkb1pW6tz9W98ddSV9eCQBaNym2sDk
	QHR9FILp9wtXMRMXW79ktjh7qbWq2VF319FKVcF6+I1in/qMV4XaOT9rPynsTT9MAVO21SbyhAl7N
	eFJaBTMx+zHtr+uB/1KmcDA1H2Rr7qRawWbraenrTQ0gtPgLoPgLh9u832vqJc/6V+aWPx33lsaaY
	Zcom4Qlw3cjskcbnyBlA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQCYgbZHrv29At0jbIiZAbPjoR2bcYIsz7/d6inu7f8=;
        b=ExPqwkg7v1NJaAb/s/k5m0AsXdPeqWANvICm34UN83+g91kLHVNxTL6wIK95elgwZ0
         BsoWOOEBJNZZMuzO0jd9e5ZnX+piu95PYHJc8aCAeb74EZLSXYYZcUnjlcrwcSx9uUSn
         +ZylXYodLpHskZhPbl4FteqkYPSevcOTC9viahsIQVrxIIJjVrJEKuNvoC6mbX+9pqR3
         89vqEOP7c1GfiVA/eOXrKlUJ2J9zGfYuC7KwccmlIyO2J0GIlDQpCElJBkH4Lwj1h0sT
         ooCHH5PYBMyLFmPU8W7WigILMi6/95wflgUZh1w0ygoWmHzMdYahkSPYjw44g9lyJXD6
         gNjA==
In-Reply-To: <20230327121317.4081816-19-arnd@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Neil Armstrong <neil.armstrong@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Stafford Horne <shorne@gmail.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>, Max Filippov <jcmvbkbc@gmail.com>, Christop

T24gTW9uLCBNYXIgMjcsIDIwMjMgYXQgMjoxNuKAr1BNIEFybmQgQmVyZ21hbm4gPGFybmRAa2Vy
bmVsLm9yZz4gd3JvdGU6Cgo+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+Cj4K
PiBUaGUgY2FjaGUgbWFuYWdlbWVudCBvcGVyYXRpb25zIGZvciBub25jb2hlcmVudCBETUEgb24g
QVJNdjYgd29yawo+IGluIHR3byBkaWZmZXJlbnQgd2F5czoKPgo+ICAqIFdoZW4gQ09ORklHX0RN
QV9DQUNIRV9SV0ZPIGlzIHNldCwgc3BlY3VsYXRpdmUgcHJlZmV0Y2hlcyBvbiBpbi1mbGlnaHQK
PiAgICBETUEgYnVmZmVycyBsZWFkIHRvIGRhdGEgY29ycnVwdGlvbiB3aGVuIHRoZSBwcmVmZXRj
aGVkIGRhdGEgaXMgd3JpdHRlbgo+ICAgIGJhY2sgb24gdG9wIG9mIGRhdGEgZnJvbSB0aGUgZGV2
aWNlLgo+Cj4gICogV2hlbiBDT05GSUdfRE1BX0NBQ0hFX1JXRk8gaXMgZGlzYWJsZWQsIGEgY2Fj
aGUgZmx1c2ggb24gb25lIENQVQo+ICAgIGlzIG5vdCBzZWVuIGJ5IHRoZSBvdGhlciBjb3JlKHMp
LCBsZWFkaW5nIHRvIGluY29uc2lzdGVudCBjb250ZW50cwo+ICAgIGFjY3Jvc3MgdGhlIHN5c3Rl
bS4KPgo+IEFzIGEgY29uc2VxdWVuY2UsIG5laXRoZXIgY29uZmlndXJhdGlvbiBpcyBhY3R1YWxs
eSBzYWZlIHRvIHVzZSBpbiBhCj4gZ2VuZXJhbC1wdXJwb3NlIGtlcm5lbCB0aGF0IGlzIHVzZWQg
b24gYm90aCBNUENvcmUgc3lzdGVtcyBhbmQgQVJNMTE3Ngo+IHdpdGggcHJlZmV0Y2hpbmcgZW5h
YmxlZC4KPgo+IFdlIGNvdWxkIGFkZCBmdXJ0aGVyIHdvcmthcm91bmRzIHRvIG1ha2UgdGhlIGJl
aGF2aW9yIG1vcmUgZHluYW1pYyBiYXNlZAo+IG9uIHRoZSBzeXN0ZW0sIGJ1dCByZWFsaXN0aWNh
bGx5LCB0aGVyZSBhcmUgY2xvc2UgdG8gemVybyByZW1haW5pbmcKPiB1c2VycyBvbiBhbnkgQVJN
MTFNUENvcmUgYW55d2F5LCBhbmQgbm9ib2R5IHNlZW1zIHRvbyBpbnRlcmVzdGVkIGluIGl0LAo+
IGNvbXBhcmVkIHRvIHRoZSBtb3JlIHBvcHVsYXIgQVJNMTE3NiB1c2VkIGluIEJNQzI4MzUgYW5k
IEFTVDI1MDAuCj4KPiBUaGUgT3huYXMgcGxhdGZvcm0gaGFzIHNvbWUgbWluaW1hbCBzdXBwb3J0
IGluIE9wZW5XUlQsIGJ1dCBtb3N0IG9mIHRoZQo+IGRyaXZlcnMgYW5kIGR0cyBmaWxlcyBuZXZl
ciBtYWRlIGl0IGludG8gdGhlIG1haW5saW5lIGtlcm5lbCwgd2hpbGUgdGhlCj4gQXJtIFZlcnNh
dGlsZS9SZWFsdmlldyBwbGF0Zm9ybSBtYWlubHkgc2VydmVzIGFzIGEgcmVmZXJlbmNlIHN5c3Rl
bSBidXQKPiBpcyBub3QgbmVjZXNzYXJ5IHRvIGJlIGtlcHQgd29ya2luZyBvbmNlIGFsbCBvdGhl
ciBBUk0xMU1QQ29yZSBhcmUgZ29uZS4KPgo+IFRha2UgdGhlIGVhc3kgd2F5IG91dCBoZXJlIGFu
ZCBkcm9wIHN1cHBvcnQgZm9yIG11bHRpcHJvY2Vzc2luZyBvbgo+IEFSTXY2LCBhbG9uZyB3aXRo
IHRoZSBDT05GSUdfRE1BX0NBQ0hFX1JXRk8gb3B0aW9uIGFuZCB0aGUgY2FjaGUKPiBtYW5hZ2Vt
ZW50IGltcGxlbWVudGF0aW9uIGZvciBpdC4gVGhpcyBhbHNvIGhlbHBzIHdpdGggb3RoZXIgQVJN
djYKPiBpc3N1ZXMsIGJ1dCBmb3IgdGhlIG1vbWVudCBsZWF2ZXMgdGhlIGFiaWxpdHkgdG8gYnVp
bGQgYSBrZXJuZWwgdGhhdAo+IGNhbiBydW4gb24gYm90aCBBUk12NyBTTVAgYW5kIHNpbmdsZS1w
cm9jZXNzb3IgQVJNdjYsIHdoaWNoIHdlIHByb2JhYmx5Cj4gd2FudCB0byBzdG9wIHN1cHBvcnRp
bmcgYXMgd2VsbCwgYnV0IG5vdCBhcyBwYXJ0IG9mIHRoaXMgc2VyaWVzLgo+Cj4gQ2M6IE5laWwg
QXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPgo+IENjOiBEYW5pZWwgR29sbGUg
PGRhbmllbEBtYWtyb3RvcGlhLm9yZz4KPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPgo+IENjOiBsaW51eC1veG5hc0Bncm91cHMuaW8KPiBTaWduZWQtb2ZmLWJ5
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPgoKWWVhaCwgd2UgZGlzY3Vzc2VkIHRoaXMg
ZWFybGllciwgbGV0J3MganVzdCBkcm9wIGl0LiBOb3Qgd29ydGggdGhlIGVmZm9ydC4KQWNrZWQt
Ynk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KCllvdXJzLApMaW51
cyBXYWxsZWlqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QKbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2
Cg==
