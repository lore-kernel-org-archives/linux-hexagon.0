From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 06/36] Hexagon: Add processor and system headers
Date: Wed, 17 Aug 2011 21:31:46 +0200
Message-ID: <2190987.TyqYXCu926@wuerfel>
References: <20110817163457.878854582@codeaurora.org> <20110817163520.423419116@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110817163520.423419116@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>

On Wednesday 17 August 2011 11:35:03 Richard Kuo wrote:

> +
> +#define cpu_relax() barrier()

If you run under a hypervisor, you might want to call a 'yield' hypercall.

	Arnd
