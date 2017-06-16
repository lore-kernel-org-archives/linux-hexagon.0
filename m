From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 09/44] c6x: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:24 +0200
Message-ID: <20170616181059.19206-10-hch@lst.de>
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
 bh=Qq8AeGjAhgMaYo45H5H0z3+n7t09h3AhcNXTUqnWhFg=; b=HJPQTy/kSdxuWgdai1m/+PD+B
 bAY9LjMARiZgYhSPdu7sb0YDWmmEZ284Fs8RNLYZYKAxfijWemszNIpqtMD2FObLGD3zaBMPv3BUc
 5e0pMsdelkeb8rtGXfP1ERex311Rc9D0qLJAX98wn3KHvX8xaldWDPjd3/4uXQJyn5yAQnCZ7J+Kt
 C3n5SJRb6WPnbSPtgkE3EpiiUSNEwAz0T5PVts911xOhv8rZkLLE4S36e7AH9R8TgQZkr3D7mpgkY
 hWMXBq3x5WNItoN5MVK/7DoFYReHQm4CjSv+ASvfNc9WUUC101uDBNBr0LCHh7QbXzdh2tQQz2h2u
 lvdfa8Mtg==;
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

U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ci0tLQogYXJjaC9j
NngvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8IDUgLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYzZ4L2luY2x1ZGUvYXNtL2RtYS1tYXBw
aW5nLmggYi9hcmNoL2M2eC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCmluZGV4IGFjYTlmNzU1
ZTRmOC4uMDVkYWYxMDM4MTExIDEwMDY0NAotLS0gYS9hcmNoL2M2eC9pbmNsdWRlL2FzbS9kbWEt
bWFwcGluZy5oCisrKyBiL2FyY2gvYzZ4L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKQEAgLTEy
LDExICsxMiw2IEBACiAjaWZuZGVmIF9BU01fQzZYX0RNQV9NQVBQSU5HX0gKICNkZWZpbmUgX0FT
TV9DNlhfRE1BX01BUFBJTkdfSAogCi0vKgotICogRE1BIGVycm9ycyBhcmUgZGVmaW5lZCBieSBh
bGwtYml0cy1zZXQgaW4gdGhlIERNQSBhZGRyZXNzLgotICovCi0jZGVmaW5lIERNQV9FUlJPUl9D
T0RFIH4wCi0KIGV4dGVybiBjb25zdCBzdHJ1Y3QgZG1hX21hcF9vcHMgYzZ4X2RtYV9vcHM7CiAK
IHN0YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGRtYV9tYXBfb3BzICpnZXRfYXJjaF9kbWFfb3Bz
KHN0cnVjdCBidXNfdHlwZSAqYnVzKQotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
