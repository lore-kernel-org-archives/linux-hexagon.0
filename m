From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/44] microblaze: remove DMA_ERROR_CODE
Date: Fri, 16 Jun 2017 20:10:27 +0200
Message-ID: <20170616181059.19206-13-hch@lst.de>
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
 bh=czzdYfIKlgw8CBoCZndnCbas2yY5kUsyMGT+aG2d85s=; b=VQstiEDIubJ/vgk24nSWIeICs
 r4mHskXs3TZlldf7U6DyqrenXbebbkUo8dtSN1J2PC/d58Xg168/cRnXnjTxGJmanyoVRJx7oKMfs
 QCu01pGjLAmB9vpLcVYPMAs7qjnvujo/qBR/ovj1BIrpM5KjIAz7u3nCq4EAHos5CSvpq2v6sJSdF
 46FKpTTFFJd+ceOZZbOrq2ePIfvFnP1hJf00xadcvHUMC0LgRWtMhh8RcZ6N6iwury4JmzXnmeyhS
 4k8ln3f/T3Wos74kOGwgWPAF6n/InKVC3akMzSpGluENepsqGgMBp3QnuvxdAGfN8vM4SoaMfYYzv
 ZOozkZeoA==;
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

bWljcm9ibGF6ZSBkb2VzIG5vdCByZXR1cm4gZXJyb3JzIGZvciBkbWFfbWFwX3BhZ2UuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KLS0tCiBhcmNoL21pY3Jv
YmxhemUvaW5jbHVkZS9hc20vZG1hLW1hcHBpbmcuaCB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvbWljcm9ibGF6ZS9pbmNsdWRlL2FzbS9k
bWEtbWFwcGluZy5oIGIvYXJjaC9taWNyb2JsYXplL2luY2x1ZGUvYXNtL2RtYS1tYXBwaW5nLmgK
aW5kZXggM2ZhZDVlNzIyYTY2Li5lMTVjZDJmNzZlMjMgMTAwNjQ0Ci0tLSBhL2FyY2gvbWljcm9i
bGF6ZS9pbmNsdWRlL2FzbS9kbWEtbWFwcGluZy5oCisrKyBiL2FyY2gvbWljcm9ibGF6ZS9pbmNs
dWRlL2FzbS9kbWEtbWFwcGluZy5oCkBAIC0yOCw4ICsyOCw2IEBACiAjaW5jbHVkZSA8YXNtL2lv
Lmg+CiAjaW5jbHVkZSA8YXNtL2NhY2hlZmx1c2guaD4KIAotI2RlZmluZSBETUFfRVJST1JfQ09E
RQkJKH4oZG1hX2FkZHJfdCkweDApCi0KICNkZWZpbmUgX19kbWFfYWxsb2NfY29oZXJlbnQoZGV2
LCBnZnAsIHNpemUsIGhhbmRsZSkJTlVMTAogI2RlZmluZSBfX2RtYV9mcmVlX2NvaGVyZW50KHNp
emUsIGFkZHIpCQkoKHZvaWQpMCkKIAotLSAKMi4xMS4wCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZl
bEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
