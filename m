From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 43/44] dma-mapping: remove the set_dma_mask
	method
Date: Fri, 16 Jun 2017 20:10:58 +0200
Message-ID: <20170616181059.19206-44-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xen.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lR6x5uNOAP+GhigMbCiwoL6Qu+Q3Ix9NaMyJN6X36xY=; b=jtup0k+m1VsOa264Mk8Lrz2Sq
 h5Fy9v49r2kfCPC4uL2OIf/0/cAQ805LjUDXaKIamo9ZSDF8n0he5o+vxervF75DqtfVPxUYWMlpn
 F9KBFDFlITK7KJIwulQsXg7hhzxyINnuuCNaH1VnlZb4U29LyTKx3SnFwM4c09JW7jS2voAWT78xZ
 ChzUZdIrCH2DmF24wFlswWFmXebapcx9fOfRQCDkeHCrHOD5e8NSLuhLGdQCRKFhi+G1TDpCDquFM
 jwOzjHget5lSKHJB0TKJlXUJTE9Liy5qaOfrqD9UQb4rKXE1UVXLhq2putcDELO5kNo+mBNZ5Wsln
 zo2QHs7kg==;
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
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

U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ci0tLQogYXJjaC9w
b3dlcnBjL2tlcm5lbC9kbWEuYyAgIHwgNCAtLS0tCiBpbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5n
LmggfCA2IC0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL2RtYS5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9kbWEu
YwppbmRleCA0MWM3NDk1ODZiZDIuLjQ2NmM5ZjA3YjI4OCAxMDA2NDQKLS0tIGEvYXJjaC9wb3dl
cnBjL2tlcm5lbC9kbWEuYworKysgYi9hcmNoL3Bvd2VycGMva2VybmVsL2RtYS5jCkBAIC0zMTYs
MTAgKzMxNiw2IEBAIEVYUE9SVF9TWU1CT0woZG1hX3NldF9jb2hlcmVudF9tYXNrKTsKIAogaW50
IF9fZG1hX3NldF9tYXNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IGRtYV9tYXNrKQogewotCWNv
bnN0IHN0cnVjdCBkbWFfbWFwX29wcyAqZG1hX29wcyA9IGdldF9kbWFfb3BzKGRldik7Ci0KLQlp
ZiAoKGRtYV9vcHMgIT0gTlVMTCkgJiYgKGRtYV9vcHMtPnNldF9kbWFfbWFzayAhPSBOVUxMKSkK
LQkJcmV0dXJuIGRtYV9vcHMtPnNldF9kbWFfbWFzayhkZXYsIGRtYV9tYXNrKTsKIAlpZiAoIWRl
di0+ZG1hX21hc2sgfHwgIWRtYV9zdXBwb3J0ZWQoZGV2LCBkbWFfbWFzaykpCiAJCXJldHVybiAt
RUlPOwogCSpkZXYtPmRtYV9tYXNrID0gZG1hX21hc2s7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2RtYS1tYXBwaW5nLmggYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKaW5kZXggM2U1
OTA4NjU2MjI2Li41MjdmMmVkOGM2NDUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZG1hLW1h
cHBpbmcuaAorKysgYi9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgKQEAgLTEyNyw3ICsxMjcs
NiBAQCBzdHJ1Y3QgZG1hX21hcF9vcHMgewogCQkJCSAgIGVudW0gZG1hX2RhdGFfZGlyZWN0aW9u
IGRpcik7CiAJaW50ICgqbWFwcGluZ19lcnJvcikoc3RydWN0IGRldmljZSAqZGV2LCBkbWFfYWRk
cl90IGRtYV9hZGRyKTsKIAlpbnQgKCpkbWFfc3VwcG9ydGVkKShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHU2NCBtYXNrKTsKLQlpbnQgKCpzZXRfZG1hX21hc2spKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0
IG1hc2spOwogI2lmZGVmIEFSQ0hfSEFTX0RNQV9HRVRfUkVRVUlSRURfTUFTSwogCXU2NCAoKmdl
dF9yZXF1aXJlZF9tYXNrKShzdHJ1Y3QgZGV2aWNlICpkZXYpOwogI2VuZGlmCkBAIC01NjMsMTEg
KzU2Miw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGRtYV9zdXBwb3J0ZWQoc3RydWN0IGRldmljZSAq
ZGV2LCB1NjQgbWFzaykKICNpZm5kZWYgSEFWRV9BUkNIX0RNQV9TRVRfTUFTSwogc3RhdGljIGlu
bGluZSBpbnQgZG1hX3NldF9tYXNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spCiB7Ci0J
Y29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpvcHMgPSBnZXRfZG1hX29wcyhkZXYpOwotCi0JaWYg
KG9wcy0+c2V0X2RtYV9tYXNrKQotCQlyZXR1cm4gb3BzLT5zZXRfZG1hX21hc2soZGV2LCBtYXNr
KTsKLQogCWlmICghZGV2LT5kbWFfbWFzayB8fCAhZG1hX3N1cHBvcnRlZChkZXYsIG1hc2spKQog
CQlyZXR1cm4gLUVJTzsKIAkqZGV2LT5kbWFfbWFzayA9IG1hc2s7Ci0tIAoyLjExLjAKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFp
bGluZyBsaXN0Clhlbi1kZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94
ZW4tZGV2ZWwK
