From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Date: Fri, 12 Oct 2018 12:42:10 -0700
Message-ID: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FrZ0b+NgKD7+5YKJ6J4ES88L1faYrWhV97OfkWWyMHY=; b=LVhBwzfXgjV8Io
	ZIe/BQu+6Wt185rIOneR5ajPZOSxa5ouI+4fU/1YTt+uEaF/+D80N0QPbSVGoiJvKp1Uc0fa7+EBw
	x0AbI9GhuFR/6Q0ZM6IWVtIaKNeQp3QpV8fLaqWeiQ3LAMHIhGuH+Ot8iskDffTtSGV8/t+YjVNOj
	05Na+6XvfMmq25xMutDMKbvhreeapxoNTKmRp24axHDBIlGfITvwZUJgRuayBCr6zHWNq4+tO18WB
	qs7e5LvBDDUamyvOv5Jfme84fodMZOCvHtxfuTVdyvhklEsbIlYZqGXinpZicVsYVvhadxtmWY6gN
	wyP2VB5ffn+/5bogv+4g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=7HZNZsB1jLEFaholpalHaVYnkWxxqdQS2UbsT4fFuJY=;
 b=Z8gYJNm7ONxx3qybdg27wFRSoVULBn2tUUBtRitXwUvZz3AhLFXo+FQIkGmVSgFidC
 qSw7CPJOp1WJWKXTflv0xxIw2LNh5s0xIfzOfYgIhSxjNXxUmUyqLzzwB0ATx3kCdzlg
 oxaGTQ7SptXZTjdi/GmovUe6gMn7aR4yslCfc=
Content-Disposition: inline
In-Reply-To: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, kernel-janitors@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Lokesh Gidra <lokeshgidra@google.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-s390@vger.kernel.org, Daniel Colascione <dancol@google.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Hugh Dickins <hughd@google.com>, "James E. J. Bottomley" <jejb@parisc-linux.org>, kasan-dev@googlegroups.com, Ingo

T24gRnJpLCBPY3QgMTIsIDIwMTggYXQgMDg6NTE6NDVQTSArMDIwMCwgU0YgTWFya3VzIEVsZnJp
bmcgd3JvdGU6Cj4gPiBUaGUgY2hhbmdlcyB3ZXJlIG9idGFpbmVkIGJ5IGFwcGx5aW5nIHRoZSBm
b2xsb3dpbmcgQ29jY2luZWxsZSBzY3JpcHQuCj4gCj4gQSBiaXQgb2YgY2xhcmlmaWNhdGlvbiBo
YXBwZW5lZCBmb3IgaXRzIGltcGxlbWVudGF0aW9uIGRldGFpbHMuCj4gaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvcGlwZXJtYWlsL2NvY2NpLzIwMTgtT2N0b2Jlci8wMDUzNzQuaHRtbAo+IAo+IEkg
aGF2ZSB0YWtlbiBhbHNvIGFub3RoZXIgbG9vayBhdCB0aGUgZm9sbG93aW5nIFNtUEwgY29kZS4K
PiAKPiAKPiA+IGlkZW50aWZpZXIgZm4gPX4KPiA+ICJeKF9fcHRlX2FsbG9jfHB0ZV9hbGxvY19v
bmV8cHRlX2FsbG9jfF9fcHRlX2FsbG9jX2tlcm5lbHxwdGVfYWxsb2Nfb25lX2tlcm5lbCkkIjsK
PiAKPiBJIHN1Z2dlc3QgdG8gYWRqdXN0IHRoZSByZWd1bGFyIGV4cHJlc3Npb24gZm9yIHRoaXMg
Y29uc3RyYWludAo+IGFuZCBpbiBzdWJzZXF1ZW50IFNtUEwgcnVsZXMuCj4gIl4oPzpwdGVfYWxs
b2MoPzpfb25lKD86X2tlcm5lbCk/KT98X19wdGVfYWxsb2MoPzpfa2VybmVsKT8pJCI7CgpTdXJl
IGl0IGxvb2tzIG1vcmUgY2xldmVyLCBidXQgd2h5PyBVZ2ggdGhhdCdzIGhhcmRlciB0byByZWFk
IGFuZCBjb25mdXNpbmcuCgo+ID4gKAo+ID4gLSBUMyBmbihUMSBFMSwgVDIgRTIpOwo+ID4gKyBU
MyBmbihUMSBFMSk7Cj4gPiB8Cj4gPiAtIFQzIGZuKFQxIEUxLCBUMiBFMiwgVDQgRTQpOwo+ID4g
KyBUMyBmbihUMSBFMSwgVDIgRTIpOwo+ID4gKQo+IAo+IEkgcHJvcG9zZSB0byB0YWtlIGFuIG90
aGVyIFNtUEwgZGlzanVuY3Rpb24gaW50byBhY2NvdW50IGhlcmUuCj4gCj4gIFQzIGZuKFQxIEUx
LAo+ICgKPiAtICAgICAgVDIgRTIKPiB8ICAgICAgVDIgRTIsCj4gLSAgICAgIFQ0IEU0Cj4gKSAg
ICAgICk7CgpBZ2FpbiB0aGlzIGlzIGNvbmZ1c2luZy4gSXQgbWFrZXMgb25lIHRoaW5rIHRoYXQg
bWF5YmUgdGhlIHNlY29uZCBhcmd1bWVudApjYW4gYWxzbyBiZSByZW1vdmVkIGFuZCByZXF1aXJl
cyBjYXJlZnVsIG9ic2VydmF0aW9uIHRoYXQgdGhlICIpOyIgZm9sbG93cy4KCj4gPiAoCj4gPiAt
ICNkZWZpbmUgZm4oYSwgYiwgYylAcCBlCj4gPiArICNkZWZpbmUgZm4oYSwgYikgZQo+ID4gfAo+
ID4gLSAjZGVmaW5lIGZuKGEsIGIpQHAgZQo+ID4gKyAjZGVmaW5lIGZuKGEpIGUKPiA+ICkKPiAK
PiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIG9taXQgdGhlIG1ldGF2YXJpYWJsZSDigJxwb3Np
dGlvbiBw4oCdIGhlcmU/CgpSaWdodCwgSSBkb24ndCBuZWVkIGl0IGluIHRoaXMgY2FzZS4gQnV0
IHRoZSBzY3JpcHQgd29ya3MgZWl0aGVyIHdheS4KCkkgbGlrZSB0byB0YWtlIG1vcmUgb2YgYSBw
cm9ibGVtIHNvbHZpbmcgYXBwcm9hY2ggdGhhdCBtYWtlcyBzZW5zZSwgdGhhbgphaW1pbmcgZm9y
IHBlcmZlY3Rpb24sIGFmdGVyIGFsbCB0aGlzIGlzIGEgdXNlZnVsIHNjcmlwdCB0aGF0IHdlIGRv
IG5vdApuZWVkIHRvIGNoZWNrIGluIG9uY2Ugd2UgZmluaXNoIHdpdGggaXQuCgogLSBKb2VsCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcmlz
Y3YgbWFpbGluZyBsaXN0CmxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yaXNjdgo=
