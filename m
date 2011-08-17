From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 34/36] Hexagon: Add configuration and makefiles for the Hexagon architecture.
Date: Wed, 17 Aug 2011 22:27:20 +0200
Message-ID: <1439336.IEGvqVMOO9@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163523.041764598@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110817163523.041764598@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:35:31 Richard Kuo wrote:

> +config HIGHMEM
> +	bool "High Memory Support"
> +	default n

Do you really want to burden yourselves with this?

Support for HIGHMEM is gradually going to get worse as we optimize the
common 64-bit case in the kernel, so it may just not be worth it.

	Arnd
