From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/44] ia64: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:25 +0200
Message-ID: <20170616181059.19206-11-hch@lst.de>
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
 bh=Uy6H3+yx5EeAWQfHfPRvhVNeqQCPFpPHV5YVmwy+QSI=; b=fKAsHkfZmPCuHOxxoipJFT2FD
 Onp8qlpmfZTTHehcB6rvxwh/YXsWS7AHRBL4/Wt2jRP281raJQNFWhTs722VhGDkM7py5HfJrfBxy
 bzS1eMCgQa4ONj75QN7BmzLVw3BB8LN1t6q1tTMf2X1DIhWQ/29Eg/LEj7CmWnBPJ8QSv4BpXEfQp
 ZgS2MkLA4P8lqnD6Kygz4C8bjipiXHw9VxWP5w+9nxhY7OxbcAaao9TiUllsIr++d1mGa6tRN+uT+
 FIoQsG3D4k/LzQ8mNOCLLcys8ZunaEaGxv/J+8dh/q9el5GxerxBPp5SF1KzhYd6YodZn8rTTnjeI
 Ex8WHgE2A==;
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

QWxsIGlhNjQgZG1hX21hcHBpbmdfb3BzIGluc3RhbmNlcyBhbHJlYWR5IGhhdmUgYSBtYXBwaW5n
X2Vycm9yIG1lbWJlci4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgotLS0KIGFyY2gvaWE2NC9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oIHwgMiAtLQogMSBm
aWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9pYTY0L2luY2x1
ZGUvYXNtL2RtYS1tYXBwaW5nLmggYi9hcmNoL2lhNjQvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcu
aAppbmRleCA3M2VjM2M2ZjRjZmUuLjNjZTVhYjQzMzlmMyAxMDA2NDQKLS0tIGEvYXJjaC9pYTY0
L2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgKKysrIGIvYXJjaC9pYTY0L2luY2x1ZGUvYXNtL2Rt
YS1tYXBwaW5nLmgKQEAgLTEyLDggKzEyLDYgQEAKIAogI2RlZmluZSBBUkNIX0hBU19ETUFfR0VU
X1JFUVVJUkVEX01BU0sKIAotI2RlZmluZSBETUFfRVJST1JfQ09ERSAwCi0KIGV4dGVybiBjb25z
dCBzdHJ1Y3QgZG1hX21hcF9vcHMgKmRtYV9vcHM7CiBleHRlcm4gc3RydWN0IGlhNjRfbWFjaGlu
ZV92ZWN0b3IgaWE2NF9tdjsKIGV4dGVybiB2b2lkIHNldF9pb21tdV9tYWNodmVjKHZvaWQpOwot
LSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
