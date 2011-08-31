From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 06/35] Hexagon: Add processor and system headers
Date: Wed, 31 Aug 2011 15:35:25 +0200
Message-ID: <201108311535.25248.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.292243127@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190800.292243127@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Tuesday 30 August 2011, Richard Kuo wrote:
> 
> Adds Hexagon information for processor/system type stuff
> like context switching, register access, and irqflags.
> 
> Changed cpu_relax() to call __vmyield().
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
