From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 28/35] Hexagon: Add ioremap support
Date: Wed, 31 Aug 2011 16:53:37 +0200
Message-ID: <201108311653.37970.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190802.372848298@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190802.372848298@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> +       if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
> +               vunmap((void *)addr);
> +               return NULL;
> +       }
> +
> +       flush_cache_vmap(addr, addr+size);

I think that ioremap_page_range implies the flush_cache_vmap already,
so there is no reason to do it again.

	Arnd
