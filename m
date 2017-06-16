From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/44] drm/exynos: don't use DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:19 +0200
Message-ID: <20170616181059.19206-5-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VolBZDxS9ZQrQoHzmubjiZ2v8Rk+FgSixd/DX4o9p2E=; b=THVPuyuHTKM8ALqXwsIZqKBJZ
 SK3+dGgdzbAXPQeRkU6eFYuLB2ODWl9twiGUVkGVau4AyN1LdNLSJVhfMKYIyFA3r9yBqyAknCEO6
 n9YFfIM2GQJXnm/5VpIyRJXXOoYKhpLPv1PJfdLZU7lI0b9XYaxxmIl/Sc5tqTVfINjx5r/vBPwLE
 hf2G4UP+ZPYIndT+Ad+Xw42tQl724CLBzEcyMVg4dpuEIVmDadecp7yA4G1m+zUIGe1Q6HJi0RSMe
 9kpTabDT4+AJiaJcXcIfn8/s8oMbjIo88GmY42gJLQF2mpA9Im6RwC84Naq1m8py5sIwUU0cdZKH3
 5ORGslnRQ==;
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

RE1BX0VSUk9SX0NPREUgYWxyZWFkeSBpc24ndCBhIHZhbGlkIEFQSSB0byB1c2VyIGZvciBkcml2
ZXJzIGFuZCB3aWxsCmdvIGF3YXkgc29vbi4gIGV4eW5vc19kcm1fZmJfZG1hX2FkZHIgdXNlcyBp
dCBhIGFuIGVycm9yIHJldHVybiB3aGVuCnRoZSBwYXNzZWQgaW4gaW5kZXggaXMgaW52YWxpZCwg
YnV0IHRoZSBjYWxsZXJzIG5ldmVyIGNoZWNrIGZvciBpdApidXQgaW5zdGVhZCBwYXNzIHRoZSBh
ZGRyZXNzIHN0cmFpZ2h0IHRvIHRoZSBoYXJkd2FyZS4KCkFkZCBhIFdBUk5fT04gaW5zdGVhZCBh
bmQganVzdCByZXR1cm4gMC4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9mYi5jIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9mYi5jIGIvZHJpdmVy
cy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2ZiLmMKaW5kZXggYzc3YTVhY2VkODFhLi5kNDhm
ZDdjOTE4ZjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9m
Yi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9mYi5jCkBAIC0xODEs
OCArMTgxLDggQEAgZG1hX2FkZHJfdCBleHlub3NfZHJtX2ZiX2RtYV9hZGRyKHN0cnVjdCBkcm1f
ZnJhbWVidWZmZXIgKmZiLCBpbnQgaW5kZXgpCiB7CiAJc3RydWN0IGV4eW5vc19kcm1fZmIgKmV4
eW5vc19mYiA9IHRvX2V4eW5vc19mYihmYik7CiAKLQlpZiAoaW5kZXggPj0gTUFYX0ZCX0JVRkZF
UikKLQkJcmV0dXJuIERNQV9FUlJPUl9DT0RFOworCWlmIChXQVJOX09OX09OQ0UoaW5kZXggPj0g
TUFYX0ZCX0JVRkZFUikpCisJCXJldHVybiAwOwogCiAJcmV0dXJuIGV4eW5vc19mYi0+ZG1hX2Fk
ZHJbaW5kZXhdOwogfQotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
