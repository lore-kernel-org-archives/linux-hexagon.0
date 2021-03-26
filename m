From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 11/17] riscv: Convert to GENERIC_CMDLINE
Date: Fri, 26 Mar 2021 15:08:22 +0100
Message-ID: <87zgyqdn3d.fsf@igel.home>
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:Date:References:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i14gTSC3ecNLdu4gy/1xA1LnzJY6dDplgd8t5/e97O4=; b=V3CBTW8vf3UQ5oQlkHh7cbPa4
	9m3CAigmPMEp3k6sb4Mv+Ewj7cFIzIglB/axruzz72sjXipIUnkAi8hix8h56q7X/4DeUQqAyfepv
	bEipzLmbBUm/WcefeO3QcpuC96PlDkPSEG1xFAcxH5vxtVDacPTGLok9TXM3K7Qk/pyBRZ9EzQCR3
	/p6mzi8HUZEBa0ZCdj8Wwp+QSzQimGar3vljQcOooNe0sTxu89n712nSBWVCV+eDCdhPVY3DhcOAK
	yJH8oZJegLNYOp2NkJiwEqaTp2rvSaZihMs0TU6y4ZGe45QCnu+LDbQugW6dOtXDzhzQGth0uIeOl
	R2WDGNz9Q==;
In-Reply-To: <46745e07b04139a22b5bd01dc37df97e6981e643.1616765870.git.christophe.leroy@csgroup.eu>
 (Christophe Leroy's message of "Fri, 26 Mar 2021 13:44:58 +0000
 (UTC)")
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
Content-Type: text/plain; charset="iso-8859-1"
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: will@kernel.org, danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org, nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org

T24gTcOkciAyNiAyMDIxLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOgoKPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYyBiL2FyY2gvcmlzY3Yva2VybmVsL3NldHVwLmMKPiBp
bmRleCBmOGYxNTMzMmNhYTIuLmU3YzkxZWU0NzhkMSAxMDA2NDQKPiAtLS0gYS9hcmNoL3Jpc2N2
L2tlcm5lbC9zZXR1cC5jCj4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvc2V0dXAuYwo+IEBAIC0y
MCw2ICsyMCw3IEBACj4gICNpbmNsdWRlIDxsaW51eC9zd2lvdGxiLmg+Cj4gICNpbmNsdWRlIDxs
aW51eC9zbXAuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2VmaS5oPgo+ICsjaW5jbHVkZSA8bGludXgv
Y21kbGluZS5oPgo+ICAKPiAgI2luY2x1ZGUgPGFzbS9jcHVfb3BzLmg+Cj4gICNpbmNsdWRlIDxh
c20vZWFybHlfaW9yZW1hcC5oPgo+IEBAIC0yMjgsMTAgKzIyOSw4IEBAIHN0YXRpYyB2b2lkIF9f
aW5pdCBwYXJzZV9kdGIodm9pZCkKPiAgCX0KPiAgCj4gIAlwcl9lcnIoIk5vIERUQiBwYXNzZWQg
dG8gdGhlIGtlcm5lbFxuIik7Cj4gLSNpZmRlZiBDT05GSUdfQ01ETElORV9GT1JDRQo+IC0Jc3Ry
bGNweShib290X2NvbW1hbmRfbGluZSwgQ09ORklHX0NNRExJTkUsIENPTU1BTkRfTElORV9TSVpF
KTsKPiArCWNtZGxpbmVfYnVpbGQoYm9vdF9jb21tYW5kX2xpbmUsIE5VTEwsIENPTU1BTkRfTElO
RV9TSVpFKTsKPiAgCXByX2luZm8oIkZvcmNpbmcga2VybmVsIGNvbW1hbmQgbGluZSB0bzogJXNc
biIsIGJvb3RfY29tbWFuZF9saW5lKTsKClNob3VsZG4ndCB0aGF0IG1lc3NhZ2UgYmVjb21lIGNv
bmRpdGlvbmFsIGluIHNvbWUgd2F5PwoKQW5kcmVhcy4KCi0tIApBbmRyZWFzIFNjaHdhYiwgc2No
d2FiQGxpbnV4LW02OGsub3JnCkdQRyBLZXkgZmluZ2VycHJpbnQgPSA3NTc4IEVCNDcgRDRFNSA0
RDY5IDI1MTAgIDI1NTIgREY3MyBFNzgwIEE5REEgQUVDMQoiQW5kIG5vdyBmb3Igc29tZXRoaW5n
IGNvbXBsZXRlbHkgZGlmZmVyZW50LiIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdApsaW51eC1yaXNjdkBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtcmlzY3YK
