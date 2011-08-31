From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 27/35] Hexagon: Provide DMA implementation
Date: Wed, 31 Aug 2011 16:51:07 +0200
Message-ID: <201108311651.07645.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190802.279215705@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190802.279215705@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Tuesday 30 August 2011, Richard Kuo wrote:
> Basic DMA implementation for our architecture.
> 
> Added sync_single_for_* routines; hexagon_map_page() still seems to be a
> convenient place to flush/invalidate.
> 
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
