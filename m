From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 37/44] mips/loongson64: implement
	->dma_supported instead of ->set_dma_mask
Date: Fri, 16 Jun 2017 20:10:52 +0200
Message-ID: <20170616181059.19206-38-hch@lst.de>
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
 bh=b32hSH5IEVBjlCN7NVj+ixF9++g48vrma/m3FufguJ8=; b=ckSPX+ws8hnvYEYv3rFnu3vLV
 BgqPfMiqTUZw4zxrjp1uGNJFyhVaDxWy5accJmNOw+ILeJtBapR4lGJylFhk2scq0VI86tmP1ial4
 zHY2YGTh1KCV+zjdc1cN/ueiX6kh6wKVnNvligjRCztnfN31FlZ8fl1p5jgNX98d+jeYgOkWoc0mE
 L57cTWEt9UxDjxS23QJTXktVH2VTnrVQ8dapQkLcv4U3sXOgx+aoLI4Q7qy33niNXf8rZPB3aRGKi
 6sSwyLEvYJFAufBKTWbqqUYFUYT0NodiukNamlG2zLQNI9hUYWZWXBdV7lL/XGpii/dOY7CmT1frN
 x+uY4p/8g==;
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

U2FtZSBiZWhhdmlvciwgbGVzcyBjb2RlIGR1cGxpY2F0aW9uLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ci0tLQogYXJjaC9taXBzL2xvb25nc29uNjQvY29t
bW9uL2RtYS1zd2lvdGxiLmMgfCAxOSArKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL21p
cHMvbG9vbmdzb242NC9jb21tb24vZG1hLXN3aW90bGIuYyBiL2FyY2gvbWlwcy9sb29uZ3NvbjY0
L2NvbW1vbi9kbWEtc3dpb3RsYi5jCmluZGV4IDE3OGNhMTdhNTY2Ny4uMzQ0ODZjMTM4MjA2IDEw
MDY0NAotLS0gYS9hcmNoL21pcHMvbG9vbmdzb242NC9jb21tb24vZG1hLXN3aW90bGIuYworKysg
Yi9hcmNoL21pcHMvbG9vbmdzb242NC9jb21tb24vZG1hLXN3aW90bGIuYwpAQCAtNzUsMTkgKzc1
LDExIEBAIHN0YXRpYyB2b2lkIGxvb25nc29uX2RtYV9zeW5jX3NnX2Zvcl9kZXZpY2Uoc3RydWN0
IGRldmljZSAqZGV2LAogCW1iKCk7CiB9CiAKLXN0YXRpYyBpbnQgbG9vbmdzb25fZG1hX3NldF9t
YXNrKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0IG1hc2spCitzdGF0aWMgaW50IGxvb25nc29uX2Rt
YV9zdXBwb3J0ZWQoc3RydWN0IGRldmljZSAqZGV2LCB1NjQgbWFzaykKIHsKLQlpZiAoIWRldi0+
ZG1hX21hc2sgfHwgIWRtYV9zdXBwb3J0ZWQoZGV2LCBtYXNrKSkKLQkJcmV0dXJuIC1FSU87Ci0K
LQlpZiAobWFzayA+IERNQV9CSVRfTUFTSyhsb29uZ3Nvbl9zeXNjb25mLmRtYV9tYXNrX2JpdHMp
KSB7Ci0JCSpkZXYtPmRtYV9tYXNrID0gRE1BX0JJVF9NQVNLKGxvb25nc29uX3N5c2NvbmYuZG1h
X21hc2tfYml0cyk7Ci0JCXJldHVybiAtRUlPOwotCX0KLQotCSpkZXYtPmRtYV9tYXNrID0gbWFz
azsKLQotCXJldHVybiAwOworCWlmIChtYXNrID4gRE1BX0JJVF9NQVNLKGxvb25nc29uX3N5c2Nv
bmYuZG1hX21hc2tfYml0cykpCisJCXJldHVybiAwOworCXJldHVybiBzd2lvdGxiX2RtYV9zdXBw
b3J0ZWQoZGV2LCBtYXNrKTsKIH0KIAogZG1hX2FkZHJfdCBwaHlzX3RvX2RtYShzdHJ1Y3QgZGV2
aWNlICpkZXYsIHBoeXNfYWRkcl90IHBhZGRyKQpAQCAtMTI2LDggKzExOCw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgbG9vbmdzb25fZG1hX21hcF9vcHMgPSB7CiAJLnN5bmNf
c2dfZm9yX2NwdSA9IHN3aW90bGJfc3luY19zZ19mb3JfY3B1LAogCS5zeW5jX3NnX2Zvcl9kZXZp
Y2UgPSBsb29uZ3Nvbl9kbWFfc3luY19zZ19mb3JfZGV2aWNlLAogCS5tYXBwaW5nX2Vycm9yID0g
c3dpb3RsYl9kbWFfbWFwcGluZ19lcnJvciwKLQkuZG1hX3N1cHBvcnRlZCA9IHN3aW90bGJfZG1h
X3N1cHBvcnRlZCwKLQkuc2V0X2RtYV9tYXNrID0gbG9vbmdzb25fZG1hX3NldF9tYXNrCisJLmRt
YV9zdXBwb3J0ZWQgPSBsb29uZ3Nvbl9kbWFfc3VwcG9ydGVkLAogfTsKIAogdm9pZCBfX2luaXQg
cGxhdF9zd2lvdGxiX3NldHVwKHZvaWQpCi0tIAoyLjExLjAKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1k
ZXZlbEBsaXN0cy54ZW4ub3JnCmh0dHBzOi8vbGlzdHMueGVuLm9yZy94ZW4tZGV2ZWwK
