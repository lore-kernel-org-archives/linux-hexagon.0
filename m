From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 33/44] openrisc: remove arch-specific
	dma_supported implementation
Date: Thu,  8 Jun 2017 15:25:58 +0200
Message-ID: <20170608132609.32662-34-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q6rrVBavW/g1iseNgi9YxHn0z+ZU/4+zYJi0PfQojcs=; b=dMuhDr7qyOcpaOo1aFdtPegSp
 BGuUJCKJ+94CQkuxu+ulN3p4dXFwSydTQBF3wq9PtQX4TO3JbyoltlpGAJiFzl81L4lLc+dHd6hB7
 /7n/hQbi1sBUODoJ12clAbvp6Ia34XBKPpv3EbkUmFpArHa5CG3yGu0ZceNeQKkVM324+9TzU8hYo
 1UuMigRxI8bPC2d30X9gIgR07lhtL2OnKAas0+cCHeQLyPFMaPBxd5hxaIO/jOhtM/Exi7fR8kr+g
 o4Q5T2GFLQszL/1SbIh6qOWvvYcPArzFjpZZkZYoItKu0nFfPFNlc21LpafszsKG1nbVG+rK9ehW+
 mL/Y38EBw==;
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <https://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xen.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xen.org>
Content-Type: text/plain; charset="us-ascii"
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

VGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBzaW1wbHkgYm9ndXMgLSBoZXhhZ29uIG9ubHkgaGFzIGEg
c2ltcGxlCmRpcmVjdCBtYXBwZWQgRE1BIGltcGxlbWVudGF0aW9uIGFuZCB0aHVzIGRvZXNuJ3Qg
Y2FyZSBhYm91dCB0aGUKYWRkcmVzcy4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPgotLS0KIGFyY2gvb3BlbnJpc2MvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcu
aCB8IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIGIvYXJjaC9vcGVucmlz
Yy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IGE0ZWExMzljMmVmOS4uZjQxYmQzY2I3
NmQ5IDEwMDY0NAotLS0gYS9hcmNoL29wZW5yaXNjL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
KysrIGIvYXJjaC9vcGVucmlzYy9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0zMywxMSAr
MzMsNCBAQCBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZ2V0X2FyY2hf
ZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIAlyZXR1cm4gJm9yMWtfZG1hX21hcF9vcHM7
CiB9CiAKLSNkZWZpbmUgSEFWRV9BUkNIX0RNQV9TVVBQT1JURUQgMQotc3RhdGljIGlubGluZSBp
bnQgZG1hX3N1cHBvcnRlZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHU2NCBkbWFfbWFzaykKLXsKLQkv
KiBTdXBwb3J0IDMyIGJpdCBETUEgbWFzayBleGNsdXNpdmVseSAqLwotCXJldHVybiBkbWFfbWFz
ayA9PSBETUFfQklUX01BU0soMzIpOwotfQotCiAjZW5kaWYJLyogX19BU01fT1BFTlJJU0NfRE1B
X01BUFBJTkdfSCAqLwotLSAKMi4xMS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KWGVuLWRldmVsIG1haWxpbmcgbGlzdApYZW4tZGV2ZWxAbGlzdHMu
eGVuLm9yZwpodHRwczovL2xpc3RzLnhlbi5vcmcveGVuLWRldmVsCg==
