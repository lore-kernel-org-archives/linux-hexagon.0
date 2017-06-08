From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 32/44] hexagon: remove the unused
	dma_is_consistent prototype
Date: Thu,  8 Jun 2017 15:25:57 +0200
Message-ID: <20170608132609.32662-33-hch@lst.de>
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
 bh=/YMzv2usr3T651rHR5jW5DWvfbn0sPoYwrpjuefSYlQ=; b=lQ7MSk/T37x5cAFLqYTRIHPhU
 YbaiMYsFNplXhMmbyqRbhmvt+wbpSVwZ7n3Nk55BuN1kxskLHBOC9EevH1bTqOxCB/k8AS92uDEMH
 JwKOX5qNr4BQ2NW6ZkibzUcPF5Mx3Alv2y/NFGCp/RZYJRp3jIY2ZOAI+bBE5Vn6P/Q3CGHStZ/Mt
 7XiNTaU3URtlEzYTEEbpVFtjUpSFwi99+GViPAUcL/J28kU6pCPAQ7bYQLi3E/YPJFPHFyM1v84Rh
 dMa9n+mku+2TnHMqVX8qNGbd6UI4Ho6ALrKQmtl/iEEirUKvT+9Y9Uzc48XIAYh7R2JrJz5HtAgkK
 IYVXQ9WlQ==;
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

U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ci0tLQogYXJjaC9o
ZXhhZ29uL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmggfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmggYi9hcmNoL2hleGFnb24vaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAppbmRleCA5
YzE1Y2I1MjcxYTYuLjQ2M2RiYzE4Zjg1MyAxMDA2NDQKLS0tIGEvYXJjaC9oZXhhZ29uL2luY2x1
ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2RtYS1t
YXBwaW5nLmgKQEAgLTM3LDcgKzM3LDYgQEAgc3RhdGljIGlubGluZSBjb25zdCBzdHJ1Y3QgZG1h
X21hcF9vcHMgKmdldF9hcmNoX2RtYV9vcHMoc3RydWN0IGJ1c190eXBlICpidXMpCiAJcmV0dXJu
IGRtYV9vcHM7CiB9CiAKLWV4dGVybiBpbnQgZG1hX2lzX2NvbnNpc3RlbnQoc3RydWN0IGRldmlj
ZSAqZGV2LCBkbWFfYWRkcl90IGRtYV9oYW5kbGUpOwogZXh0ZXJuIHZvaWQgZG1hX2NhY2hlX3N5
bmMoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICp2YWRkciwgc2l6ZV90IHNpemUsCiAJCQkgICBl
bnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBkaXJlY3Rpb24pOwogCi0tIAoyLjExLjAKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGlu
ZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4t
ZGV2ZWwK
