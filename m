From: Joe Perches <joe@perches.com>
Subject: Re: [patch v2 09/35] Hexagon: Add checksum functions
Date: Tue, 30 Aug 2011 12:34:47 -0700
Message-ID: <1314732887.14422.10.camel@Joe-Laptop>
References: <20110830190729.923334292@codeaurora.org>
	 <20110830190800.574002538@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110830190800.574002538@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org

On Tue, 2011-08-30 at 14:07 -0500, Richard Kuo wrote:
> Removed most non-assembly functions and use the generic ones instead.
[]
> +++ linux-hexagon-kernel/arch/hexagon/include/asm/checksum.h	2011-08-24 18:45:48.133877105 -0500
[]
> +#define do_csum	do_csum

That looks pretty odd.
I have a hard time believing that's useful or necessary.


