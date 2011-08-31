From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v2 22/35] Hexagon: Add locking types and functions
Date: Wed, 31 Aug 2011 16:09:49 +0200
Message-ID: <201108311609.49361.arnd@arndb.de>
References: <20110830190729.923334292@codeaurora.org> <20110830190801.806746182@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190801.806746182@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tuesday 30 August 2011, Richard Kuo wrote:
> We pretty much just reused the PPC version of rwsem.h.  Spinlocks use ll/sc.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> 
> ---
>  arch/hexagon/include/asm/rwsem.h          |  132 +++++++++++++++++++++
>  arch/hexagon/include/asm/spinlock.h       |  186 ++++++++++++++++++++++++++++++
>  arch/hexagon/include/asm/spinlock_types.h |   42 ++++++
>  3 files changed, 360 insertions(+)

If you have reused an existing version of the rwsem.h file, please move that
into asm-generic and change powerpc and hexagon to just use it from there.

	Arnd
