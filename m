From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/44] m32r: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:26 +0200
Message-ID: <20170616181059.19206-12-hch@lst.de>
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
 bh=+BimIphw+O/ZeWv5ilcXGOZNr0jC0FIS9166yVuBOCo=; b=aar/hGEgYNDN760LyRQGOkf/c
 muF7aFh0DgtllPrRo3c8wxtJxCfC6AqYgWxIk0PYRwz603D6psbrFTgHfcfmRH0ibidr7pujlTu34
 fV23h02D1Ktmi4xFT/ee4A7nL1dt+Xhuk0CJjXosgYfbcmiG5ZFGyIOmdopFiyx9AioD8NlANQV+G
 4bApgR0F/BP4Yreisd6zvQ+ByN5YNX3ffICBEDZWdSJ45Bo5QIi2ws6GGz6fQpmI7caiiDfGmN2dM
 ZIUhm9lG/76+KFCNx0yp+QwUQVlMsFmukfOKgbQ3upwhKdkhZfg3xbYGffum+a9HlYUAPm0gi91JJ
 ok2iqMXDQ==;
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

ZG1hLW5vb3AgaXMgdGhlIG9ubHkgZG1hX21hcHBpbmdfb3BzIGluc3RhbmNlIGZvciBtMzJyIGFu
ZCBkb2VzIG5vdCByZXR1cm4KZXJyb3JzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+Ci0tLQogYXJjaC9tMzJyL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgg
fCAyIC0tCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNo
L20zMnIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCBiL2FyY2gvbTMyci9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oCmluZGV4IGMwMWQ5ZjUyZDIyOC4uYWZmM2FlOGI2MmY3IDEwMDY0NAotLS0g
YS9hcmNoL20zMnIvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaAorKysgYi9hcmNoL20zMnIvaW5j
bHVkZS9hc20vZG1hLW1hcHBpbmcuaApAQCAtOCw4ICs4LDYgQEAKICNpbmNsdWRlIDxsaW51eC9k
bWEtZGVidWcuaD4KICNpbmNsdWRlIDxsaW51eC9pby5oPgogCi0jZGVmaW5lIERNQV9FUlJPUl9D
T0RFICh+KGRtYV9hZGRyX3QpMHgwKQotCiBzdGF0aWMgaW5saW5lIGNvbnN0IHN0cnVjdCBkbWFf
bWFwX29wcyAqZ2V0X2FyY2hfZG1hX29wcyhzdHJ1Y3QgYnVzX3R5cGUgKmJ1cykKIHsKIAlyZXR1
cm4gJmRtYV9ub29wX29wczsKLS0gCjIuMTEuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZHJpLWRldmVsCg==
