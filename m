From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 09/36] Hexagon: Add checksum functions
Date: Wed, 17 Aug 2011 21:40:09 +0200
Message-ID: <3022109.2FN82h7jRd@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.702483311@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163520.702483311@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Wednesday 17 August 2011 11:35:06 Richard Kuo wrote:
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> 
> ---
>  arch/hexagon/include/asm/checksum.h   |   91 +++++++++++
>  arch/hexagon/include/asm/intrinsics.h |   26 +++
>  arch/hexagon/lib/checksum.c           |  269 ++++++++++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+)

I think you should be able to use the generic implementation for the
bits that don't have hexagon specific assembly in them, to simplify the
code.

	Arnd
