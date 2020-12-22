From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] arch: consolidate pm_power_off callback
Date: Tue, 22 Dec 2020 21:14:19 +0100
Message-ID: <2f1d53e9-0dbb-78ef-22d5-ab230438ddf0@metux.net>
References: <20201222184510.19415-1-info@metux.net>
 <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sPM6Fnx+0wbWwNgbJOJA/IoTtP1/v3Cm+6wsOAVW8T8=; b=eEWsut9Ff3+Rod7znRWWptL+V
	NtBFXT0TTLIhjymtrhA//xDpxY7nM5nLyKLSYaiGywdvyoh0lmRfT4BN7/YTTBdgWOKmGF3B9YzuA
	ARz1n5uJoz8GnSiuEW/wYNgR+WVbTn7yJpV8HXfqxQySr2VyAMbIoc7b4ovQ6StABlCIQXa2S903S
	gtBXqKyokvj7BM7m0+Eb1L5d/HcfW1MLiY3TzhAoPvbTcffSH9rPASyxWTRUuatZW5S2LW6bewu7K
	Nhj4gE+tcvibIw3icTC1jZ78pZLiLVXklBn2PAK9Zc+zCwKEcsElbihhqpRlcK6/Wfz6dVnwWYdVc
	YmDBy45ZA==;
In-Reply-To: <CAMuHMdVze3oaWmzvzn8ROjpP6h6Tsv2SFLiV7T1Cnej36X445g@mail.gmail.com>
Content-Language: tl
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
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, James Bottomley <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, linux-csky@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv <linux-riscv@lists.infradead.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonas Bonn <jonas@southpole.se>, linux-s390 <linux-s390@vger.kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>

T24gMjIuMTIuMjAgMTk6NTQsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToKCkhpLAoKPiBPbiBU
dWUsIERlYyAyMiwgMjAyMCBhdCA3OjQ2IFBNIEVucmljbyBXZWlnZWx0LCBtZXR1eCBJVCBjb25z
dWx0Cj4gPGluZm9AbWV0dXgubmV0PiB3cm90ZToKPj4gTW92ZSB0aGUgcG1fcG93ZXJfb2ZmIGNh
bGxiYWNrIGludG8gb25lIGdsb2JhbCBwbGFjZSBhbmQgYWxzbyBhZGQgYW4KPj4gZnVuY3Rpb24g
Zm9yIGNvbmRpdGlvbmFsbHkgY2FsbGluZyBpdCAod2hlbiBub3QgTlVMTCksIGluIG9yZGVyIHRv
IHJlbW92ZQo+PiBjb2RlIGR1cGxpY2F0aW9uIGluIGFsbCBpbmRpdmlkdWFsIGFyY2hzLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdCA8aW5mb0Bt
ZXR1eC5uZXQ+Cj4gCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQo+IAo+PiAtLS0gYS9hcmNoL2Fs
cGhhL2tlcm5lbC9wcm9jZXNzLmMKPj4gKysrIGIvYXJjaC9hbHBoYS9rZXJuZWwvcHJvY2Vzcy5j
Cj4+IEBAIC00MywxMiArNDMsNiBAQAo+PiAgI2luY2x1ZGUgInByb3RvLmgiCj4+ICAjaW5jbHVk
ZSAicGNpX2ltcGwuaCIKPj4KPj4gLS8qCj4+IC0gKiBQb3dlciBvZmYgZnVuY3Rpb24sIGlmIGFu
eQo+PiAtICovCj4+IC12b2lkICgqcG1fcG93ZXJfb2ZmKSh2b2lkKSA9IG1hY2hpbmVfcG93ZXJf
b2ZmOwo+IAo+IEFzc2lnbm1lbnRzIGxpa2UgdGhlc2UgYXJlIGxvc3QgaW4gdGhlIGNvbnZlcnNp
b24uCgpZZXMsIGJ1dCB0aGlzIGRvZXNuJ3Qgc2VlbSB0byBiZSBldmVyIGNhbGxlZCBhbnl3YXlz
LiAoaW4gYXJjaC9hbHBoYSkKQW5kLCBCVFcsIGxldHRpbmcgaXQgcG9pbnQgdG8gbWFjaGluZV9w
b3dlcl9vZmYoKSBkb2Vzbid0IG1ha2UgbXVjaApzZW5zZSwgc2luY2UgaXQncyB0aGUgYXJjaCdz
IG1hY2hpbmVfcG93ZXJfb2ZmKCkgZnVuY3Rpb24sIHdobydyZQpjYWxsaW5nIHBtX3Bvd2VyX29m
ZigpLgoKQWN0dWFsbHksIHdlIGNvdWxkIHJlbW92ZSBwbV9wb3dlcl9vZmYgY29tcGxldGVseSBm
cm9tIGhlcmUsIGFzc3VtaW5nCm5vYm9keSB3b3VsZCAqYnVpbGQqIGFueSBkcml2ZXJzIHRoYXQg
cmVnaXN0ZXIgdGhlbXNlbHZlcyBpbnRvCnBtX3Bvd2VyX29mZi4KCklmIHlvdSBmZWVsIGJldHRl
ciB3aXRoIGl0LCBJIGNvdWxkIHBvc3QgYSBwYXRjaCB0aGF0IGp1c3QgcmVtb3ZlcwpwbV9wb3dl
cl9vZmYgZnJvbSBhcmNoL2FscGhhLgoKCi0tbXR4CgotLSAKLS0tCkhpbndlaXM6IHVudmVyc2No
bMO8c3NlbHRlIEUtTWFpbHMga8O2bm5lbiBsZWljaHQgYWJnZWjDtnJ0IHVuZCBtYW5pcHVsaWVy
dAp3ZXJkZW4gISBGw7xyIGVpbmUgdmVydHJhdWxpY2hlIEtvbW11bmlrYXRpb24gc2VuZGVuIFNp
ZSBiaXR0ZSBpaHJlbgpHUEcvUEdQLVNjaGzDvHNzZWwgenUuCi0tLQpFbnJpY28gV2VpZ2VsdCwg
bWV0dXggSVQgY29uc3VsdApGcmVlIHNvZnR3YXJlIGFuZCBMaW51eCBlbWJlZGRlZCBlbmdpbmVl
cmluZwppbmZvQG1ldHV4Lm5ldCAtLSArNDktMTUxLTI3NTY1Mjg3CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QK
bGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJpc2N2Cg==
