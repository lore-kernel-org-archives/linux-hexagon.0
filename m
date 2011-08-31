From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 13/35] Hexagon: Support dynamic module loading.
Date: Wed, 31 Aug 2011 15:41:45 +0200
Message-ID: <201108311541.45530.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.974918693@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190800.974918693@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Tuesday 30 August 2011, Richard Kuo wrote:
> 
> Modules should be compiled as ordinary .o's; shared objects are not
> supported.
> 
> Deleted module functions that already have generic equivalents.
> 
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
