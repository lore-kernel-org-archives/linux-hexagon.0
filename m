From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 08/35] Hexagon: Add delay functions
Date: Wed, 31 Aug 2011 15:39:43 +0200
Message-ID: <201108311539.43528.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.478027955@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190800.478027955@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> Added read_current_timer elsewhere, so __delay isn't really used.
> 
> udelay is based off of __vmgettime() which returns processor ticks.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Why do you still provide __delay then?

If you disable CONFIG_GENERIC_CALIBRATE_DELAY, it should just never
be called at all so you can remove it.

	Arnd
