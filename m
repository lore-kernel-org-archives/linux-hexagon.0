From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 29/35] Hexagon: Add page table header files & etc.
Date: Wed, 31 Aug 2011 16:57:32 +0200
Message-ID: <201108311657.32735.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190802.462665808@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190802.462665808@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Tuesday 30 August 2011, Richard Kuo wrote:
> Removed highmem as we currently don't need it (and it didn't
> quite work).
>
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Apparently you haven't removed it completely yet:

>+/**
>+ * kunmap - unmaps a kernel mapping
>+ * @page: pointer to page struct
>+ *
>+ * If it's not in highmem, then you ain't unmapping anybody.
>+ *
>+ * If it is in highmem, it calls kunmap_high, which magically
>+ * removes the mapping or something.  Seems to only decrement pkmap_count
>+ * for the page.  If the pkmap_count was decremented to 1, that means it's
>+ * ready to be flushed.
>+ *
>+ * It also is responsible for waking anybody up that was waiting for a kmap
>+ * to free up.
>+ */
>+extern void kunmap_hexagon(struct page *page);
>+#define kunmap(p)      kunmap_hexagon((p))
>+
>+extern struct page *kmap_atomic_to_page_hexagon(void *ptr);
>+#define kmap_atomic_to_page(p) kmap_atomic_to_page_hexagon((p))
>+
>+extern void *kmap_atomic_prot(struct page *page, pgprot_t prot);
>+extern void __kunmap_atomic(void *);
>+
>+static inline void *__kmap_atomic(struct page *page)
>+{
>+       return kmap_atomic_prot(page, kmap_prot);
>+}

I think if you disable CONFIG_ARCH_HAS_KMAP you can use the trivial
functions provided by include/linux/highmem.h.

	Arnd
