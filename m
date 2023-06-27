From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
Date: Mon, 26 Jun 2023 21:44:08 -0700 (PDT)
Message-ID: <e8992eee-4140-427e-bacb-9449f346318@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VG2JL77SHZdH4N8vxGKcgU/PmH7IFmf/tOT+X32fR6A=; b=WS1LJA/cidlgMx
	U8b6pQmluEb1vVa0okxA9Ni2yHCyauR2Sece+GrdMnl03GHgDYzk65lFIbGuYFBYcexB8r2cOmHsO
	5K0dDy65XLGDiXWi4bfaOTQ0m3df0c5THh0FaKcKh1Ljq+QqbS8sp6bdbsJ0hrGSAkaXMJqkEKgZ5
	A7D6HwuiDynPP5+2d2FJh/1um0GCk9tzhsdeb3yYhKfPxnAee8OupfuikL/a4LYznYCwgL0i3d8wU
	/ObhgtZueo+AkX8NO2jh5A3W6tIXL7pPZ6ljRNQTJ7cJwvdNjNHauGoHnx9iA267pbW5hWc0Qaw8x
	hbkDva74czDlPg5JS1oA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687841060; x=1690433060;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVtrcXbE5qXWKdJhq2ArhetT4KPRpQBwbjTOuMnTdxE=;
        b=501HLYHctmk8sIJeTmzxhRx3/mgKpv1jRi1zyxe6IKd5PzvxEUvUlafEKoDqL6yZVr
         8LPzltfzYfOsnNGE3T6BklB22lAMitCgdhFuhtcXDNR8cn90bt0hxS6/rFyMCnKABSjm
         /oRswCkgkHFa78/d8yQxqLAP7w+UcywLgaNVEk0kQUj/E5gzTgG4U1Ib/QTJ68K6B1lq
         DHiArvPKR0yaKTV4AcdaFGyA0a3QVzlRHTqcAyQmjJhyBDsZIisDj9Axezm4VTj3plhb
         Dus4mDTAcMi1b8nttzH3dDwb6//iZcVcKmqu+MryYnw/GG09jfr1xcEP4Qfwx6utRJkj
         zVzA==
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
List-Id: <linux-hexagon.vger.kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane-mx.org@lists.infradead.org
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Jonas

On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:

> The MM subsystem is trying to shrink struct page. This patchset
> introduces a memory descriptor for page table tracking - struct ptdesc.
...
>  39 files changed, 686 insertions(+), 455 deletions(-)

I don't see the point of this patchset: to me it is just obfuscation of
the present-day tight relationship between page table and struct page.

Matthew already explained:

> The intent is to get ptdescs to be dynamically allocated at some point
> in the ~2-3 years out future when we have finished the folio project ...

So in a kindly mood, I'd say that this patchset is ahead of its time.
But I can certainly adapt to it, if everyone else sees some point to it.

Hugh
