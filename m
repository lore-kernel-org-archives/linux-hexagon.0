From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Pv-drivers] [PATCH 29/36] cpuidle,	xenpv: Make more
 PARAVIRT_XXL noinstr clean
Date: Tue, 14 Jun 2022 18:44:02 +0200
Message-ID: <Yqi60lnN6MQpysBw@hirez.programming.kicks-ass.net>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.759631860@infradead.org>
 <510b9b68-7d53-7d4d-5a05-37fbd199eb4b@csail.mit.edu>
 <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=lGPDnVOvpW5cJYkNK5aiO+HQt8YloxSeZZcAt0L3T+0=; b=DAyjnelx4YBZDCDKjW1vABnwD6
 bfuQInSMcO0k1N9c43zulrHrt0FEspCLqBV7dzVlaMMaDm/0d8h+E1vx/Mn16eV+mdIA5cFTuH3pJ
 ZPctIYIGAc1IQVFMkXT59RectB0+FvezRUN6pXOBo7jPhyxeW7DquiSvQAiutE+ZX5GvtHgbHFHRx
 6HNiF1zBAiNoXSUuUybOLrpKXxYLhLp7SkKzRQuOg8AsSzW4GjX7X7PIc8C1Yqe4MS+PoRyI4eENc
 TnTVXl8b+mj78ByEoizyUwQl4K8tWC0/1bV8h78+HtzLeArX034mK97ekOVdMcZW15wljxz2QwCm7
 eJasXJFA==;
Content-Disposition: inline
In-Reply-To: <BAE566A0-AEA3-493E-8AC5-912C795BF1DE@vmware.com>
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
To: Nadav Amit <namit@vmware.com>
Cc: "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bsegall@google.com" <bsegall@google.com>, "guoren@kernel.org" <guoren@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "linux-imx@nxp.com" <linux-imx@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, "xen-devel@lists.xenproject.org" <xen-dev>

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDc6MjM6MTNQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90
ZToKPiBPbiBKdW4gMTMsIDIwMjIsIGF0IDExOjQ4IEFNLCBTcml2YXRzYSBTLiBCaGF0IDxzcml2
YXRzYUBjc2FpbC5taXQuZWR1PiB3cm90ZToKPiAKPiA+IOKaoCBFeHRlcm5hbCBFbWFpbAo+ID4g
Cj4gPiBPbiA2LzgvMjIgNDoyNyBQTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4gPj4gdm1saW51
eC5vOiB3YXJuaW5nOiBvYmp0b29sOiBhY3BpX2lkbGVfZW50ZXJfczJpZGxlKzB4ZGU6IGNhbGwg
dG8gd2JpbnZkKCkgbGVhdmVzIC5ub2luc3RyLnRleHQgc2VjdGlvbgo+ID4+IHZtbGludXgubzog
d2FybmluZzogb2JqdG9vbDogZGVmYXVsdF9pZGxlKzB4NDogY2FsbCB0byBhcmNoX3NhZmVfaGFs
dCgpIGxlYXZlcyAubm9pbnN0ci50ZXh0IHNlY3Rpb24KPiA+PiB2bWxpbnV4Lm86IHdhcm5pbmc6
IG9ianRvb2w6IHhlbl9zYWZlX2hhbHQrMHhhOiBjYWxsIHRvIEhZUEVSVklTT1Jfc2NoZWRfb3Au
Y29uc3Rwcm9wLjAoKSBsZWF2ZXMgLm5vaW5zdHIudGV4dCBzZWN0aW9uCj4gPj4gCj4gPj4gU2ln
bmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
Cj4gPiAKPiA+IFJldmlld2VkLWJ5OiBTcml2YXRzYSBTLiBCaGF0IChWTXdhcmUpIDxzcml2YXRz
YUBjc2FpbC5taXQuZWR1Pgo+ID4gCj4gPj4gCj4gPj4gLXN0YXRpYyBpbmxpbmUgdm9pZCB3Ymlu
dmQodm9pZCkKPiA+PiArZXh0ZXJuIG5vaW5zdHIgdm9pZCBwdl9uYXRpdmVfd2JpbnZkKHZvaWQp
Owo+ID4+ICsKPiA+PiArc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIHdiaW52ZCh2b2lkKQo+
ID4+IHsKPiA+PiAgICAgIFBWT1BfQUxUX1ZDQUxMMChjcHUud2JpbnZkLCAid2JpbnZkIiwgQUxU
X05PVChYODZfRkVBVFVSRV9YRU5QVikpOwo+ID4+IH0KPiAKPiBJIGd1ZXNzIGl0IGlzIHlldCBh
bm90aGVyIGluc3RhbmNlIG9mIHdyb25nIGFjY291bnRpbmcgb2YgR0NDIGZvcgo+IHRoZSBhc3Nl
bWJseSBibG9ja3PigJkgd2VpZ2h0LiBJIGd1ZXNzIGl0IGlzIG5vdCBhIHNvbHV0aW9uIGZvciBv
bGRlcgo+IEdDQ3MsIGJ1dCBwcmVzdW1hYmx5IF9fX19QVk9QX0FMVF9DQUxMKCkgYW5kIGZyaWVu
ZHMgc2hvdWxkIGhhdmUKPiB1c2VkIGFzbV9pbmxpbmUgb3Igc29tZSBuZXcg4oCcYXNtX3ZvbGF0
aWxlX2lubGluZeKAnSB2YXJpYW50LgoKUGFydGlhbGx5LCBzb21lIG9mIHRoZSAqU0FOIG9wdGlv
bnMgYWxzbyBnZW5lcmF0ZSBhIG1ldHJpYyB0b24gb2YKbm9uc2Vuc2Ugd2hlbiBlbmFibGVkIGFu
ZCBza2V3IHRoZSBjb21waWxlcnMgdG93YXJkcyBub3QgaW5saW5pbmcKdGhpbmdzLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
