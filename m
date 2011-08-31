From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 04/35] Hexagon: Add atomic ops support
Date: Wed, 31 Aug 2011 15:26:32 +0200
Message-ID: <201108311526.32953.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190800.097783373@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110830190800.097783373@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> 
> Our architecture uses load locked/store conditional type semantics for atomic
> ops.
> 
> Added inline assembly version of atomic_add_unless.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
