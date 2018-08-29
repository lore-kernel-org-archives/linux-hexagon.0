From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 0/7] switch several architectures NO_BOOTMEM
Date: Wed, 29 Aug 2018 10:20:19 +0300
Message-ID: <20180829072019.GA13173@rapoport-lnx>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, Ley Foon Tan <lftan@altera.com>, Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-um@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

Any updates on this?

On Fri, Aug 03, 2018 at 10:58:43PM +0300, Mike Rapoport wrote:
> 
> Hi,
> 
> These patches perform conversion to NO_BOOTMEM of hexagon, nios2, uml and
> unicore32. The architecture maintainers have acked the patches, but, since
> I've got no confirmation the patches are going through the arch tree I'd
> appreciate if the set would be applied to the -mm tree.
> 
> Mike Rapoport (7):
>   hexagon: switch to NO_BOOTMEM
>   of: ignore sub-page memory regions
>   nios2: use generic early_init_dt_add_memory_arch
>   nios2: switch to NO_BOOTMEM
>   um: setup_physmem: stop using global variables
>   um: switch to NO_BOOTMEM
>   unicore32: switch to NO_BOOTMEM
> 
>  arch/hexagon/Kconfig      |  3 +++
>  arch/hexagon/mm/init.c    | 20 +++++++-----------
>  arch/nios2/Kconfig        |  3 +++
>  arch/nios2/kernel/prom.c  | 17 ---------------
>  arch/nios2/kernel/setup.c | 39 ++++++----------------------------
>  arch/um/Kconfig.common    |  2 ++
>  arch/um/kernel/physmem.c  | 22 +++++++++----------
>  arch/unicore32/Kconfig    |  1 +
>  arch/unicore32/mm/init.c  | 54 +----------------------------------------------
>  drivers/of/fdt.c          | 11 +++++-----
>  10 files changed, 41 insertions(+), 131 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.

